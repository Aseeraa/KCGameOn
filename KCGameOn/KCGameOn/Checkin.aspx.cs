using System;
using System.Web;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using Zen.Barcode;
using System.IO;

namespace KCGameOn
{
    public partial class Checkin : System.Web.UI.Page, IPostBackEventHandler
    {
        public static String hasCheckedIn;
        public static Int32 getEventID;

        private string errorString;
        public string ErrorString
        {
            get { return errorString; }
            set { errorString = value; }
        }

        String conn = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

        public void RaisePostBackEvent(string eventArgument)
        {
            MySqlCommand cmd9 = new MySqlCommand("SELECT Username FROM payTable WHERE Barcode = " + eventArgument + "; ", new MySqlConnection(conn));
            cmd9.Connection.Open();
            cmd9.CommandType = System.Data.CommandType.Text;

            if (cmd9.ExecuteScalar() != null)
            {
                SessionVariables.UserName = (String)cmd9.ExecuteScalar();
                SessionVariables.UserAdmin = 0;
            }
            cmd9.Connection.Close();
            Response.Redirect("~/Checkin.aspx");
        }

        private string getBarcode(string barcode)
        {
            BarcodeSymbology s = BarcodeSymbology.Code39NC;
            BarcodeDraw drawObject = BarcodeDrawFactory.GetSymbology(s);
            var metrics = drawObject.GetDefaultMetrics(45);
            metrics.Scale = 1;
            var barcodeImage = drawObject.Draw(barcode, metrics);

            using (MemoryStream ms = new MemoryStream())
            {
                barcodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imageBytes = ms.ToArray();

                return Convert.ToBase64String(imageBytes);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                // Setting image to barcode based on defined string
                //barc.Attributes["src"] = ResolveUrl("data:image/png;base64," + getBarcode("412672016012240"));


                //Create Command
                MySqlCommand cmd = new MySqlCommand("SELECT pay.idpaytable, pay.username, pay.EventID, sea.checkedin, pay.verifiedPaid, pay.paymentKey FROM payTable AS pay LEFT JOIN (SELECT username, checkedin FROM seatingchart WHERE username = \"" + SessionVariables.UserName + "\" AND ActiveIndicator = \"TRUE\") sea on pay.username = sea.username WHERE pay.username = \"" + SessionVariables.UserName + "\" AND pay.EventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1) AND pay.verifiedPaid = \"Y\"", new MySqlConnection(conn));
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection.Open();

                //Bind command to reader
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    //read each row
                    while (reader.Read())
                    {
                        //associate variables
                        getEventID = (Int32)reader["EventID"];
                        hasCheckedIn = reader["checkedin"].ToString();
                        SessionVariables.verifiedPaid = reader["verifiedPaid"].ToString();
                    }
                    // Call Close when done reading.
                    reader.Close();
                }

                cmd.Connection.Close();

                if (hasCheckedIn == "")
                {
                    CheckoutButton.Enabled = false;
                    checkoutLabel.Text = "You must go to the map and select a seat before finishing.";
                }
                else
                {
                    if (hasCheckedIn != "True" && SessionVariables.verifiedPaid == "Y")
                    {
                        cmd = new MySqlCommand("UPDATE seatingchart SET checkedin = true, checkedin_time = CURRENT_TIMESTAMP() WHERE username = \'" + SessionVariables.UserName + "\' AND ActiveIndicator = \'TRUE\'", new MySqlConnection(conn));
                        cmd.Connection.Open();
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();

                        cmd = new MySqlCommand("INSERT IGNORE INTO EventArchive (Username,eventID,checkedin,prize,activeIndicator,wondoor,wonloyalty) VALUES (\"" + SessionVariables.UserName + "\", (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1), 1, \"\", 1, 0, 0); ", new MySqlConnection(conn));
                        cmd.Connection.Open();
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        //checkinLabel.Text = "You have successfully checked yourself in.";
                    }
                    else
                    {
                        //checkinLabel.Text = "You are already checked in.";
                    }
                }
            }
            catch { checkinLabel.Text = "An error occured.  Sorry please try again."; }            
        }
        protected void CheckoutButton_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();

            //Clearn Authentication Cookie.
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            // clear session cookie (not necessary for your current problem but i would recommend you do it anyway)
            HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);
            Response.Redirect("~/Checkin.aspx");
            //FormsAuthentication.RedirectToLoginPage();
        }

        protected void MapButton_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("/Map.aspx");
            }
            catch
            {
            }
        }

        protected void TournButton_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("/Tournament.aspx");
            }
            catch
            {
            }
        }
        protected void CashButton_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("/Checkin.aspx");
            }
            catch
            {
            }
        }
        protected void PaypalButton_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("/EventRegistration.aspx");
            }
            catch
            {
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            String UserName = Request.Form["ctl00$MainContent$UserName"];
            String Password = Request.Form["ctl00$MainContent$Password"];

            if (UserName != null && Password != null)
            {

                //Hash Users Password.
                PasswordHash PasswordHasher = new PasswordHash();
                String Salt = PasswordHasher.CreateSalt(UserName.ToLower());
                String HashedPassword = PasswordHasher.HashPassword(Salt, Password);
                MySqlCommand cmd = null;
                int Authentication = 0;

                try
                {
                    cmd = new MySqlCommand("checkUser", new MySqlConnection(conn));
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("Username", UserName);
                    cmd.Parameters.AddWithValue("UserPass", HashedPassword);

                    cmd.Connection.Open();
                    //Reader = cmd.ExecuteReader();
                    Authentication = Convert.ToInt32(cmd.ExecuteScalar());
                    switch (Authentication)
                    {
                        case -1:
                            ErrorString = "Please Activate your account.";
                            break;
                        case -2: // UserActivated, User Is Admin and UserAuthenticated.
                            SessionVariables.UserName = UserName;
                            SessionVariables.UserAdmin = 1;
                            // Set Cookies if Remember was checked.
                            break;
                        case -3: // UserActivatd, UseAuthenticated and User isn't Admin.
                            SessionVariables.UserName = UserName;
                            SessionVariables.UserAdmin = 0;
                            // Set Cookies if Remember was checked.
                            break;
                        case -4:
                            ErrorString = "Your Input Sucks!";
                            break;
                        default:
                            break;
                    }
                }
                finally
                {
                    if (cmd != null)
                        cmd.Connection.Close();
                }

                try
                {

                    cmd = new MySqlCommand("SELECT BlockPayments FROM AdminProperties", new MySqlConnection(conn));
                    cmd.Connection.Open();
                    cmd.CommandType = System.Data.CommandType.Text;
                    string blocked = cmd.ExecuteScalar().ToString();
                    if (blocked.Equals("TRUE"))
                        if (SessionVariables.UserAdmin == 0 && !SessionVariables.UserName.ToLower().Equals("kctestaccount"))
                            SessionVariables.registrationBlocked = true;
                }
                catch (Exception)
                {

                }
                finally
                {
                    if (cmd.Connection != null)
                        cmd.Connection.Close();
                }

                if (SessionVariables.UserName != null)
                {
                    MySqlDataReader reader = null;
                    try
                    {
                        
                        cmd = new MySqlCommand("SELECT pay.idpaytable, pay.username, pay.EventID, sea.checkedin, pay.verifiedPaid, pay.paymentKey FROM payTable AS pay LEFT JOIN(SELECT username, checkedin FROM seatingchart WHERE username = \"" + SessionVariables.UserName + "\" AND ActiveIndicator = \"TRUE\") sea on pay.username = sea.username WHERE pay.username = \"" + SessionVariables.UserName + "\" AND pay.EventID = (SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1) AND pay.verifiedPaid = \"Y\"", new MySqlConnection(conn));
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.Connection.Open();
                        IAsyncResult result = cmd.BeginExecuteReader();
                        reader = cmd.EndExecuteReader(result);
                        result = cmd.BeginExecuteReader();
                        if (reader == null || !reader.HasRows)
                        {
                            SessionVariables.verifiedPaid = "N";
                        }
                        else
                        {
                            while (reader.Read())
                            {
                                SessionVariables.paymentKey = reader["paymentKey"].ToString();
                                SessionVariables.verifiedPaid = reader["verifiedPaid"].ToString();
                                //TODO ADD TO RAFFLE TABLE HERE?
                            }
                        }
                    }
                    catch (Exception)
                    {
                    }
                    finally
                    {
                        if (reader != null)
                        {
                            reader.Close();
                        }
                        if (cmd != null)
                        {
                            cmd.Connection.Close();
                        }
                    }
                }
                try
                {
                    if (SessionVariables.UserName != null)
                    {
                        Response.Redirect("~/Checkin.aspx");
                    }
                }
                catch
                {
                }
            }
        }
    }
}