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

        <script async src="js/bootbox.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
        <script src="js/index.js"></script>
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

                <script async src="js/bootbox.js"></script>
                <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
                <script src="js/index.js"></script>
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

        <h2>There are currently no events available for registration, please check back closer to the event date or when the announcement email has been sent.</h2>
        <br />
        <%} %>
</asp:Content>




