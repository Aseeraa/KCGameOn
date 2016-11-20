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

namespace KCGameOn
{
    public partial class Tournaments : System.Web.UI.Page
    {
       
        public static Boolean TKFRegistered = false;

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
                        // Set active
                        TKFRegistered = Reader.GetBoolean("Active");
                    }
                    cmd.Connection.Close();
                    UpdateFields();
                }
            }
        }



        protected void UpdateFields()
        {
            // Set the textbox values
            usernameText.Text = SessionVariables.UserName;

            TKFRegisteredCB.Checked = TKFRegistered;


        }

        protected void ChangeProfile_Click(object sender, EventArgs e)
        {
            if (Request.Form["ctl00$MainContent$TKFRegisteredCB"] == "on")
            {
                TKFRegistered = true;
            }
            else
            {
                TKFRegistered = false;

            }

            UpdateFields();
            using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Active = " + TKFRegistered + " WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            //using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Email = \'" + Email + "\', Cerner = \'" + Sponsor + "\', Active = " + isActive + ", Password = \'" + NewHashedPassword + "\', SteamHandle = \'" + SteamHandle + "\', BattleHandle = \'" + BattleHandle + "\', OriginHandle = \'" + OriginHandle + "\', TwitterHandle = \'" + TwitterHandle + "\' WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                ProfileUpdateMessage.Text = "Profile Successfully Updated!";
            }
        }
    }
}