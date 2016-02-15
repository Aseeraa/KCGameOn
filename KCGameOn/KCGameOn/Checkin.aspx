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
            <center><h2>Welcome <% =SessionVariables.UserName %>, your funds have been verified! <br /><!--<asp:Label ID="checkinLabel" Text="" runat="server" /><asp:Label ID="Label1" Text="" runat="server" /></h2><br />-->
                
                    <h3>You may view your seat on the map or sign up for tournaments with the following buttons.</h3><br />
                    <asp:Button ID="MapButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="MapButton_Click" runat="server" Text="Map"/>
                    <asp:Button ID="TournButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="TournButton_Click" runat="server" Text="Tournaments"/>
                    <h3><br /><asp:Label ID="checkoutLabel" Text="" runat="server" /><br /><br /></h3>
                    <asp:Button ID="CheckoutButton" CssClass="btn btn-inverse" Font-Size="28px" Width="300px" Height="150px" OnClick="CheckoutButton_Click" runat="server" Text="Complete Checkin"/>
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
    <form class="well form-inline" runat="server">
        <center>
        <h2>KcGameOn Event Checkin System</h2>
            <p>
        Please enter your username and password.
        
        <a href="/Account/Register.aspx">Register</a> if you don't have an account.</p></center>
        <%if (ErrorString != null && ErrorString != ""){ %>
            <div class="alert alert-error"><%=ErrorString%></div>
        <%} %>
    
        <br />
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="LoginUserValidationGroup"/>
            <div class="accountInfo">
                <fieldset class="login">
                    <p>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                        <br />
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                        <br />
                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                             ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                         <a href="/Account/AccountManagement.aspx?AccountAction=recovery">Forgot password?</a>
                    </p>
                </fieldset>
            </div>
        <asp:Button ID="Button1" Class="btn btn-inverse" runat="server" Text="Login" ValidationGroup="LoginUserValidationGroup" OnClick="Button1_Click"/>
    </form>
    <%} %>
</asp:Content>
