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
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using HtmlAgilityPack;
using MySql.Data.MySqlClient;
using PayPal.AdaptivePayments;
using PayPal.AdaptivePayments.Model;

namespace KCGameOn
{
    public partial class EventRegistration : System.Web.UI.Page
    {
        //Used on pageload only.
        public static List<users> userlist = new List<users>();
        public static List<String> usernames = new List<String>();
        public static List<String> firstnames = new List<String>();
        public static List<String> lastnames = new List<String>();
        public static List<String> names = new List<String>();

        public static String tableUsername = "";
        public static String tableFirstname = "";
        public static String tableLastname = "";

        //For use with "Pay Now" button
        public static List<users> usersToPay = new List<users>();


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

        [WebMethod]
        [ScriptMethod]
        public static String BuyTickets()
        //public static String BuyTickets(string data)
        {
            bool tableValid = true;
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            //Payment paymnt = null;
            quantity = 0;
            List<users> payment = new List<users>();
            JavaScriptSerializer json = new JavaScriptSerializer();
            //List<String[]> mystring = json.Deserialize<List<string[]>>(data);
            //for (int i = 0; i < mystring.Count; i++)
            foreach(users user in usersToPay)
            {
                string username = user.Username;
                string first = user.First;
                string last = user.Last;
                //String user = mystring.ElementAt(i).ElementAt(0).ToString();
                //String first = mystring.ElementAt(i).ElementAt(1).ToString();
                //String last = mystring.ElementAt(i).ElementAt(2).ToString();
               
                MySqlCommand cmd = null;
                MySqlConnection conn = null;

                try
                {
                    conn = new MySqlConnection(UserInfo);
                    conn.Open();

                    cmd = new MySqlCommand("spValidateUsersForPayment", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("UserName", username);
                    cmd.Parameters.AddWithValue("Firstname", first);
                    cmd.Parameters.AddWithValue("Lastname", last);

                    int userValue = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (userValue)
                    {
                        case -1: // Successfully Validated
                            //quantity = mystring.Count;
                            quantity = usersToPay.Count;
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
                PayRequest requestPay = Payment(quantity);
                PayResponse responsePay = PayAPIOperations(requestPay);
                RedirectURL = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=" + responsePay.payKey;
                //for (int i = 0; i < mystring.Count; i++)
                foreach (users user in usersToPay)
                {
                    String username = user.Username;//mystring.ElementAt(i).ElementAt(0).ToString();
                    String payKey = responsePay.payKey;
                    String fullYear = "N";
                    String verfiedPaid = "N";
                    String paymentMethod = "PayPal";

                    MySqlCommand cmd = null;
                    MySqlConnection conn = null;

                    try
                    {
                        conn = new MySqlConnection(UserInfo);
                        conn.Open();

                        cmd = new MySqlCommand("spAddPayment", conn);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("Username", username);
                        cmd.Parameters.AddWithValue("VerifiedPaid", verfiedPaid);
                        cmd.Parameters.AddWithValue("PaidFullYear", fullYear);
                        cmd.Parameters.AddWithValue("PaymentMethod", paymentMethod);
                        cmd.Parameters.AddWithValue("PaymentKey", payKey);

                        int userValue = Convert.ToInt32(cmd.ExecuteScalar());
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
            }
            else
            {
                quantity = 0;
                RedirectURL = "www.kcgameon.com/Default.aspx";
            }
            //HttpContext.Current.Response.Redirect(RedirectURL, true);
            return RedirectURL;
        }

        // # Payment
        public static PayRequest Payment(int quantity)
        {
            // # PayRequest
            // The code for the language in which errors are returned
            RequestEnvelope envelopeRequest = new RequestEnvelope();
            envelopeRequest.errorLanguage = "en_US";

            List<Receiver> listReceiver = new List<Receiver>();

            // Amount to be credited to the receiver's account
            decimal amount = Convert.ToDecimal(quantity * 15.00);
            Receiver receive = new Receiver(amount);

            // A receiver's email address
            receive.email = "payments@kcgameon.com";
            listReceiver.Add(receive);
            ReceiverList listOfReceivers = new ReceiverList(listReceiver);

            // PayRequest which takes mandatory params:
            //  
            // * `Request Envelope` - Information common to each API operation, such
            // as the language in which an error message is returned.
            // * `Action Type` - The action for this request. Possible values are:
            // * PAY - Use this option if you are not using the Pay request in
            // combination with ExecutePayment.
            // * CREATE - Use this option to set up the payment instructions with
            // SetPaymentOptions and then execute the payment at a later time with
            // the ExecutePayment.
            // * PAY_PRIMARY - For chained payments only, specify this value to delay
            // payments to the secondary receivers; only the payment to the primary
            // receiver is processed.
            // * `Cancel URL` - URL to redirect the sender's browser to after
            // canceling the approval for a payment; it is always required but only
            // used for payments that require approval (explicit payments)
            // * `Currency Code` - The code for the currency in which the payment is
            // made; you can specify only one currency, regardless of the number of
            // receivers
            // * `Recevier List` - List of receivers
            // * `Return URL` - URL to redirect the sender's browser to after the
            // sender has logged into PayPal and approved a payment; it is always
            // required but only used if a payment requires explicit approval
            PayRequest requestPay = new PayRequest(envelopeRequest, "PAY", "https://kcgameon.com/Default.aspx", "USD", listOfReceivers, "https://kcgameon.com/Map.aspx");
            return requestPay;
        }

        // # Pay API Operations
        // Use the Pay API operations to transfer funds from a sender’s PayPal account to one or more receivers’ PayPal accounts. You can use the Pay API operation to make simple payments, chained payments, or parallel payments; these payments can be explicitly approved, preapproved, or implicitly approved. 
        public static PayResponse PayAPIOperations(PayRequest reqPay)
        {
            // Create the PayResponse object
            PayResponse responsePay = new PayResponse();

            try
            {
                // Create the service wrapper object to make the API call
                AdaptivePaymentsService service = new AdaptivePaymentsService();

                // # API call
                // Invoke the Pay method in service wrapper object
                responsePay = service.Pay(reqPay);

                if (responsePay != null)
                {
                    // Response envelope acknowledgement
                    string acknowledgement = "Pay API Operation - ";
                    acknowledgement += responsePay.responseEnvelope.ack.ToString();

                    // # Success values
                    if (responsePay.responseEnvelope.ack.ToString().Trim().ToUpper().Equals("SUCCESS"))
                    {
                        // The pay key, which is a token you use in other Adaptive
                        // Payment APIs (such as the Refund Method) to identify this
                        // payment. The pay key is valid for 3 hours; the payment must
                        // be approved while the pay key is valid.

                        //use responsePay.payKey with username

                        // Once you get success response, user has to redirect to PayPal
                        // for the payment. Construct redirectURL as follows,
                        //redirectURL="https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=" + responsePay.payKey;
                    }
                    // # Error Values 
                    else
                    {
                        List<ErrorData> errorMessages = responsePay.error;
                        foreach (ErrorData error in errorMessages)
                        {

                        }
                    }
                }
            }
            // # Exception log    
            catch (System.Exception ex)
            {
                // Log the exception message
            }
            return responsePay;
        }

        public class users
        {
            private string username;
            private string firstname;
            private string lastname;
            private double price;

            public users()
            {

            }
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

        protected void pay_Click(object sender, EventArgs e)
        {

        }

        protected void add_Click(object sender, EventArgs e)
        {
            // Total number of rows.
            int rowCnt;
            // Current row count.
            int rowCtr;
            // Total number of cells per row (columns).
            int cellCtr;
            // Current cell counter
            int cellCnt;

            rowCnt = int.Parse(TextBox1.Text);
            cellCnt = int.Parse(TextBox2.Text);

            for (rowCtr = 1; rowCtr <= rowCnt; rowCtr++)
            {
                // Create new row and add it to the table.
                TableRow tRow = new TableRow();
                Table1.Rows.Add(tRow);
                for (cellCtr = 1; cellCtr <= cellCnt; cellCtr++)
                {
                    // Create a new cell and add it to the row.
                    TableCell tCell = new TableCell();
                    tCell.Text = "Row " + rowCtr + ", Cell " + cellCtr;
                    tRow.Cells.Add(tCell);
                }
            }
        }

        protected void delete_row_Click(object sender, EventArgs e)
        {

        }
    }
}