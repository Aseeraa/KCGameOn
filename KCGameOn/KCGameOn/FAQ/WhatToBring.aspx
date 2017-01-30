<%@ Page Title="GameOn What To Bring" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WhatToBring.aspx.cs" Inherits="KCGameOn.FAQ.WhatToBring" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
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

<h2>What do I need to bring?</h2><br />
<form class="well form-inline">
<div class="UImenu">
   <div class="UImenuItem">
        <label class="Menubody-trigger">PC System Check</label> 
        <div class="Content">
            <p>
			<p>Before attending an event, please make sure everything is in working order to avoid any inconvenience</p>
            Gaming computer<br />
            Monitor<br />
            Power cable for monitor<br />
            Power cable for computer<br />
            Headphones<br />
            Keyboard<br />
            Mouse<br />
            Mouse Pad<br />
            Labels for your gear (optional)<br />
			Install any OS updates<br />
			Install and update your Anti-Virus application<br />
			Install and patch all games you plan to play<br />
			
            <p><br/>
        <p>Please scan computer attending!!!</p><br />
        Trend Micro HouseCall - <a href="http://housecall.trendmicro.com">http://housecall.trendmicro.com</a><br />
        Windows Defender<br />
        Ad-Aware - <a href="http://www.lavasoftusa.com">http://www.lavasoftusa.com</a><br />
        
        </p>
            </p>
        </div>
    </div>

    <div class="UImenuItem">
        <label class="Menubody-trigger">Console System Check</label> 
        <div class="Content">
        <p>
			<p>KCGAMEON tries to provide some projectors and speakers for use at the KCGO events.  These are reserved when you sit on the map - first come, first serve.<br/></p>
			Your console of choice<br/>
			Power cord<br/>
			Video cord(s) (usually hdmi or component, but I recommend you bring composite as well, if your console supports that)<br/>
			Controller(s)<br/>
			Batteries for Controllers (optional)<br/>
			Headsets (optional)<br/>
			Games you want to play (KCGAMEON does not provide any console games)<br/>
			Batteries for Controllers (optional)<br/>
			Network Card - we do not have wifi that connects to the LAN<br/>
			Monitor/TV (optional - some people bring their own)<br/>
			Label your gear - label it to make sure it doesn't get mixed up with your neighbors<br/>
			

        </p>
        </div>
    </div>
	<div class="UImenuItem">
        <label class="Menubody-trigger">Boardgame System Check</label> 
        <div class="Content">
        <p>
        Your Boardgame collection<br />
		Labels for your boxes/games/gear<br />
		Little baggies for your game pieces<br />
		Plastic containers for more game pieces<br />
		        
        </p>
        </div>
    </div>
		<div class="UImenuItem">
        <label class="Menubody-trigger">Cardgame System Check</label> 
        <div class="Content">
        <p>
        Your Cardgame collection<br />
		Sleeves for your cards<br />
		20-sided dice<br />
		Counters<br />
		Labels for any binders/boxes<br />
        Pen/Pad of paper for keep track of scores<br />
		        
        </p>
        </div>
    </div>
    <div class="UImenuItem">
        <label class="Menubody-trigger">What KCGAMEON provides</label> 
        <div class="Content">
        <p>
        A location in WHQ 2702 with tables and chairs for your gaming needs<br />
        A fast and reliable network infrastructure (all gigabit!)<br />
		Network cable for each machine<br />
        1 Powerstrip per 2 computers<br />
		Electricity for your power hungry gaming systems<br />
        Various liquids to drink<br />
        Various snack foods to eat<br />
        An organized event with organized tournaments<br />
        Dinner will be provided around 6:00pm<br />
		Announcements and door prizes will occur around 6:45pm (subject to change)<br />
        A great time for all<br />
        </p>
        </div>
    </div>
</div>
</form>
</asp:Content>
