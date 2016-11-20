<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tournaments.aspx.cs" Inherits="KCGameOn.Tournaments" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">

    <script type="text/javascript" src='https://www.google.com/recaptcha/api.js'></script>

</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
        {%>
<form class="well form-horizontal" runat="server" id="updatepassword">
    <h2>Welcome, <asp:Literal runat="server" ID="usernameText" EnableViewState="false" />!</h2>    

    <div class="UImenu">
        <div class="UImenuItem">
            <label class="Menubody-trigger">What is KCGAMEON?</label>
            <div class="Content">
                <p>KCGAMEON started as a LAN (Local Area Network) party. It is basically a bunch of gamers who pack up their computers, 
                (BYOC = Bring your own computer), set it up in a room with many other gamers, plug into a network connection, 
                and play games until their eyes bleed. Both men and women attend LANs, some LANs include tournaments in which 
                the winner may win a prize. Usually there is food provided. Over the last few years we have expanded our event to encompass all forms of gaming - PC, Console, Boardgames and Card games.
                </p>
            </div>
        </div>
        <div class="UImenuItem">
            <label class="Menubody-trigger">How many events are their a year?</label>
                <div class="Content">
                    <p>There are SIX events each year. They are roughly 6-8 weeks apart. During the summer we tend to spread them out little more due to folks being on vacations and what not.</p>
                </div>
        </div> 
    </div>

   <div class="UImenuItem">
        <label class="Menubody-trigger">The King of Fighters XIV logo</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       <input type="checkbox" id="TKFRegisteredCB" runat="server" />
    </div>
	<div class="UImenuItem">
        <label class="Menubody-trigger">Guilty Gear Xrd: Revelator</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Killer Instinct</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Skullgirls 2nd Encore</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Ultra Street Fighter 4</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">BlazBlue: Central Fiction</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Street Fighter III: 3rd Strike</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">BlazBlue: Central Fiction</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Mortal Kombat X</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Ultimate Marvel vs Capcom 3</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Dead or Alive 5 Last Round</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">Pokken</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
 
    <div class="control-group">
        <asp:Literal runat="server" ID="ProfileUpdateMessage" EnableViewState="false" />
    </div>
    <asp:Button ID="ChangeProfileConfirm" class="btn btn-large btn-success" type="submit" Text="Submit Changes" OnClick="ChangeProfile_Click" runat="server" />
</form>
    <%}
        else
        {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <%} %>

</asp:Content>
