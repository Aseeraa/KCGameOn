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
    public partial class Schedule : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        //    MySqlDataReader Reader = null;
        //    MySqlCommand cmd = null;
        //    int i = 1;
        //    try
        //    {
        //        cmd = new MySqlCommand("getSchedule", new MySqlConnection(UserInfo));
        //        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        //        //command.CommandType = SqlDataSourceCommandType.StoredProcedure();
        //        //command.CommandText = "SELECT UserName, AES_DECRYPT(Password,'KcGameOnHrishi') AS Password, Admin FROM KcGameOn.UserAccount WHERE Username ='" + UserName + "' AND Password=AES_ENCRYPT('" + Password + "','KcGameOnHrishi');";
        //        //myConn.Open();
        //        cmd.Connection.Open();

        //        //Reader = command.ExecuteReader();
        //        Reader = cmd.ExecuteReader();
        //        while (Reader.Read())
        //        {
        //            if (i == 1)
        //            {
        //                TRow1.Text = Reader.GetString("Tournament").ToString();
        //                DRow1.Text = Reader.GetString("TournamentDate").ToString();
        //                StartRow1.Text = Reader.GetString("StartTime").ToString();
        //                StopRow1.Text = Reader.GetString("StopTime").ToString();
        //            }
        //            if (i == 2)
        //            {
        //                TRow2.Text = Reader.GetString("Tournament").ToString();
        //                DRow2.Text = Reader.GetString("TournamentDate").ToString();
        //                StartRow2.Text = Reader.GetString("StartTime").ToString();
        //                StopRow2.Text = Reader.GetString("StopTime").ToString();
        //            }
        //            if (i == 3)
        //            {
        //                TRow3.Text = Reader.GetString("Tournament").ToString();
        //                DRow3.Text = Reader.GetString("TournamentDate").ToString();
        //                StartRow3.Text = Reader.GetString("StartTime").ToString();
        //                StopRow3.Text = Reader.GetString("StopTime").ToString();
        //            }
        //            if (i == 4)
        //            {
        //                TRow4.Text = Reader.GetString("Tournament").ToString();
        //                DRow4.Text = Reader.GetString("TournamentDate").ToString();
        //                StartRow4.Text = Reader.GetString("StartTime").ToString();
        //                StopRow4.Text = Reader.GetString("StopTime").ToString();
        //            }
        //            if (i == 5)
        //            {
        //                TRow5.Text = Reader.GetString("Tournament").ToString();
        //                DRow5.Text = Reader.GetString("TournamentDate").ToString();
        //                StartRow5.Text = Reader.GetString("StartTime").ToString();
        //                StopRow5.Text = Reader.GetString("StopTime").ToString();
        //            }
        //            if (i == 6)
        //            {
        //                TRow6.Text = Reader.GetString("Tournament").ToString();
        //                DRow6.Text = Reader.GetString("TournamentDate").ToString();
        //                StartRow6.Text = Reader.GetString("StartTime").ToString();
        //                StopRow6.Text = Reader.GetString("StopTime").ToString();
        //            }
        //            i++;
        //        }
        //        cmd.Connection.Close();
        //    }
        //    finally
        //    {
        //        if (cmd.Connection != null)
        //            cmd.Connection.Close();
        //        if (Reader != null)
        //            Reader.Close();
        //    }
        //}

        public static StringBuilder ScheduleHTMLActive;
        public static StringBuilder ScheduleHTMLOld;
        protected void Page_Load(object sender, EventArgs e)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader = null;
            MySqlCommand cmd = null;

            try
            {
                cmd = new MySqlCommand("getSchedule", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                ScheduleHTMLActive = new StringBuilder();
                ScheduleHTMLOld = new StringBuilder();

                while (Reader.Read())
                {
                    if (Reader.GetString("Active").ToString().Equals("1"))
                    {
                        ScheduleHTMLActive.AppendLine("<tr>");
                        ScheduleHTMLActive.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("Tournament").ToString()).Append("</td>");
                        ScheduleHTMLActive.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("TournamentDate").ToString()).Append("</td>");
                        ScheduleHTMLActive.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("StartTime").ToString() + " - " + Reader.GetString("StopTime").ToString()).Append("</td>");
                        ScheduleHTMLActive.AppendLine("</tr>");
                    }
                    else
                    {
                        ScheduleHTMLOld.AppendLine("<tr>");
                        ScheduleHTMLOld.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("Tournament").ToString()).Append("</td>");
                        ScheduleHTMLOld.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("TournamentDate").ToString()).Append("</td>");
                        ScheduleHTMLOld.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("StartTime").ToString() + " - " + Reader.GetString("StopTime").ToString()).Append("</td>");
                        ScheduleHTMLOld.AppendLine("<td class=\"col-md-1\">").Append(Reader.GetString("Attendance").ToString()).Append("</td>");
                        ScheduleHTMLOld.AppendLine("</tr>");
                    }
                }
            }
            finally
            {
                if (cmd.Connection != null)
                    cmd.Connection.Close();
                if (Reader != null)
                    Reader.Close();
            }
        }
    }
}