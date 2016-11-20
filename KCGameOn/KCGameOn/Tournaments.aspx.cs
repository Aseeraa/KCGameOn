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

   //check to see if row exists for user
   //if username doesn't exist - a row is created in the tournaments table where username = seesionvariables and eventid = eventid - the rest should be set to false.
   //futuredev - if row exists for eventid - 1, copy that row and create new row for current eventid
            if (!IsPostBack)
            {
                if (SessionVariables.UserName != null )
                {
                    using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM tournaments WHERE tournaments.Username = \'" + SessionVariables.UserName + "\' AND tournaments.EventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1)", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                    {
                        MySqlDataReader Reader = null;
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        Reader = cmd.ExecuteReader();
                        if (Reader.Read())
                        {
                            while (Reader.Read())
                            {
                                // Set active
                                SFVRegistered = Reader.GetBoolean("SFV");
                                TKFRegistered = Reader.GetBoolean("KingofFighters");
                                //GGXRegistered = Reader.GetBoolean("GuiltyGear");
                                //KIRegistered = Reader.GetBoolean("KI");
                                //SG2ERegistered = Reader.GetBoolean("Skullgirls");
                                //USF4Registered = Reader.GetBoolean("UltraSF4");
                                //BBCFRegistered = Reader.GetBoolean("BlazBlue");
                                //SF3Registered = Reader.GetBoolean("SF3");
                                //MKXRegistered = Reader.GetBoolean("MKX");
                                //MVCRegistered = Reader.GetBoolean("MVC");
                                //DOA5Registered = Reader.GetBoolean("DOA5");
                                //POKRegistered = Reader.GetBoolean("Pokken");
                            }
                            cmd.Connection.Close();
                            UpdateFields();
                        }
                        else
                        {
                            using (MySqlCommand cmd2 = new MySqlCommand("INSERT INTO tournaments (id, username, EventID) VALUES ((SELECT ID FROM useraccount WHERE username = \'" + SessionVariables.UserName + "\'), \'" + SessionVariables.UserName + "\', (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1))", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                            {
                                cmd2.CommandType = System.Data.CommandType.Text;
                                cmd2.Connection.Open();
                                cmd2.ExecuteNonQuery();
                                cmd2.Connection.Close();
                                ProfileUpdateMessage.Text = "Had no history, created row in table!";
                            }
                        }
                    }
                }
            }
        }



        protected void UpdateFields()
        {
            // Set the textbox values
            usernameText.Text = SessionVariables.UserName;

            SFVRegisteredCB.Checked = SFVRegistered;
            TKFRegisteredCB.Checked = TKFRegistered;
            //GGXRegisteredCB.Checked = GGXRegistered;
            //KIRegisteredCB.Checked = KIRegistered;
            //SG2ERegisteredCB.Checked = SG2ERegistered;
            //USF4RegisteredCB.Checked = USF4Registered;
            //BBCFRegisteredCB.Checked = BBCFRegistered;
            //SF3RegisteredCB.Checked = SF3Registered;
            //MKXRegisteredCB.Checked = MKXRegistered;
            //MVCRegisteredCB.Checked = MVCRegistered;
            //DOA5RegisteredCB.Checked = DOA5Registered;
            //POKRegisteredCB.Checked = POKRegistered;


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

            if (Request.Form["ctl00$MainContent$SFVRegisteredCB"] == "on")
            {
                SFVRegistered = true;
            }
            else
            {
                SFVRegistered = false;

            }

            UpdateFields();
            using (MySqlCommand cmd = new MySqlCommand("UPDATE tournaments SET SFV = " + SFVRegistered + ", KingofFighters = " + TKFRegistered + " WHERE tournaments.username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            //using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Email = \'" + Email + "\', Cerner = \'" + Sponsor + "\', Active = " + isActive + ", Password = \'" + NewHashedPassword + "\', SteamHandle = \'" + SteamHandle + "\', BattleHandle = \'" + BattleHandle + "\', OriginHandle = \'" + OriginHandle + "\', TwitterHandle = \'" + TwitterHandle + "\' WHERE useraccount.Username = \'" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                //fails here, tried a few different escape characters, but not sure what is wrong with the sql above to actually update rows.
                cmd.Connection.Close();
                ProfileUpdateMessage.Text = "Profile Successfully Updated!";
            }
        }
    }
}