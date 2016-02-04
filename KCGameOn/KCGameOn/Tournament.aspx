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

            .csdiv, .hsdiv, .loldiv, .rldiv {
                padding: 20px;
                height: 1080px;
                width: 1140px;
                position: relative;
                background-size: cover;
            }

            .cscontentmain, .hscontentmain, .lolcontentmain, .rlcontentmain {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.75);
				overflow-y: auto;
                height: 700px;
                width: 500px;
                margin: auto;
                position: absolute;
                top: 0;
                bottom: 0;
                left: 0;
                right: 0;
            }

            .cscontentleft, .hscontentleft, .rlcontentleft, .lolcontentleft {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.75);
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

            .cscontentright, .hscontentright, .rlcontentright, .lolcontentright {
				padding: 10px;
                background-color: rgba(0, 0, 0, 0.75);
				overflow-y: auto;
                height: 700px;
                width: 250px;
                margin: auto;
                position: absolute;
                right: 0;
                top: 0;
                bottom: 0;
                left: 75%;
            }

            .csbracket, .hsbracket, .lolbracket, .rlbracket
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
    <h2>Event Tournaments</h2>
    <h4>If you want to request a tournament for a particular game, please let us know and we will work on getting one set up!</h4>
    <div class="container">
        <ul class="list-inline">
            <li><a id="csgo" href="#" class="brand">Counter-Strike: Global Offensive</a></li>
            <li><a id="hs" href="#" class="brand">Hearthstone</a></li>
            <li><a id="lol" href="#" class="brand">League of Legends</a></li>
            <li><a id="rl" href="#" class="brand">Rocket League</a></li>
        </ul>

        <form class="well form-inline">
            <a name="csgopage"></a>
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
            <a name="hearthstonepage"></a>
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
            <a name="leagueoflegendspage"></a>
            <div class="loldiv">
                <div class="lolcontentleft">
                    <p>Game & Region</p>
					<p><h2>League of Legends</h2></p>
					<p>North America</p>
					<br />
					<p>Date & Time</p>
					<p><h2>Saturday, Feb 20, 2016</h2></p>
					<p><h2>2:30PM</h2></p>
					<br />
					<p>Format</p>
					<p><h2>5v5</h2></p>
					<br />
					<p>Game Map & Type</p>
					<p><h2>Summoners Rift</h2></p>
					<p>Tournament Draft</p>		
                </div>
                <div class="lolcontentmain">
                    <p><h2>Rules</h2></p>
					Note: Please report your team's score after each given match.<br />

<p><h2>Registration Rules</h2></p>

<p>We only accept serious registrations. If you do register for a League of Legends tournament, we ask that you follow through and show up on game day. If your team is not present at the proper time, you may face a ban from future tournaments.
You may only register one team at a time. Please do not try to register more than once as it will not increase your chances of participating.
If you have any questions or inquiries about a current registration, please email us at info@vipertechgaming.com
The registration period ends at 6:30 PM EST on the day of the tournament. Make sure you fill up the slots or they will be filled with BYEs.</p>
<p><h2>Player/Team Eligibility</h2></p>

<p>In order to compete, your summoner name must be included with the team's initial registration.
Once a League of Legends tournament begins, no roster swapping will be allowed. Only the original 5 members may compete.
We currently are only accepting NA teams and players.</p>

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
					<p>In the process of getting sponsorship</p>
					<p><h2>Schedule</h2></p>
					<p>2:30</p>
					<p>3:30PM</p>
					<p>etc</p>
					<p><h2>Questions</h2></p>
					<p>Contact nick@kcgameon for any questions</p>
                </div>
            </div>
            <a name="rocketleaguepage"></a>
            <div class="rldiv">
                <div class="rlcontentleft">
                    <p>Filler content</p>
                </div>
                <div class="rlcontentmain">
                    <p>Filler content</p>
                    <div class="rlbracket"></div>
                </div>
                <div class="rlcontentright">
                    <p>Filler content</p>
                </div>
            </div>
        </form>
    </div>
</asp:Content>
