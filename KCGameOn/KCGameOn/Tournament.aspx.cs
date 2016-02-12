using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KCGameOn
{
    public partial class Tournament : System.Web.UI.Page
    {
        public string pp = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.UrlReferrer != null)
            {
                pp = Request.UrlReferrer.ToString().ToLower();
                if (pp.Contains("checkin.aspx") == true)
                { previousPage.Text = "Click <a href=\"./Checkin.aspx\">here</a> to continue the check in process after selecting a seat!"; }
                else { previousPage.Text = pp; }
            }
        }
    }
}