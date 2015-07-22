using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KCGameOn.Account
{
    public partial class AccountManagement : System.Web.UI.Page
    {
        private string accountmanagement;
        private string changePasswordErrorString;
        private bool changePasswordSucess;
        public string AccountManagements
        {
            get { return accountmanagement; }
            set { accountmanagement = value; }
        }
        public string ChangePasswordErrorString
        {
            get { return changePasswordErrorString; }
            set { changePasswordErrorString = value;}
        }
        public bool ChangePasswordSucess
        {
            get { return changePasswordSucess; }
            set { changePasswordSucess = value; }
        }

        private void InitializeForm()
        {
            AccountManagements = null;
            ChangePasswordErrorString = null;
            changePasswordSucess = false;

            // Static Variables for the Recovery Option 1.
            SessionVariables.recoveryCode = null;
            SessionVariables.iSeq = 0;

            // Error Strings for Recovery Option 1.
            recoveryError.Text = string.Empty;
            recoveryError1.Text = string.Empty;
        }
        public bool UserCookiesExists()
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            HttpCookie macCookie = Request.Cookies[ConfigurationManager.ConnectionStrings["MacCookieName"].ConnectionString];
            HttpCookie ipCookie = Request.Cookies[ConfigurationManager.ConnectionStrings["IpCookieName"].ConnectionString];
            if (authCookie != null && macCookie != null && ipCookie != null)
            {
                // Get the Form Authentcation cookie.
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                // Check to see if Authentication cookie has been exired or not.
                if (!ticket.Expired)
                {
                    cookies decryptCookie = new cookies();
                    if (decryptCookie.Unprotect(macCookie.Value, ConfigurationManager.ConnectionStrings["MacCookieName"].ConnectionString) == decryptCookie.MacAddress &&
                        decryptCookie.Unprotect(ipCookie.Value, ConfigurationManager.ConnectionStrings["IpCookieName"].ConnectionString) == decryptCookie.IPAddress)
                    {
                        return true;
                    }
                }
            }
            return false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeForm();
                string AccountMgmt = !string.IsNullOrEmpty(Request.QueryString["AccountAction"]) ? Request.QueryString["AccountAction"] : null;
                if (!string.IsNullOrEmpty(AccountMgmt))
                {
                    if (AccountMgmt.ToLower() == "recovery")
                    {
                        AccountManagements = "recovery";
                        // If user is log in, prompt user to log out in order to recover their account.

                        // I don't know my password. 
                            // To reset your password, enter the email address you use to sign in to KcGameOn.
                            // Send PassCode in email.
                        // I don't know my username.
                            //  Select a recovery method below.
                            // Email Address.
                            // First and Last name.
                            // Human Verification.
                    }
                    else if (AccountMgmt.ToLower() == "changepassword")
                    {
                        //Make sure User is logged inorder to change password.
                        if (UserCookiesExists() || !string.IsNullOrEmpty(SessionVariables.UserName))
                            AccountManagements = "changepassword";
                        else
                        {
                            // If user is not loged in redirect them to login page.
                            Response.Redirect("Login.aspx");
                          
                        }
                    }
                    else
                    {
                        // Incase user Temper with the URL. Throw 404 Error.
                        Response.Redirect("/ErrorPage/404.aspx");
                    }
                }
                else
                {
                    Response.Redirect("/ErrorPage/404.aspx");
                }
            }
        }

        protected void Recovery_Click(object sender, EventArgs e)
        {
            AccountManagements = "recovery";

            string RadioRecovery = Request.Form["RadioRecovery"].ToString().Trim();

            if (RadioRecovery.Equals("1") )
            {
                if (Request.Form["sequence"].ToString().Trim().Equals("1"))
                {
                    string RecoveryEmail = Request.Form["ctl00$MainContent$Email"].ToString().Trim();
                    if (RecoveryEmail.Length != 0)
                    {
                        MySqlCommand cmd = null;
                        String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
                        try
                        {
                            cmd = new MySqlCommand("spValidateUserEmail", new MySqlConnection(UserInfo));
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("email", RecoveryEmail);

                            cmd.Connection.Open();
                            int userID = Convert.ToInt32(cmd.ExecuteScalar());
                            switch (userID)
                            {
                                case -1:
                                    SessionVariables.recoveryCode = Guid.NewGuid().ToString();
                                    string subject = "KcGameOn Account: Password change request";
                                    string body = "Behold,";
                                    body += "<br /><br />This is an automated message generated by KcGameOn administration to help you reset your KcGameOn password.";
                                    body += "<br /><br />Please enter the following code into the Verification Code field.";
                                    body += "<br /><br /><b>" + SessionVariables.recoveryCode + "</b>";
                                    body += "<br /><br />Thanks,";
                                    body += "<br />KcGameOn Team!";
                                    MailClient Mailsender = new MailClient();
                                    Mailsender.SendEmail(body, subject, RecoveryEmail);
                                    SessionVariables.iSeq = 2;
                                    break;
                                case -2:
                                    // UserNot Found
                                    SessionVariables.iSeq = 1;
                                    recoveryError.Text = "Unable to validate an Email!";
                                    break;
                                default:
                                    break;
                            }
                        }
                        catch
                        {
                            Response.Redirect("/ErrorPage/Error.aspx");
                        }
                        finally
                        {
                            if (cmd.Connection != null)
                                cmd.Connection.Close();
                        }
                    }
                }
                else if (Request.Form["sequence"].ToString().Trim().Equals("2"))
                {
                    if (Request.Form["ctl00$MainContent$inputCode"].ToString().Trim().Equals(SessionVariables.recoveryCode))
                    {
                        string recoveryNewPass = Request.Form["ctl00$MainContent$inputRecoveryNewPass"].ToString().Trim();
                        string recoveryConfirmedPass = Request.Form["ctl00$MainContent$inputConfirmRecoverNewPass"].ToString().Trim();
                        string RecoveryEmail = Request.Form["RecoveryEmail"].ToString().Trim();

                        string username = null;
                        Regex regex = new Regex(@"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}");
                        Match match = regex.Match(recoveryNewPass);

                        if (match.Success && recoveryNewPass == recoveryConfirmedPass && !string.IsNullOrEmpty(RecoveryEmail))
                        {
                            //Hash Users Password.
                            PasswordHash PasswordHasher = new PasswordHash();
                            // Get Username inorder to Salt the password.
                            MySqlCommand cmd = null;
                            MySqlDataReader Reader = null;
                            string SqlConnection = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

                            try
                            {
                                cmd = new MySqlCommand("spGetUserInfo", new MySqlConnection(SqlConnection));
                                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                               
                                cmd.Parameters.AddWithValue("UserName", "");
                                // Add Email Variable.
                                cmd.Parameters.AddWithValue("Email", RecoveryEmail);

                                cmd.Connection.Open();
                                Reader = cmd.ExecuteReader();
                                while (Reader.Read())
                                {
                                    username = Reader.GetString("Username").ToString().ToLower();
                                }

                            }
                            finally
                            {
                                if (cmd.Connection != null)
                                    cmd.Connection.Close();
                                if (Reader != null)
                                    Reader.Close();
                            }
                            
                            if (!string.IsNullOrEmpty(username))
                            {
                                string Salt = PasswordHasher.CreateSalt(username.ToLower());
                                string HashedNewPassword = PasswordHasher.HashPassword(Salt, recoveryNewPass);
                                cmd = null;

                                try
                                {
                                    cmd = new MySqlCommand("spChangePasswordAccountRecovery", new MySqlConnection(SqlConnection));
                                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                                    cmd.Parameters.AddWithValue("UserName", username);
                                    cmd.Parameters.AddWithValue("NewPassword", HashedNewPassword);
                                    cmd.Parameters.AddWithValue("Email", RecoveryEmail);

                                    cmd.Connection.Open();
                                    int ID = Convert.ToInt32(cmd.ExecuteScalar());

                                    switch (ID)
                                    {
                                        case -1:
                                            SessionVariables.iSeq = 3;
                                            // Password Changed Sucessfully.
                                            break;
                                        case -2:
                                            //There was an error while updating password.
                                            break;
                                        default:
                                            break;
                                    }
                                }
                                finally
                                {
                                    if (cmd.Connection != null)
                                        cmd.Connection.Close();
                                }
                            }
                            // If password update successful, only then set the iSeq to 3.
                        }
                        else
                        {
                            recoveryError1.Text = "Error Validating Password!";
                            SessionVariables.iSeq = 2;
                            // Password Must match.
                        }
                        // All Golden
                    }
                    else // Wrong Code.
                    {
                        recoveryError1.Text = "Please check the Verification Code!";
                        SessionVariables.iSeq = 2;
                    }
                }
            }
            // Send User an Email with UserID.
            else if(RadioRecovery.Equals("2"))
            {
                string RecoveryEmail = Request.Form["ctl00$MainContent$UserNameEmail"].ToString().Trim();
                if (RecoveryEmail.Length != 0)
                {
                    MySqlCommand cmd = null;
                    String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
                    try
                    {
                        cmd = new MySqlCommand("spValidateUserEmail", new MySqlConnection(UserInfo));
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("email", RecoveryEmail);

                        cmd.Connection.Open();
                        int userID = Convert.ToInt32(cmd.ExecuteScalar());
                        switch (userID)
                        {
                            case -1:
                                SessionVariables.recoveryCode = Guid.NewGuid().ToString();
                                string subject = "KcGameOn Account: Password change request";
                                string body = "Behold,";
                                body += "<br /><br />This is an automated message generated by KcGameOn administration to help you reset your KcGameOn password.";
                                body += "<br /><br />Please enter the following code into the Verification Code field.";
                                body += "<br /><br /><b>" + SessionVariables.recoveryCode + "</b>";
                                body += "<br /><br />Thanks,";
                                body += "<br />KcGameOn Team!";
                                MailClient Mailsender = new MailClient();
                                Mailsender.SendEmail(body, subject, RecoveryEmail);
                                //SessionVariables.iSeq = 2;
                                break;
                            case -2:
                                // UserNot Found
                                //SessionVariables.iSeq = 1;
                                recoveryError.Text = "Unable to validate an Email!";
                                break;
                            default:
                                break;
                        }
                    }
                    catch
                    {
                        Response.Redirect("/ErrorPage/Error.aspx");
                    }
                    finally
                    {
                        if (cmd.Connection != null)
                            cmd.Connection.Close();
                    }
                }
                // Send User an Email with UserName.       
            }
            else
            {
                Response.Redirect("/ErrorPage/error.aspx");
            }
        }

        protected void PasswordChange_Click(object sender, EventArgs e)
        {
            string Password = Request.Form["ctl00$MainContent$inputCurrentPassword"].ToString().Trim();
            string NewPassword = Request.Form["ctl00$MainContent$inputNewPassword"].ToString().Trim();
            string ConfirmNewPassword = Request.Form["ctl00$MainContent$inputConfirmNewPassword"].ToString().Trim();
            // Check for NewPassword for length requirements.
            Regex Passregex = new Regex(@"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}");
            Match match = Passregex.Match(NewPassword);
            // This is where we change the password. 

            if (!String.IsNullOrEmpty(Password) && !String.IsNullOrEmpty(NewPassword) &&
                    !String.IsNullOrEmpty(ConfirmNewPassword) &&
                    !String.IsNullOrEmpty(NewPassword) && match.Success && NewPassword == ConfirmNewPassword)
            {
                //Hash Users Password.
                PasswordHash PasswordHasher = new PasswordHash();
                string Salt = PasswordHasher.CreateSalt(SessionVariables.UserName.ToLower());
                string HashedPassword = PasswordHasher.HashPassword(Salt, Password);
                string HashedNewPassword = PasswordHasher.HashPassword(Salt, NewPassword);
                
                
                // Update the Database.
                MySqlCommand cmd = null;
                string SqlConnection = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
                try
                {
                    cmd = new MySqlCommand("spChangePassword", new MySqlConnection(SqlConnection));
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("UserName", SessionVariables.UserName);
                    cmd.Parameters.AddWithValue("CurrentPassword", HashedPassword);
                    cmd.Parameters.AddWithValue("NewPassword", HashedNewPassword);

                    cmd.Connection.Open();
                    int ID = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (ID)
                    {
                        case -1:
                            AccountManagements = "changepassword";
                            changePasswordSucess = true;
                            // Password Changed Sucessfully.
                            break;
                        case -2:
                            AccountManagements = "changepassword";
                            ChangePasswordErrorString = "Your Input Sucks!";
                            break;
                        default:
                            break;
                    }
                }
                catch (Exception ex)
                {

                    // Redirect to Error Page.
                }
                finally
                {
                    if(cmd.Connection != null)
                        cmd.Connection.Close();
                }
            }
            else
            {
                AccountManagements = "changepassword";
                ChangePasswordErrorString = "Don’t worry, we have server side Validations! \n Check missing fields, and Password must contain at least 6 characters, including UPPER/lowercase and numbers";
            }
        }
    }
}