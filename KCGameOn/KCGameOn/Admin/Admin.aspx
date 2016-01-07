<%@ Page Title="Admin Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="KCGameOn.Admin.Admin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8" />
    <script>
        function registrationAllowances() {

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {
          if (SessionVariables.UserAdmin == 1)
          {%>
    <div class="container">
        <h3>Block/Unblock Payments
        </h3>
        <div class="pull-left">
            <button id="blockPayments" class="btn pull-left btn-danger" onclick="registrationAllowances">Block Registration</button>
            <button id="unblockPayments" class="btn pull-left btn-success" onclick="registrationAllowances">Unblock Registration</button>
        </div>
        <h3>Archive Event
        </h3>
        <div class="pull-left">
            <label>Unarchived Events:</label>
            <select id="eventDropdown" class="dropdown">
                <option selected="selected">None</option>
            </select>
            <button id="archiveEvent" class="btn pull-left btn-danger">Archive Event</button>
        </div>
        <h3>User Payment Verification
        </h3>
        <table>
        </table>
    </div>
    <%}
          else
          {%>
    <h2>You do not have the necessary privileges to view this page.</h2>
    <br />
    <%} %>
    <%} %>
    <%else
      {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <br />
    <%} %>
</asp:Content>
