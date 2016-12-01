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
using Zen.Barcode;
using System.IO;
using System.Net.Mail;
using System.Net.Mime;
using PayPal.AdaptivePayments.Model;
using PayPal.AdaptivePayments;
using System.Data;

namespace KCGameOn.Admin
{
    public class entry<T1,T2,T3>
    {
        public T1 Name { get; set; }
        public T2 Event { get; set; }
        public T3 Won { get; set; }
    }
    public partial class Admin : System.Web.UI.Page
    {
        public static List<UsersObject> userlist = new List<UsersObject>();
        public static List<String> usernames = new List<String>();
        public static List<int> eventids = new List<int>();
        public static List<String> firstnames = new List<String>();
        public static List<String> lastnames = new List<String>();
        public static List<String> names = new List<String>();
        public static UsersObject current = new UsersObject("", "", "");
        public static StringBuilder AdminUserHTML;
        public static StringBuilder RaffleHTML;
        public static List<string> usersPaid = new List<string>();
        public static Dictionary<string, int> usersCheckedIn = new Dictionary<string, int>();
        public static List<entry<string, int, int>> loyaltyRaffle = new List<entry<string, int, int>>();
        public static entry<string, int, int> loyaltyWinner = new entry<string, int, int>();
        public static string currentPrize;
        public static string currentPrizeUrl;
        public static string currentPrizeSponsor;
        public static UsersObject raffleWinner = new UsersObject("", "", "");
        protected void Page_Load(object sender, EventArgs e)
        {
            userlist = new List<UsersObject>();
            usernames = new List<String>();
            firstnames = new List<String>();
            lastnames = new List<String>();
            names = new List<String>();
            populateEventDropdown();

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
                cmd = new MySqlCommand("SELECT DISTINCT * FROM payTable WHERE eventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1) AND verifiedPaid = \'Y\' AND activeIndicator=\'TRUE\'", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                AdminUserHTML = new StringBuilder();

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

                //raffle-populate user table in admin page
                cmd = new MySqlCommand("select ea.username, ua.FirstName, ua.LastName, ea.eventID, ea.wondoor, ea.wonloyalty from EventArchive ea left join useraccount ua on ea.Username = ua.username WHERE eventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1) and wondoor != 0", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                RaffleHTML = new StringBuilder();

                while (Reader.Read())
                {
                    RaffleHTML.AppendLine("<tr>");
                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("username")).Append("</td>");
                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("FirstName")).Append("</td>");
                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("LastName")).Append("</td>");
                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("eventID")).Append("</td>");
                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("wondoor")).Append("</td>");
                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("wonloyalty")).Append("</td>");
                    RaffleHTML.AppendLine("</tr>");
                }
                Reader.Close();

                //populate checked in users for raffle
                cmd = new MySqlCommand("SELECT DISTINCT * FROM EventArchive WHERE eventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1) AND checkedin = 1 AND activeIndicator = 1", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();


                while (Reader.Read())
                {
                    if (Reader["userName"] != DBNull.Value)
                    {
                        if (!usersCheckedIn.ContainsKey(Reader.GetString("userName")))
                            usersCheckedIn.Add(Reader.GetString("userName"), Reader.GetByte("wonloyalty"));
                    }
                }
                Reader.Close();

                //populate checked in users for loyalty event
                cmd = new MySqlCommand("SELECT DISTINCT * FROM EventArchive WHERE eventID >=69 AND checkedin = 1 AND activeIndicator = 1;", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();


                while (Reader.Read())
                {
                    if (Reader["userName"] != DBNull.Value)
                    {
                        //If loyaltyRaffle does NOT have the existing userName and eventID pair, add it with 
                        if (!(loyaltyRaffle.Any(entry => entry.Name.Contains(Reader.GetString("userName")) && entry.Event == Reader.GetInt32("eventID"))))
                        {
                            entry<string, int, int> user = new entry<string, int, int>();
                            user.Name = Reader.GetString("userName"); user.Event = Reader.GetInt32("eventID"); user.Won = Reader.GetByte("wonloyalty");
                            loyaltyRaffle.Add(user);
                        }
                    }
                }
                Reader.Close();
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

        private static string getBarcode(string barcode)
        {
            BarcodeSymbology s = BarcodeSymbology.Code39NC;
            BarcodeDraw drawObject = BarcodeDrawFactory.GetSymbology(s);
            var metrics = drawObject.GetDefaultMetrics(45);
            metrics.Scale = 1;
            var barcodeImage = drawObject.Draw(barcode, metrics);

            using (MemoryStream ms = new MemoryStream())
            {
                barcodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imageBytes = ms.ToArray();

                return Convert.ToBase64String(imageBytes);
            }
        }

        [WebMethod]
        public static bool archiveEvent(string data)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

            JavaScriptSerializer json = new JavaScriptSerializer();
            String eventid = json.Deserialize<string>(data);


            MySqlCommand cmd = null;
            MySqlConnection conn = null;
            MySqlDataReader reader = null;
            if (!eventid.ToUpper().Trim().Equals("NONE"))
            {
                conn = new MySqlConnection(UserInfo);
                try
                {

                    conn.Open();

                    cmd = new MySqlCommand("spArchiveEvent", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("eventid", int.Parse(eventid));

                    cmd.ExecuteNonQuery();

                    return true;
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
            }
            return false;

        }

        
        public void populateEventDropdown()
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

            MySqlCommand cmd = null;
            MySqlConnection conn = null;
            MySqlDataReader reader = null;
            eventids = new List<int>();

            conn = new MySqlConnection(UserInfo);
            try
            {

                conn.Open();

                cmd = new MySqlCommand("spFetchActiveEvents", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    eventids.Add(int.Parse(reader["eventid"].ToString()));
                }
                
            }
            catch (Exception ex)
            {
                //return "An internal error has occurred, please contact an administrator.";
               
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }
                reader.Close();

            }
          

        }

        [WebMethod]
        public static bool validateKeys(string data)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            List<Users> payment = new List<Users>();
            JavaScriptSerializer json = new JavaScriptSerializer();
            List<String[]> mystring = json.Deserialize<List<string[]>>(data);
            List<string> paypalKeys = new List<string>();
            String user = mystring.ElementAt(0).ElementAt(0).ToString();
            String first = mystring.ElementAt(0).ElementAt(1).ToString().Split(' ').ElementAt(0);
            String last = mystring.ElementAt(0).ElementAt(1).ToString().Split(' ').ElementAt(1);

            MySqlCommand cmd = null;
            MySqlConnection conn = null;
            MySqlDataReader reader = null;
            string key = null;
            conn = new MySqlConnection(UserInfo);
            try
            {

                conn.Open();

                cmd = new MySqlCommand("spRetrieveKeys", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("UserName", user);

                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    paypalKeys.Add(reader[0].ToString());
                }
                reader.Close();
                conn.Close();

                validateKeys(paypalKeys);
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
                reader.Close();
            }
            return true;
        }

        private static void validateKeys(List<string> paypalKeys)
        {
            foreach (string key in paypalKeys)
            {
                PaymentDetailsResponse responsePaymentDetails = new PaymentDetailsResponse();

                try
                {
                    // # PaymentDetailsRequest
                    // The code for the language in which errors are returned
                    RequestEnvelope envelopeRequest = new RequestEnvelope();
                    envelopeRequest.errorLanguage = "en_US";

                    // PaymentDetailsRequest which takes,
                    // `Request Envelope` - Information common to each API operation, such
                    // as the language in which an error message is returned.
                    PaymentDetailsRequest requestPaymentDetails = new PaymentDetailsRequest(envelopeRequest);

                    // You must specify either,
                    //
                    // * `Pay Key` - The pay key that identifies the payment for which you want to retrieve details. This is the pay key returned in the PayResponse message.
                    // * `Transaction ID` - The PayPal transaction ID associated with the payment. The IPN message associated with the payment contains the transaction ID.
                    // `payDetailsRequest.transactionId = transactionId`
                    // * `Tracking ID` - The tracking ID that was specified for this payment in the PayRequest message.
                    // `requestPaymentDetails.trackingId = trackingId`
                    requestPaymentDetails.payKey = key;

                    // Create the service wrapper object to make the API call
                    AdaptivePaymentsService service = new AdaptivePaymentsService();

                    // # API call
                    // Invoke the PaymentDetails method in service wrapper object
                    responsePaymentDetails = service.PaymentDetails(requestPaymentDetails);

                    if (responsePaymentDetails != null)
                    {
                        // Response envelope acknowledgement
                        string acknowledgement = "PaymentDetails API Operation - ";
                        acknowledgement += responsePaymentDetails.responseEnvelope.ack.ToString();
                        Console.WriteLine(acknowledgement + "\n");

                        // # Success values
                        if (responsePaymentDetails.responseEnvelope.ack.ToString().Trim().ToUpper().Equals("SUCCESS"))
                        {
                            // The status of the payment. Possible values are:
                            //
                            // * CREATED - The payment request was received; funds will be
                            // transferred once the payment is approved
                            // * COMPLETED - The payment was successful
                            // * INCOMPLETE - Some transfers succeeded and some failed for a
                            // parallel payment or, for a delayed chained payment, secondary
                            // receivers have not been paid
                            // * ERROR - The payment failed and all attempted transfers failed
                            // or all completed transfers were successfully reversed
                            // * REVERSALERROR - One or more transfers failed when attempting
                            // to reverse a payment
                            // * PROCESSING - The payment is in progress
                            // * PENDING - The payment is awaiting processing
                            if (responsePaymentDetails.status == "COMPLETED")
                            {
                                validatePayment(key, true);
                                return;
                            }
                        }
                        // # Error Values
                        else
                        {
                            validatePayment(key, false);
                            return;
                            //List<ErrorData> errorMessages = responsePaymentDetails.error;
                            //foreach (ErrorData error in errorMessages)
                            //{
                            //}
                        }
                    }
                }
                // # Exception log    
                catch (System.Exception ex)
                {
                    return;
                    // Log the exception message
                }
            }
        }
        [WebMethod]
        public static void sendBarcodes()
        {
            //Create Command
            string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader reader = null;
            MySqlCommand cmd = null;
            cmd = new MySqlCommand("SELECT MAX(pt.idpayTable), ua.username, ua.Email, MAX(pt.Barcode), pt.EventID FROM payTable pt LEFT JOIN useraccount ua on pt.username = ua.username WHERE pt.verifiedPaid = 'Y' AND pt.Barcode IS NOT NULL AND pt.eventID = (SELECT min(schedule.EventID) FROM schedule WHERE schedule.Active = 1) GROUP BY pt.username", new MySqlConnection(UserInfo));
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection.Open();

            //Bind command to reader
            using (reader = cmd.ExecuteReader())
            {
                //read each row
                while (reader.Read())
                {
                    //associate variables
                    string toEmail = reader["Email"].ToString();
                    string barcode = reader["Barcode"].ToString();
                    string user = reader["username"].ToString();
                    string eid = reader["EventID"].ToString();
                    MailMessage mail = new MailMessage();
                    SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                    mail.From = new MailAddress(ConfigurationManager.ConnectionStrings["FromEmail"].ConnectionString);
                    mail.To.Add(toEmail);
                    mail.Subject = "KcGameOn Account: Quick Check-In Barcode for Event #" + eid;
                    mail.IsBodyHtml = true;

                    var imageData = Convert.FromBase64String(getBarcode(barcode));

                    var contentId = Guid.NewGuid().ToString();
                    var linkedResource = new LinkedResource(new MemoryStream(imageData), "image/jpeg");
                    linkedResource.ContentId = contentId;
                    linkedResource.TransferEncoding = TransferEncoding.Base64;

                    var body = "Behold, ";
                    body += "<br /><br />This is your ticket to the lan event #" + eid + ", keep it safe!.";
                    body += "<br /><br /><b>" + user + "</b>";
                    body += string.Format("<br /><br /><img src=\"cid:{0}\" />", contentId);
                    body += "<br /><br />This October 8th event is a collaboration event with Extra-Life, a 25-hour marathon where we will you can stream or just put get in your hours or just game out - this is totally optional and there is no pressure to join/donate.";
                    body += "<br /><br /><a href=\"http://www.extra-life.org/index.cfm?fuseaction=donorDrive.teamParticipants&teamID=29099\">If you do feel like being a part of this Extra-life marathon, feel free to join our team, run your own team or contribute in cash at the Extra-life booth located at the event.</a>";
                    body += "<br /><br />";
                    body += "<br /><br />";
                    body += "<br /><br /><a href=\"https://kcgameon.com/Tournament.aspx\">Go to the KCGameOn tournament page for the tournament sign ups, check back often as tournaments will be added/removed</a>";
                    body += "<br /><br />If you are signing up for any tournament at this event, your password is 'kansascity' - no space";
                    body += "<br /><br />Thanks,";
                    body += "<br />KcGameOn Team!";
                    var htmlView = AlternateView.CreateAlternateViewFromString(body, null, "text/html");
                    htmlView.LinkedResources.Add(linkedResource);
                    mail.AlternateViews.Add(htmlView);

                    SmtpServer.Port = 587;
                    SmtpServer.Credentials = new System.Net.NetworkCredential(ConfigurationManager.ConnectionStrings["FromEmail"].ConnectionString, ConfigurationManager.ConnectionStrings["FromEmailPass"].ConnectionString);
                    SmtpServer.EnableSsl = true;

                    SmtpServer.Send(mail);
                }
                // Call Close when done reading.
                reader.Close();
            }

            cmd.Connection.Close();
            return;
        }

        private static void validatePayment(string key, bool validKey)
        {
            MySqlCommand cmd = null;
            string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            if (validKey)
            {
                try
                {
                    cmd = new MySqlCommand("UPDATE payTable SET verifiedPaid = 'Y' WHERE paymentKey = \'" + key + "\'", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                }
                finally
                {
                    if (cmd != null)
                    {
                        cmd.Connection.Close();
                    }
                }
            }
            else
            {
                try
                {
                    cmd = new MySqlCommand("UPDATE payTable SET activeIndicator = 'FALSE' WHERE paymentKey = \'" + key + "\'", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                }
                finally
                {
                    if (cmd != null)
                    {
                        cmd.Connection.Close();
                    }
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
            Double donationAmount = 0;

            MySqlCommand cmd = null;
            MySqlConnection conn = null;

            conn = new MySqlConnection(UserInfo);
            try
            {

                conn.Open();

                cmd = new MySqlCommand("spAddPayment", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("UserName", user);
                cmd.Parameters.AddWithValue("VerifiedPaid", "Y");
                cmd.Parameters.AddWithValue("PaidFullYear", "N");
                cmd.Parameters.AddWithValue("PaymentMethod", paymentType);
                cmd.Parameters.AddWithValue("PaymentKey", "");
                cmd.Parameters.AddWithValue("DonationAmount", donationAmount);

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
            //Create Command
            cmd = new MySqlCommand("SELECT ua.Email,pt.Barcode,pt.EventID FROM payTable pt LEFT JOIN useraccount ua on pt.username = ua.username WHERE pt.Username = \'" + user + "\' AND pt.Barcode IS NOT NULL AND pt.verifiedPaid = 'Y' AND pt.eventID = (SELECT min(schedule.EventID) FROM schedule WHERE schedule.Active = 1)  LIMIT 1", conn);
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection.Open();

            //Bind command to reader
            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                //read each row
                while (reader.Read())
                {
                    //associate variables
                    string toEmail = reader["Email"].ToString();
                    string barcode = reader["Barcode"].ToString();
                    string eid = reader["EventID"].ToString();
                    MailMessage mail = new MailMessage();
                    SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                    mail.From = new MailAddress(ConfigurationManager.ConnectionStrings["FromEmail"].ConnectionString);
                    mail.To.Add(toEmail);
                    mail.Subject = "KcGameOn Account: Quick Check-In Barcode for Event #" + eid;
                    mail.IsBodyHtml = true;

                    var imageData = Convert.FromBase64String(getBarcode(barcode));

                    var contentId = Guid.NewGuid().ToString();
                    var linkedResource = new LinkedResource(new MemoryStream(imageData), "image/jpeg");
                    linkedResource.ContentId = contentId;
                    linkedResource.TransferEncoding = TransferEncoding.Base64;

                    var body = "Behold, ";
                    body += "<br /><br />This is your ticket to the lan event #" + eid + ", keep it safe!.";
                    body += "<br /><br /><b>" + user + "</b>";
                    body += string.Format("<br /><br /><img src=\"cid:{0}\" />", contentId);
                    body += "<br /><br />This October 8th event is a collaboration event with Extra-Life, a 25-hour marathon where we will you can stream or just put get in your hours or just game out - this is totally optional and there is no pressure to join/donate.";
                    body += "<br /><br /><a href=\"http://www.extra-life.org/index.cfm?fuseaction=donorDrive.teamParticipants&teamID=29099\">If you do feel like being a part of this Extra-life marathon, feel free to join our team, run your own team or contribute in cash at the Extra-life booth located at the event.</a>";
                    body += "<br /><br />";
                    body += "<br /><br />";
                    body += "<br /><br /><a href=\"https://kcgameon.com/Tournament.aspx\">Go to the KCGameOn tournament page for the tournament sign ups, check back often as tournaments will be added/removed</a>";
                    body += "<br /><br />If you are signing up for any tournament at this event, your password is 'kansascity' - no space";
                    body += "<br /><br />Thanks,";
                    body += "<br />KcGameOn Team!";
                    var htmlView = AlternateView.CreateAlternateViewFromString(body, null, "text/html");
                    htmlView.LinkedResources.Add(linkedResource);
                    mail.AlternateViews.Add(htmlView);

                    SmtpServer.Port = 587;
                    SmtpServer.Credentials = new System.Net.NetworkCredential(ConfigurationManager.ConnectionStrings["FromEmail"].ConnectionString, ConfigurationManager.ConnectionStrings["FromEmailPass"].ConnectionString);
                    SmtpServer.EnableSsl = true;

                    SmtpServer.Send(mail);
                }
                // Call Close when done reading.
                reader.Close();
            }

            cmd.Connection.Close();
            return true;
        }
        //nickcode
        public static bool addRaffle(string data)
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

            conn = new MySqlConnection(UserInfo);
            try
            {

                conn.Open();

                cmd = new MySqlCommand("spAddPayment", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("UserName", user);
                cmd.Parameters.AddWithValue("wondoor", "0");
                cmd.Parameters.AddWithValue("wonloyalty", "0");


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

        [WebMethod]
        public static string getRaffleWinner(string data)
        {
            string winner = null;
            if (data.Equals("repick"))
            {
                if (raffleWinner != null)
                    winner = raffleWinner.Username;

                if (dbHelper("UPDATE kcgameon.EventArchive SET wondoor = 2 WHERE Username = \"" + winner + "\""))
                {
                    usersCheckedIn[raffleWinner.Username] = 2;//Update the local users list for raffle to Did Not Show
                    return "Previous winner marked as a no show.  Select another.";
                }
                else
                    return null;

            }
            else
            {
                Random randNum = new Random();
                int randomNumber;
                //temporary user list to enable looping
                List<string> eligibleUsers = usersCheckedIn.Where(user => user.Value == 0).Select(x => x.Key).ToList();
                if (eligibleUsers.Count > 0)
                {
                    randomNumber = randNum.Next(eligibleUsers.Count);
                    raffleWinner = userlist.Find(user => user.Username.Equals(eligibleUsers.ElementAt(randomNumber)));//Get user's first + last name

                    if (raffleWinner != null)
                        winner = raffleWinner.First + " " + raffleWinner.Last;
                    else

                        winner = eligibleUsers.ElementAt(randomNumber);

                    usersCheckedIn[eligibleUsers.ElementAt(randomNumber)] = 1;//Update the local users list for raffle
                    dbHelper("UPDATE kcgameon.EventArchive SET wondoor = 1 WHERE Username = \"" + eligibleUsers.ElementAt(randomNumber) + "\"");
                    return winner;
                }
            }
            return "Ran out of users, probably...";
        }

        [WebMethod]
        public static string loyalty(string data)
        {
            string winner = null;
            if (!String.IsNullOrWhiteSpace(loyaltyWinner.Name) && data.Equals("spin"))
            {
                loyaltyRaffle.Single(t => t.Name == loyaltyWinner.Name && t.Event == loyaltyWinner.Event).Won = 1;
                if (dbHelper("UPDATE kcgameon.EventArchive SET wonloyalty = 1 WHERE Username = \"" + loyaltyWinner.Name + "\" AND eventID = \"" + loyaltyWinner.Event + "\" LIMIT 1"))//actually commit the winner to DB, do we need to update prize table?
                {
                    //if(dbHelper("UPDATE kcgameon.prizes SET ClaimedBy = \"" + loyaltyWinner.Name + "\" WHERE Prize = \"" + currentPrize + "\""))//TODO PRIZE
                    loyaltyWinner.Name = null;
                    return loyalty("skipSelection");//spin after committing
                }
                else
                    return "Fail";

            }
            if(data.Equals("skipSelection") || data.Equals("spin"))
            {
                Random randNum = new Random();
                int randomNumber;
                //temporary user list to enable looping
                List<entry<string,int,int>> eligibleUsers = loyaltyRaffle.Where(user => user.Won == 0 && !String.IsNullOrWhiteSpace(user.Name)).ToList();
                if (eligibleUsers.Count > 0)
                {
                    randomNumber = randNum.Next(eligibleUsers.Count);
                    loyaltyWinner = loyaltyRaffle.ElementAt(randomNumber);
                    winner = userlist.Find(user => user.Username.Equals(loyaltyRaffle.ElementAt(randomNumber).Name)).First;
                    winner += " " + userlist.Find(user => user.Username.Equals(loyaltyRaffle.ElementAt(randomNumber).Name)).Last;//Get user's first + last name
                    return winner;
                }
                else
                    return "Fail";
            }
            //else (data has a value not eqaul to NULL or skipSelection) AND (loyaltyWinner is null), which shoudln't ever happen, so just hit failure
            return "Fail";
        }

        //[WebMethod]
        //public static string loadPrizePicture(string data)//TODO PRIZE
        //{
        //    if(dbHelper("SELECT * FROM kcgameon.prizes WHERE"))
                
        //    return null;
        //}

        [WebMethod]
        public static void blockUnblock(string data)
        {
            MySqlCommand cmd = null;
            using (MySqlConnection connection = new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString))
            {
                try
                {


                    connection.Open();
                    if (data.ToLower() == "block")
                    {
                        cmd = new MySqlCommand("UPDATE AdminProperties SET BlockPayments = \'TRUE\'", connection);
                    }
                    else
                    {
                        cmd = new MySqlCommand("UPDATE AdminProperties SET BlockPayments = \'FALSE\'", connection);
                    }
                    cmd.CommandType = CommandType.Text;
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                catch (Exception e)
                {
                    return;
                }
            }
        }

        //Basic database helper to be used for any command that doesn't return data
        protected static bool dbHelper(string command)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader = null;
            MySqlCommand cmd = null;
            MySqlConnection conn = null;
            Boolean successFlag = true;
            try
            {
                cmd = new MySqlCommand(command, new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = command;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception e)
            {
                successFlag = false;
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
            return successFlag;

        }
    }
}