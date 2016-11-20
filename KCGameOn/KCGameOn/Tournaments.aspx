<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tournaments.aspx.cs" Inherits="KCGameOn.Tournaments" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/index.css" rel="stylesheet" />
    <script type="text/javascript" src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">
            jQuery(document).ready(function () {
                jQuery(".Content").hide();
                //toggle the componenet with class msg_body
                jQuery(".Menubody-trigger").click(function () {
                    // For Nav Labels
                    if ($(this).hasClass("Menubody-trigger-active")) {
                        $(this).removeClass("Menubody-trigger-active");
                        $(this).parent().find('.Content').stop(true, true).slideUp(500);
                    }
                    else {
                        $(this).addClass("Menubody-trigger-active");
                        $(this).parent().find('.Content').stop(true, true).slideDown(500);
                        //$(this).parent().find('.Content2').hide();
                    }
                });
            });
        </script>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
        {%>
<form class="well form-horizontal" runat="server" id="updatepassword">
    <h2>Welcome, <asp:Literal runat="server" ID="usernameText" EnableViewState="false" />!</h2>    

  <!--  <div class="UImenu">
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
    </div> -->
   <div class="UImenuItem">
        <input type="checkbox" id="SFVRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">SFV</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
   </div>
   <div class="UImenuItem">
        <input type="checkbox" id="TKFRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">The King of Fighters XIV logo</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
	<div class="UImenuItem">
        <input type="checkbox" id="GGXRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Guilty Gear Xrd: Revelator</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="KIRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Killer Instinct</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="SG2ERegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Skullgirls 2nd Encore</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="USF4RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Ultra Street Fighter 4</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="BBCFRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">BlazBlue: Central Fiction</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="SF3RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Street Fighter III: 3rd Strike</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="MKXRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Mortal Kombat X</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="MVCRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Ultimate Marvel vs Capcom 3</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="DOA5RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Dead or Alive 5 Last Round</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="POKRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Pokken</label>
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
