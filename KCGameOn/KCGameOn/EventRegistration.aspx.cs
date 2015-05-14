using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using HtmlAgilityPack;
using MySql.Data.MySqlClient;
using PayPal;
using PayPal.Api;

namespace KCGameOn
{
    public partial class EventRegistration : System.Web.UI.Page
    {
        public static List<users> userlist = new List<users>();
        public static List<String> usernames = new List<String>();
        public static List<String> firstnames = new List<String>();
        public static List<String> lastnames = new List<String>();
        public static List<String> names = new List<String>();
        public List<users> payments = new List<users>();
        public static int quantity = 0;
        public static users current = new users("", "", "");
        public static StringBuilder newRow;
        //private static Page page;
        public static String RedirectURL;

        protected void Page_Load(object sender, EventArgs e)
        {
            //page = this.Page;
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader = null;
            MySqlCommand cmd = null;
            MySqlConnection conn = null;

            try
            {
                conn = new MySqlConnection(UserInfo);
                conn.Open();
                userlist = new List<users>();
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
                    users newUser = new users(username, first, last);
                    usernames.Add(username);
                    firstnames.Add(first);
                    lastnames.Add(last);
                    names.Add(first + ' ' + last);
                    userlist.Add(newUser);
                }
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


        public class users
        {
            private string username;
            private string firstname;
            private string lastname;
            private double price;

            public users(string username, string firstname, string lastname)
            {
                // TODO: Complete member initialization
                this.username = username;
                this.firstname = firstname;
                this.lastname = lastname;
            }

            public string Username
            {
                set { this.username = value; }
                get { return this.username; }
            }

            public string First
            {
                set { this.firstname = value; }
                get { return this.firstname; }
            }

            public string Last
            {
                set { this.lastname = value; }
                get { return this.lastname; }
            }

            public double Price
            {
                set { this.price = value; }
                get { return this.price; }
            }
        }

        [WebMethod()]
        public static String BuyTickets(string data)
        {
            bool tableValid = true;
            //Payment paymnt = null;
            quantity = 0;
            List<users> payment = new List<users>();
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<String[]> mystring = json.Deserialize<List<string[]>>(data);
            for (int i = 0; i < mystring.Count; i++)
            {
                String user = mystring.ElementAt(i).ElementAt(0).ToString();
                String first = mystring.ElementAt(i).ElementAt(1).ToString();
                String last = mystring.ElementAt(i).ElementAt(2).ToString();
                String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

                MySqlCommand cmd = null;
                MySqlConnection conn = null;

                try
                {
                    conn = new MySqlConnection(UserInfo);
                    conn.Open();

                    cmd = new MySqlCommand("spValidateUsersForPayment", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("UserName", user);
                    cmd.Parameters.AddWithValue("Firstname", first);
                    cmd.Parameters.AddWithValue("Lastname", last);

                    int userValue = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (userValue)
                    {
                        case -1: // Successfully Validated
                            break;
                        case -2: // Unsuccessfully validated
                            tableValid = false;
                            //return String.Format("User: {0}, {1}, {2} is not correct, please choose the correct username, first name, and last name.", user, first, last);
                            break;
                        default:
                            break;
                    }
                    conn.Close();

                }
                catch (Exception)
                {
                    //return "An internal error has occurred, please contact an administrator.";
                    //return;
                }
                finally
                {
                    if (conn != null)
                    {
                        conn.Close();
                    }
                }
            }
            if (tableValid)
            {
                quantity = mystring.Count;
                //paymnt = CreatePayment("daniel.t.robison-facilitator@gmail.com", "15.00", quantity.ToString(), "KCGameOn Tickets", "www.kcgameon.com/Map.aspx", "www.kcgameon.com/Default.aspx");
                string url = "https://www.sandbox.paypal.com/cgi-bin/webscr";


                var builder = new StringBuilder();
                builder.Append(url);
                builder.AppendFormat("?cmd=_xclick&business={0}", HttpUtility.UrlEncode("daniel.t.robison-facilitator@gmail.com"));
                builder.Append("&lc=US&no_note=0&currency_code=USD");
                builder.AppendFormat("&item_name={0}", HttpUtility.UrlEncode("KCGameOn Ticket"));
                builder.AppendFormat("&amount={0}", HttpUtility.UrlEncode("15.00"));
                builder.AppendFormat("&return={0}", HttpUtility.UrlEncode("www.kcgameon.com/Map.aspx"));
                builder.AppendFormat("&cancel_return={0}", HttpUtility.UrlEncode("www.kcgameon.com/Default.aspx"));
                builder.AppendFormat("&quantity={0}", HttpUtility.UrlEncode(quantity.ToString()));

                //WkznwF8qQAau1-lXhLJrkhkS0WfwoUnwghvu7U4XV-fZp0J_edX7DK0cKuu

                RedirectURL = builder.ToString();

            }
            else
            {
                quantity = 0;
                RedirectURL = "www.kcgameon.com/Default.aspx";
            }
            //HttpContext.Current.Response.Redirect(RedirectURL, true);
            return RedirectURL;
        }

        //public static Payment CreatePayment(string email, string orderAmount, string orderQuan, string orderDescription, string returnUrl, string cancelUrl)
        //{
        //    Payment pymnt = null;

        //    Amount amount = new Amount();
        //    amount.currency = "USD";
        //    amount.total = orderAmount;

        //    RedirectUrls redirectUrls = new RedirectUrls();
        //    redirectUrls.return_url = returnUrl;
        //    redirectUrls.cancel_url = cancelUrl;

        //    Transaction transaction = new Transaction();
        //    transaction.amount = amount;
        //    transaction.description = orderDescription;
        //    transaction.notify_url = "www.kcgameon.com/Map.aspx";
        //    List<Transaction> transactions = new List<Transaction>();
        //    transactions.Add(transaction);

        //    Payer payer = new Payer();

        //    Payment pyment = new Payment();
        //    pyment.intent = "sale";
        //    pyment.payer = payer;
        //    pyment.transactions = transactions;
        //    pyment.redirect_urls = redirectUrls;

        //    pymnt = pyment.Create(Api);
        //    return pymnt;
        //}

        //private static string AccessToken
        //{
        //    get
        //    {
        //        string token = new OAuthTokenCredential
        //                        (
        //                           "AT2GqVN3r3pMF8uMUBCt4ppky6PAyHN4eOvOxeJTzmXfbIvOFYDV1g8OSzAfiffnjAY2dwGXXSfod4Un",
        //                            "EKsz2uNaFzeNu9tqa25ild9fhg_RpNau-FejBIMFuY85_nzr1yf2LmKRAWFhaGAqtLhXa9XvzjnboTeH"
        //                        ).GetAccessToken();
        //        return token;
        //    }
        //}

        //private static APIContext Api
        //{
        //    get
        //    {
        //        APIContext context = new APIContext(AccessToken);
        //        return context;
        //    }
        //}

        //public void deleteLast(object sender, EventArgs e)
        //{
        //    int rowCount = registrationTable.Rows.Count - 1;
        //    if (rowCount < 1)
        //    {
        //        registrationTable.Rows[1].Cells.Clear();
        //    }
        //    else
        //    {
        //        TableRow row = registrationTable.Rows[rowCount];
        //        registrationTable.Rows.Remove(row);
        //    }
        //}

        //public void addUser(object sender, EventArgs e)
        //{
        //    newRow = new StringBuilder();
        //    String username = Request.Form["ctl00$MainContent$lastDropdown"].ToString().Trim();
        //    String firstname = Request.Form["ctl00$MainContent$userDropdown"].ToString().Trim();
        //    String lastname = Request.Form["ctl00$MainContent$firstDropdown"].ToString().Trim();

        //    TableRow row = new TableRow();
        //    for (int i = 0; i < 4; i++)
        //    {
        //        row.Cells.Add(new TableCell());
        //    }

        //    row.Cells[0].Text = username;
        //    row.Cells[1].Text = firstname;
        //    row.Cells[2].Text = lastname;
        //    row.Cells[3].Text = "15.00";

        //    registrationTable.Rows.Add(row);
        //}

        //public void addPayment(String username, String firstname, String lastname)
        //{
        //    if (!String.IsNullOrEmpty(username) || !String.IsNullOrEmpty(firstname) || !String.IsNullOrEmpty(lastname))
        //    {
        //        if (!username.Equals("None") || !firstname.Equals("None") || !lastname.Equals("None"))
        //        {
        //            payments.Add(new users(username, firstname, lastname));
        //        }
        //    }
        //}

        //public void removePayment(String username, String firstname, String lastname)
        //{
        //    if (!String.IsNullOrEmpty(username) || !String.IsNullOrEmpty(firstname) || !String.IsNullOrEmpty(lastname))
        //    {
        //        if (!username.Equals("None") || !firstname.Equals("None") || !lastname.Equals("None"))
        //        {
        //            users user = new users(username, firstname, lastname);
        //            payments.Remove(user);
        //        }
        //    }
        //}

        //public void submitPayment(List<users> payments)
        //{

        //}
    }
}