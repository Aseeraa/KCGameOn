using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.Security;

namespace KCGameOn.Account
{
    public partial class Login : System.Web.UI.Page
    {
        private string errorString;
        private static string redirect;
        string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        MySqlDataReader reader = null;
        MySqlCommand cmd = null;
        public string ErrorString
        {
            get { return errorString;}
            set { errorString = value; }
        }
        
        public void CookiesANDRememberMe()
        {
            // Set Cookies if the RememberMe is checked.
            if (RememberMe.Checked)
            {
                String UserName = Request.Form["ctl00$MainContent$UserName"];
                // Create Authentication Cookies.
                var authTicket = new FormsAuthenticationTicket(1, UserName, DateTime.Now, DateTime.Now.AddDays(Convert.ToInt32(ConfigurationManager.ConnectionStrings["CookieSaveDay"].ConnectionString)), true, "", "/");
                //Encrypt the ticket and add it to the cookie.
                HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(authTicket));
                cookie.Expires = DateTime.Now.AddDays(Convert.ToInt32(ConfigurationManager.ConnectionStrings["CookieSaveDay"].ConnectionString));
                Response.Cookies.Add(cookie);

                // Create a new instance of Cookies class.
                cookies cookiez = new cookies();

                // Create MacAddressCookie
                HttpCookie MacAddressCookie = new HttpCookie(ConfigurationManager.ConnectionStrings["MacCookieName"].ConnectionString);
                MacAddressCookie.Value = cookiez.Protect(cookiez.MacAddress, ConfigurationManager.ConnectionStrings["MacCookieName"].ConnectionString);
                MacAddressCookie.Expires = DateTime.Now.AddDays(Convert.ToInt32(ConfigurationManager.ConnectionStrings["CookieSaveDay"].ConnectionString));
                Response.Cookies.Add(MacAddressCookie);

                // Create IpAddressCookie
                HttpCookie IpAddressCookie = new HttpCookie(ConfigurationManager.ConnectionStrings["IpCookieName"].ConnectionString);
                IpAddressCookie.Value = cookiez.Protect(cookiez.IPAddress, ConfigurationManager.ConnectionStrings["IpCookieName"].ConnectionString);
                IpAddressCookie.Expires = DateTime.Now.AddDays(Convert.ToInt32(ConfigurationManager.ConnectionStrings["CookieSaveDay"].ConnectionString));
                Response.Cookies.Add(IpAddressCookie);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.UrlReferrer != null){
                if (!Request.UrlReferrer.ToString().Contains("Account/Login.aspx"))
                {
                    redirect = Request.UrlReferrer.ToString();
                }
            }

            if (!IsPostBack)
            {
                ErrorString = null;
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
                            if (String.IsNullOrEmpty(redirect))
                            {
                                    Response.Redirect("/Default.aspx");
                            }
                            else if (redirect.Contains("/AccountManagement.aspx"))
                            {
                                Response.Redirect("/Default.aspx");
                            }
                            else
                            {
                                Response.Redirect(redirect);
                            }
                        }
                    }
                }
            }
            else
            {
                
            }

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            String UserName = Request.Form["ctl00$MainContent$UserName"];
            String Password = Request.Form["ctl00$MainContent$Password"];

            //Set Connection String to MySql.
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

            if (UserName != null && Password != null)
            {

                //Hash Users Password.
                PasswordHash PasswordHasher = new PasswordHash();
                String Salt = PasswordHasher.CreateSalt(UserName.ToLower());
                String HashedPassword = PasswordHasher.HashPassword(Salt, Password);
                MySqlCommand cmd =  null;
                int Authentication = 0;

                try
                {
                    cmd = new MySqlCommand("checkUser", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("Username", UserName);
                    cmd.Parameters.AddWithValue("UserPass", HashedPassword);

                    cmd.Connection.Open();
                    //Reader = cmd.ExecuteReader();
                    Authentication = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (Authentication)
                    {
                        case -1:
                            ErrorString = "Please Activate your account.";
                            break;
                        case -2: // UserActivated, User Is Admin and UserAuthenticated.
                            SessionVariables.UserName = UserName;
                            SessionVariables.UserAdmin = 1;
                            // Set Cookies if Remember was checked.
                            CookiesANDRememberMe();
                            break;
                        case -3: // UserActivatd, UseAuthenticated and User isn't Admin.
                            SessionVariables.UserName = UserName;
                            SessionVariables.UserAdmin = 0;
                            // Set Cookies if Remember was checked.
                            CookiesANDRememberMe();
                            break;
                        case -4:
                            ErrorString = "Your Input Sucks!";
                            break;
                        default:
                            break;
                    }
                }
                finally
                {
                    if(cmd != null)
                        cmd.Connection.Close();          
                }

                try
                {
                    
                    cmd = new MySqlCommand("SELECT BlockPayments FROM AdminProperties", new MySqlConnection(UserInfo));
                    cmd.Connection.Open();
                    cmd.CommandType = System.Data.CommandType.Text;
                    string blocked = cmd.ExecuteScalar().ToString();
                    if (blocked.Equals("TRUE"))
                        if(SessionVariables.UserAdmin == 0 && !SessionVariables.UserName.ToLower().Equals("kctestaccount"))
                            SessionVariables.registrationBlocked = true;
                        else
                            SessionVariables.registrationBlocked = false;
                }
                catch (Exception)
                {

                }
                finally
                {
                    if (cmd.Connection != null)
                        cmd.Connection.Close();
                }
                
                if (SessionVariables.UserName != null)
                {
                    try
                    {
                        cmd = new MySqlCommand("SELECT pay.idpaytable, pay.username, pay.EventID, sea.checkedin, pay.verifiedPaid, pay.paymentKey FROM payTable AS pay LEFT JOIN (SELECT username, checkedin FROM seatingchart WHERE username = \"" + SessionVariables.UserName + "\" AND ActiveIndicator = \"TRUE\") sea on pay.username = sea.username WHERE pay.username = \"" + SessionVariables.UserName + "\" AND pay.EventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1) AND pay.verifiedPaid = \'Y\'", new MySqlConnection(UserInfo));
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        IAsyncResult result = cmd.BeginExecuteReader();
                        reader = cmd.EndExecuteReader(result);
                        result = cmd.BeginExecuteReader();
                        if (reader == null || !reader.HasRows)
                        {
                            SessionVariables.verifiedPaid = "N";
                        }
                        else
                        {
                            while (reader.Read())
                            {
                                SessionVariables.paymentKey = reader["paymentKey"].ToString();
                                SessionVariables.verifiedPaid = reader["verifiedPaid"].ToString();
                            }
                        }
                    }
                    catch (Exception)
                    {
                    }
                    finally
                    {
                        if (reader != null)
                        {
                            reader.Close();
                        }
                        if (cmd != null)
                        {
                            cmd.Connection.Close();
                        }
                    }
                    if (String.IsNullOrEmpty(redirect))
                    {
                        Response.Redirect("/Default.aspx");
                    }
                    else if(redirect.Contains("/AccountManagement.aspx"))
                        {
                            Response.Redirect("/Default.aspx");
                        }
                    else
                    {
                        Response.Redirect(redirect);
                    }
                }
            }
        }
    }
}