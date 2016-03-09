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

        .modal-content, .modal-dialog, .modal-footer {
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
    <script>
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
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Success</h4>
                </div>
                <div class="modal-body" id="successMessage">
                    <p>You have been successfully seated.</p>
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
    <center><h3 style="color: red;"><asp:Label ID="previousPage" Text="" runat="server" /></h3></center>
    <div class="">
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
    </div>

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
    <%if (!SessionVariables.registrationBlocked)
    {%>
      <%if (String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <div id="viewport">

        <script async src="js/bootbox.js?v=1.0"></script>
        <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
        <script src="js/index.js?v=1.0"></script>
        <script async>

            var viewport,
                currentUser = null
            function initialize() {
                viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
                viewport.updateMarkers(people, filtered);
            }
            google.maps.event.addDomListener(window, "load", initialize);
        </script>
        <div>
            <%} %>
            <%else
            { %>
            <div id="viewport">

                <script async src="js/bootbox.js?v=1.0"></script>
                <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
                <script src="js/index.js?v=1.0"></script>
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
        <%} %>
        <%else
        { %>
		<div align=center><br /><br /><br />
        <h2>There are currently no events available for registration, please check back closer to the event date or when the announcement email has been sent.</h2>
        </div>
		
        <%} %>
</asp:Content>




