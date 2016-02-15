using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Text;
using System.Web.Security;

namespace KCGameOn
{
    public partial class Checkin : System.Web.UI.Page
    {
        public static int count;
        public static StringBuilder UserHTML;
        public static String hasPaid;
        public static String hasCheckedIn;
        public static Int32 getEventID;

        private string errorString;
        private static string redirect;
        string UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        MySqlDataReader reader = null;
        MySqlCommand cmd = null;
        public string ErrorString
        {
            get { return errorString; }
            set { errorString = value; }
        }

        String connectionString = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand("SELECT EventID FROM kcgameon.schedule WHERE Active = 1 order by ID LIMIT 1;", new MySqlConnection(connectionString));
                cmd.Connection.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                getEventID = (Int32)cmd.ExecuteScalar();
                cmd.Connection.Close();

                MySqlCommand cmd2 = new MySqlCommand("SELECT checkedin FROM seatingchart WHERE username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                cmd2.Connection.Open();
                cmd2.CommandType = System.Data.CommandType.Text;
                hasCheckedIn = Convert.ToString(cmd2.ExecuteScalar());
                if (hasCheckedIn == "")
                {
                    CheckoutButton.Enabled = false;
                    checkoutLabel.Text = "You must go to the map and select a seat before finishing.";
                }
                cmd2.Connection.Close();

                MySqlCommand cmd1 = new MySqlCommand("SELECT verifiedPaid FROM payTable WHERE username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                cmd1.Connection.Open();
                cmd1.CommandType = System.Data.CommandType.Text;
                hasPaid = (String)cmd1.ExecuteScalar();
                cmd1.Connection.Close();

                if (hasCheckedIn == "False" && hasPaid == "Y")
                {
                    MySqlCommand cmd3 = new MySqlCommand("UPDATE seatingchart SET checkedin = true, checkedin_time = CURRENT_TIMESTAMP() WHERE Username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
                    cmd3.Connection.Open();
                    cmd3.CommandType = System.Data.CommandType.Text;
                    cmd3.ExecuteNonQuery();
                    cmd3.Connection.Close();
                    //checkinLabel.Text = "You have successfully checked yourself in.";
                }
                else
                {
                    //checkinLabel.Text = "You are already checked in.";
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
            Response.Redirect("/Checkin.aspx");
            //FormsAuthentication.RedirectToLoginPage();

            //try
            //{
            //    MySqlCommand cmd = new MySqlCommand("UPDATE seatingchart SET checkedin = false, checkedin_time = null WHERE Username = \'" + SessionVariables.UserName + "\' AND EventID = " + getEventID, new MySqlConnection(connectionString));
            //    cmd.Connection.Open();
            //    cmd.CommandType = System.Data.CommandType.Text;
            //    cmd.ExecuteNonQuery();
            //    cmd.Connection.Close();
            //    checkoutLabel.Text = "You have successfully checked yourself out.";
            //    CheckoutButton.Visible = false;
            //}
            //catch
            //{
            //    checkoutLabel.Text = "An error occured.  Sorry please try again.";
            //}
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

            //Set Connection String to MySql.
            String UserInfo = ConfigurationManager.ConnectionStrings["KcGameOnSQL"].ConnectionString;

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
                    cmd = new MySqlCommand("checkUser", new MySqlConnection(UserInfo));
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

                    cmd = new MySqlCommand("SELECT BlockPayments FROM AdminProperties", new MySqlConnection(UserInfo));
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
                    try
                    {
                        cmd = new MySqlCommand("SELECT paymentKey,verifiedPaid FROM payTable WHERE paidDate = (SELECT MAX(paidDate) FROM payTable where userName = \'" + SessionVariables.UserName.ToLower() + "\')", new MySqlConnection(UserInfo));
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
                    Response.Redirect("/Checkin.aspx");
                }
                catch
                {
                }
            }
        }
    }
}