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
    public partial class Users : System.Web.UI.Page
    {
        public static StringBuilder UserHTML;
        protected void Page_Load(object sender, EventArgs e)
        {
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
            MySqlDataReader Reader = null;
            MySqlCommand cmd = null;

            try
            {
                cmd = new MySqlCommand("getUsers", new MySqlConnection(UserInfo));
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Connection.Open();
                Reader = cmd.ExecuteReader();
                UserHTML = new StringBuilder();

                while (Reader.Read())
                {
                    UserHTML.AppendLine("<tr>");
                    UserHTML.AppendLine("<td>").Append(Reader.GetString("UserName").ToString()).Append("</td>");
                    UserHTML.AppendLine("<td>").Append(Reader.GetString("FirstName").ToString()).Append("</td>");
                    UserHTML.AppendLine("<td>").Append(Reader.GetString("LastName").ToString()).Append("</td>");
                    UserHTML.AppendLine("<td>").Append(Reader.GetString("GamingInitials").ToString()).Append("</td>");
                    UserHTML.AppendLine("<td>").Append(Reader.GetString("GamingGroup").ToString()).Append("</td>");
                    UserHTML.AppendLine("</tr>");
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