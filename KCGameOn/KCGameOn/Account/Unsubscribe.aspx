<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Unsubscribe.aspx.cs" MasterPageFile="~/Site.Master" Inherits="KCGameOn.Account.Unsubscribe" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<%if (!String.IsNullOrEmpty(SessionVariables.UserName))
{%>
    <h2><asp:Literal runat="server" id="unsubscribeMessage" EnableViewState="false" /></h2>
    <% }
        else { %>
    <h2>Please <a href="/Account/Login.aspx">login</a> to unsubscribe.</h2>
    <% } %>
</asp:Content>