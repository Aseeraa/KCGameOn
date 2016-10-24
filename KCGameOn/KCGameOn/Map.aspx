<%@ Page Title="Maps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="KCGameOn.Map" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8" />
    <link href="css/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-inline, .form, .btn-group {
            margin-bottom: 10px;
        }

        .modal-content, .modal-footer {
            background: #282828;
        }

        .modal-dialog {
            width: 64%; /* desired relative width */
            left: 0%; /* (100%-width)/2 */
            /* place center */
            margin-left: auto;
            margin-right: auto;
            background: #282828;
        }

        h3 {
            color: #33b5e5;
            padding: 0px;
            margin: 0px;
        }

        .Count {
            margin: auto;
            margin-left: 150px;
            width: auto;
            max-width: 450px;
        }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script async src="js/bootbox.js?v=1.0"></script>
    <script async2 src="js/bootbox.js?v=1.0"></script>
    <script async3 src="js/bootbox.js?v=1.0"></script>
    <script src="js/index.js?v=1.0"></script>
    <script src="js/index2.js?v=1.0"></script>
    <script src="js/index3.js?v=1.0"></script>
    <!-- Nick replace this with the name of your new file-->
    <script>
        $(document).ready(function () {
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
        });

        $(function () {
            $('#payButton').click(function () {
                window.location = 'EventRegistration.aspx'
            });
        });
        $(function () {
            $('#loginButton').click(function () {
                window.location = '/Account/Login.aspx'
            });
        });

    </script>
    <!-- Success modal-->
    <div class="modal" id="success" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content" height="90%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Success</h4>
                </div>
                <div class="modal-body" id="successMessage">
                    <p>You have been successfully seated.  If you are interested in tournaments, please sign up below.</p>
                    <table width="100%" table-layout="fixed">
                        <!-- Tournament Posters -->
                        <tr>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/lolPoster.png" alt="League of Legends" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/rlPoster.png" alt="Rocket League" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/csgoPoster.jpg" alt="CS:GO" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/overwatchPoster.jpg" alt="Overwatch" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/halo5Poster.png" alt="Halo5" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/hearthstonePoster.jpg" alt="Hearthstone" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/fpvPoster.jpg" alt="FPV" /></a>
                            </td>
                            <td width="11%">
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/destinyPoster.jpg" alt="Destiny" /></a>
                            </td>

                            <!--
							<td>
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/sfvPoster.png" alt="Street Fighter V" height="350" width="193" /></a>
                            </td>
							<td>
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/dota2Poster.png" alt="Dota 2" height="350" width="193" /></a>
                            </td>
							<td>
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/smashPoster.png" alt="Super Smash Bros." height="350" width="193" /></a>
                            </td>
                            <td>
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/hotsPoster.jpg" alt="Heroes of the Storm" height="350" width="193" /></a>
                            </td>
							<td>
                                <a href="https://kcgameon.com/Tournament.aspx">
                                    <img src="img/magicposter.jpg" alt="Magic: The Gathering" height="350" width="193" /></a>
                            </td> -->
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <!-- Failure modal-->
    <div class="modal" id="failure" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Failure</h4>
                </div>
                <div class="modal-body" id="failureMessage">
                    <p>Failed to sit down, please LOG OFF and then LOG IN and try again.  If that doesn't work, please inform an administrator or try again in a few minutes.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <!-- Pay modal-->
    <div class="modal" id="payToSit" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Failure</h4>
                </div>
                <div class="modal-body" id="payToSitMessage">
                    <p>Failed to sit down, please inform an administrator or try again in a few minutes.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" id="payButton" class="btn btn-primary" data-dismiss="modal">Pay Now</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <!-- Login modal-->
    <div class="modal" id="login" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Login</h4>
                </div>
                <div class="modal-body" id="loginMessage">
                    <p>Please login before attempting to find a seat.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" id="loginButton" class="btn btn-primary" data-dismiss="modal">Login</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <center>
        <h3 style="color: red;">
            <asp:Label ID="previousPage" Text="" runat="server" /></h3>
    </center>
    <div class="container">
        <ul class="nav nav-pills" role="tablist">
            <li class="active">
                <a href="#KCExpoFloor" id="KCExpoFloorTab" role="tab" data-toggle="tab">
                    <i class="fa fa-envelope">KC Expo Center</i>
                </a>
            </li>
            <li>
                <a href="#FirstFloor" id="FirstFloorTab" role="tab" data-toggle="tab">
                    <i class="fa fa-envelope">1st floor map - Tabletop/BYOC/Card games/Hearthstone</i>
                </a>
            </li>
            <li>
                <a href="#ThirdFloor" id="ThirdFloorTab" role="tab" data-toggle="tab">
                    <i class="fa fa-cog">3rd floor map - Console/$2000 CSGO/BYOC/Halo 5/Destiny/Extra Life</i>
                </a>
            </li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <form class="form-inline pull-left" role="search">
                <div class="form-inline">
                    <input id="Mapsearch" type="text" placeholder="Username to find" />
                    <button id="Mapsearchbutton" class="btn btn-default " type="button">Search</button>
                </div>
            </form>
            <div class="Count pull-left">
                <h3>There are currently <%= count %> gamers locked in for the LAN</h3>
            </div>
            <div class="btn-group pull-right">
                <button id="Legend" class="btn btn-default pull-right dropdown-toggle" type="button" data-toggle="dropdown">Legend</button>
                <ul id="legenddropdown" class="dropdown-menu pull-right" role="menu">
                    <li>Current/Projector seat</br>
						<img src="/img/active.png" />
                        |
						<img src="/img/active_proj.png" />
                    </li>
                    <li class="divider"></li>
                    <li>Occupied/Projector seat</br>
						<img src="/img/occupied.png" />
                        |
						<img src="/img/occupied_proj.png" />
                    </li>
                    <li class="divider"></li>
                    <li>Empty/Projector seat</br>
						<img src="/img/empty.png" />
                        |
						<img src="/img/projector.png" />
                    </li>
                    <li class="divider"></li>
                    <li>
                        <img src="/img/reserved.png" />
                        Reserved seat</li>

                </ul>
            </div>
            <%if (SessionVariables.registrationBlocked)
                {%>
            <div align="center">
                <br />
                <br />
                <br />
                <h2>There are currently no events available for registration, please check back closer to the event date or when the announcement email has been sent.</h2>
            </div>
            <%} %>
            <%else
                { %>
            <%-- First Floor Map --%>
            <div class="tab-pane fade" id="FirstFloor">
                <%if (String.IsNullOrEmpty(SessionVariables.UserName))
                    {%>
                <div id="viewport">
                    <script async>


                        var viewport,
                            currentUser = null
                        function initialize() {
                            viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
                            viewport.updateMarkers(people, filtered);
                        }
                        google.maps.event.addDomListener(window, "load", initialize);
                    </script>
                </div>
                <%} %>
                <%else
                    { %>
                <div id="viewport">
                    <script async>
                        var viewport,
							currentUser = "<%= SessionVariables.UserName.ToLower() %>"
                        function initialize() {
                            viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
                            viewport.updateMarkers(people, filtered);
                        }
                        google.maps.event.addDomListener(window, "load", initialize);
                    </script>
                </div>
                <%} %>
            </div>
            <%-- Expo center Map --%>
            <div class="tab-pane fade active in" id="KCExpoFloor">
                <%if (String.IsNullOrEmpty(SessionVariables.UserName))
                    {%>
                <div id="viewport2">
                    <script async2>

                        var viewport2,
                            currentUser = null
                        function initialize2() {
                            viewport2 = new GameOn2.SeatingMap(document.getElementById("viewport2"), seats2, currentUser);
                            viewport2.updateMarkers(people, filtered);
                        }
                        google.maps.event.addDomListener(window, "load", initialize2);
                    </script>
                </div>
                <%} %>
                <%else
                    { %>
                <div id="viewport2">
                    <script async2>
                        var viewport2,
							currentUser = "<%= SessionVariables.UserName.ToLower() %>"
                        function initialize2() {
                            viewport2 = new GameOn2.SeatingMap(document.getElementById("viewport2"), seats2, currentUser);
                            viewport2.updateMarkers(people, filtered);
                        }
                        google.maps.event.addDomListener(window, "load", initialize2);
                    </script>
                </div>
                <%} %>
            </div>
            <%-- Third Floor Map --%>
            <div class="tab-pane fade" id="ThirdFloor">
                <%if (String.IsNullOrEmpty(SessionVariables.UserName))
                    {%>
                <div id="viewport3">
                    <script async3>

                        var viewport3,
                            currentUser = null
                        function initialize3() {
                            viewport3 = new GameOn3.SeatingMap(document.getElementById("viewport3"), seats3, currentUser);
                            viewport3.updateMarkers(people, filtered);
                        }
                        google.maps.event.addDomListener(window, "load", initialize3);
                    </script>
                </div>
                <%} %>
                <%else
                    { %>
                <div id="viewport3">
                    <script async3>
                        var viewport3,
							currentUser = "<%= SessionVariables.UserName.ToLower() %>"
                        function initialize3() {
                            viewport3 = new GameOn3.SeatingMap(document.getElementById("viewport3"), seats3, currentUser);
                            viewport3.updateMarkers(people, filtered);
                        }
                        google.maps.event.addDomListener(window, "load", initialize3);
                    </script>
                </div>
                <%} %>
            </div>
            <%} %>
        </div>
    </div>
    <script async2>
        seats2 = <%=seats2%>
                filtered = [];
        $(document).ready(function () {
            $('form input').keydown(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    var found = [];
                    var value = $(this).val().toLowerCase();
                    $.grep(people, function (n) {
                        if (value != "") {
                            var index = n.title.indexOf(value);
                            if (index != -1) {
                                //filtered.push(people.get(index));
                                found.push(n);
                            }
                        }
                    });
                    filtered = found;
                    viewport2.updateMarkers(people, filtered);
                }
            });
            $('#Mapsearchbutton').click(function (event) {
                event.preventDefault();
                var found = [];
                var value = $('#Mapsearch').val().toLowerCase();
                $.grep(people, function (n) {
                    if (value != "") {
                        var index = n.title.indexOf(value);
                        if (index != -1) {
                            //filtered.push(people.get(index));
                            found.push(n);
                        }
                    }
                });
                filtered = found;
                viewport2.updateMarkers(people, filtered);
            });
        });
    </script>
    <script async>
        var people = <%=people%>
        seats = <%=seats%>
                filtered = [];
        $(document).ready(function () {
            $('form input').keydown(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    var found = [];
                    var value = $(this).val().toLowerCase();
                    $.grep(people, function (n) {
                        if (value != "") {
                            var index = n.title.indexOf(value);
                            if (index != -1) {
                                //filtered.push(people.get(index));
                                found.push(n);
                            }
                        }
                    });
                    filtered = found;
                    viewport.updateMarkers(people, filtered);
                }
            });
            $('#Mapsearchbutton').click(function (event) {
                event.preventDefault();
                var found = [];
                var value = $('#Mapsearch').val().toLowerCase();
                $.grep(people, function (n) {
                    if (value != "") {
                        var index = n.title.indexOf(value);
                        if (index != -1) {
                            //filtered.push(people.get(index));
                            found.push(n);
                        }
                    }
                });
                filtered = found;
                viewport.updateMarkers(people, filtered);
            });
        });
    </script>
    <script async3>
        var seats3 = <%=seats3%>
                filtered = [];
        $(document).ready(function () {
            $('form input').keydown(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    var found = [];
                    var value = $(this).val().toLowerCase();
                    $.grep(people, function (n) {
                        if (value != "") {
                            var index = n.title.indexOf(value);
                            if (index != -1) {
                                //filtered.push(people.get(index));
                                found.push(n);
                            }
                        }
                    });
                    filtered = found;
                    viewport3.updateMarkers(people, filtered);
                }
            });
            $('#Mapsearchbutton').click(function (event) {
                event.preventDefault();
                var found = [];
                var value = $('#Mapsearch').val().toLowerCase();
                $.grep(people, function (n) {
                    if (value != "") {
                        var index = n.title.indexOf(value);
                        if (index != -1) {
                            //filtered.push(people.get(index));
                            found.push(n);
                        }
                    }
                });
                filtered = found;
                viewport3.updateMarkers(people, filtered);
            });
        });
    </script>
</asp:Content>
