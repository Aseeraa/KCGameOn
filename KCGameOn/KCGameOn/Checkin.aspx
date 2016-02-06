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
            <h2>Welcome <% =SessionVariables.UserName %>, <asp:Label ID="checkinLabel" Text="" runat="server" /></h2><br />
            <form id="CheckinForm" runat="server">
                <center>
                    <h3>You may view your seat on the map or sign up for tournaments with the following buttons.</h3><br />
                    <asp:Button ID="MapButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="MapButton_Click" OnClientClick="document.getElementById('CheckinForm').target ='_blank';" runat="server" Text="Map"/>
                    <asp:Button ID="TournButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="TournButton_Click" OnClientClick="document.getElementById('CheckinForm').target ='_blank';" runat="server" Text="Tournaments"/>
                    <h3><br /><asp:Label ID="checkoutLabel" Text="Click the button when you are finished." runat="server" /><br /><br /></h3>
                    <asp:Button ID="CheckoutButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="CheckoutButton_Click" OnClientClick="document.getElementById('CheckinForm').target ='';" runat="server" Text="Done"/>
                </center>
            </form>
        <%}
        else
        {%>
            <h2>You have not paid.  Please <a href="./EventRegistration.aspx">click here</a> to pay so you can check in. Or you may pay cash to the check in managers.</h2>
        <%} %>    
    </div>
    <%}
    else
    {%>
        <h2>Please <a href="/Account/Login.aspx">login</a> to check into the event.</h2>
    <%} %>
</asp:Content>
