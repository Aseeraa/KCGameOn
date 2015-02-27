using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace KCGameOn
{
    public partial class Schedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader;
            int i = 1;
            try
            {
                MySqlCommand cmd = new MySqlCommand("getSchedule", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                //command.CommandType = SqlDataSourceCommandType.StoredProcedure();
                //command.CommandText = "SELECT UserName, AES_DECRYPT(Password,'KcGameOnHrishi') AS Password, Admin FROM KcGameOn.UserAccount WHERE Username ='" + UserName + "' AND Password=AES_ENCRYPT('" + Password + "','KcGameOnHrishi');";
                //myConn.Open();
                cmd.Connection.Open();

                //Reader = command.ExecuteReader();
                Reader = cmd.ExecuteReader();
                while (Reader.Read())
                {
                    if (i == 1)
                    {
                        TRow1.Text = Reader.GetString("Tournament").ToString();
                        DRow1.Text = Reader.GetString("TournamentDate").ToString();
                        StartRow1.Text = Reader.GetString("StartTime").ToString();
                        StopRow1.Text = Reader.GetString("StopTime").ToString();
                    }
                    if (i == 2)
                    {
                        TRow2.Text = Reader.GetString("Tournament").ToString();
                        DRow2.Text = Reader.GetString("TournamentDate").ToString();
                        StartRow2.Text = Reader.GetString("StartTime").ToString();
                        StopRow2.Text = Reader.GetString("StopTime").ToString();
                    }
                    if (i == 3)
                    {
                        TRow3.Text = Reader.GetString("Tournament").ToString();
                        DRow3.Text = Reader.GetString("TournamentDate").ToString();
                        StartRow3.Text = Reader.GetString("StartTime").ToString();
                        StopRow3.Text = Reader.GetString("StopTime").ToString();
                    }
                    if (i == 4)
                    {
                        TRow4.Text = Reader.GetString("Tournament").ToString();
                        DRow4.Text = Reader.GetString("TournamentDate").ToString();
                        StartRow4.Text = Reader.GetString("StartTime").ToString();
                        StopRow4.Text = Reader.GetString("StopTime").ToString();
                    }
                    if (i == 5)
                    {
                        TRow5.Text = Reader.GetString("Tournament").ToString();
                        DRow5.Text = Reader.GetString("TournamentDate").ToString();
                        StartRow5.Text = Reader.GetString("StartTime").ToString();
                        StopRow5.Text = Reader.GetString("StopTime").ToString();
                    }
                    if (i == 6)
                    {
                        TRow6.Text = Reader.GetString("Tournament").ToString();
                        DRow6.Text = Reader.GetString("TournamentDate").ToString();
                        StartRow6.Text = Reader.GetString("StartTime").ToString();
                        StopRow6.Text = Reader.GetString("StopTime").ToString();
                    }
                    i++;
                }
                cmd.Connection.Close();
            }
            finally
            {
                // Close databse connection.
                //myConn.Close();

            }
        }
    }
}