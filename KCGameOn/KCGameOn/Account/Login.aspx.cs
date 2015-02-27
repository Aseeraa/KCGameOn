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
                
                if (SessionVariables.UserName != null)
                {
                    if (String.IsNullOrEmpty(redirect))
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