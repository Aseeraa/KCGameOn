using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text;

namespace KCGameOn.Admin
{
    public partial class Admin : System.Web.UI.Page
    {
        public static List<UsersObject> userlist = new List<UsersObject>();
        public static List<String> usernames = new List<String>();
        public static List<String> firstnames = new List<String>();
        public static List<String> lastnames = new List<String>();
        public static List<String> names = new List<String>();
        public static UsersObject current = new UsersObject("", "", "");
        public static StringBuilder AdminUserHTML;
        protected void Page_Load(object sender, EventArgs e)
        {
            userlist = new List<UsersObject>();
            usernames = new List<String>();
            firstnames = new List<String>();
            lastnames = new List<String>();
            names = new List<String>();

            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader = null;
            MySqlCommand cmd = null;
            MySqlConnection conn = null;

            try
            {
                conn = new MySqlConnection(UserInfo);
                conn.Open();
                userlist = new List<UsersObject>();
                usernames = new List<String>();
                firstnames = new List<String>();
                lastnames = new List<String>();
                names = new List<String>();
                cmd = new MySqlCommand("getUsers", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                IAsyncResult result = cmd.BeginExecuteReader();
                Reader = cmd.EndExecuteReader(result);
                //Reader = cmd.ExecuteReader();
                //DefaultHTML = new StringBuilder();

                while (Reader.Read())
                {

                    string username = Reader.GetString("UserName").ToString();
                    string first = Reader.GetString("FirstName").ToString();
                    string last = Reader.GetString("LastName").ToString();
                    UsersObject newUser = new UsersObject(username, first, last);
                    usernames.Add(username);
                    firstnames.Add(first);
                    lastnames.Add(last);
                    names.Add(first + ' ' + last);
                    userlist.Add(newUser);
                }
                Reader.Close();
                Reader = null;
                names.Sort();
                usernames.Sort();
                firstnames.Sort();
                lastnames.Sort();
                if (SessionVariables.UserName != null)
                {
                    if (current != null)
                    {
                        if (current.Username != SessionVariables.UserName)
                        {
                            foreach (var user in userlist)
                            {

                                if (user.Username == SessionVariables.UserName.ToLower())
                                {
                                    current = user;
                                }
                            }
                        }
                    }
                }

                //populate user table in admin page
                cmd = new MySqlCommand("SELECT DISTINCT * FROM payTable WHERE eventID = 67 AND verifiedPaid = \'Y\' AND activeIndicator=\'TRUE\'", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                AdminUserHTML = new StringBuilder();
                List<string> usersPaid = new List<string>();
                while (Reader.Read())
                {
                    usersPaid.Add(Reader.GetString("userName"));
                }
                Reader.Close();

                foreach (UsersObject user in userlist)
                {
                    AdminUserHTML.AppendLine("<tr>");
                    AdminUserHTML.AppendLine("<td class=\"col-md-1\">").Append(user.Username).Append("</td>");

                    AdminUserHTML.AppendLine("<td class=\"col-md-1\">").Append(user.First).Append("</td>");
                    AdminUserHTML.AppendLine("<td class=\"col-md-1\">").Append(user.Last).Append("</td>");

                    if (usersPaid.Contains(user.Username))
                    {
                        AdminUserHTML.AppendLine("<td class=\"col-md-1\">").Append("<img src=\'/img/Button-Check-icon.png\' height=\"20px\" width=\"20px\"/>").Append("</td>");
                    }
                    else
                        AdminUserHTML.AppendLine("<td class=\"col-md-1\">").Append("<img src=\'/img/Actions-button-cancel-icon.png\' height=\"20px\" width=\"20px\"/>").Append("</td>");
                    AdminUserHTML.AppendLine("</tr>");
                }
            }
            catch (Exception)
            {

            }
            finally
            {
                if (cmd.Connection != null)
                    cmd.Connection.Close();
                if (Reader != null)
                    Reader.Close();
                if (conn != null)
                {
                    conn.Close();
                }
            }
        }

        [WebMethod]
        public static bool addPayment(string data)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            List<Users> payment = new List<Users>();
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<String[]> mystring = json.Deserialize<List<string[]>>(data);

            String user = mystring.ElementAt(0).ElementAt(0).ToString();
            String first = mystring.ElementAt(0).ElementAt(1).ToString().Split(' ').ElementAt(0);
            String last = mystring.ElementAt(0).ElementAt(1).ToString().Split(' ').ElementAt(1);
            String paymentType = mystring.ElementAt(0).ElementAt(2).ToString();

            MySqlCommand cmd = null;
            MySqlConnection conn = null;

            try
            {
                conn = new MySqlConnection(UserInfo);
                conn.Open();

                cmd = new MySqlCommand("spAddPayment", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("UserName", user);
                cmd.Parameters.AddWithValue("VerifiedPaid", "Y");
                cmd.Parameters.AddWithValue("PaidFullYear", "N");
                cmd.Parameters.AddWithValue("PaymentMethod", paymentType);
                cmd.Parameters.AddWithValue("PaymentKey", "");

                cmd.ExecuteScalar();
                conn.Close();
            }
            catch (Exception)
            {
                //return "An internal error has occurred, please contact an administrator.";
                return false;
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
            }
            return true;
        }
    }
}