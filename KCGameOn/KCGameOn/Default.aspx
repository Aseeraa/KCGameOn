<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KCGameOn.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .tbody
        {
            width: 100%;
            height: 235px;
            display: block;
            overflow-y: auto;
        }

        .scrollable
        {
            width: 389px;
            height: 235px;
            width: 100%;
        }
        /* Fade transition for carousel items */
.carousel .item {
    left: 0 !important;
      -webkit-transition: opacity .4s; /*adjust timing here */
         -moz-transition: opacity .4s;
           -o-transition: opacity .4s;
              transition: opacity .4s;
}
.carousel-control {
    background-image: none !important; /* remove background gradients on controls */
}
/* Fade controls with items */
.next.left,
.prev.right {
    opacity: 1;
    z-index: 1;
}
.active.left,
.active.right {
    opacity: 0;
    z-index: 2;
}
    </style>
    <script>
        function myFunction() {
            <!-- document.getElementById("demo").innerHTML = "For now, log into website and seat yourself on the map"; -->
		window.location.href = "https://kcgameon.com/EventRegistration.aspx";
        }

        jQuery(document).bind('keyup', function (e) {

            if (e.keyCode == 39) {
                jQuery('a.carousel-control.right').trigger('click');
            }

            else if (e.keyCode == 37) {
                jQuery('a.carousel-control.left').trigger('click');
            }

        });
    </script>

</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="row-fluid">
        <div class="span7">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Carousel items -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="/img/gameon2016.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>KCGameOn</h4>
                            <p>KCGameOn 2016 poster</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/csgo.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>Hrishi is king, beat him and take his title</p>
                        </div>
                    </div>
                    
                    <div class="item">
                        <img src="/img/lol.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>Our most popular game</p>
                        </div>
                    </div>
					<div class="item">
                        <img src="/img/rocket-league.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>3v3 tournament and a ton of fun</p>
						</div>
					</div>
					<div class="item">
                        <img src="/img/dota_2.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>A MOBA favorite at KCGameOn</p>
						</div>
					</div>
					<div class="item">
                        <img src="/img/lfd2.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>A great 4v4 game for everyone to enjoy</p>
						</div>
					</div>
                    <div class="item">
                        <img src="/img/mtg.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>Magic:The Gathering</h4>
                            <p>Play Standard, Legacy, Commander and other various multiplayer formats!</p>
                        </div>
                    </div>
					<div class="item">
                        <img src="/img/hearthstone.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>Pull up a chair by the hearth!</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/diablo-3.png" style="width: 100%" />
                        <div class="carousel-caption">
                            
                            <p>Hack n' Slash your way to better loot!</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/boardgames.jpg" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>Board Gaming</h4>
                            <p>A huge variety of board games with friendly gamers!</p>
                        </div>
                    </div>
                </div>
                <!-- Carousel nav -->
                <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
            </div>



        </div>
        <div class="span5">
            <!--<div class="scrollable">
                <table class="tbody" id="table_feed" runat="server">
                </table>
            </div>-->
			<iframe src="https://discordapp.com/widget?id=143552833805877248&theme=dark" width="470" height="270" allowtransparency="true" frameborder="0"></iframe>
            <%--<a data-toggle="modal" href="#myModal" >
		<img src="/img/GameOn.jpg"style="width:389px;height:235px;width:100%"/></a>--%>
<%--            <div class="modal hide" id="myModal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h3>GameOn Events</h3>
                    <img src="/img/GameOn.jpg" />
                </div>
            </div>--%>


            <br />
            <br />

            <form class="well form-inline">
                <h3>KCGameOn Event #69 - June 11th, 2016!</h3>
                <br />
                <div class="control-group">
                    <div class="controls">
                        <div class="input-append">
                <button id="Button1" type="button" class="btn btn-inverse" style="padding-left: 13px" onclick="myFunction()" runat="server">Registration for #69!</button>
				
                            <!-- <p id="demo"></p> -->
                        </div>
                    </div>
                </div>
				<!-- Please bear with us while we set up for the next event. <br /> -->
                <p style="text-align: justify">

                    <b style="color: #0099cc;">Who we are:</b> Gamers putting on a gaming event for YOU and your friends.  PC, Console, Board Games and Card games welcome!
            <br />
                    <b style="color: #0099cc;">Where:</b> 2702 Rockcreek Parkway, North Kansas City, MO 64117.
            <br />
                    <b style="color: #0099cc;">Cost:</b> $15/pre-pay or $20@door <!-- You can pay using paypal via <a href="https://kcgameon.com/EventRegistration.aspx">registration</a> page, bitcoin OR by cash.-->
			<%--<br />
					<b style="color: #0099cc;">For more poster submission information, click <a href="https://kcgameon.com/Postersubmission.aspx">HERE.</a>--%>
            </form>

        </div>
    </div>

    <div class="row-fluid">
        <div class="span4">
            <center>
                
                    <a href="http://www.collectorscache.com">
					<img src="img/collectorscache.png" /></a><p>
					<!-- <img src="img/shinra.png" /><p>
		<p><a href="http://www.cerner.com"> -->
                        <!-- <img src="img/cernerlogo2.png" /></a></p> -->
                <br />
                <br />
            </center>
        </div>

        <div class="span4">
            <p>
		<center>
                    <a href="http://www.ransomgaming.com">
                        <img src="img/ransomgaminglogo.png" /></a>
                    <br />
                    <br />
                </center>
                <center>
		<a href="http://www.ibm.com">
                        <img src="img/IBM_logo_transparent.png" /></a>
                    
                    <br />
                    <br />
                </center>
                
        </div>

        <div class="span4">
            <center>
                <!-- <a href="http://www.soprogaming.com">
                    <img src="img/soprogaming-2.png" /></a> -->
					<a href="http://www.kcgameon.com/howtohelp.aspx">
                    <img src="img/sponsor.jpg" /></a>
                <br />
                <br />
            </center>
        </div>
    </div>
</asp:Content>
