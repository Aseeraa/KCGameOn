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

            .csdiv, .hsdiv, .loldiv, .rldiv, .destinydiv, .smashdiv, .heroesdiv, .dota2div, .magicdiv, .sfvdiv, .overwatchdiv, .halo5div, .fpvdiv {
                padding: 20px;
                height: 1080px;
                width: 1140px;
                position: relative;
                background-size: cover;
            }

            .cscontentmain, .hscontentmain, .destinycontentmain, .lolcontentmain, .rlcontentmain, .smashcontentmain, .heroescontentmain, .dota2contentmain, .magiccontentmain, .sfvcontentmain, .overwatchcontentmain, .halo5contentmain, .fpvcontentmain {
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

            .cscontentleft, .hscontentleft, .rlcontentleft, .destinycontentleft, .lolcontentleft, .smashcontentleft, .heroescontentleft, .dota2contentleft, .magiccontentleft, .sfvcontentleft, .overwatchcontentleft, .halo5contentleft, .fpvcontentleft {
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

            .cscontentright, .hscontentright, .rlcontentright, .lolcontentright, .destinycontentright, .smashcontentright, .heroescontentright, .dota2contentright, .magiccontentright, .sfvcontentright, .overwatchcontentright, .halo5contentright, .fpvcontentright {
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

            .cscontenttop, .hscontenttop, .rlcontenttop, .lolcontenttop, .smashcontenttop, .destinycontenttop, .heroescontenttop, .dota2contenttop, .magiccontenttop, .sfvcontenttop, .overwatchcontenttop, .halo5contenttop, .fpvcontenttop {
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

            .csbracket, .hsbracket, .lolbracket, .rlbracket, .smashbracket, .heroesbracket, .destinybracket, .dota2bracket, .magicbracket, .sfvbracket, .overwatchbracket, .halo5bracket, .fpvbracket {
                position: absolute;
                bottom: 0;
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
                background-image: url("img/sfv.png");
            }

            .halo5div {
                background-image: url("img/halo5tourney.jpg");
            }

            .overwatchdiv {
                background-image: url("img/overwatchtourny.png");
            }

            .fpvdiv {
                background-image: url("img/fpvtourney.jpg");
            }

            .destinydiv {
                background-image: url("img/destinytourny.png");
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
    <center>
        <h3 style="color: red;">
            <asp:Label ID="previousPage" Text="" runat="server" /></h3>
    </center>
    <h2>Event Tournaments</h2>
	<h4>Tournament page will need some work, check back later...</h4>
    <!-- <h4>If you want to request a tournament for a particular game, please let us know and we will work on getting one set up!</h4> -->
    <div class="container">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <!--<li class="active">
                <a href="#LoL" role="tab" data-toggle="tab">
                    <%--<i class="fa fa-envelope"></i>--%>
                    <img src="/img/lolsticker.png">
                </a>
            </li>
            <li>
                <a href="#RL" role="tab" data-toggle="tab">
                    <%--<i class="fa fa-cog"></i>--%>
                    <img src="/img/rocketsticker.png">
                </a>
            </li>
            <li>
                <a href="#overwatch" role="tab" data-toggle="tab">
                    <%--<i class="fa fa-user"></i>--%>
                    <img src="/img/overwatchsticker.png">
                </a>
            </li>
            <li>
                <a href="#halo5" role="tab" data-toggle="tab">
                    <%--<i class="fa fa-user"></i>--%>
                    <img src="/img/halo5sticker.png">
                </a>
            </li>
            <li>
                <a href="#CSGO" role="tab" data-toggle="tab">
                    <%--<i class="fa fa-user"></i>--%>
                    <img src="/img/csgosticker.png">
                </a>
            </li>
            <li><a href="#destiny" role="tab" data-toggle="tab">
                <%--<i class="fa fa-user"></i>--%>
                <img src="/img/destinysticker.png">
            </a>
            </li>
            <li><a href="#fpv" role="tab" data-toggle="tab">
                <%--<i class="fa fa-user"></i>--%>
                <img src="/img/fpvsticker.png">
            </a>
            </li>
            <li><a href="#HS" role="tab" data-toggle="tab">
                <%--<i class="fa fa-user"></i>--%>
                <img src="/img/hearthstonesticker.png">
            </a>
            </li> -->
            <!--<li>
	  <a href="#sfv" role="tab" data-toggle="tab">
		<%--<i class="fa fa-user"></i>--%> <img src="/img/sfvsticker.png">
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
      </li>-->
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
                        </div>
                        <div class="col-md-3">
                            <!-- <a href="https://battlefy.com/kcgameon/league-of-legends-kcgameon-71-gold-and-under-only/57c24e784132ddf60cbde839/join/rules">
                                <img src="/img/join.png"></a>
                            <a href="http://events.na.leagueoflegends.com/events/217617">
                                <img src="/img/registerlol.png" height="34" width="170"></a></ br> -->
						<p>Gold and under only please.</p>
                        </div>
                    </div>
                    <div class="lolcontentmain">
                        <p>
                            <h2>Rules</h2>
                        </p>
                        <b>Hearts of Gold tournament - Only gold rank(s) and below are allowed to play.<br />
                        </b>
                        Note: Please report your team's score after each given match.<br />

                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a League of Legends tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 1:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>
                        <p>
                            <h2>Player/Team Eligibility</h2>
                        </p>

                        <p>
                            Players must be present at the event.  In order to compete, your summoner name must be included with the team's initial registration.
Once a League of Legends tournament begins, no roster swapping will be allowed. Only the original 5 members may compete.
                        </p>

                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future League of Legends tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered teams check-in no later than 10 minutes before the tournament start.
A reminder will be sent to the Team Captain prior to check-in.
All 5 members on your team must be present at check-in or else it will not qualify.
If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.
                        </p>

                        <p>Captains can report their own score.</p>

                        <div class="lolbracket"></div>
                    </div>
                    <div class="lolcontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>FIRST PLACE INDIVIDUALS</p>
                        <p>1500 RP, Triumphant Ryze, Mystery Icon</p>
                        <br />

                        <p>SECOND PLACE INDIVIDUALS</p>
                        <p>1000 RP, Mystery Icon</p>
                        <br />

                        <p>THIRD PLACE - FOURTH PLACE INDIVIDUALS</p>
                        <p>Mystery Icon</p>
                        <br />

                        <!-- <p>FIRST PLACE INDIVIDUALS
						4200 RP, Ryze, Triumphant Ryze, 10-Win IP Boost</p>

						<p>SECOND PLACE INDIVIDUALS
						3000 RP, 10-Win IP Boost</p>

						<p>THIRD PLACE INDIVIDUALS
						1800 RP, 10-Win IP Boost</p>

						<p>FOURTH PLACE INDIVIDUALS
						1000 RP, 10-Win IP Boost</p>

						<p>FIFTH PLACE INDIVIDUALS–EIGHTH PLACE INDIVIDUALS
						10-Win IP Boost</p> -->
                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>2:30 PM</p>
                        <p>3:30</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                        <br />

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
                            <p>
                                <h2>Oct 8, 2016 @800p</h2>
                            </p>
                            Please register with battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>PC/PS4/XB1 3v3</h2>
                            </p>
                            double elimination
                        </div>

                        <div class="col-md-3">
                            <p>Game Map & Type</p>
                            <p>
                                <h2>Random 3v3 map</h2>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <a href="https://battlefy.com/kcgameon/rocket-league-kcgameon-71-3v3/57c24dea372a12100d5befd0/join/password">
                                <img src="/img/join.png"></a>
                            <p>This tournament is cross-platform</p>
                        </div>
                    </div>
                    <div class="rlcontentmain">
                        <p>
                            <h2>Rules</h2>
                        </p>
                        Note: Please report your team's score after each given match.<br />

                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a Rocket League tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 7:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>
                        <p>
                            <h2>Player/Team Eligibility</h2>
                        </p>

                        <p>
                            In order to compete, your steam/ps4 name must be included with the team's initial registration.
Once a Rocket League tournament begins, no roster swapping will be allowed. Only the original 3 members may compete.
                        </p>

                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered teams check-in no later than 10 minutes before the tournament start.
A reminder will be sent to the Team Captain prior to check-in.
All 3 members on your team must be present at check-in or else it will not qualify.
If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.
                        </p>

                        <p>Captains can report their own score.</p>
                        <div class="rlbracket"></div>
                    </div>
                    <div class="rlcontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>
                            FIRST PLACE INDIVIDUALS
                            <br />
                            Free KCGameOn #72 attendance w/8 or more teams competing.
                        </p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>6:30 PM</p>
                        <p>7:00</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                    </div>
                </div>
            </div>
            <%-- fpv --%>
            <div class="tab-pane fade" id="fpv">
                <!--  <h2>Rocket League</h2>-->
                <div class="fpvdiv">
                    <div class="fpvcontenttop">
                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h2>Oct 8, 2016 @200p</h2>
                            </p>
                            Please register with battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>Standard Race</h2>
                            </p>
                            Other Types TBA
                        </div>

                        <div class="col-md-3">
                            <p>Class</p>
                            <p>
                                <h2>TBA</h2>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <a href="https://battlefy.com/kcgameon/fpv-kcgameon-71/57e20c5a132f59710c64b669/join/player-join">
                                <img src="/img/join.png"></a>
                            <%--<p>This tournament is cross-platform</p>--%>
                        </div>
                    </div>
                    <div class="fpvcontentmain">
                        <p>
                            <h2>General Rules</h2>
                        </p>
                        Note: Please report your score after each given match.<br />
                        Please also use the pits on the map to ready yourself for each race.  Each person will have a 3' foot space, power is underneath the tables.
                        <ul>
                            <li>All pilots will need to arrive and check-in by 1:30 pm and attend the pilot briefing and safety meeting at 2:00 pm.</li>
                            <li>Pilots will use the designated charging areas only.</li>
                            <li>Pilots will not be allowed to fly in any area of Cerner not approved by the Cerner Rep.</li>
                            <li>All registered pilots will be allowed to race in any or all events.</li>
                            <li>If a pilot breaks his/her quad and cannot fix it they will be allowed to use another person's identical quad with their permission. </li>
                        </ul>
                        <h2>Standard Race-</h2>
                        These races will be run similar to our standard FPV racing events.
                        <ul>
                            <li>Each pilot will be given 3 practice races.</li>
                            <li>Each pilot will be given 3 mains heats to accumulate points to reach top 8 (points reset after).</li>
                            <li>Each top 8 pilot will be given 3 heats to accumulate points to secure a final 4 spot (points reset after). </li>
                            <li>Each final 4 pilot will be given 3 reverse course heats to determine final 4 points for overall winner.   </li>
                        </ul>
                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a FPV tournament, we ask that you follow through and show up on race day. Registration fees will be non refundable.
If you have any questions or inquiries about registration or event rules, etc., please email KCGameOn at webmaster@kcgameon.com or Josh Chambers at haydnjayce@gmail.com.
                        </p>
                        <p>
                            The registration period ends at 1:30 PM CST on the day of the event. 
Pilot briefing and safety meeting is at 2:00pm.
                        </p>

                        <p>
                            <h2>Pilot Eligibility</h2>
                        </p>

                        <p>
                            Pilots must be flying TinyWhoops. Other similar micro class quads with ducts or prop guards may or may not be allowed to race. This will be determined on a case by case basis, depending on size and speed. Safety to others and Cerner’s equipment and facility is paramount. Micro quads must be consented by the other pilots in the race or competition. An “unrestricted class” may be formed for these pilots.
                        </p>

                        <p>
                            <h2>Event Conduct</h2>
                        </p>

                        <p>
                            <ul>
                                <li>All pilots will NOT power on their quads when not racing (windows for repairs and video testing will be scheduled). A single warning system will be in effect, if you power on again you will be eliminated from all events and prizes.</li>
                                <li>Racing pilots are “encouraged” to have a spotter with goggles or a DVR. If their video is stomped on by another “non racer” and can be confirmed, they will be given another heat.</li>
                                <li>If a pilot is not on the “block” for his upcoming event when it starts, they will not get a makeup race.</li>
                                <li>All pilots are expected to behave in a decent, friendly manner to pilots and non pilots alike. Fights, arguments, sexual harassment, etc. will not be tolerated.This will end with your swift ejection from the event without reimbursement, a possible ban from future events and depending on the severity of the situation, being escorted off the property by Cerner security. </li>
                            </ul>
                        </p>

                       
                    </div>
                    <div class="fpvcontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>
                            FIRST PLACE INDIVIDUALS
                            <br />
                            Free KCGameOn #72 attendance w/8 or more persons competing.
                        </p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>12:00 PM</p>
                        <p>12:30</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                    </div>
                </div>
            </div>

            <!--  
	<%-- sfv --%>
      <div class="tab-pane fade" id="sfv">
          <div class="sfvdiv">
                <div class="sfvcontenttop">
                    <div class="col-md-3">
						<p>Date & Time</p>
						<p><h2>Jun 11, 2016 @400p</h2></p>
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
                    
<p><h2><a href="http://tinyurl.com/KO61116">Event page on Facebook</a></h2></p>
<p><h2>Rules</h2></p>
Note: Please report your score after each given match.<br />
For additional rules specific for SFV, please check out <a href="http://http://tinyurl.com/KO61116RULES">this link.</a> 



<p><h2>Registration Rules</h2></p>

<p>We only accept serious registrations. If you do register for a SFV tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 2:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
<p><h2>Game Conduct</h2></p>

<p>Please be respectful to other players and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.</p>

<p><h2>Tournament Check-In</h2></p>

<p>We require that all registered players check-in no later than 10 minutes before the tournament start.

If a player that is registered fails to show up to check-in, a substitute player that is checked in will take their place.</p>

<p>Players can report their own score.</p>		
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
					<p>Contact jspot1n0nly@gmail.com or nick@kcgameon for any questions</p>
					
                </div>
            </div>
      </div>  -->
            <%-- halo5 --%>
            <div class="tab-pane fade" id="halo5">
                <div class="halo5div">
                    <div class="halo5contenttop">
                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h2>Oct 8, 2016 @2p</h2>
                            </p>
                            Please register with Battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>
                                Bo3 Prelim
                            </p>
                            <p>Bo5 Qtrs/Semis</h2></p>

                        </div>

                        <div class="col-md-3">
                            <p>Finals</p>
                            <p>
                                <h2>
                                Bo7 Finals
                            </p>
                            <p>Double elim bracket</h2></p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <h2>Entry Fee: FREE</h2>
                            </p>
                            <%--<p>paid to TO prior to start of tournament</p>--%>
                            <a href="https://battlefy.com/kcgameon/halo5/57e205682d8925300cc29453/join/rules">
                                <img src="/img/registerlol.png" height="34" width="170"></a>
                        </div>
                    </div>
                    <div class="halo5contentmain">

                        <p>
                            <h2><a href="https://www.facebook.com/events/1641022716188181/">Event page on Facebook</a></h2>
                        </p>
                        <p>
                            <h2>Rules</h2>
                        </p>
                        Note: Please report your score after each given match.<br />
                        For additional rules specific for Halo5, please check out <a href="https://pdstournaments.com/our-rules/">this link.</a>



                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a Halo5 tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 12:00 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>
                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other players and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered players check-in no later than 10 minutes before the tournament start.

If a player that is registered fails to show up to check-in, a substitute player that is checked in will take their place.
                        </p>

                        <p>Players can report their own score.</p>
                        <div class="halo5bracket"></div>
                    </div>
                    <div class="halo5contentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>

                        <p>Cash payouts:</p>
                        <p>1st place team members will receive a free entry to KCGameOn #72 w/8 or more teams</p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>2:00 PM</p>
                        <p>3:00</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                    </div>
                </div>
            </div>

            <%-- destiny --%>
            <div class="tab-pane fade" id="destiny">
                <div class="destinydiv">
                    <div class="destinycontenttop">
                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h2>Oct 8, 2016 @2p</h2>
                            </p>
                            Please register with Battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>
                                Bo3 Prelim
                            </p>
                            <p>
                                Bo5 Semis/Finals</h2>
                            </p>

                        </div>

                        <div class="col-md-3">
                            <p>Bo3</p>
                            <p>2 objective games, 1 skirmish</p>
                            <p>Bo5</p>
                            <p>3 objective, 2 skirmish</p>
                            <p>Double elim bracket</p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <h2>Entry Fee: FREE</h2>
                            </p>
                            <%--<p>paid to TO prior to start of tournament</p>--%>
                            <a href="https://battlefy.com/kcgameon/destiny-rise-of-iron-kcgameon-71/57e20764ab9554220c2bb032/join/rules">
                                <img src="/img/registerlol.png" height="34" width="170"></a>
                        </div>
                    </div>
                    <div class="destinycontentmain">

                        <p>
                            <h2><a href="https://www.facebook.com/events/1641022716188181/">Event page on Facebook</a></h2>
                        </p>
                        <p>Please bring a full setup for your team (monitor, console - PS4 or XBone, game and controllers for each player)</p>
                        <p>
                            <h2>Rules</h2>
                        </p>
                        Note: Please report your score after each given match.<br />
                        For additional rules specific for Destiny, please check out <a href="https://pdstournaments.com/our-rules/">this link.</a>



                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a Destiny tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
The registration period ends at 12:00 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>
                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other players and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered players check-in no later than 10 minutes before the tournament start.

If a player that is registered fails to show up to check-in, a substitute player that is checked in will take their place.
                        </p>

                        <p>Players can report their own score.</p>
                        <div class="destinybracket"></div>
                    </div>
                    <div class="destinycontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>

                        <p>Cash payouts:</p>
                        <p>1st place team members will receive a free entry to KCGameOn #72 w/8 or more teams</p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>2:00 PM</p>
                        <p>3:00</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
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
                            <p>
                                <h2>Oct 8, 2016 @7p</h2>
                            </p>
                            Please register with battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>6v6</h2>
                            </p>
                            double elimination
                        </div>

                        <div class="col-md-3">
                            <p>Game Map & Type</p>
                            <p>
                                <h2>Random Custom</h2>
                            </p>
                            <p>Rules: Competitive</p>
                        </div>
                        <div class="col-md-3">
                            <a href="https://battlefy.com/kcgameon/overwatch-kcgameon-71/57c24d8a6897c81a0c9af2e9/join/password">
                                <img src="/img/join.png"></a>
                            <p>This is a PC tournament</p>
                        </div>
                    </div>
                    <div class="overwatchcontentmain">
                        <p>
                            <h2>Rules</h2>
                        </p>
                        Note: Please report your team's score after each given match.<br />

                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a Overwatch tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
							You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 3:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>
                        <p>
                            <h2>Player/Team Eligibility</h2>
                        </p>

                        <p>
                            Players must be present at the event.  In order to compete, your summoner name must be included with the team's initial registration.
							Once the Overwatch tournament begins, no roster swapping will be allowed. Only the original 6 members may compete.
                        </p>

                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
							You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
							If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered teams check-in no later than 10 minutes before the tournament start.
							A reminder will be sent to the Team Captain prior to check-in.
							All 6 members on your team must be present at check-in or else it will not qualify.
							If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.
                        </p>

                        <p>Captains can report their own score.</p>
                        <%--<div class="overwatchbracket"></div>--%>
                    </div>
                    <div class="overwatchcontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>
                            FIRST PLACE INDIVIDUALS
                            <br />
                            Free KCGameOn #72 attendance w/8 or more teams competing.
                        </p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>7:00 PM</p>
                        <p>8:00</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                    </div>
                </div>
            </div>

            <%-- CS:GO --%>
            <div class="tab-pane fade" id="CSGO">

                <div class="csdiv">
                    <div class="cscontenttop">
                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h2>Oct 8, 2016 @200p</h2>
                            </p>
                            Please register with battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>PC 5v5</h2>
                            </p>
                            pool play, double elimination
                        </div>

                        <div class="col-md-3">
                            <p>Game Map & Type</p>
                            <p>
                                <h2>5v5 draft map</h2>
                            </p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <h2>Entry Fee: $50</h2>
                            </p>
                            <p>paid to TO prior to start of tournament</p>
                            <a href="https://battlefy.com/kcgameon/kcgameon-71-csgo-2000/57c24ccb91d0a5220c405973/join/rules">
                                <img src="/img/join.png"></a>

                        </div>
                    </div>
                    <div class="cscontentmain">
                        <p>
                            <h2>Rules</h2>
                        </p>
                        Note: Please report your team's score after each given match.<br />

                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a CS:GO tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
							You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 11:00 AM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.  You must pay the $50 entry fee per person to the tournament organizer (on 3rd floor) as soon as you set up your PC.
                        </p>
                        <p>
                            <h2>Player/Team Eligibility</h2>
                        </p>

                        <p>
                            Players must be present at the event.  In order to compete, your steam name must be included with the team's initial registration.
							Once the CS:GO tournament begins, no roster swapping will be allowed. Only the original 5 members +subs may compete.
                        </p>

                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
							You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
							If a team is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered teams check-in no later than 10 minutes before the tournament start.
							A reminder will be sent to the Team Captain prior to check-in.
							All 5 members on your team must be present at check-in or else it will not qualify.
							If a team that is registered fails to show up to check-in, a substitute team that is checked in will take their place.
                        </p>

                        <p>Captains can report their own score.</p>
                        <%--<div class="csbracket"></div>--%>
                    </div>
                    <div class="cscontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>$2000* (based on 8 teams entering)</p>
                        <p>Cash payouts: 55/30/15%</p>


                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>12:00 PM</p>
                        <p>1:00</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                    </div>
                </div>
            </div>
            <%-- Hearthstone --%>
            <div class="tab-pane fade" id="HS">
                <%-- <h2>Hearthstone</h2>--%>
                <div class="hsdiv">
                    <div class="hscontenttop">
                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h2>Oct 8, 2016 @200p</h2>
                            </p>
                            Please register with battlefy or you will not be eligible for prizing.
						
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h2>Standard</h2>
                            </p>
                            double elimination
                        </div>

                        <div class="col-md-3">
                            <p>Gameplay</p>
                            <p>
                                <h2>Best of 3
                                    <p>Best of 5 (in final 4)</p>
                                </h2>
                            </p>

                        </div>
                        <div class="col-md-3">
                            <a href="https://battlefy.com/kcgameon/hearthstone-kcgameon-71/57c24ef44f81a31a0dc6445c/join/rules">
                                <img src="/img/join.png"></a>
                            <p>Multi-platform tournament</p>
                        </div>
                    </div>
                    <div class="hscontentmain">
                        <p>
                            <h2>Rules</h2>
                            <p><a href="https://bnetcmsus-a.akamaihd.net/cms/gallery/j9/J976W710HSTP1455317433658.pdf">Offical Competition Rules</a></p>
                        </p>
                        Note: Please report your score after each given match.<br />

                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a Hearthstone tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
							You may only register one player of the same name. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 1:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>
                        <p>
                            <h2>Player/Team Eligibility</h2>
                        </p>

                        <p>
                            Players must be present at the event.  In order to compete, your gamer name must be included with the team's initial registration.
							
                        </p>

                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other players and participants. Refrain from using vulgar language or racial/sexist slurs in "All Chat" or you will be disqualified immediately.
							You may use an approved third-party communication program to coordinate and speak with your team, however, there is zero-tolerance for the use of a hack or cheat. Players accused and proved of hacking are immediately disqualified.
							If a person is found intentionally feeding or throwing the game, they will be disqualified and possibly banned from our future tournaments.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered persons check-in no later than 10 minutes before the tournament start.
							
							All players must be present at check-in or else they will not qualify.
							
                        </p>

                        <p>Players can report their own score.</p>
                        <div class="hsbracket"></div>
                    </div>
                    <div class="hscontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>
                            FIRST PLACE INDIVIDUALS
                            <br />
                            Free KCGameOn #72 attendance w/8 or more players competing.
                        </p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>2:00 PM</p>
                        <p>2:30</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>
                    </div>
                </div>
            </div>
            <!--
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
	-->
            <%-- Magic --%>
            <div class="tab-pane fade" id="MAGIC">

                <div class="magicdiv">
                    <div class="magiccontenttop">
                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h3>July 30, 2016 @1p and 7p</h3>
                            </p>

                            <a href="http://goo.gl/forms/uWdzgzcw2jgSefLD3">
                                <img src="/img/registerlol.png" height="34" width="170"></a>
                        </div>

                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h3><a href="https://en.wikipedia.org/wiki/Magic:_The_Gathering#Limited">Booster Draft ($10 entry)</a></h3>
                            </p>
                            3 packs<br />
                            4 Round <a href="https://en.wikipedia.org/wiki/Swiss-system_tournament">Swiss</a><br />
                            8 player minimum per flight
                        </div>

                        <div class="col-md-3">
                            <p>Date & Time</p>
                            <p>
                                <h3>July 30, 2016 @1 and 7p</h3>
                            </p>
                            <a href="http://goo.gl/forms/uWdzgzcw2jgSefLD3">
                                <img src="/img/registerlol.png" height="34" width="170"></a>
                        </div>
                        <div class="col-md-3">
                            <p>Format</p>
                            <p>
                                <h3><a href="https://en.wikipedia.org/wiki/Magic:_The_Gathering#Limited">Sealed Deck ($20 entry)</a></h3>
                            </p>
                            6 packs<br />
                            4 Round <a href="https://en.wikipedia.org/wiki/Swiss-system_tournament">Swiss</a><br />
                            8 player minimum per flight
                        </div>
                    </div>
                    <div class="magiccontentmain">
                        <p>
                            <h2>Rules</h2>
                        </p>
                        Note: Winner of each match, please report your score to the judge after each given match.<br />

                        <p>
                            <h2>Registration Rules</h2>
                        </p>

                        <p>
                            We only accept serious registrations. If you do register for a MTG tournament, we ask that you follow through and show up on game day. If you are not present at the proper time, you may face a ban from future tournaments.
							You may only register yourself once for each tournament. Please do not try to register more than once as it will not increase your chances of participating.
							If you have any questions or inquiries about a current registration, please email us at webmaster@kcgameon.com
							The registration period ends at 12:30 PM CST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.
                        </p>

                        <p>
                            <h2>Player Eligibility</h2>
                        </p>

                        <p>
                            Players must be present at the event.  In order to compete, you must use your real name must be used in the registration.
							Once the MTG tournament begins, no player swapping will be allowed. Only the original member may compete.
                        </p>

                        <p>
                            <h2>Game Conduct</h2>
                        </p>

                        <p>
                            Please be respectful to other teams and participants. Refrain from using vulgar language or racial/sexist slurs or you will be disqualified immediately.
							There is zero-tolerance for cheating. If you have any questions at all, please contact the tournament judge.
                        </p>

                        <p>
                            <h2>Tournament Check-In</h2>
                        </p>

                        <p>
                            We require that all registered player check-in no later than 10 minutes before the tournament start.
							
							If a player that is registered fails to show up to check-in, a substitute player that is checked in will take their place.
                        </p>

                        <div class="magicbracket"></div>
                    </div>
                    <div class="magiccontentright">
                        <p>
                            <h2>Prizes</h2>
                        </p>
                        <p>
                            Standard prizing for sealed/draft
                            <br />
                            details to follow
                        </p>

                        <p>
                            <h2>Schedule</h2>
                        </p>
                        <p>1 PM</p>
                        <p>2 PM</p>
                        <p>etc</p>
                        <p>
                            <h2>Questions</h2>
                        </p>
                        <p>Contact nick@kcgameon for any questions</p>

                    </div>
                </div>
            </div>
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
