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
                background-color: rgba(0, 0, 0, 0.6);
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
                background-color: rgba(0, 0, 0, 0.6);
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
                background-color: rgba(0, 0, 0, 0.6);
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
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
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
                    <p>Filler content</p>
                </div>
                <div class="lolcontentmain">
                    <p>Filler content</p>
                    <div class="lolbracket"></div>
                </div>
                <div class="lolcontentright">
                    <p>Filler content</p>
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
        <%}
      else
      {%>
        <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
        <br />
        <%} %>
    </div>
</asp:Content>
