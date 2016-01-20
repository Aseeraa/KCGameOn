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
        public static Boolean isActive = false;
        private String HashedPasswordFromDB = null;
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
                        isActive = Reader.GetBoolean("Active");
                        if (!IsPostBack)
                        {
                            emailInput.Text = Email;
                            ActiveCheckbox.Checked = isActive;
                        }
                        
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
            String OrigPassword = Request.Form["ctl00$MainContent$CurrentPassword"].ToString().Trim();
            Regex regex = new Regex(@"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}");
            Match matchOrig = regex.Match(OrigPassword);
            PasswordHash PasswordHasher = new PasswordHash();
            String Salt = PasswordHasher.CreateSalt(SessionVariables.UserName.ToLower());
            String OrigHashedPassword = PasswordHasher.HashPassword(Salt, OrigPassword);
            using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM useraccount WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                while (Reader.Read())
                {
                    HashedPasswordFromDB = Reader.GetString("Password").ToString();
                }
                cmd.Connection.Close();
            }

            if (OrigHashedPassword == HashedPasswordFromDB)
            {
                if (emailInput.Text != Email)
                {
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Email = \'" + emailInput.Text + "\' WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                    {
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        Email = emailInput.Text;
                        ProfileUpdateMessage.Text = "Profile Successfully Updated!";
                    }
                }
                else
                {
                }
                if (ActiveCheckbox.Checked != isActive)
                {
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Active = " + ActiveCheckbox.Checked + " WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                    {
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        isActive = ActiveCheckbox.Checked;
                        ProfileUpdateMessage.Text = "Profile Successfully Updated!";
                    }
                }
                else
                {
                    
                }
                if (Request.Form["ctl00$MainContent$NewPassword"].ToString() != "" && Request.Form["ctl00$MainContent$NewPasswordConfirm"].ToString() != "")
                {
                    String NewPassword = Request.Form["ctl00$MainContent$NewPassword"].ToString().Trim();
                    Match matchNew = regex.Match(NewPassword);
                    String HashedPassword = PasswordHasher.HashPassword(Salt, NewPassword);
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Password = \'" + HashedPassword + "\' WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                    {
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        ProfileUpdateMessage.Text = "Profile Successfully Updated!";
                    }
                }
                else
                {
                }
                
            }
            else
            {
                ProfileUpdateMessage.Text = "Original Password Does Not Match!";
            }
        }
    }
}