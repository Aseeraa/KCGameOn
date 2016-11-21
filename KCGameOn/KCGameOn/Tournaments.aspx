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
    <p>Buttons/Check boxes will get tournament registration started.  Click the game names for more information. </p>    

<h2>PC Gaming</h2>

    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">League of Legends</label>
        <div class="Content">
            <p><div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h2>Oct 8, 2016 @230p</h2>
                            </p>
                            Please register with both battlefy and the LoL website or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>5v5</h2>
                            </p>
                            double elimination
                        </div>

                        <div class="col-md-3">
                            <p>Game Map & Type</p>
                            <p>
                                <h2>Summoners Rift</h2>
                            </p>
                            <p>Tournament Draft</p>
                        </div></p>
       </div>
   </div>
   <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Overwatch</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Rocket League</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">CS:GO</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>


<h2>Console Gaming</h2>

   <div class="UImenuItem">
        <input type="checkbox" id="SFVRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 SFV</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
   </div>
   <div class="UImenuItem">
        <input type="checkbox" id="TKFRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 The King of Fighters XIV</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
	<div class="UImenuItem">
        <input type="checkbox" id="GGXRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 Guilty Gear Xrd: Revelator</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="KIRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 Killer Instinct</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="SG2ERegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 Skullgirls 2nd Encore</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="USF4RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 Ultra Street Fighter 4</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="BBCFRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 BlazBlue: Central Fiction</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="SF3RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$5 Street Fighter III: 3rd Strike</label>
        <div class="Content">
			<p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <input type="checkbox" id="MKXRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 Mortal Kombat X</label>
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
        <input type="checkbox" id="DOA5RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">$10 Dead or Alive 5 Last Round</label>
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
     <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Destiny</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Halo5</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
     <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Sm4sh</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Smash PM</label>
        <div class="Content">
            <p>game info here</p>
        </div>
       
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Smash Melee</label>
        <div class="Content">
            <p>game info here</p>
        </div>
    </div>

  <h2>Mobile/Other</h2>

     <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Hearthstone</label>
        <div class="Content">
            <p>game info here</p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger tournament-menu">Tiny Whoop (Mini Drone Racing)</label>
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
