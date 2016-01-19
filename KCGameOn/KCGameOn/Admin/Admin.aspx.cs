using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KCGameOn.Admin
{
    public partial class Admin : System.Web.UI.Page
    {
        public static string blockButtonVal;
        protected void Page_Load(object sender, EventArgs e)
        {
            //try
            //{

            //    cmd = new MySqlCommand("SELECT BlockPayments FROM AdminProperties", new MySqlConnection(UserInfo));
            //    cmd.Connection.Open();
            //    cmd.CommandType = System.Data.CommandType.Text;
            //    string blocked = cmd.ExecuteScalar().ToString();
            //    if (blocked.Equals("TRUE"))
            //        if (SessionVariables.UserAdmin == 0)
            //            SessionVariables.registrationBlocked = true;
            //}
            //catch (Exception)
            //{

            //}
            //finally
            //{
            //    if (cmd.Connection != null)
            //        cmd.Connection.Close();
            //}
        }
    }
}