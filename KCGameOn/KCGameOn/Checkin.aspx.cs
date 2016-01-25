﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Text;

namespace KCGameOn
{
    public partial class Checkin : System.Web.UI.Page
    {
        public static int count;
        public static StringBuilder UserHTML;
        public static String hasPaid;
        public static String hasCheckedIn;
        public static Int32 getEventID;
        String connectionString = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand("SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1;", new MySqlConnection(connectionString));
                cmd.Connection.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                getEventID = (Int32)cmd.ExecuteScalar();
                cmd.Connection.Close();
                MySqlCommand cmd1 = new MySqlCommand("SELECT verifiedPaid FROM payTable WHERE username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                cmd1.Connection.Open();
                cmd1.CommandType = System.Data.CommandType.Text;
                hasPaid = (String)cmd1.ExecuteScalar();
                cmd1.Connection.Close();
                MySqlCommand cmd2 = new MySqlCommand("SELECT checkedin FROM seatingchart WHERE username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                cmd2.Connection.Open();
                cmd2.CommandType = System.Data.CommandType.Text;
                hasCheckedIn = Convert.ToString(cmd2.ExecuteScalar());
                cmd2.Connection.Close();
            }
            catch { }
        }

        protected void CheckinButton_Click(object sender, EventArgs e)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand("UPDATE seatingchart SET checkedin = true, checkedin_time = CURRENT_TIMESTAMP() WHERE Username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                cmd.Connection.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                checkinLabel.Text = "You have successfully checked yourself in.";
                CheckinButton.Visible = false;
            }
            catch {
                checkinLabel.Text = "An error occured.  Sorry please try again.";
            }
        }

        protected void CheckoutButton_Click(object sender, EventArgs e)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand("UPDATE seatingchart SET checkedin = false, checkedin_time = null WHERE Username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                cmd.Connection.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                checkoutLabel.Text = "You have successfully checked yourself out.";
                CheckoutButton.Visible = false;
            }
            catch
            {
                checkoutLabel.Text = "An error occured.  Sorry please try again.";
            }
        }
    }
}