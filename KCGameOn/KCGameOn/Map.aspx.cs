using System;
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

namespace KCGameOn
{
    public partial class Map : System.Web.UI.Page
    {
        public static List<String> seatList = new List<String>();
        public string seats;
        public string people;
        public int count;
        private string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        MySqlDataReader reader = null;
        MySqlCommand cmd = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            checkPayPal();
            try
            {
                count = 0;
                cmd = new MySqlCommand("SELECT * FROM seatcoords", new MySqlConnection(UserInfo));
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
                    cmd = new MySqlCommand("SELECT paymentKey,verifiedPaid FROM payTable WHERE paidDate = (SELECT MAX(paidDate) FROM payTable where userName = \'" + SessionVariables.UserName.ToLower() + "\' AND ActiveIndicator = \'TRUE\')", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection.Open();
                    IAsyncResult result = cmd.BeginExecuteReader();
                    reader = cmd.EndExecuteReader(result);
                    result = cmd.BeginExecuteReader();
                    if (reader == null || !reader.HasRows)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
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
            }
            return false;
        }

        private static bool checkPayPal()
        {
            if (!String.IsNullOrEmpty(SessionVariables.UserName))
            {
                if (!checkForUpdate())
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
                    return true;
            }
            return false;
        }

        private static void updatePayTable()
        {
            string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader reader = null;
            MySqlCommand cmd = null;
            string paymentkey = null;
            try
            {
                cmd = new MySqlCommand("SELECT paymentKey,verifiedPaid FROM payTable WHERE paidDate = (SELECT MAX(paidDate) FROM payTable where userName = \'" + SessionVariables.UserName.ToLower() + "\' AND ActiveIndicator = \'TRUE\')", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                IAsyncResult result = cmd.BeginExecuteReader();
                reader = cmd.EndExecuteReader(result);
                result = cmd.BeginExecuteReader();
                if (reader == null || !reader.HasRows)
                {
                }
                else
                {
                    paymentkey = reader["paymentKey"].ToString();
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
            if (!string.IsNullOrEmpty(paymentkey))
            {
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
                    paid = checkPayPal();
                    return serializer.Serialize(paid);
                }
                else
                {
                    paid = true;
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