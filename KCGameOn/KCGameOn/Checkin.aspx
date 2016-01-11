<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkin.aspx.cs" Inherits="KCGameOn.Checkin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <asp:Label ID="paidStatus" runat="server" Visible="false" />
    <asp:Label ID="checkInStatus" runat="server" Visible="false" />
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <div class="container">

        <%if (this.paidStatus.Text == "N")
        {%>
            <%if (this.checkInStatus.Text == "False")
            {%>
                <form id="CheckinForm" runat="server">
                    <asp:Label ID="successLabel" Text="Click the button to check yourself in." runat="server" /><br />
                    <asp:Button ID="CheckinButton" CssClass="btn btn-inverse" OnClick="CheckinButton_Click" runat="server" Text="Checkin"/>
                </form>
            <%}
            else
            {%>
                You already checked in.
            <%} %>
        <%}
        else
        {%>
            You have not paid.  Please pay so you can check in.
        <%} %>    
    </div>
    <%}
    else
    {%>
        <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
        <h3>There are currently <%=count.ToString() %> people registered at kcgameon.com, <a href="https://www.kcgameon.com/Account/Register.aspx">sign up</a> today!</>
        <br />
    <%} %>
</asp:Content>
