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
using Newtonsoft.Json.Linq;
using System.Data;
using HtmlAgilityPack;

namespace KCGameOn
{
    public partial class Default : Page
    {
        //public static StringBuilder DefaultHTML;
        
        protected void Page_Load(object sender, EventArgs e)
        {
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

                    sTitle = "";
                    sDescription = "";
                    sLink = "";
                }
            }
        }


    }
}