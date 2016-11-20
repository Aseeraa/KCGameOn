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
            // Eventually we copy the precious eventID settings to a new row if they don't have one but did last event
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
                            // Set variables from db
                            SFVRegistered = Reader.GetBoolean("SFV");
                            TKFRegistered = Reader.GetBoolean("KingofFighters");
                            GGXRegistered = Reader.GetBoolean("GuiltyGear");
                            KIRegistered = Reader.GetBoolean("KI");
                            SG2ERegistered = Reader.GetBoolean("Skullgirls");
                            USF4Registered = Reader.GetBoolean("UltraSF4");
                            BBCFRegistered = Reader.GetBoolean("BlazeBlue");
                            SF3Registered = Reader.GetBoolean("SF3");
                            MKXRegistered = Reader.GetBoolean("MKX");
                            MVCRegistered = Reader.GetBoolean("MVC");
                            DOA5Registered = Reader.GetBoolean("DOA5");
                            POKRegistered = Reader.GetBoolean("Pokken");
                            cmd.Connection.Close();
                            UpdateFields();
                        }
                        else
                        {
                            // Create new row if they do not have one
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
            // Set checkboxes from db value
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
            // Set values from checkboxes to send to db
            SFVRegistered = SFVRegisteredCB.Checked;
            TKFRegistered = TKFRegisteredCB.Checked;
            GGXRegistered = GGXRegisteredCB.Checked;
            KIRegistered = KIRegisteredCB.Checked;
            SG2ERegistered = SG2ERegisteredCB.Checked;
            USF4Registered = USF4RegisteredCB.Checked;
            BBCFRegistered = BBCFRegisteredCB.Checked;
            SF3Registered= SF3RegisteredCB.Checked;
            MKXRegistered = MKXRegisteredCB.Checked;
            MVCRegistered = MVCRegisteredCB.Checked;
            DOA5Registered = DOA5RegisteredCB.Checked;
            POKRegistered = POKRegisteredCB.Checked;

            UpdateFields();
            using (MySqlCommand cmd = new MySqlCommand("UPDATE tournaments SET SFV = " + SFVRegistered + ", KingofFighters = " + TKFRegistered + ", GuiltyGear = " + GGXRegistered + ", KI = " + KIRegistered + ", Skullgirls = " + SG2ERegistered + ", UltraSF4 = " + USF4Registered + ", BlazeBlue = " + BBCFRegistered + ", SF3 = " + SF3Registered + ", MKX = " + MKXRegistered + ", MVC = " + MVCRegistered + ", DOA5 = " + DOA5Registered + ", Pokken = " + POKRegistered + " WHERE tournaments.username = \' AND tournaments.EventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1)" + SessionVariables.UserName + "\'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
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