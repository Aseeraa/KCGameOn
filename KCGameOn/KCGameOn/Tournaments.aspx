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

    <h2>Welcome,
            <asp:Literal runat="server" ID="usernameText" EnableViewState="false" />!</h2>
    <p>Buttons/Check boxes will get tournament registration started.  Click the game names for more information. </p>
    <form class="well form-horizontal" runat="server" id="updatepassword">
        <div id="ProfileUpdateLeftPane" style="width: 50%; float: left;">
            <img src="/img/logo.png" height="50" width="300" />
            <%--<p></p>
            <h3>NOON start time</h3>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/kcgameon-72-csgo-2000/582be9c55b2cfb3f03235ab3/info"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">CS:GO $50 entry, $2000 payout*</label>
                <div class="Content">

                    <ul>
                        <li>*based on 8 teams paying $250 per team</li>
                        <li>Cash payouts: 70/20/10% of total cash pot</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC 5v5</li>
                        <li>Competitive map pool</li>
                        <li>2x4 pool play, then double elimination bracket, bottom of pool play starts in losers bracket</li>
                    </ul>



                </div>

            </div>--%>
            
            
            <p></p>
            <h3>1:30pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/league-of-legends-kcgameon-73/588673d4f40cc1c5063c3199/info"><img src="/img/join.png" /></a><a href="http://events.na.leagueoflegends.com/events/237629"><img src="/img/registerlol.png" /></a> <label class="Menubody-trigger tournament-menu">League of Legends</label>
                <div class="Content">
                    <ul>
                        <li>NO GOLD or lower restriction - all are eligible to play</li>
                        <li>Winning team will get prizes TBA</li>
                        <li>Please register with battlefy or you will not be eligible for prizing. BOTH links</li>
                        <li>Please register with League of Legends or you will not be eligible for prizing. BOTH links</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC 5v5</li>
                        <li>Summoners Rift</li>
                        <li>Tournament draft</li>
                        <li>double elimination bracket</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>7:00 pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/overwatch-kcgameon-73/5886e0234ab139df0672f54e/info"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Overwatch</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #74 event with 8 or more teams in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC 6v6</li>
                        <li>Competitive map pool</li>
                        <li>Standard Competitive rules</li>
                        <li>double elimination bracket</li>
                    </ul>

                </div>

            </div>
            <p></p>
            <h3>8:00pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/rocket-league-kcgameon-73-3v3/5886b792d28ca93a038d38d0/info"><img src="/img/join.png" /></a> <label class="Menubody-trigger tournament-menu">Rocket League (PS4/XBone also eligible to play)</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #74 event with 8 or more teams in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC/PS4/XBone 3v3</li>
                        <li>Competitive map pool</li>
                        <li>Standard Competitive rules</li>
                        <li>double elimination bracket</li>
                    </ul>
                </div>

            </div>
            <hr />

            <h2>Hand Held Gaming/Other</h2>
            <p></p>
            <h3>2pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/hearthstone-kcgameon-73/5886d8950aea610106f66985/info"><img src="/img/join.png" /></a> <label class="Menubody-trigger tournament-menu">Hearthstone</label>
                <div class="Content">
                    <ul>
                        <li>All are eligible to play</li>
                        <li>Winning player will get free attendance to KCGO #74 event with 8 or more players in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>PC/hand held device 1v1</li>
                        <li>Standard</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (final 4)</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/fpv-kcgameon-73/5886dd3d038a154b06b5ed05/info"><img src="/img/join.png" /></a> <label class="Menubody-trigger tournament-menu">Tiny Whoop (Mini Drone Racing)</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #74 event with 8 or more teams in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Standard Race</li>
                    </ul>
                </div>
            </div>
            <p></p>
           <%--  <h3>3pm start time</h3>
           <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Pokemon Sun/Moon</label>
                <div class="Content">
                    <p>game info here</p>
                </div>
            </div>--%>
            <hr />
            <img src="/img/pds.jpg" height="75" width="200" />
            <h3>1:30 pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="http://challonge.com/KCGOIW"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Call of Duty: Infinite Warfare $10 entry, $320 payout*</label>
                <div class="Content">
                    <ul>
                        <li>*based on 8 teams paying $40 per team</li>
                        <li>$5 cash back for full setup (monitor/ps4/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>4v4</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3 (prelims)</li>
                        <li>Best 3/5 (qtrs/semis)</li>
                        <li>Best 5/7 (finals)</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <%--<div class="UImenuItem clearfix">
                <a href="http://challonge.com/KCGODestiny"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Destiny</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #73 event w/8 or more teams</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>3v3</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>2 objective games, 1 skirmish</li>
                        <li>Best 3/5 (final 4)</li>
                        <li>3 objective, 2 skirmish</li>
                    </ul>
                </div>

            </div>--%>
            <%--<div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/halo5-kcgameon-72/5833d4d3d9ed303803045e59/info"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Halo5</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #73 event w/8 or more teams</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>4v4</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3 (prelims)</li>
                        <li>Best 3/5 (qtrs/semis)</li>
                        <li>Best 5/7 (finals)</li>
                    </ul>
                </div>

            </div>--%>
            <p></p>
            <div class="UImenuItem clearfix">
                <a href="http://challonge.com/KCGOSmash"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Sm4sh</label>
                <div class="Content">
                    <ul>
                        <li>$5 cash back for full setup (monitor/WiiU/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        
                        <li>Double Elimination</li>
                    </ul>
                </div>

            </div>
            <p></p>
            <h3>4:30 pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="http://challonge.com/KCGOSmash"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Smash PM</label>
                <div class="Content">
                    <ul>
                        <li>$5 cash back for full setup (monitor/WiiU/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        
                        <li>Double Elimination</li>
                    </ul>
                </div>

            </div>
            <p></p>
            <h3>8:30 pm start time</h3>
            <div class="UImenuItem clearfix">
                <a href="http://challonge.com/KCGOSmash"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Smash Melee</label>
                <div class="Content">
                    <ul>
                        <li>$5 cash back for full setup (monitor/WiiU/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        
                        <li>Double Elimination</li>
                    </ul>
                </div>

            </div>
        </div>
        <div id="ProfileUpdateRightPane" style="width: 50%; float: right;">
            <img src="/img/maxout.png" height="65" width="200" />
            <p></p>
            <h3>1pm start time</h3>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="SFVRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Street Fighter V - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="SG2ERegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Skullgirls 2nd Encore - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 3/5 the whole way</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winner is allowed to switch assists but not characters or team order.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="POKRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Pokken - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>3pm start time</h3>

            <div class="UImenuItem clearfix">
                <input type="checkbox" id="TKFRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">The King of Fighters XIV - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="KIRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Killer Instinct - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 3/5 the whole way</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
                <p></p>
                <h3>4pm start time</h3>
            </div>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="GGXRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Guilty Gear Xrd: Revelator - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="MVCRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Ultimate Marvel vs Capcom 3</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 3/5 the whole way</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winner is allowed to switch assists but not characters or team order.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>

                    </ul>
                </div>
            </div>
            <p></p>
            <h3>5pm start time</h3>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="MKXRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Mortal Kombat X - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>6pm start time</h3>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="BBCFRegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">BlazBlue: Central Fiction - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="DOA5RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Dead or Alive 5 Last Round - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>7pm start time</h3>
            <div class="UImenuItem clearfix">
                <input type="checkbox" id="USF4RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Ultra Street Fighter 4 - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>

            <div class="UImenuItem clearfix">
                <input type="checkbox" id="SF3RegisteredCB" runat="server" /><label class="Menubody-trigger tournament-menu">Street Fighter III: 3rd Strike - $5 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winner is allowed to pick a different Super Art but is not allowed to switch characters</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h4>To pre-reg for a Maxout tournaments (or multiple tournaments) - click the box(es) for the game you want to play and click the SUBMIT button (below here).  It will save your selections to your profile and you will be added to the brackets prior to check-in.</h4>




        </div>
        <div class="control-group">
            <asp:Literal runat="server" ID="ProfileUpdateMessage" EnableViewState="false" />
        </div>
        <div class="pull-right">
            <asp:Button ID="ChangeProfileConfirm" class="btn btn-large btn-success" type="submit" Text="Submit Changes" OnClick="ChangeProfile_Click" runat="server" />
        </div>
    </form>
    <%}
        else
        {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to start the tournament signup process.</h2>
    
        <div id="ProfileUpdateLeftPane1" style="width: 50%; float: left;">
            <img src="/img/logo.png" height="50" width="300" />
            <%--<p></p>
            <h3>NOON start time</h3>
            <div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/kcgameon-72-csgo-2000/582be9c55b2cfb3f03235ab3/info"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">CS:GO $50 entry, $2000 payout*</label>
                <div class="Content">

                    <ul>
                        <li>*based on 8 teams paying $250 per team</li>
                        <li>Cash payouts: 70/20/10% of total cash pot</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC 5v5</li>
                        <li>Competitive map pool</li>
                        <li>2x4 pool play, then double elimination bracket, bottom of pool play starts in losers bracket</li>
                    </ul>



                </div>

            </div>--%>
            
            
            <p></p>
            <h3>1:30pm start time</h3>
            <div class="UImenuItem clearfix">
                 <label class="Menubody-trigger tournament-menu">League of Legends</label>
                <div class="Content">
                    <ul>
                        <li>NO GOLD or lower restriction - all are eligible to play</li>
                        <li>Winning team will get prizes TBA</li>
                        <li>Please register with battlefy or you will not be eligible for prizing. BOTH links</li>
                        <li>Please register with League of Legends or you will not be eligible for prizing. BOTH links</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC 5v5</li>
                        <li>Summoners Rift</li>
                        <li>Tournament draft</li>
                        <li>double elimination bracket</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>7:00 pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Overwatch</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #74 event with 8 or more teams in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC 6v6</li>
                        <li>Competitive map pool</li>
                        <li>Standard Competitive rules</li>
                        <li>double elimination bracket</li>
                    </ul>

                </div>

            </div>
            <p></p>
            <h3>8:00pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Rocket League (PS4/XBone also eligible to play)</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #74 event with 8 or more teams in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>Team Captains of team and ALL free agents must check in 30 min prior at tournament desk</li>
                        <li>PC/PS4/XBone 3v3</li>
                        <li>Competitive map pool</li>
                        <li>Standard Competitive rules</li>
                        <li>double elimination bracket</li>
                    </ul>
                </div>

            </div>
            <hr />

            <h2>Hand Held Gaming/Other</h2>
            <p></p>
            <h3>2pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Hearthstone</label>
                <div class="Content">
                    <ul>
                        <li>All are eligible to play</li>
                        <li>Winning player will get free attendance to KCGO #74 event with 8 or more players in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>PC/hand held device 1v1</li>
                        <li>Standard</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (final 4)</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Tiny Whoop (Mini Drone Racing)</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #74 event with 8 or more teams in the tournament</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Standard Race</li>
                    </ul>
                </div>
            </div>
            <p></p>
           <%--  <h3>3pm start time</h3>
           <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Pokemon Sun/Moon</label>
                <div class="Content">
                    <p>game info here</p>
                </div>
            </div>--%>
            <hr />
            <img src="/img/pds.jpg" height="75" width="200" />
            <h3>1:30 pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Call of Duty: Infinite Warfare $10 entry, $320 payout*</label>
                <div class="Content">
                    <ul>
                        <li>*based on 8 teams paying $40 per team</li>
                        <li>$5 cash back for full setup (monitor/ps4/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>4v4</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3 (prelims)</li>
                        <li>Best 3/5 (qtrs/semis)</li>
                        <li>Best 5/7 (finals)</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <%--<div class="UImenuItem clearfix">
                <a href="http://challonge.com/KCGODestiny"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Destiny</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #73 event w/8 or more teams</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>3v3</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>2 objective games, 1 skirmish</li>
                        <li>Best 3/5 (final 4)</li>
                        <li>3 objective, 2 skirmish</li>
                    </ul>
                </div>

            </div>--%>
            <%--<div class="UImenuItem clearfix">
                <a href="https://battlefy.com/kcgameon/halo5-kcgameon-72/5833d4d3d9ed303803045e59/info"><img src="/img/join.png" /></a><label class="Menubody-trigger tournament-menu">Halo5</label>
                <div class="Content">
                    <ul>
                        <li>Winning team will get free attendance to KCGO #73 event w/8 or more teams</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>4v4</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3 (prelims)</li>
                        <li>Best 3/5 (qtrs/semis)</li>
                        <li>Best 5/7 (finals)</li>
                    </ul>
                </div>

            </div>--%>
            <p></p>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Sm4sh</label>
                <div class="Content">
                    <ul>
                        <li>$5 cash back for full setup (monitor/WiiU/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        
                        <li>Double Elimination</li>
                    </ul>
                </div>

            </div>
            <p></p>
            <h3>4:30 pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Smash PM</label>
                <div class="Content">
                    <ul>
                        <li>$5 cash back for full setup (monitor/WiiU/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        
                        <li>Double Elimination</li>
                    </ul>
                </div>

            </div>
            <p></p>
            <h3>8:30 pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Smash Melee</label>
                <div class="Content">
                    <ul>
                        <li>$5 cash back for full setup (monitor/WiiU/game/dlc) usage during tournament play</li>
                        <li>Please register with battlefy or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        
                        <li>Double Elimination</li>
                    </ul>
                </div>

            </div>
        </div>
        <div id="ProfileUpdateRightPane2" style="width: 50%; float: right;">
            <img src="/img/maxout.png" height="65" width="200" />
            <p></p>
            <h3>1pm start time</h3>
            
           
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Pokken - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            
            <p></p>
            <h3>2pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Street Fighter V - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
            <p></p>
            <h3>3pm start time</h3>

            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">The King of Fighters XIV - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Killer Instinct - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 3/5 the whole way</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
                <p></p>
                <h3>4pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Mortal Kombat X - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
           
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Ultimate Marvel vs Capcom 3</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 3/5 the whole way</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winner is allowed to switch assists but not characters or team order.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>

                    </ul>
                </div>
            </div>
            <p></p>
            <h3>5pm start time</h3>
             <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Guilty Gear Xrd: Revelator - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Ultra Street Fighter 4 - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>6pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">BlazBlue: Central Fiction - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>

            </div>
            
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Street Fighter III: 3rd Strike - $5 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winner is allowed to pick a different Super Art but is not allowed to switch characters</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            <p></p>
            <h3>7pm start time</h3>
            <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Dead or Alive 5 Last Round - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 2/3</li>
                        <li>Best 3/5 (finals)</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
             <div class="UImenuItem clearfix">
                <label class="Menubody-trigger tournament-menu">Skullgirls 2nd Encore - $10 Entry</label>
                <div class="Content">
                    <ul>
                        <li>Please register with kcgameon website or you will not be eligible for prizing.</li>
                        <li>ALL players must check in 30 min prior at tournament desk</li>
                        <li>Double Elimination</li>
                        <li>Best 3/5 the whole way</li>
                        <li>Winner keeps same character, loser may select a new one.</li>
                        <li>Winner is allowed to switch assists but not characters or team order.</li>
                        <li>Winners Finals, Losers Finals, and Grand Finals for all tournaments will switch to best 3 out of 5 matches.</li>
                        <li>Payout: 70/20/10% of cash pot collected at check-in.</li>
                    </ul>
                </div>
            </div>
            

            
        </div>
   
    <%} %>
</asp:Content>
