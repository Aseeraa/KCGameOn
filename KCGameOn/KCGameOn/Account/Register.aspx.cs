using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Xml;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

namespace KCGameOn.Account
{
    public partial class Register : System.Web.UI.Page
    {
        private string errorString;
        public bool registartionSucess;
        public string RegisterErrorString
        {
            get { return errorString; }
            set { errorString = value; }
        }
        public bool RegistrationSucess
        {
            get { return registartionSucess; }
            set { registartionSucess = value;}
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeForm();

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
                            SessionVariables.UserName = ticket.Name;
                            Response.Redirect("/Default.aspx");
                        }
                    }
                }
            }
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:disableSubmit(); ", true);
        }
        private void InitializeForm()
        {
            RegisterErrorString = null;
            RegistrationSucess = false;
        }
        public bool Validate()
        {
            string Response = Request.Form["g-recaptcha-response"];
            bool Valid = false;

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create("https://www.google.com/recaptcha/api/siteverify?secret=" + System.Configuration.ConfigurationManager.ConnectionStrings["captchaKey"].ToString() + "&response=" + Response);
            try
            {
                using (WebResponse wResoponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResoponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                        JavaScriptSerializer js = new JavaScriptSerializer();
                        MyObject data = js.Deserialize<MyObject>(jsonResponse);

                        Valid = Convert.ToBoolean(data.success);
                    }
                }
                return Valid;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }
        public class MyObject
        {
            public string success { get; set; }
        }
        protected void SignButton_Click(object sender, EventArgs e)
        {
            //if(Recaptcha.IsValid)
            String FirstName = Request.Form["ctl00$MainContent$inputFirst"].ToString().Trim();
            String LastName = Request.Form["ctl00$MainContent$inputLast"].ToString().Trim();
            String Email = Request.Form["ctl00$MainContent$inputEmail"].ToString().Trim();
            String ConfirmEmail = Request.Form["ctl00$MainContent$inputEmail1"].ToString().Trim();
            String UserName = Request.Form["ctl00$MainContent$inputUser"].ToString().Trim();
            String Sponsor = Request.Form["ctl00$MainContent$inputCerner"].ToString().Trim();
            String Password = Request.Form["ctl00$MainContent$Password"].ToString().Trim();
            String ConfirmPassword = Request.Form["ctl00$MainContent$Password1"].ToString().Trim();
            String SecretQuestion = Request.Form["ctl00$MainContent$DropDownList1"].ToString().Trim();
            String SecretAnswer = Request.Form["ctl00$MainContent$SecretAnswer"].ToString().Trim();
            Regex regex = new Regex(@"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}");
            Match match = regex.Match(Password);
            
            //No spaces allowed :).
            Regex.Replace(UserName, @"\s+", "");

            int userID = 0;

            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

            if (Validate())
            {
                if (!String.IsNullOrEmpty(UserName) && !String.IsNullOrEmpty(Password) &&
                    !String.IsNullOrEmpty(Email) && !String.IsNullOrEmpty(SecretAnswer) &&
                    !String.IsNullOrEmpty(SecretAnswer) && match.Success && Password == ConfirmPassword && Email == ConfirmEmail)
                {
                    //Hash Users Password.
                    PasswordHash PasswordHasher = new PasswordHash();
                    String Salt = PasswordHasher.CreateSalt(UserName.ToLower());
                    String HashedPassword = PasswordHasher.HashPassword(Salt, Password);
                    String HashedSecretAnswer = PasswordHasher.HashPassword(Salt, SecretAnswer.ToLower());
                    MySqlCommand cmd = null;

                    try
                    {
                        cmd = new MySqlCommand("AddUsers", new MySqlConnection(UserInfo));
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("UserName", UserName);
                        cmd.Parameters.AddWithValue("Pass", HashedPassword);
                        cmd.Parameters.AddWithValue("First", FirstName);
                        cmd.Parameters.AddWithValue("Last", LastName);
                        cmd.Parameters.AddWithValue("Email", Email);
                        cmd.Parameters.AddWithValue("Cerner", Sponsor);
                        cmd.Parameters.AddWithValue("Admin", 0);
                        cmd.Parameters.AddWithValue("SecretQuestion", SecretQuestion);
                        cmd.Parameters.AddWithValue("SecretAnswer", HashedSecretAnswer);

                        cmd.Connection.Open();
                        userID = Convert.ToInt32(cmd.ExecuteScalar());

                        switch (userID)
                        {
                            case -1:
                                RegisterErrorString = "Username already exists.";
                                break;
                            case -2:
                                RegisterErrorString = "Email address has already been used.";
                                break;
                            default:
                                SendActivationEmail(userID, UserName);
                                RegistrationSucess = true;
                                //SessionVariables.UserName = UserName;
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        // Redirect to Error Page.
                    }
                    finally
                    {
                        cmd.Connection.Close();
                    }
                }
                else
                {
                    RegisterErrorString = "Don’t worry, we have server side Validations! \n Check missing fields, and Password must contain at least 6 characters, including UPPER/lowercase and numbers";
                }
            }
            else
            {
                RegisterErrorString = "We've indicated that you're not a Human.";
                //"Dont worry we do server side Validations!"
            }
        }
        private void SendActivationEmail(int userID, string userName)
        {
            string activationCode = Guid.NewGuid().ToString();
            //Insert into Database.
            using (MySqlCommand cmd = new MySqlCommand("INSERT INTO UserActivation VALUES(@UserId, @ActivationCode)", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Parameters.AddWithValue("@UserId", userID);
                cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
            }
            //Send User an email.
            string subject = "KcGameOn Account Activation";
            string body = "Behold " + userName + ",";
            body += "<br /><br />Registration is almost complete!";
            body += "<br /><br />This message is an automated reply to your registration request. In order to complete the process, please validate your email address by clicking the link below.";
            body += "<br /><a href = '" + Request.Url.AbsoluteUri.Replace("Register.aspx", "Activation.aspx?ActivationCode=" + activationCode) + "'>Click here to activate your account.</a>";
            body += "<br /><br />Once validated, you will be able to register for the events, get event information and sound off on the message board.";
            body += "<br /><br />If you did not register for our website, kcgameon.com, then feel free to ignore this email and you will not be bothered again";
            body += "<br /><br />Thanks,";
            body += "<br />KcGameOn";
            MailClient Mailsender = new MailClient();
            Mailsender.SendEmail(body, subject, Request.Form["ctl00$MainContent$inputEmail"]);
        }
    }
}