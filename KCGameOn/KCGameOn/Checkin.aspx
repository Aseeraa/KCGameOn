<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkin.aspx.cs" Inherits="KCGameOn.Checkin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<%--    <asp:Label ID="DebugLabel" runat="server" Visible="true" Text="" />--%>
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <div class="container">
        <form id="CheckinForm" runat="server">
        <%if (Checkin.hasPaid == "Y")
        {%>
            <h2>Welcome <% =SessionVariables.UserName %>, <asp:Label ID="checkinLabel" Text="" runat="server" /><asp:Label ID="Label1" Text="" runat="server" /></h2><br />
                <center>
                    <h3>You may view your seat on the map or sign up for tournaments with the following buttons.</h3><br />
                    <asp:Button ID="MapButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="MapButton_Click" runat="server" Text="Map"/>
                    <asp:Button ID="TournButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="TournButton_Click" runat="server" Text="Tournaments"/>
                    <h3><br /><asp:Label ID="checkoutLabel" Text="Click the button when you are finished." runat="server" /><br /><br /></h3>
                    <asp:Button ID="CheckoutButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="CheckoutButton_Click" runat="server" Text="Done"/>
                </center>
            
        <%}
        else
        {%>
            <h2>You have not paid! Please pay using the following options.</h2>
            <h3 style="color: red;">If you choose to pay with cash please wait for the admin to confirm payment before clicking the cash button below.</h3>
            <center>
                <br /><br />
                <asp:Button ID="CashButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="CashButton_Click" runat="server" Text="Cash"/>
                <br /><br />
                <asp:Button ID="PaypalButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="PaypalButton_Click" runat="server" Text="PayPal"/>
            </center>
        <%} %>    
        </form>
    </div>
    <%}
    else
    {%>
        <h2>Please <a href="/Account/Login.aspx">login</a> to check into the event.</h2>
    <%} %>
</asp:Content>
