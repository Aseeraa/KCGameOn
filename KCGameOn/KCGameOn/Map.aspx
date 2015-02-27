<%@ Page Title="Maps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="KCGameOn.Map" %>
<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8">
    <link href="css/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <form class="form-inline" role="search">
  <div class="form-inline">
    <input id="Mapsearch" type="text" class="form-control" placeholder="Username to find">
  </div>
</form>
    <script>
        $(document).ready(function () {
            $('#Mapsearch').typeahead({
                source: function (query) {
                    $.ajax({
                        type: "POST",
                        url: "Map.aspx/FindUser",
                        data: '{user: ' + JSON.stringify(typeahead) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        sucess: function (response) {
                            debugger;
                            found = response;
                        },
                        error: function () {
                        }
                    });
                }
            });
        });
    </script>
        <div id="viewport"></div>
    <script src="js/bootbox.js"></script>
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/src/infobox.js"></script>
    <script src="js/index.js"></script>
    <%if (String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <script>

        var viewport,
            currentUser = null,
            seats = <%=seats%>
        people = <%=people%>
                    function initialize() {
                        viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
                        viewport.updateMarkers(people);
                    }
        google.maps.event.addDomListener(window, "load", initialize);
    </script>
    <%} %>
        <%else { %>
    <script>
        var viewport,
            currentUser = "<%= SessionVariables.UserName.ToLower() %>",
            seats = <%=seats%>
        people = <%=people%>
        function initialize() {
            viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
            viewport.updateMarkers(people);
        }
        google.maps.event.addDomListener(window, "load", initialize);
        </script>
    <%} %>
</asp:Content>




