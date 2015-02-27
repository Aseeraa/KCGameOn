using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KCGameOn
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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
                            SessionVariables.UserName = ticket.Name;
                        }
                    }
                    //string cookiePath = ticket.CookiePath;
                    //DateTime expiration = ticket.Expiration;
                    //bool expired = ticket.Expired; 
                }
            }
            HttpContext.Current.Session["Magic"] = HttpContext.Current.Request.ServerVariables["REMOTE_HOST"];
        }
    }
}