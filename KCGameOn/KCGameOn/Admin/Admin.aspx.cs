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
            if (EventRegistration.paymentsBlocked == true)
                blockButtonVal = "Unblock";
            else
                blockButtonVal = "Block";
        }
    }
}