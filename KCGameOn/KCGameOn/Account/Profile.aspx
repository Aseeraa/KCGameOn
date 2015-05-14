<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="KCGameOn.Account.Profile" %>

<%@ Import Namespace="KCGameOn" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="HeadContent">
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="MainContent">
        <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
          {%>
    <h2>Coming soon!</h2>
    <%}
          else
          {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <%} %>
</asp:content>
