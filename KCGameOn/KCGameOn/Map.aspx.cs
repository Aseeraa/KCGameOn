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

namespace KCGameOn
{
    public partial class Map : System.Web.UI.Page
    {
        public static List<String> seatList = new List<String>();
        public string seats;
        public string people;
        public string pp = null;
        public int count;
        MySqlDataReader reader = null;
        MySqlCommand cmd = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.UrlReferrer != null)
            {
                pp = Request.UrlReferrer.ToString().ToLower();
                if (pp.Contains("checkin.aspx") == true)
                { previousPage.Text = "Click <a href=\"./Checkin.aspx\">here</a> to continue the check in process after selecting a seat!"; }
                else { previousPage.Text = pp; }
            }
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
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

        [WebMethod]
        [ScriptMethod(UseHttpGet = false,ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
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