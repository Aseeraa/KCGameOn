using System;
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
        public String hasPaid;
        public bool hasCheckedIn;
        String connectionString = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand("SELECT verifiedPaid FROM payTable WHERE username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(connectionString));
                cmd.Connection.Open();
                hasPaid = (String) cmd.ExecuteScalar();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                paidStatus.Text = hasPaid.ToString();

                MySqlCommand cmd2 = new MySqlCommand("SELECT checkedin FROM seatingchart WHERE username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(connectionString));
                cmd2.Connection.Open();
                hasCheckedIn = (bool)cmd2.ExecuteScalar();
                cmd2.ExecuteNonQuery();
                cmd2.Connection.Close();
                checkInStatus.Text = hasCheckedIn.ToString();
            }
            catch { }
        }

        protected void CheckinButton_Click(object sender, EventArgs e)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand("UPDATE seatingchart SET checkedin = true WHERE Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(connectionString));
                cmd.Connection.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                successLabel.Text = "You have successfully checked yourself in.";
            }
            catch {
                successLabel.Text = "An error occured.  Sorry please try again.";
            }
        }
    }
}