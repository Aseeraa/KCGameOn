<%@ Page Title="Maps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="KCGameOn.Map" %>
<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8">
    <link href="css/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <form class="form-inline" role="search">
  <div class="form-inline">
    <input id="Mapsearch" type="text" placeholder="Username to find"/>
  </div>
</form>
    <script>
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
                    debugger;
                    filtered = found;
                    viewport.updateMarkers(people, filtered);
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
            currentUser = null
                    function initialize() {
                        viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
                        viewport.updateMarkers(people, filtered);
                    }
        google.maps.event.addDomListener(window, "load", initialize);
    </script>
    <%} %>
        <%else { %>
    <script>
        var viewport,
            currentUser = "<%= SessionVariables.UserName.ToLower() %>"
        function initialize() {
            viewport = new GameOn.SeatingMap(document.getElementById("viewport"), seats, currentUser);
            viewport.updateMarkers(people, filtered);
        }
        google.maps.event.addDomListener(window, "load", initialize);
        </script>
    <%} %>
</asp:Content>




