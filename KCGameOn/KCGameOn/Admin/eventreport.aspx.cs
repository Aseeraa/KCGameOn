using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

using System.Net;
using System.Text;

namespace KCGameOn
{
    public partial class eventreport : System.Web.UI.Page
    {
        public static List<String> seatList = new List<String>();
        public string seats;
        public string people;
        public int count;
        MySqlDataReader reader = null;
        MySqlCommand cmd = null;
        public static List<ReportUser> userlist;
        public static StringBuilder UserHTML;
        protected void Page_Load(object sender, EventArgs e)
        {
            userlist = new List<ReportUser>();
            // SQL query to update the SeatingChart.
            using (MySqlCommand cmd = new MySqlCommand("spEventReport", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Connection.Open();

                IAsyncResult result = cmd.BeginExecuteReader();
                //reader = cmd.ExecuteReader();
                reader = cmd.EndExecuteReader(result);
                UserHTML = new StringBuilder();

                while (reader.Read())
                {
                    ReportUser user = new ReportUser();
                    
                    try
                    {
                        UserHTML.AppendLine("<tr>");
                        UserHTML.AppendLine("<td class=\"col-md-1\">").Append(reader.GetString("UserName").ToString()).Append("</td>");
                        UserHTML.AppendLine("<td class=\"col-md-1\">").Append(reader.GetString("FirstName").ToString()).Append("</td>");
                        UserHTML.AppendLine("<td class=\"col-md-1\">").Append(reader.GetString("LastName").ToString()).Append("</td>");
                        UserHTML.AppendLine("</tr>");
                    }
                    catch (Exception)
                    { continue; }
                }
                reader.Close();
                cmd.Connection.Close();
            }
        }




    }
}
public class ReportUser
{
    public string Username { get; set; }
    public string First { get; set; }
    public string Last { get; set; }
}