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
                        <img src="/img/poster2015-2.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>KCGameOn</h4>
                            <p>KCGameOn 2015 poster</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/csgo.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>Counter Strike:GO</h4>
                            <p>Hrishi is king, beat him and take his title</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/lfd2.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>Left 4 Dead 2</h4>
                            <p>A great 4v4 game for everyone to enjoy</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/lol.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>LoL</h4>
                            <p>League of Legends - our most popular game</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/mtg.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>MTG</h4>
                            <p>Magic the Gathering - Test out your new decks, and have fun!</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/diablo-3.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>Diablo 3</h4>
                            <p>Hack N' Slash your way to better loot!</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="/img/boardgames.png" style="width: 100%" />
                        <div class="carousel-caption">
                            <h4>Board Games</h4>
                            <p>Wide variety of board games!</p>
                        </div>
                    </div>
                </div>
                <!-- Carousel nav -->
                <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
            </div>



        </div>
        <div class="span5">
            <div class="scrollable">
                <table class="tbody" id="table_feed" runat="server">
                </table>
            </div>
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
                <h3>Announcing the 66th Cerner LAN - Dec 5, 2015!</h3>
                <br />
                <div class="control-group">
                    <div class="controls">
                        <div class="input-append">
                <button id="Button1" type="button" class="btn btn-inverse" style="padding-left: 13px" onclick="myFunction()" runat="server">Registration for #66!</button>
                            <!-- <p id="demo"></p> -->
                        </div>
                    </div>
                </div>
                <p style="text-align: justify">

                    <b style="color: #0099cc;">Who we are:</b> Cerner associates putting on a team building and networking event for Cerner associates and your friends.
            <br />
                    <b style="color: #0099cc;">Where:</b> 2702 Rockcreek Parkway, the entire lower level of the building.
            <br />
                    <b style="color: #0099cc;">Cost:</b> $15 if you pre-pay, $20 dollars at the door.  You can pay using paypal via payments@kcgameon.com, bitcoin OR by cash.

            </form>

        </div>
    </div>

    <div class="row-fluid">
        <div class="span4">
            <center>
                <a href="http://www.shinra.com">
                    <img src="img/shinra.png" /></a><p>
		<!-- <p><a href="http://www.cerner.com"> -->
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
                <a href="/sponsors.aspx">
                    <img src="img/soprogaming-2.png" /></a>
                <br />
                <br />
            </center>
        </div>
    </div>
</asp:Content>
