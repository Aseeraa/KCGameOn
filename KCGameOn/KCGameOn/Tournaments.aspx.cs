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
       
        public static Boolean SFVRegistered = false;
        public static Boolean TKFRegistered = false;
        public static Boolean GGXRegistered = false;
        public static Boolean KIRegistered = false;
        public static Boolean SG2ERegistered = false;
        public static Boolean USF4Registered = false;
        public static Boolean BBCFRegistered = false;
        public static Boolean SF3Registered = false;
        public static Boolean MKXRegistered = false;
        public static Boolean MVCRegistered = false;
        public static Boolean DOA5Registered = false;
        public static Boolean POKRegistered = false;
        

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
                        SFVRegistered = Reader.GetBoolean("SFV");
                        TKFRegistered = Reader.GetBoolean("KingofFighters");
                        GGXRegistered = Reader.GetBoolean("GuiltyGear");
                        KIRegistered = Reader.GetBoolean("KI");
                        SG2ERegistered = Reader.GetBoolean("Skullgirls");
                        USF4Registered = Reader.GetBoolean("UltraSF4");
                        BBCFRegistered = Reader.GetBoolean("BlazBlue");
                        SF3Registered = Reader.GetBoolean("SF3");
                        MKXRegistered = Reader.GetBoolean("MKX");
                        MVCRegistered = Reader.GetBoolean("MVC");
                        DOA5Registered = Reader.GetBoolean("DOA5");
                        POKRegistered = Reader.GetBoolean("Pokken");
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

            SFVRegisteredCB.Checked = SFVRegistered;
            TKFRegisteredCB.Checked = TKFRegistered;
            GGXRegisteredCB.Checked = GGXRegistered;
            KIRegisteredCB.Checked = KIRegistered;
            SG2ERegisteredCB.Checked = SG2ERegistered;
            USF4RegisteredCB.Checked = USF4Registered;
            BBCFRegisteredCB.Checked = BBCFRegistered;
            SF3RegisteredCB.Checked = SF3Registered;
            MKXRegisteredCB.Checked = MKXRegistered;
            MVCRegisteredCB.Checked = MVCRegistered;
            DOA5RegisteredCB.Checked = DOA5Registered;
            POKRegisteredCB.Checked = POKRegistered;


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
            using (MySqlCommand cmd = new MySqlCommand("UPDATE tournaments SET SFV = \'" + SFVRegistered + "\',KingofFighters = \'" + TKFRegistered + "\', WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
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