using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
using MySql.Data.MySqlClient;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;

namespace KCGameOn
{
    public partial class Default : Page
    {
        public static StringBuilder DefaultHTML;
        public static List<users> userlist = new List<users>();
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            userlist = new List<users>();
            WebRequest MyRssRequest = WebRequest.Create("http://store.steampowered.com/feeds/news.xml");
            WebResponse MyRssResponse = MyRssRequest.GetResponse();

            Stream MyRssStream = MyRssResponse.GetResponseStream();

            XmlDocument MyRssDocument = new XmlDocument();
            MyRssDocument.Load(MyRssStream);

            XmlNodeList MyRssList = MyRssDocument.SelectNodes("//*");

            string sTitle = "";
            string sLink = "";
            string sDescription = "";
            table_feed.Attributes.Add("Class", "tbody");
            //Iterate/Loop through RSS Feed items
            for (int i = 0; i < MyRssList.Count; i++)
            {
                if (MyRssList.Item(i).Name == "title")
                    sTitle = MyRssList.Item(i).InnerText;

                if (MyRssList.Item(i).Name == "link")
                    sLink = MyRssList.Item(i).InnerText;

                if (MyRssList.Item(i).Name == "description")
                    sDescription = MyRssList.Item(i).InnerText;

                if (!String.IsNullOrEmpty(sTitle) && !String.IsNullOrEmpty(sLink) && !String.IsNullOrEmpty(sDescription))
                {
                    // Now generating HTML table rows and cells based on Title,Link & Description
                    HtmlTableCell block = new HtmlTableCell();

                    // You can style the Title From Here
                    block.InnerHtml = "<span style='font-weight:bold'><a href='" + sLink + "' target='new'>" + sTitle + "</a></span>";
                    HtmlTableRow row = new HtmlTableRow();
                    row.Cells.Add(block);
                    table_feed.Rows.Add(row);
                    HtmlTableCell block_description = new HtmlTableCell();

                    //You can style the Description from here
                    block_description.InnerHtml = "<p align='justify'>" + sDescription + "</p>";
                    HtmlTableRow row2 = new HtmlTableRow();
                    row2.Cells.Add(block_description);
                    table_feed.Rows.Add(row2);

                    sTitle = "";
                    sDescription = "";
                    sLink = "";
                }
                else if (!String.IsNullOrEmpty(sTitle) && !String.IsNullOrEmpty(sLink) && i > 4)
                {
                    // Now generating HTML table rows and cells based on Title,Link & Description
                    HtmlTableCell block = new HtmlTableCell();

                    // You can style the Title From Here
                    block.InnerHtml = "<span style='font-weight:bold'><a href='" + sLink + "' target='new'>" + sTitle + "</a></span>";
                    HtmlTableRow row = new HtmlTableRow();
                    row.Cells.Add(block);
                    table_feed.Rows.Add(row);
                    HtmlTableCell block_description = new HtmlTableCell();

                    ////You can style the Description from here
                    //block_description.InnerHtml = "<p align='justify'>" + sDescription + "</p>";
                    //HtmlTableRow row2 = new HtmlTableRow();
                    //row2.Cells.Add(block_description);
                    //tbl_Feed_Reader.Rows.Add(row2);

                    sTitle = "";
                    sDescription = "";
                    sLink = "";
                }

                String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
                MySqlDataReader Reader = null;
                MySqlCommand cmd = null;

                try
                {
                    cmd = new MySqlCommand("getUsers", new MySqlConnection(UserInfo));
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Connection.Open();
                    Reader = cmd.ExecuteReader();
                    DefaultHTML = new StringBuilder();

                    while (Reader.Read())
                    {
                        users newUser = new users();
                        newUser.Username = Reader.GetString("UserName").ToString();
                        newUser.First = Reader.GetString("FirstName").ToString();
                        newUser.Last = Reader.GetString("LastName").ToString();
                        userlist.Add(newUser);
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

        public class users
        {
            private string username;
            private string first;
            private string last;

            public string Username
            {
                set { this.username = value; }
                get { return this.username; }
            }

            public string First
            {
                set { this.first = value; }
                get { return this.first; }
            }

            public string Last
            {
                set { this.last = value; }
                get { return this.last; }
            }
        }

        //[WebMethod]
        //[ScriptMethod]
        //protected void validatePass(String password)
        //{
        //    String UserName = SessionVariables.UserName;
        //    String Password = password.ToString();

        //    //Set Connection String to MySql.
        //    String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

        //    if (UserName != null && Password != null)
        //    {

        //        //Hash Users Password.
        //        PasswordHash PasswordHasher = new PasswordHash();
        //        String Salt = PasswordHasher.CreateSalt(UserName.ToLower());
        //        String HashedPassword = PasswordHasher.HashPassword(Salt, Password);
        //        MySqlCommand cmd = null;
        //        int Authentication = 0;

        //        try
        //        {
        //            cmd = new MySqlCommand("checkUser", new MySqlConnection(UserInfo));
        //            cmd.CommandType = System.Data.CommandType.StoredProcedure;

        //            cmd.Parameters.AddWithValue("Username", UserName);
        //            cmd.Parameters.AddWithValue("UserPass", HashedPassword);

        //            cmd.Connection.Open();
        //            //Reader = cmd.ExecuteReader();
        //            Authentication = Convert.ToInt32(cmd.ExecuteScalar());

        //            switch (Authentication)
        //            {
        //                case -1:
        //                    ErrorString = "Please Activate your account.";
        //                    break;
        //                case -2: // UserActivated, User Is Admin and UserAuthenticated.
        //                    SessionVariables.UserName = UserName;
        //                    SessionVariables.UserAdmin = 1;
        //                    break;
        //                case -3: // UserActivatd, UseAuthenticated and User isn't Admin.
        //                    SessionVariables.UserName = UserName;
        //                    SessionVariables.UserAdmin = 0;
        //                    break;
        //                case -4:
        //                    ErrorString = "Your Input Sucks!";
        //                    break;
        //                default:
        //                    break;
        //            }
        //        }
        //        finally
        //        {
        //            if (cmd != null)
        //                cmd.Connection.Close();
        //        }
        //    }
        //}
    }
}