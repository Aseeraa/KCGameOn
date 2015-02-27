using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KCGameOn.Account
{
    public partial class Activation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string activationCode = !string.IsNullOrEmpty(Request.QueryString["ActivationCode"]) ? Request.QueryString["ActivationCode"] : Guid.Empty.ToString();
                string SQlConnectionString = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
                using (MySqlCommand cmd = new MySqlCommand("DELETE FROM UserActivation WHERE ActivationCode = @ActivationCode", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
                    cmd.Connection.Open();

                    int rowAffected = cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                    if (rowAffected == 1)
                    {
                        ltMessage.Text = "Activation Sucessful. Nick Will buy Hrishi a cookie! ";
                    }
                    else
                    {
                        ltMessage.Text = "Invalid Activation Code.";
                    }
                }
            }
        }
    }
}