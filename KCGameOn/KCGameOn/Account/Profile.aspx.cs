using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;

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
                    usernameText.Text = SessionVariables.UserName;
                    FirstName = Reader.GetString("FirstName").ToString();
                    firstNameText.Text = FirstName;
                    LastName = Reader.GetString("LastName").ToString();
                    lastNameText.Text = LastName;
                    Email = Reader.GetString("Email").ToString();
                    emailText.Text = Email;
                    if (!Reader.IsDBNull(10))
                    {
                        Sponsor = Reader.GetString("Cerner").ToString();
                        sponsorText.Text = Sponsor;
                    }

                    Joined = Reader.GetString("Submission_Date").ToString();
                    joinedDateText.Text = Joined;
                }
                cmd.Connection.Close();
            }
        }
        protected void ChangeProfile_Click(object sender, EventArgs e)
        {
            String Password = Request.Form["ctl00$MainContent$Password"].ToString().Trim();
            Regex regex = new Regex(@"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}");
            Match match = regex.Match(Password);
            PasswordHash PasswordHasher = new PasswordHash();
            String Salt = PasswordHasher.CreateSalt(SessionVariables.UserName.ToLower());
            String HashedPassword = PasswordHasher.HashPassword(Salt, Password);
            using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Password = \'" + HashedPassword + "\' WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
    }
}