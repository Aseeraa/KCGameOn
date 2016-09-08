using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;
using System.Text;

namespace KCGameOn.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        public static String FirstName = null;
        public static String LastName = null;
        public static String Email = null;
        public static String Sponsor = null;
        public static String Joined = null;
        public static Boolean isActive = false;

        public static String SteamHandle = null;
        public static String BattleHandle = null;
        public static String OriginHandle = null;
        public static String TwitterHandle = null;
        public static String AboutMe = null;

        public static String HashedPasswordFromDB = null;
        //        public static StringBuilder RaffleHTML;

        //        //raffle-populate user table in admin page
        //        cmd = new MySqlCommand("select Username, eventID, wondoor, wonloyalty from EventArchive where username = '\'" + SessionVariables.UserName + "\'", new MySqlConnection(UserInfo));
        //                cmd.CommandType = System.Data.CommandType.Text;

        //                cmd.Connection.Open();
        //                Reader = cmd.ExecuteReader();
        //                RaffleHTML = new StringBuilder();

        //                while (Reader.Read())
        //                {
        //                    RaffleHTML.AppendLine("<tr>");
        //                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("username")).Append("</td>");
        //        RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("FirstName")).Append("</td>");
        //        RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("LastName")).Append("</td>");
        //        RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("eventID")).Append("</td>");
        //        RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("wondoor")).Append("</td>");
        //        RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("wonloyalty")).Append("</td>");
        //        RaffleHTML.AppendLine("</tr>");
        //                }
        //    Reader.Close();

        //                foreach (UsersObject user in userlist)
        //                {
        //                    RaffleHTML.AppendLine("<tr>");
        //                    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("username")).Append("</td>");
        //    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("FirstName")).Append("</td>");
        //    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("LastName")).Append("</td>");
        //    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("eventID")).Append("</td>");
        //    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("wondoor")).Append("</td>");
        //    RaffleHTML.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("wonloyalty")).Append("</td>");
        //    RaffleHTML.AppendLine("</tr>");
        //                    //copyall the way up to foreach after rebuilding get string for everything you want.
        //                }



        protected void Page_Load(object sender, EventArgs e)
        {
            // On first load get the values for the user logged in
            if (!IsPostBack)
            {
                using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM useraccount WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                {
                    MySqlDataReader Reader = null;
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection.Open();
                    Reader = cmd.ExecuteReader();
                    while (Reader.Read())
                    {
                        // Get current password
                        HashedPasswordFromDB = Reader.GetString("Password").ToString();

                        // Set the firstname
                        FirstName = Reader.GetString("FirstName").ToString();

                        // Set the lastname
                        LastName = Reader.GetString("LastName").ToString();

                        // Set the email
                        Email = Reader.GetString("Email").ToString();

                        // Set the sponsor
                        Sponsor = Reader.GetString("Cerner").ToString();

                        // Set active
                        isActive = Reader.GetBoolean("Active");

                        // Set joined date
                        Joined = Reader.GetString("Submission_Date").ToString();

                        SteamHandle = Reader.GetString("SteamHandle").ToString();

                        BattleHandle = Reader.GetString("BattleHandle").ToString();

                        OriginHandle = Reader.GetString("OriginHandle").ToString();

                        TwitterHandle = Reader.GetString("TwitterHandle").ToString();

                    }
                    cmd.Connection.Close();
                }
            }

            UpdateFields();
        }


        protected void UpdateFields()
        {
            // Set the textbox values
            usernameText.Text = SessionVariables.UserName;
            firstNameText.Text = FirstName;
            lastNameText.Text = LastName;
            emailInput.Value = Email;
            sponsorText.Value = Sponsor;
            joinedDateText.Text = Joined;
            ActiveCheckbox.Checked = isActive;

            SteamHandleTB.Value = SteamHandle;
            BattleHandleTB.Value = BattleHandle;
            OriginHandleTB.Value = OriginHandle;
            TwitterHandleTB.Value = TwitterHandle;

        }

        protected void ChangeProfile_Click(object sender, EventArgs e)
        {
            String OrigPassword = Request.Form["ctl00$MainContent$CurrentPassword"].ToString().Trim();
            Regex regex = new Regex(@"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}");
            Match matchOrig = regex.Match(OrigPassword);
            PasswordHash PasswordHasher = new PasswordHash();
            String Salt = PasswordHasher.CreateSalt(SessionVariables.UserName.ToLower());
            String OrigHashedPassword = PasswordHasher.HashPassword(Salt, OrigPassword);

            if (OrigHashedPassword == HashedPasswordFromDB)
            {
                String NewHashedPassword = HashedPasswordFromDB;
                // Set our variables to the new inputs
                Email = Request.Form["ctl00$MainContent$emailInput"].ToString();
                Sponsor = Request.Form["ctl00$MainContent$sponsorText"].ToString();
                SteamHandle = Request.Form["ctl00$MainContent$SteamHandleTB"].ToString();
                BattleHandle = Request.Form["ctl00$MainContent$BattleHandleTB"].ToString();
                OriginHandle = Request.Form["ctl00$MainContent$OriginHandleTB"].ToString();
                TwitterHandle = Request.Form["ctl00$MainContent$TwitterHandleTB"].ToString();

                if (Request.Form["ctl00$MainContent$ActiveCheckbox"] == "on")
                {
                    isActive = true;
                }
                else
                {
                    isActive = false;

                }

                UpdateFields();

                if (Request.Form["ctl00$MainContent$NewPassword"].ToString() != "" && Request.Form["ctl00$MainContent$NewPasswordConfirm"].ToString() != "")
                {
                    String NewPassword = Request.Form["ctl00$MainContent$NewPassword"].ToString().Trim();
                    Match matchNew = regex.Match(NewPassword);
                    NewHashedPassword = PasswordHasher.HashPassword(Salt, NewPassword);
                }

                using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Email = \'" + Email + "\', Cerner = \'" + Sponsor + "\', Active = " + isActive + ", Password = \'" + NewHashedPassword + "\', SteamHandle = \'" + SteamHandle + "\', BattleHandle = \'" + BattleHandle + "\', OriginHandle = \'" + OriginHandle + "\', TwitterHandle = \'" + TwitterHandle + "\' WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
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
                ProfileUpdateMessage.Text = "Original Password Does Not Match!";
            }
        }
    }
}