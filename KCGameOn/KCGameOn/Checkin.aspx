<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkin.aspx.cs" Inherits="KCGameOn.Checkin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<%--    <asp:Label ID="DebugLabel" runat="server" Visible="true" Text="" />--%>
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <div class="container">

        <%if (Checkin.hasPaid == "Y")
        {%>
            <%if (Checkin.hasCheckedIn == "False")
            {%>
                <form id="CheckinForm" runat="server">
                    <h2><asp:Label ID="checkinLabel" Text="Click the button to check yourself in." runat="server" /></h2><br />
                    <center><asp:Button ID="CheckinButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="CheckinButton_Click" runat="server" Text="Check In"/></center>
                </form>
            <%}
            else if (Checkin.hasCheckedIn == "True")
            {%>
                <form id="CheckoutForm" runat="server">
                    <h2><asp:Label ID="checkoutLabel" Text="You are already checked in, press the button to check out." runat="server" /></h2><br />
                    <center><asp:Button ID="CheckoutButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="CheckoutButton_Click" runat="server" Text="Check Out"/></center>
                </form>

            <%}
            else 
            {%>
                <h2>Checkin for event <% =Checkin.getEventID %>  is not ready yet, please try again on the day of the event.</h2>
            <%} %>
        <%}
        else
        {%>
            <h2>You have not paid.  Please pay so you can check in.</h2>
        <%} %>    
    </div>
    <%}
    else
    {%>
        <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
        <h3>There are currently <%=Users.count.ToString() %> people registered at kcgameon.com, <a href="https://www.kcgameon.com/Account/Register.aspx">sign up</a> today!</h3>
        <br />
    <%} %>
</asp:Content>
