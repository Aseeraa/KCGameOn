using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace KCGameOn.Account
{
    public partial class Unsubscribe : System.Web.UI.Page
    {

        public static String EmailID = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(SessionVariables.UserName))
            {
                //get user EmailID by QueryString as below:
                //if (Request.QueryString["emailID"] != null && Request.QueryString["emailID"] != "0")
                //{
                //    EmailID = Request.QueryString["emailID"].ToString();
                //}
                //else
                //{
                //    EmailID = null;
                //}

                //if (EmailID != null)
                //{
                    //Update the usertable as below:
                    //using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Active = false WHERE useraccount.Email = '" + EmailID + "' AND useraccount.username = '" + SessionVariables.UserName + "'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                    //{
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE useraccount SET Active = false WHERE useraccount.username = '" + SessionVariables.UserName + "'", new MySqlConnection(ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString)))
                    {
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        unsubscribeMessage.Text = "Successfully unsubscribed and set to inactive!";
                    }
                //}
                //else
                //{
                //    unsubscribeMessage.Text = "Nothing to do here!";
                //}
            }          
        }
    }
}