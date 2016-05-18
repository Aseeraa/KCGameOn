<%@ Page Title=" " Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tournament.aspx.cs" Inherits="KCGameOn.Tournament" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <style>
            .list-inline {
                display: inline-block;
            }

            .well {
                padding: 0px;
                margin: 0px;
            }

            .csdiv, .hsdiv, .loldiv, .rldiv, .smashdiv, .heroesdiv, .dota2div, .magicdiv, .sfvdiv, .overwatchdiv {
                padding: 20px;
                height: 1080px;
                width: 1140px;
                position: relative;
                background-size: cover;
            }

            .cscontentmain, .hscontentmain, .lolcontentmain, .rlcontentmain, .smashcontentmain, .heroescontentmain, .dota2contentmain, .magiccontentmain, .sfvcontentmain, .overwatchcontentmain {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.85);
				overflow-y: auto;
                height: 700px;
                width: 750px;
                margin: auto;
                position: absolute;
                top: 0;
                bottom: 0;
                left: 0;
                right: 25%;
            }

            .cscontentleft, .hscontentleft, .rlcontentleft, .lolcontentleft, .smashcontentleft, .heroescontentleft, .dota2contentleft, .magiccontentleft, .sfvcontentleft, .overwatchcontentleft {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.85);
				overflow-y: auto;
                height: 700px;
                width: 250px;
                margin: auto;
                position: absolute;
                left: 0;
                top: 0;
                bottom: 0;
                right: 75%;
            }

            .cscontentright, .hscontentright, .rlcontentright, .lolcontentright, .smashcontentright, .heroescontentright, .dota2contentright, .magiccontentright, .sfvcontentright, .overwatchcontentright {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.85);
				overflow-y: auto;
                height: 700px;
                width: 300px;
                margin: auto;
                position: absolute;
                right: 0;
                top: 0;
                bottom: 0;
                left: 70%;
            }
			
			.cscontenttop, .hscontenttop, .rlcontenttop, .lolcontenttop, .smashcontenttop, .heroescontenttop, .dota2contenttop, .magiccontenttop, .sfvcontenttop, .overwatchcontenttop {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.85);
                height: 150px;
                width: 1025px;
                margin: auto;
                position: absolute;
                left: 0;
                top: 0;
                bottom: 80%;
                right: 0;
            }

            .csbracket, .hsbracket, .lolbracket, .rlbracket, .smashbracket, .heroesbracket, .dota2bracket, .magicbracket, .sfvbracket, .overwatchbracket
            {
                position:absolute;
                bottom:0;
            }

            .rldiv {
                background-image: url("img/RocketLeagueTourny.png");
            }

            .csdiv {
                background-image: url("img/CSGOTourny.png");
            }

            .hsdiv {
                background-image: url("img/HSTourny.png");
            }

            .loldiv {
                background-image: url("img/LoLTourny.png");
            }
			
			.smashdiv {
                background-image: url("img/SmashTourny.png");
            }
			
			.heroesdiv {
                background-image: url("img/HeroesTourny.png");
            }
			
			.dota2div {
                background-image: url("img/dota2tourny.png");
            }
			
			.magicdiv {
                background-image: url("img/magictourny.png");
            }
			
			.sfvdiv {
                background-image: url("img/sfv.jpg");
            }
			
			.overwatchdiv {
                background-image: url("img/overwatchtourny.png");
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".Content").hide();
                //toggle the componenet with class msg_body
                $(".Menubody-trigger").click(function () {
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

                function scrollToAnchor(aid) {
                    var aTag = $("a[name='" + aid + "']");
                    $('html,body').animate({ scrollTop: aTag.offset().top }, 'slow');
                }
                $("#csgo").click(function () {
                    scrollToAnchor('csgopage');
                });
                $("#rl").click(function () {
                    scrollToAnchor('rocketleaguepage');
                });
                $("#lol").click(function () {
                    scrollToAnchor('leagueoflegendspage');
                });
                $("#hs").click(function () {
                    scrollToAnchor('hearthstonepage');
                });
				$("#smash").click(function () {
                    scrollToAnchor('smashpage');
                });
				$("#Dota2").click(function () {
                    scrollToAnchor('dota2');
                });
				$("#sfv").click(function () {
                    scrollToAnchor('sfv');
                });

                var doubleEliminationData = {
                    teams: [
                      ["Team 1", "Team 2"],
                      ["Team 3", "Team 4"]
                    ],
                    results: [[      /* WINNER BRACKET */
                      [[1, 2], [3, 4]], /* first and second matches of the first round */
                      [[5, 6]]         /* second round */
                    ], [              /* LOSER BRACKET */
                      [[7, 8]],        /* first round */
                      [[9, 10]]        /* second round */
                    ], [              /* FINALS */
                      [[1, 12], [13, 14]],
                      [[15, 16]]       /* LB winner won first round so need a rematch */
                    ]]
                }

                $(function () {
                    $('div .csbracket').bracket({
                        init: doubleEliminationData
                    })
                })
            });
        </script>
    </head>
    <center><h3 style="color: red;"><asp:Label ID="previousPage" Text="" runat="server" /></h3></center>
    <h2>Event Tournaments</h2>
    <h4>If you want to request a tournament for a particular game, please let us know and we will work on getting one set up!</h4>
    <div class="container">
        <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
      <li class="active">
          <a href="#LoL" role="tab" data-toggle="tab">
              <%--<i class="fa fa-envelope"></i>--%> <img src="/img/lolsticker.png">
          </a>
      </li>
      <li>
          <a href="#RL" role="tab" data-toggle="tab">
              <%--<i class="fa fa-cog"></i>--%> <img src="/img/rocketsticker.png">
          </a>
      </li>
	  <li>
		  <a href="#sfv" role="tab" data-toggle="tab">
			<%--<i class="fa fa-user"></i>--%> <img src="/img/sfvsticker.png">
          </a>
      </li>
	  <li>
		  <a href="#overwatch" role="tab" data-toggle="tab">
			<%--<i class="fa fa-user"></i>--%> <img src="/img/overwatchsticker.png">
          </a>
      </li>
    <!--
	  <li>
          <a href="#CSGO" role="tab" data-toggle="tab">
              <%--<icon class="fa fa-home"></icon>--%> Counter-Strike: Global Offensive 
          </a>
      </li>
      <li><a href="#HS" role="tab" data-toggle="tab">
          <%--<i class="fa fa-user"></i>--%> Hearthstone
          </a>
      </li>
	  <li><a href="#SMASH" role="tab" data-toggle="tab">
          <%--<i class="fa fa-user"></i>--%> <img src="/img/smashsticker.png">
          </a>
      </li>
	  
	  <li><a href="#Dota2" role="tab" data-toggle="tab">
          <%--<i class="fa fa-user"></i>--%> <img src="/img/Dota2sticker.png">
          </a>
      </li>
	  <li><a href="#HEROES" role="tab" data-toggle="tab">
          <%--<i class="fa fa-user"></i>--%> <img src="/img/heroessticker.png">
          </a>
      </li>
	  <li><a href="#MAGIC" role="tab" data-toggle="tab">
          <%--<i class="fa fa-user"></i>--%> <img src="/img/mtgsticker.png">
          </a>
      </li>
	  -->
	</ul>  
      
    
    <!-- Tab panes -->
    <div class="tab-content">
      <%-- League of Legends--%>
      <div class="tab-pane fade active in" id="LoL">
    <!--      <h2>League of Legends</h2>-->
          <div class="loldiv">
                <div class="lolcontenttop row">
					<div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Jun 11, 2016 @230p</h2></p>
						Please register with both battlefy and the LoL website or you will not be eligible for prizing.
						
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
					<p><h2>5v5</h2></p>
					double elimination
					</div>
					
					<div class="col-md-3">
					<p>Game Map & Type</p>
					<p><h2>Summoners Rift</h2></p>
					<p>Tournament Draft</p>
					</div>
					<div class="col-md-3">
						<iframe src="https://battlefy.com/embeds/join/573b91714973e582122def85" title="League of Legends - KCGameOn #69  (gold and under only)" width="186" height="50" scrolling="no" frameborder="0"></iframe>
						<a href="http://events.na.leagueoflegends.com/events/197052"><img src="/img/registerlol.png" height="34" width="170"></a>
					</div>			
                </div>
                <div class="lolcontentmain">
                    <p><h2>Rules</h2></p>
					Note: Please report your team's score after each given match.<br />

<p><h2>Registration Rules</h2></p>

<p>We only accept serious registrations. If you do register for a League of Legends tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 1:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
<p><h2>Player/Team Eligibility</h2></p>

<p>Players must be present at the event.  In order to compete, your summoner name must be included with the team's initial registration.
Once a League of Legends tournament begins, no roster swapping will be allowed. Only the original 5 members may compete.</p>

<p><h2>Game Conduct</h2></p>

<p>Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future League of Legends tournaments.</p>

<p><h2>Tournament Check-In</h2></p>

<p>We require that all registered teams check-in no later than 10 minutes before the tournament start.
A reminder will be sent to the Team Captain prior to check-in.
All 5 members on your team must be present at check-in or else it will not qualify.
If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.</p>

<p>Captains can report their own score.</p>				
					
                    <div class="lolbracket"></div>
                </div>
                <div class="lolcontentright">
                    <p><h2>Prizes</h2></p>
						<p>FIRST PLACE INDIVIDUALS
						4200 RP, Ryze, Triumphant Ryze, 10-Win IP Boost</p>

						<p>SECOND PLACE INDIVIDUALS
						3000 RP, 10-Win IP Boost</p>

						<p>THIRD PLACE INDIVIDUALS
						1800 RP, 10-Win IP Boost</p>

						<p>FOURTH PLACE INDIVIDUALS
						1000 RP, 10-Win IP Boost</p>

						<p>FIFTH PLACE INDIVIDUALS–EIGHTH PLACE INDIVIDUALS
						10-Win IP Boost</p>
					<p><h2>Schedule</h2></p>
					<p>2:30 PM</p>
					<p>3:30</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					
					<br />
					<iframe src="https://battlefy.com/embeds/teams/573b91714973e582122def85" title="Battlefy Tournament Teams" width="100%" height="500" scrolling="yes" frameborder="0"></iframe>
                </div>
            </div>
      </div>
      <%-- Rocket League --%>
      <div class="tab-pane fade" id="RL">
        <!--  <h2>Rocket League</h2>-->
          <div class="rldiv">
                <div class="rlcontenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Jun 11, 2016 @800p</h2></p>
						Please register with battlefy or you will not be eligible for prizing.
						
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
					<p><h2>3v3</h2></p>
					double elimination
					</div>
					
					<div class="col-md-3">
					<p>Game Map & Type</p>
					<p><h2>Random 3v3 map</h2></p>
					</div>
					<div class="col-md-3">
						<iframe src="https://battlefy.com/embeds/join/573b947e35810f821203b574" title="Rocket League - KCGameOn #69 3v3" width="186" height="50" scrolling="no" frameborder="0"></iframe>
					</div>	
                </div>
                <div class="rlcontentmain">
                    <p><h2>Rules</h2></p>
					Note: Please report your team's score after each given match.<br />

<p><h2>Registration Rules</h2></p>

<p>We only accept serious registrations. If you do register for a Rocket League tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 7:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
<p><h2>Player/Team Eligibility</h2></p>

<p>In order to compete, your steam/ps4 name must be included with the team's initial registration.
Once a Rocket League tournament begins, no roster swapping will be allowed. Only the original 3 members may compete.</p>

<p><h2>Game Conduct</h2></p>

<p>Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.</p>

<p><h2>Tournament Check-In</h2></p>

<p>We require that all registered teams check-in no later than 10 minutes before the tournament start.
A reminder will be sent to the Team Captain prior to check-in.
All 3 members on your team must be present at check-in or else it will not qualify.
If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.</p>

<p>Captains can report their own score.</p>		
                    <div class="rlbracket"></div>
                </div>
                <div class="rlcontentright">
                                        <p><h2>Prizes</h2></p>
						<p>FIRST PLACE INDIVIDUALS <br />
						Free KCGameOn #70 attendance w/8 or more teams competing.</p>

					<p><h2>Schedule</h2></p>
					<p>6:30 PM</p>
					<p>7:00</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					<iframe src="https://battlefy.com/embeds/teams/573b947e35810f821203b574" title="Battlefy Tournament Teams" width="100%" height="500" scrolling="yes" frameborder="0"></iframe>
                </div>
            </div>
      </div>
	  
	<%-- sfv --%>
      <div class="tab-pane fade" id="sfv">
          <div class="sfvdiv">
                <div class="sfvcontenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Jun 11, 2016 @300p</h2></p>
						Please register with Challonge or you will not be eligible for prizing.
						
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
					<p><h2>2/3 sets</p>
					<p>Double Elimination</h2></p>
					
					</div>
					
					<div class="col-md-3">
					<p>Finals</p>
					<p><h2>3/5 sets</h2></p>
					</div>
					<div class="col-md-3">
					<p><h2>Entry Fee: $10</h2></p>
					<p>paid to TO prior to start of tournament</p>
						<a href="http://ko.challonge.com/KCGO69/"><img src="/img/registerlol.png" height="34" width="170"></a>
					</div>	
                </div>
                <div class="sfvcontentmain">
                    <p><h2>Rules</h2></p>
					Note: Please report your team's score after each given match.<br />

<p><h2>Registration Rules</h2></p>

<p>We only accept serious registrations. If you do register for a SFV tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 2:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
<p><h2>Player/Team Eligibility</h2></p>

<p>In order to compete, your gametag name must be included with the team's initial registration.
Once a SFV tournament begins, no roster swapping will be allowed. Only the original 5 members may compete.</p>

<p><h2>Game Conduct</h2></p>

<p>Please be respectful to other players and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.</p>

<p><h2>Tournament Check-In</h2></p>

<p>We require that all registered players check-in no later than 10 minutes before the tournament start.

If a player that is registered fails to show up to check-in, a substitute player that is checked in will take their place.</p>

<p>Captains can report their own score.</p>		
                    <div class="sfvbracket"></div>
                </div>
                <div class="sfvcontentright">
                                        <p><h2>Prizes</h2></p>
						<p>1st place - Free entry to KCGameOn #70 w/8 or more players</p><br />
						<p>Cash payouts: 70/20/10% of total cash pot</p>

					<p><h2>Schedule</h2></p>
					<p>3:00 PM</p>
					<p>3:15</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					
                </div>
            </div>
      </div>
	    
		 <%-- overwatch --%>
			  <div class="tab-pane fade" id="overwatch">
			
				  <div class="overwatchdiv">
						<div class="overwatchcontenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Jun 11, 2016 @400p</h2></p>
						Please register with battlefy or you will not be eligible for prizing.
						
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
					<p><h2>6v6</h2></p>
					double elimination
					</div>
					
					<div class="col-md-3">
					<p>Game Map & Type</p>
					<p><h2>Random 6v6 map</h2></p>
					</div>
					<div class="col-md-3">
						<iframe src="https://battlefy.com/embeds/join/573b951e66404d8512e49c07" title="Overwatch - KCGameOn #69" width="186" height="50" scrolling="no" frameborder="0"></iframe>
					</div>	
                </div>
						<div class="overwatchcontentmain">
									<p><h2>Rules</h2></p>
							Note: Please report your team's score after each given match.<br />

							<p><h2>Registration Rules</h2></p>

							<p>We only accept serious registrations. If you do register for a Overwatch tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
							You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 3:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
							<p><h2>Player/Team Eligibility</h2></p>

							<p>Players must be present at the event.  In order to compete, your summoner name must be included with the team's initial registration.
							Once the Overwatch tournament begins, no roster swapping will be allowed. Only the original 6 members may compete.</p>

							<p><h2>Game Conduct</h2></p>

							<p>Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
							You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
							If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.</p>

							<p><h2>Tournament Check-In</h2></p>

							<p>We require that all registered teams check-in no later than 10 minutes before the tournament start.
							A reminder will be sent to the Team Captain prior to check-in.
							All 6 members on your team must be present at check-in or else it will not qualify.
							If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.</p>

							<p>Captains can report their own score.</p>	
							<div class="overwatchbracket"></div>
						</div>
						<div class="overwatchcontentright">
							        <p><h2>Prizes</h2></p>
						<p>FIRST PLACE INDIVIDUALS <br />
						Free KCGameOn #70 attendance w/8 or more teams competing.</p>

					<p><h2>Schedule</h2></p>
					<p>4:00 PM</p>
					<p>5:00</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					<iframe src="https://battlefy.com/embeds/teams/573b951e66404d8512e49c07" title="Battlefy Tournament Teams" width="100%" height="500" scrolling="yes" frameborder="0"></iframe>
                </div>
			  </div>
    </div>
	  
<!--	  <%-- CS:GO --%>
      <div class="tab-pane fade" id="CSGO">
          <h2>Counter-Strike: Global Offensive</h2>
          <div class="csdiv">
                <div class="cscontentleft">
                    <p>Filler content</p>
                </div>
                <div class="cscontentmain">
                    <p>Filler content</p>
                    <div class="csbracket"></div>
                </div>
                <div class="cscontentright">
                    <p>Filler content</p>
                </div>
            </div>
      </div>
      <%-- Hearthstone --%>
      <div class="tab-pane fade" id="HS">
          <h2>Hearthstone</h2>
          <div class="hsdiv">
                <div class="hscontentleft">
                    <p>Filler content</p>
                </div>
                <div class="hscontentmain">
                    <p>Filler content</p>
                    <div class="hsbracket"></div>
                </div>
                <div class="hscontentright">
                    <p>Filler content</p>
                </div>
            </div>
      </div> 

		<%-- Dota2 --%>
      <div class="tab-pane fade" id="Dota2">
          <div class="dota2div">
                <div class="dota2contenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Apr 16, 2016 @100p</h2></p>
						Please register with battlefy or you will not be eligible for prizing.
						
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
					<p><h2>Captains mode 5v5</h2></p>
					double elimination
					</div>
					
					<div class="col-md-3">
					<p>Game Map & Type</p>
					<p><h2>Aeon of Strife</h2></p>
					</div>
					<div class="col-md-3">
						<iframe src="https://battlefy.com/embeds/join/56f0a7a1b85b5a8d12d69651" title="DOTA 2 - KCGameOn #68" width="186" height="50" scrolling="no" frameborder="0"></iframe>
					</div>	
                </div>
                <div class="dota2contentmain">
                    <p><h2>Rules</h2></p>
					Note: Please report your team's score after each given match.<br />

<p><h2>Registration Rules</h2></p>

<p>We only accept serious registrations. If you do register for a Dota2 tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 12:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
<p><h2>Player/Team Eligibility</h2></p>

<p>In order to compete, your steam name must be included with the team's initial registration.
Once a Dota2 tournament begins, no roster swapping will be allowed. Only the original 5 members may compete.</p>

<p><h2>Game Conduct</h2></p>

<p>Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.</p>

<p><h2>Tournament Check-In</h2></p>

<p>We require that all registered teams check-in no later than 10 minutes before the tournament start.
A reminder will be sent to the Team Captain prior to check-in.
All 5 members on your team must be present at check-in or else it will not qualify.
If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.</p>

<p>Captains can report their own score.</p>		
                    <div class="dota2bracket"></div>
                </div>
                <div class="dota2contentright">
                                        <p><h2>Prizes</h2></p>
						<p>FIRST PLACE INDIVIDUALS <br />
						Free KCGameOn #69 attendance w/8 or more teams competing.</p>

					<p><h2>Schedule</h2></p>
					<p>1:00 PM</p>
					<p>2:00</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					<iframe src="https://battlefy.com/embeds/teams/56f0a7a1b85b5a8d12d69651" title="Battlefy Tournament Teams" width="100%" height="500" scrolling="yes" frameborder="0"></iframe>
                </div>
            </div>
      </div>
	  
			<%-- SMASH --%>
			  <div class="tab-pane fade" id="SMASH">
			
				  <div class="smashdiv">
						<div class="smashcontenttop">
							<div class="col-md-3">
								<p>Date & Time</p>
								<p><h2>April 16, 2016 @2:30p</h2></p>
								PM Doubles
							</div>
					
							<div class="col-md-3">
								<p>Date & Time</p>
								<p><h2>April 16, 2016 @3:30p</h2></p>
								Smash 4
							</div>
					
							<div class="col-md-3">
								<p>Date & Time</p>
								<p><h2>April 16, 2016 @5:30p</h2></p>
								PM Singles
							</div>
							<div class="col-md-3">
								<p>Date & Time</p>
								<p><h2>April 16, 2016 @7:30p</h2></p>
								Smash Melee
							</div>
						</div>
						<div class="smashcontentmain">
							<p><a href="https://docs.google.com/forms/d/1RBycSPKtdmJT2sQ7-onv84JUxs0xrAIY2BtdFJNJtdE/viewform"><h2>Sign up form for Smash tournaments</h2></a></p>
							<p><a href="https://docs.google.com/spreadsheets/d/1L48utM7npD1Ri28g9WfMW1Zu7qYsZo-tMa44hTPIny8/edit?usp=sharing"><h3>View Responses</h3></a></p>
						
							<p><h2>Rules</h2><p>
					<p>Note: Please report your (or team's) score after each given match.</p>

<p><a href="https://docs.google.com/document/d/1iztqH6k3qJsG9ZVw5gbsqvsJz_wHu_ALYAPoY334oXQ/edit?usp=sharing"<h2>Wii U</h2></a></p>

<p><a href="https://www.facebook.com/notes/kc-smash-bros-forum/project-m-rules/1117364751612826"<h2>PM</h2></a></p>

<p><a href="https://www.facebook.com/notes/kc-smash-bros-forum/melee-rules/1117371374945497"<h2>Melee</h2></a></p>		

<p>Bring a full setup for $5 off venue fee(refunded in cash when you arrive)</p>
							<div class="smashbracket"></div>
						</div>
						<div class="smashcontentright">
							        <p><h2>Entry Fee</h2></p>
									$5 per tournament entry<br />
									$10 per team tournament entry
									<p><h2>Prizes</h2></p>
									<p>Payouts:
										1st: 60%
										2nd: 30%
										3rd: 10%</p>

									<p><h2>Schedule</h2></p>
									<p>2:30 as time allows</p>
									
									<p><h2>Questions</h2></p>
									<p>Contact nick@kcgameon for any questions</p>
						</div>
					</div>
			  </div>	

			  <%-- HEROES --%>
			  <div class="tab-pane fade" id="HEROES">
			
				  <div class="heroesdiv">
						<div class="heroescontenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Apr 16, 2016 @330p</h2></p>
						Please register with battlefy or you will not be eligible for prizing.
						
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
					<p><h2>5v5</h2></p>
					double elimination
					</div>
					
					<div class="col-md-3">
					<p>Game Map & Type</p>
					<p><h2>Random 5v5 map</h2></p>
					</div>
					<div class="col-md-3">
						<iframe src="https://battlefy.com/embeds/join/56de470a6d41378f12b4b977" title="Heroes of the Storm - KCGameOn #68" width="186" height="50" scrolling="no" frameborder="0"></iframe>
					</div>	
                </div>
						<div class="heroescontentmain">
									<p><h2>Rules</h2></p>
							Note: Please report your team's score after each given match.<br />

							<p><h2>Registration Rules</h2></p>

							<p>We only accept serious registrations. If you do register for a Heroes tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
							You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 3:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
							<p><h2>Player/Team Eligibility</h2></p>

							<p>Players must be present at the event.  In order to compete, your summoner name must be included with the team's initial registration.
							Once the Heroes tournament begins, no roster swapping will be allowed. Only the original 5 members may compete.</p>

							<p><h2>Game Conduct</h2></p>

							<p>Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
							You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
							If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.</p>

							<p><h2>Tournament Check-In</h2></p>

							<p>We require that all registered teams check-in no later than 10 minutes before the tournament start.
							A reminder will be sent to the Team Captain prior to check-in.
							All 5 members on your team must be present at check-in or else it will not qualify.
							If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.</p>

							<p>Captains can report their own score.</p>	
							<div class="heroesbracket"></div>
						</div>
						<div class="heroescontentright">
							        <p><h2>Prizes</h2></p>
						<p>FIRST PLACE INDIVIDUALS <br />
						Free KCGameOn #69 attendance w/8 or more teams competing.</p>

					<p><h2>Schedule</h2></p>
					<p>3:30 PM</p>
					<p>4:30</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					<iframe src="https://battlefy.com/embeds/teams/56de470a6d41378f12b4b977" title="Battlefy Tournament Teams" width="100%" height="500" scrolling="yes" frameborder="0"></iframe>
                </div>
			  </div>
    </div>
	
	<%-- Magic --%>
			  <div class="tab-pane fade" id="MAGIC">
			
				  <div class="magicdiv">
						<div class="magiccontenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Apr 16, 2016 @2p</h2></p>
						
						<a href="https://goo.gl/vps01p"><img src="/img/registerlol.png" height="34" width="170"></a>
					</div>
					
					<div class="col-md-3">
					<p>Format</p>
						<p><h2><a href="https://en.wikipedia.org/wiki/Magic:_The_Gathering#Limited">Booster Draft (3 FREE packs)</a></h2></p>
						4 Round <a href="https://en.wikipedia.org/wiki/Swiss-system_tournament">Swiss</a>
					</div>
					
					<div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Apr 16, 2016 @7p</h2></p>
						<a href="https://goo.gl/vps01p"><img src="/img/registerlol.png" height="34" width="170"></a>
					</div>
					<div class="col-md-3">
					<p>Format</p>
						<p><h2><a href="https://en.wikipedia.org/wiki/Magic:_The_Gathering#Limited">Sealed Deck (6 FREE packs)</a></h2></p>
						4 Round <a href="https://en.wikipedia.org/wiki/Swiss-system_tournament">Swiss</a>			
					</div>	
                </div>
						<div class="magiccontentmain">
									<p><h2>Rules</h2></p>
							Note: Winner of each match, please report your score to the judge after each given match.<br />

							<p><h2>Registration Rules</h2></p>

							<p>We only accept serious registrations. If you do register for a MTG tournament, we ask that you follow through and show up on game day. If you are not present at the proper time, you may face a ban from future tournaments.
							You may only register yourself once for each tournament. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 1:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
							
							<p><h2>Player Eligibility</h2></p>

							<p>Players must be present at the event.  In order to compete, you must use your real name must be used in the registration.
							Once the MTG tournament begins, no player swapping will be allowed. Only the original member may compete.</p>

							<p><h2>Game Conduct</h2></p>

							<p>Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs or you will be disqualified immediately.
							There is zero-tolerance for cheating. If you have any questions at all, please contact the tournament judge.</p>

							<p><h2>Tournament Check-In</h2></p>

							<p>We require that all registered player check-in no later than 10 minutes before the tournament start.
							
							If a player that is registered fails to show up to check-in, a substitute player that is checked in will take their place.</p>

							<div class="magicbracket"></div>
						</div>
						<div class="magiccontentright">
							        <p><h2>Prizes</h2></p>
						<p>FIRST PLACE INDIVIDUALS <br />
						Free KCGameOn #69 attendance w/8 or more teams competing.  If extra packs are available, we can pontentially use those as prizes as well.</p>

					<p><h2>Schedule</h2></p>
					<p>2 PM</p>
					<p>3 PM</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
					
						</div>
					  </div>
			</div> -->
        <%--<ul class="list-inline">
            <li><a id="lol" href="#" class="brand">League of Legends</a></li>
            <li><a id="rl" href="#" class="brand">Rocket League</a></li>
			<li><a id="csgo" href="#" class="brand">Counter-Strike: Global Offensive</a></li>
            <li><a id="hs" href="#" class="brand">Hearthstone</a></li>
			<li><a id="smash"" href="#" class="brand">Smash Bros</a></li>
			<li><a id="Dota2"" href="#" class="brand">Dota 2</a></li>
			<li><a id="magic"" href="#" class="brand">Magic: The Gathering</a></li>
			<li><a id="sfv"" href="#" class="brand">Street Fighter V</a></li>
        </ul>--%>

        <%--<form class="well form-inline">--%>
            <%--<a name="csgopage"></a>--%>
            
            <%--<a name="hearthstonepage"></a>--%>
            
            <%--<a name="leagueoflegendspage"></a>--%>
            
            <%--<a name="rocketleaguepage"></a>--%>
			
			<%--<a name="smashbros"></a>--%>
			
			<%--<a name="Dota 2"></a>--%>
			
			<%--<a name="magic"></a>--%>
			
			<%--<a name="sfv"></a>--%>
            
        <%--</form>--%>
    </div>
</asp:Content>
