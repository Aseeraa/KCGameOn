﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

using System.Net;
using System.Web.Script.Serialization;
using System.Web.Helpers;
using System.Web.Mvc;
using PayPal.AdaptivePayments.Model;
using PayPal.AdaptivePayments;
using System.Net.Mime;
using System.Net.Mail;
using System.IO;
using Zen.Barcode;

namespace KCGameOn
{
    public partial class Map : System.Web.UI.Page
    {
        public static List<String> seatList = new List<String>();
        public string seats;
        public string seats2;
        public string seats3;
        public string people;
        public string people3;
        public int count;
        public string pp = null;
        private string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        MySqlDataReader reader = null;
        MySqlCommand cmd = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().ToLower().Contains("checkin.aspx"))
            { previousPage.Text = "Click <a href=\"./Checkin.aspx\">here</a> to continue the check in process after selecting a seat!"; }
            checkPayPal();

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
                count = 0;
                cmd = new MySqlCommand("SELECT * FROM seatcoords WHERE floor = 1", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                IAsyncResult result = cmd.BeginExecuteReader();
                //reader = cmd.ExecuteReader();
                reader = cmd.EndExecuteReader(result);
                seats += "[";
                while (reader.Read())
                {
                    String seat = "{ \"id\": \"" + reader["id"].ToString() + "\", \"title\": \"" + reader["title"] + "\", \"lat\": " + (double)reader["lat"] + ", \"lng\":" + (double)reader["lng"] + " },";
                    seats = seats + seat;
                }
                seats += "]";
                reader.Close();

                cmd.Connection.Close();

                cmd = new MySqlCommand("SELECT * FROM seatcoords WHERE floor = 3", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                result = cmd.BeginExecuteReader();
                //reader = cmd.ExecuteReader();
                reader = cmd.EndExecuteReader(result);
                seats3 += "[";
                while (reader.Read())
                {
                    String seat3 = "{ \"id\": \"" + reader["id"].ToString() + "\", \"title\": \"" + reader["title"] + "\", \"lat\": " + (double)reader["lat"] + ", \"lng\":" + (double)reader["lng"] + " },";
                    seats3 = seats3 + seat3;
                }
                seats3 += "]";
                reader.Close();

                cmd = new MySqlCommand("SELECT * FROM seatcoords WHERE floor = 2", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                result = cmd.BeginExecuteReader();
                //reader = cmd.ExecuteReader();
                reader = cmd.EndExecuteReader(result);
                seats2 += "[";
                while (reader.Read())
                {
                    String seat2 = "{ \"id\": \"" + reader["id"].ToString() + "\", \"title\": \"" + reader["title"] + "\", \"lat\": " + (double)reader["lat"] + ", \"lng\":" + (double)reader["lng"] + " },";
                    seats2 = seats2 + seat2;
                }
                seats2 += "]";
                reader.Close();

                cmd.Connection.Close();

                cmd = new MySqlCommand("SELECT * FROM seatingchart WHERE ActiveIndicator = \'TRUE\'", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                result = cmd.BeginExecuteReader();

                int counter = 0;

                //reader = cmd.ExecuteReader();
                reader = cmd.EndExecuteReader(result);
                people += "[";
                while (reader.Read())
                {
                    String title = "";
                    try
                    {
                        title = reader["username"].ToString();
                    }
                    catch (Exception)
                    {
                        continue;
                    }
                    String person = "{ \"id\": \"" + reader["seatID"].ToString() + "\", \"title\": \"" + title + "\" },";
                    people += person;
                    counter++;
                }
                people += "]";
                reader.Close();
                cmd.Connection.Close();
                if (counter < 1)
                {
                    people = "[\"{}\"]";
                }
                count = counter;
            }
            catch (Exception s)
            {
                Console.WriteLine(s.StackTrace);
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

        private static bool checkForUpdate()
        {
            if (SessionVariables.UserName != null)
            {
                MySqlDataReader reader = null;
                MySqlCommand cmd = null;
                string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
                try
                {
                    cmd = new MySqlCommand("SELECT paymentKey,verifiedPaid FROM payTable WHERE paidDate = (SELECT MAX(paidDate) FROM payTable where userName = \'" + SessionVariables.UserName.ToLower() + "\' AND ActiveIndicator = \'TRUE\') AND userName = \'" + SessionVariables.UserName.ToLower() + "\'", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection.Open();
                    //IAsyncResult result = cmd.BeginExecuteReader();
                    //result = cmd.BeginExecuteReader();
                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        if (reader == null && !reader.HasRows)
                        {
                            return false;
                        }
                        else
                        {
                            SessionVariables.paymentKey = reader["paymentKey"].ToString();
                            SessionVariables.verifiedPaid = reader["verifiedPaid"].ToString();
                            return true;
                        }
                    }
                }
                catch (Exception e)
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
            return false;
        }

        private static bool checkPayPal()
        {
            if (!String.IsNullOrEmpty(SessionVariables.UserName))
            {
                if (checkForUpdate())
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
                        requestPaymentDetails.payKey = SessionVariables.paymentKey;

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
                                    updatePayTable();
                                    return true;
                                }
                            }
                            // # Error Values
                            else
                            {
                                return false;
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
                        return false;
                        // Log the exception message
                    }
                }
                else
                    return false;
            }
            return false;
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

        private static void updatePayTable()
        {
            string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader reader = null;
            MySqlCommand cmd = null;
            bool paid = false;
            string paymentkey = null;
            try
            {
                cmd = new MySqlCommand("SELECT paymentKey,verifiedPaid FROM payTable WHERE paidDate = (SELECT MAX(paidDate) FROM payTable where userName = \'" + SessionVariables.UserName.ToLower() + "\' AND ActiveIndicator = \'TRUE\')", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                //IAsyncResult result = cmd.BeginExecuteReader();
                //result = cmd.BeginExecuteReader();
                //reader = cmd.EndExecuteReader(result);
                reader = cmd.ExecuteReader();

                if (reader != null && reader.HasRows)
                {
                    reader.Read();
                    paymentkey = reader["paymentKey"].ToString();
                    if (reader["verifiedPaid"].ToString().Equals("Y"))
                        paid = true;
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
            if (!string.IsNullOrEmpty(paymentkey) && !paid)
            {
                try
                {
                    cmd = new MySqlCommand("spUpdatePayment", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("Username", SessionVariables.UserName);
                    cmd.Parameters.AddWithValue("PaymentKey", paymentkey);
                    cmd.ExecuteScalar();
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

                //Create Command
                cmd = new MySqlCommand("SELECT ua.username, ua.Email, pt.Barcode, pt.EventID FROM payTable pt LEFT JOIN useraccount ua on pt.username = ua.username WHERE pt.PaymentKey = \'" + paymentkey + "\' AND pt.Barcode IS NOT NULL AND pt.eventID = (SELECT min(schedule.EventID) FROM schedule WHERE schedule.Active = 1)", new MySqlConnection(UserInfo));
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
                        body += "<br /><br />The next event takes place at Cerner's World Headquarters - in building 2702";
                        body += "<br /><br />The address is <a href=\"https://www.google.com/maps/place/2702+Rock+Creek+Pkwy,+Kansas+City,+MO+64117/@39.151148,-94.5495217,17z\">2702 Rock Creek Pkwy, Kansas City, MO 64117.</a>";
                        body += "<br /><br />This event will provide ethernet and powerstrips - just make sure you bring your own powercord and peripherals - if you need more info, check out our <a href=\"http://www.kcgameon.com/FAQ/FAQ.aspx\">FAQ</a> page.";
                        body += "<br /><br />";
                        body += "<br /><br /><a href=\"https://kcgameon.com/Tournament.aspx\">Go to the KCGameOn tournament page for the tournament sign ups.</a> Check back often as tournaments could be added/removed based on demand.";
                        body += "<br /><br />BYOC will still use battlefy registration and Fighting games will use challonge - please be sure to pre-reg for those fighting tournaments to help out the organization side of things.";
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
            }
        }

        [WebMethod]
        public static string checkPaid()
        {
            bool paid = false;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader paidReader = null;
            MySqlCommand mySQLCmd = null;
            try
            {
                mySQLCmd = new MySqlCommand("SELECT paymentKey,verifiedPaid FROM payTable WHERE paidDate = (SELECT MAX(paidDate) FROM payTable where userName = \'" + SessionVariables.UserName.ToLower() + "\' AND ActiveIndicator = \'TRUE\')", new MySqlConnection(UserInfo));
                mySQLCmd.CommandType = System.Data.CommandType.Text;
                mySQLCmd.Connection.Open();
                IAsyncResult result = mySQLCmd.BeginExecuteReader();
                paidReader = mySQLCmd.EndExecuteReader(result);
                result = mySQLCmd.BeginExecuteReader();
                if (paidReader == null || !paidReader.HasRows)
                {
                    paid = false;
                    return serializer.Serialize(paid);
                }
                else
                {
                    while (paidReader.Read())
                    {
                        if (paidReader["verifiedPaid"].ToString().Equals("Y"))
                        {
                            paid = true;
                        }
                    }
                    if (paid != true)
                        paid = checkPayPal();
                    return serializer.Serialize(paid);
                }
            }
            catch (Exception)
            {
            }
            finally
            {
                if (paidReader != null)
                {
                    paidReader.Close();
                }
                if (mySQLCmd != null)
                {
                    mySQLCmd.Connection.Close();
                }
            }
            paid = false;
            return serializer.Serialize(paid);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static void SaveUser(User user)
        {
            if (SessionVariables.UserName.ToLower() == user.Username.ToLower())// Add or User is Admin)
            {
                // SQL query to update the SeatingChart.
                using (MySqlCommand cmd = new MySqlCommand("spAddUserSeat", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("seatID", user.SeatID);
                    cmd.Parameters.AddWithValue("Username", user.Username.ToLower());

                    cmd.Connection.Open();
                    int seatValue = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (seatValue)
                    {
                        case -1: // Successfully Added UserSeat.
                            break;
                        case -2: // Successfully Updated UserSeat.
                            break;
                        case -3: // This means someone already have that seat.
                            break;
                        default:
                            break;
                    }
                    cmd.Connection.Close();
                }
            }
            else
            {
                // Some smart kid is trying to update seat for someone else.
            }
        }

        [WebMethod]
        [ScriptMethod]
        public static void DeleteUser(User user)
        {
            if (SessionVariables.UserName.ToLower() == user.Username.ToLower())// Add or User is Admin)
            {
                // SQL query to update the SeatingChart.
                using (MySqlCommand cmd = new MySqlCommand("spRemoveUserSeat", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("seatID", user.SeatID);
                    cmd.Parameters.AddWithValue("Username", user.Username.ToLower());

                    cmd.Connection.Open();
                    int seatValue = Convert.ToInt32(cmd.ExecuteScalar());

                    switch (seatValue)
                    {
                        case -1: // Successfully Removed UserSeat.
                            break;
                        case -2: // Could not remove seat.
                            break;
                        default:
                            break;
                    }
                    cmd.Connection.Close();
                }
            }
            else
            {
                // Some smart kid is trying to update seat for someone else.
            }
        }
    }
}
public class User
{
    public string Username { get; set; }
    public int SeatID { get; set; }
}