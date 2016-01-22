using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Text;
using System.Net.NetworkInformation;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace KCGameOn
{
    public class SessionVariables
    {
        public static int UserAdmin;
        public static bool registrationBlocked;
        private static string paymentVerify;

        public static string getSessionString(String name)
        {
            if (HttpContext.Current.Session[name] != null)
            {
                return HttpContext.Current.Session[name].ToString().Trim();
            }
            else
            {
                return null;
            }
        }
        private static string RecoveryCode;
        public static string recoveryCode
        {
            get { return RecoveryCode; }
            set { RecoveryCode = value; }
        }
        private static int iseq;
        public static int iSeq
        {
            get { return iseq; }
            set { iseq = value; }
        }
        private static void setSessionString(object item, string name)
        {
            if (item != null)
            {
                HttpContext.Current.Session[name] = item.ToString().Trim();
            }
            else
            {
                HttpContext.Current.Session[name] = null;
            }
        }

        public static string UserName
        {
            get { return getSessionString("UserName");}
            set { setSessionString(value, "UserName"); }
        }

        public static string paymentKey { get; set; }

        public static string verifiedPaid
        {
            get { return paymentVerify; }
            set
            {
                paymentVerify = value;
                if (paymentVerify.Equals("Y"))
                {
                    updatePayTable(paymentKey);
                }
            }
        }

        private static void updatePayTable(string paymentkey)
        {
            string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader reader = null;
            MySqlCommand cmd = null;
            try
            {
                cmd = new MySqlCommand("spUpdatePayment", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Connection.Open();
                cmd.Parameters.AddWithValue("Username", SessionVariables.UserName);
                cmd.Parameters.AddWithValue("PaymentKey", paymentkey);
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
        }
    }

    public class cookies
    {
        private string authcookies;
        private string macAddress;
        private string ipAddress;

        public string AuthCookies
        {
            get { return authcookies; }
            set { authcookies = value; }
        }
        public string MacAddress
        {
            get 
            {
                NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
                return nics[0].GetPhysicalAddress().ToString();
            }
        }
        public string IPAddress
        {
            get
            {
                NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
                return nics[0].GetIPProperties().UnicastAddresses.ToString();

            }
        }

        // Cookie protections, machine level encryption.
        public string Protect(string data, string purpose)
        {
            if (string.IsNullOrEmpty(data))
                return null;
            byte[] stream = Encoding.UTF8.GetBytes(data);
            byte[] encodedValue = MachineKey.Protect(stream, purpose);
            return HttpServerUtility.UrlTokenEncode(encodedValue);

        }
        // Decryption method for machine level encryption.
        public string Unprotect(string data, string purpose)
        {
            if (string.IsNullOrEmpty(data))
                return null;
            byte[] stream = HttpServerUtility.UrlTokenDecode(data);
            byte[] decodedValue = MachineKey.Unprotect(stream, purpose);
            return Encoding.UTF8.GetString(decodedValue);
        }
    }

    public class PasswordHash
    {
        public string CreateSalt(string UserName)
        {
            Rfc2898DeriveBytes hasher = new Rfc2898DeriveBytes(UserName,
                System.Text.Encoding.Default.GetBytes("KcGaM30n"), 10000);
            return Convert.ToBase64String(hasher.GetBytes(25));
        }

        public string HashPassword(string Salt, string Password)
        {
            Rfc2898DeriveBytes Hasher = new Rfc2898DeriveBytes(Password,
                System.Text.Encoding.Default.GetBytes(Salt), 10000);
            return Convert.ToBase64String(Hasher.GetBytes(25));
        }
    }
    public class MailClient
    {
        public void SendEmail(string body, string subject, string ToEmail)
        {
            //Send User an email.
            using (MailMessage mm = new MailMessage(ConfigurationManager.ConnectionStrings["FromEmail"].ConnectionString, ToEmail))
            {
                mm.Subject = subject;
                mm.Body = body;
                mm.IsBodyHtml = true;

                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = true,
                    Credentials = new NetworkCredential(ConfigurationManager.ConnectionStrings["FromEmail"].ConnectionString, ConfigurationManager.ConnectionStrings["FromEmailPass"].ConnectionString)
                };
                smtp.Send(mm);
            }
        }
    }
}