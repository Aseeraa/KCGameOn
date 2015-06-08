using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace KCGameOn.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        MySqlDataReader Reader = null;
        public static String FirstName = null;
        public static String LastName = null;
        public static String Email = null;
        public static String Sponsor = "None";
        public static String Joined = "Unknown";
        public static String LastSeen = "Unknown";
        public static String GamerInitials = "N/A";
        public static String GamingGroup = "N/A";
        public static String PCTags = "N/A;N/A;N/A";
        public static String consoleTags = "N/A;N/A";
        protected void Page_Load(object sender, EventArgs e)
        {
            using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM useraccount WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                while (Reader.Read())
                {
                    FirstName = Reader.GetString("FirstName").ToString();
                    LastName = Reader.GetString("LastName").ToString();
                    Email = Reader.GetString("Email").ToString();
                    if (!Reader.IsDBNull(10))
                    {
                        Sponsor = Reader.GetString("Sponsor").ToString();
                    }

                    Joined = Reader.GetString("Submission_Date").ToString();
                }
                cmd.Connection.Close();
            }
        }
    }
}