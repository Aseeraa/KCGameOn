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
        public static List<UsersObject> userlist = new List<UsersObject>();
        public static List<String> usernames = new List<String>();
        public static List<String> firstnames = new List<String>();
        public static List<String> lastnames = new List<String>();
        public static List<String> names = new List<String>();
        public List<UsersObject> payments = new List<UsersObject>();
        public static int quantity = 0;
        public static Double extraLife = 0.00;
        public static UsersObject current = new UsersObject("", "", "");
        public static StringBuilder newRow;
        //private static Page page;
        public static String RedirectURL;
        public static int remainingEvents = 0;
        public static string checkInDay = "false";

        protected void Page_Load(object sender, EventArgs e)
        {
            checkInDay = "false";
            if (Request.UrlReferrer != null)
            {
                if (Request.UrlReferrer.ToString().ToLower().Contains("checkin.aspx"))
                {
                    checkInDay = "true";
                }
            }
            //page = this.Page;
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader = null;
            MySqlCommand cmd = null;
            MySqlConnection conn = null;
            try
            {

                cmd = new MySqlCommand("SELECT BlockPayments FROM AdminProperties", new MySqlConnection(UserInfo));
                cmd.Connection.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                string blocked = cmd.ExecuteScalar().ToString();
                if (blocked.Equals("TRUE"))
                    if (SessionVariables.UserAdmin == 0)
                        SessionVariables.registrationBlocked = true;
            }
            catch (Exception)
            {

            }
            finally
            {
                if (cmd.Connection != null)
                    cmd.Connection.Close();
            }
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

            try
            {
                conn = new MySqlConnection(UserInfo);
                conn.Open();

                cmd = new MySqlCommand("spFetchRemainingEvents", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                remainingEvents = Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch(Exception)
            {

            }
            finally
            {
                if (cmd.Connection != null)
                    cmd.Connection.Close();
                if (conn != null)
                {
                    conn.Close();
                }
            }
            
        }

        [WebMethod]
        [ScriptMethod]
        public static String BuyTickets(string data)
        {
            bool tableValid = true;
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            //Payment paymnt = null;
            quantity = 0;
            extraLife = 0.00;
            List<Users> payment = new List<Users>();
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<String[]> mystring = json.Deserialize<List<string[]>>(data);
            for (int i = 0; i < mystring.Count; i++)
            {
                String user = mystring.ElementAt(i).ElementAt(1).ToString();
                String first = mystring.ElementAt(i).ElementAt(2).ToString();
                String last = mystring.ElementAt(i).ElementAt(3).ToString();
                Double donationAmount = 0.00;

                MySqlCommand cmd = null;
                MySqlConnection conn = null;

                try
                {
                    conn = new MySqlConnection(UserInfo);
                    conn.Open();

                    //This SQL command should be replaced by a function in the database.
                    MySqlCommand existsCommand = new MySqlCommand("SELECT CASE WHEN EXISTS(SELECT userName FROM payTable WHERE eventID = (SELECT MAX(eventID) FROM payTable) AND userName = '" + user + "')THEN 'TRUE'ELSE 'FALSE'END ", conn);
                    existsCommand.CommandType = CommandType.Text;

                    //existsCommand.Parameters.AddWithValue("Username", user);
                    bool doesUserExist = Convert.ToBoolean(existsCommand.ExecuteScalar());

                    //If the user already has an entry in the pay table, return a json message saying "duplicate"
                    if (doesUserExist)
                    {
                        return new JavaScriptSerializer().Serialize(new { Message = "duplicate" });
                    }

                    cmd = new MySqlCommand("spValidateUsersForPayment", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("UserName", user);
                    cmd.Parameters.AddWithValue("Firstname", first);
                    cmd.Parameters.AddWithValue("Lastname", last);

                    int userValue = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (userValue)
                    {
                        case -1: // Successfully Validated
                            if (mystring.ElementAt(i).ElementAt(0).Equals("True"))
                                quantity += remainingEvents;
                            else
                                quantity += 1;
                            if (donationAmount > 0)
                                extraLife += donationAmount;
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
                catch (Exception e)
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
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                PayRequest requestPay = Payment(quantity, extraLife);
                PayResponse responsePay = PayAPIOperations(requestPay);
                RedirectURL = "https://www.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=" + responsePay.payKey;
                //RedirectURL = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=" + responsePay.payKey;
                if (responsePay.payKey != null)
                {
                    for (int i = 0; i < mystring.Count; i++)
                    {
                        String fullYear;
                        if (mystring.ElementAt(i).ElementAt(0).ToString().Equals("True"))
                            fullYear = "Y";
                        else
                            fullYear = "N";
                        String user = mystring.ElementAt(i).ElementAt(1).ToString();
                        String payKey = responsePay.payKey;

                        String verfiedPaid = "N";
                        String paymentMethod = "PayPal";

                        Double donationAmount = 0.00;

                        MySqlCommand cmd = null;
                        MySqlConnection conn = null;

                        try
                        {
                            conn = new MySqlConnection(UserInfo);
                            conn.Open();

                            cmd = new MySqlCommand("spAddPayment", conn);
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("Username", user);
                            cmd.Parameters.AddWithValue("VerifiedPaid", verfiedPaid);
                            cmd.Parameters.AddWithValue("PaidFullYear", fullYear);
                            cmd.Parameters.AddWithValue("PaymentMethod", paymentMethod);
                            cmd.Parameters.AddWithValue("PaymentKey", payKey);
                            cmd.Parameters.AddWithValue("DonationAmount", donationAmount);

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
                    RedirectURL = "https://kcgameon.com/Default.aspx";
                    //RedirectURL = "https://nickthenerd.com/Default.aspx";
                }
            }
            //HttpContext.Current.Response.Redirect(RedirectURL, true);
            return RedirectURL;
        }

        // # Payment
        public static PayRequest Payment(int quantity, Double extraLife)
        {
            // # PayRequest
            // The code for the language in which errors are returned
            RequestEnvelope envelopeRequest = new RequestEnvelope();
            envelopeRequest.errorLanguage = "en_US";

            List<Receiver> listReceiver = new List<Receiver>();

            // Amount to be credited to the receiver's account
            decimal amount;
            if (checkInDay.Equals("true"))
            {
                amount = Convert.ToDecimal((quantity - 1) * 15.00);
                amount += Convert.ToDecimal(20.00);
            }
            else
            {
                    amount = Convert.ToDecimal(quantity * 15.00);
            }
            if (extraLife > 0)
            {
                amount += Convert.ToDecimal(extraLife);
            }
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
            PayRequest requestPay;
            if (checkInDay.Equals("true"))
                requestPay = new PayRequest(envelopeRequest, "PAY", "https://kcgameon.com/Checkin.aspx", "USD", listOfReceivers, "https://kcgameon.com/Checkin.aspx");
            else
                requestPay = new PayRequest(envelopeRequest, "PAY", "https://kcgameon.com/Default.aspx", "USD", listOfReceivers, "https://kcgameon.com/Map.aspx");
            //PayRequest requestPay = new PayRequest(envelopeRequest, "PAY", "https://nickthenerd.com/Default.aspx", "USD", listOfReceivers, "https://nickthenerd.com/Map.aspx");
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
    }
}