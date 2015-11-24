<%@ Page Title=" " Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GameServers.aspx.cs" Inherits="KCGameOn.GameServers" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <head>
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
    </head>

    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <h2>Game Servers</h2>
    <br />
    <form class="well form-inline">
        <p>These servers are given local IPs - Players outside the LAN will not be able to connect to these servers at any time.<br />
        </p>
        <div class="UImenu">
            <div class="UImenuItem">
                <label class="Menubody-trigger"><strike>192.168.1.241 Counter-Strike:GO</strike></label>
                <div class="Content">
                    Launch Counter-Strike<p>
                        (enable the console) click options, scroll near the bottom and find 'Enable Developer Console (~)' and set this to YES.  click back<p>
                            Now, you can click the ~ key and open the console, type: connect 192.168.1.241:27015 and hit enter.<p>
                                <p>
                                    Second Option - Play > Browse Community Servers > Favorites > Add A Server > 192.168.1.241:27015 and click 'find games at this address'</span><br />
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger"><strike>192.168.1.242 Left4Dead2</strike></label>
                <div class="Content">
                    Launch L4D2<p>
                        (enable the console) Options> Keyboard/Mouse> Allow Developer Console > Enabled.  Click Done.<p>
                    Now, you can click the ~ key and open the console, type: 192.168.1.242 and hit enter.
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger"><strike>192.168.1.243 Minecraft - Feed The Beast Unleashed</strike></label>
                <div class="Content">
                    Click <a href="http://www.creeperrepo.net/direct/FTB2/cbf28412ef3ab36443e551e59b42b2eb/launcher%5EFTB_Launcher.exe">HERE</a> to download the FTB launcher.<p>
                        Execute the EXE and install it to the folder of your choice - I recommend the game folder you may or may not have already.<p>
                            Once it commpletes, a 'console' window will pop up and start auto-downloading maps and textures.  Allow this to complete and close that window.<p>
                                Scroll down the left pane of the 'FTB launcher' window and click the FTB Unleashed mod.  Now click LAUNCH in the lower right corner.<p>
                                    This will launch Minecraft 1.5.2 with all the mods needed for FTB unleashed - from this point go through the normal process.
                                    <p>
                    Login, click Multiplayer, then create a new entry called GAMEON FTB, use the IP address 192.168.1.243 and click connect.
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">192.168.1.243 Mumble (voice chat)</label>
                <div class="Content">
                    Click <a href="http://mumble.sourceforge.net/Main_Page">HERE</a> and download the compatible client for your machine.<p>
                        Once installed, Mumble will ask you for a connection, create new connection, name it GAMEONLAN, address = 192.168.1.244, port = 64738, name = (your gamer name here), then hit OK, then connect.<p>
                    Now that you are connected to the server, pick out a room related to a game and have fun!  Watch the side bar for announcements periodically during the day.
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">192.168.1.241 Starbound</label>
                <div class="Content">
                    Launch Starbound, click multiplayer, server = 192.168.1.241, no user/pass is required
                </div>
            </div>

		<div class="UImenuItem">
                <label class="Menubody-trigger">192.168.1.242 Minecraft - vanilla</label>
                <div class="Content">
                    Launch Minecraft-login with your user/pass, Click Multiplayer, server = 192.168.1.246<p>
                    
                </div>
		</div>

		<div class="UImenuItem">
                <label class="Menubody-trigger">192.168.1.244 Terraria</label>
                <div class="Content">
                    Launch Terraria-click multiplayer, use ip 192.168.1.244, no user/pass required <p>
                    
                </div>
         </div>
		 
        </div>
        <br />
        If you want to request a KCGAMEON server for a particular game, please let us know and we will try to get one set up.
    </form>
    <%} else
      {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <br />
    <%} %>
</asp:Content>
