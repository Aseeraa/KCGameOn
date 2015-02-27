(function(GameOn, gmaps) {
    "use strict";

    // Custom Map
    GameOn.CustomMap = function(mapDivId) {
        var map,
            icons = {},
            markers = [],
            markerEvents = {};

        initIcons();
        createMap();
        setCustomMapType();

        var setMarkerEvents = function(events) {
            markerEvents = events;
        };

        var addMarker = function(latLng, id, title) {
            if (isMarkerIdTaken(id))
                return;

            var marker = new gmaps.Marker({
                map: map,
                position: latLng,
                title: title,
                icon: icons.empty
            });
            marker.id = id;
            markers.push(marker);

            if (markerEvents.hasOwnProperty("mouseover"))
                gmaps.event.addListener(marker, "mouseover", function() { markerEvents.mouseover({ marker: marker }); });
            if (markerEvents.hasOwnProperty("mouseout"))
                gmaps.event.addListener(marker, "mouseout", function() { markerEvents.mouseout({ marker: marker }); });
            if (markerEvents.hasOwnProperty("click"))
                gmaps.event.addListener(marker, "click", function() { markerEvents.click({ marker: marker }); });
            if (markerEvents.hasOwnProperty("rightclick"))
                gmaps.event.addListener(marker, "rightclick", function () { markerEvents.rightclick({ marker: marker }); });
            if (markerEvents.hasOwnProperty("dblclick"))
                gmaps.event.addListener(marker, "dblclick", function () { markerEvents.dblclick({ marker: marker }); });
        };

        var deleteMarker = function(id) {
            for (var i = 0; i < markers.length; i++) {
                if (markers[i].id == id) {
                    markers[i].setMap(null);
                    markers.splice(i, 1);
                    return;
                }
            };
        };

        var loadMarkers = function (points) {
            points.forEach(function(point) {
                addMarker(new gmaps.LatLng(point.lat, point.lng), point.id, point.title);
            });
        };

        function initIcons() {
            var base = {
                size: new gmaps.Size(20, 20),
                origin: new gmaps.Point(0,0),
                anchor: new gmaps.Point(12, 15)
            };
            icons.empty = {
                url: "/img/empty.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.full = {
                url: "/img/occupied.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.active = {
                url: "/img/active.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.reserved = {
                url: "/img/reserved.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.projector = {
                url: "/img/projector.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.occupied_projector = {
                url: "/img/occupied_proj.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.active_projector = {
                url: "/img/active_proj.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
            icons.found = {
                url: "/img/found.png",
                size: base.size, origin: base.origin, anchor: base.anchor
            };
        }

        function createMap() {
            var options = {
                draggable: false,
                center: new gmaps.LatLng(84.55, -171.5),
                zoom: 7,
                disableDefaultUI: true
            };
            map =  new gmaps.Map(mapDivId, options);
        }

        function setCustomMapType() {
            var options = {
                getTileUrl: function (coord, zoom) {
                    var normalizedCoord = getNormalizedCoord(coord, zoom);
                    if (!normalizedCoord)
                        return null;
                    var imageURL = "/img/tiles/" + zoom + "_" + normalizedCoord.x + "_" + normalizedCoord.y + ".png";
                    if (exists(imageURL)) {
                        return imageURL;
                    }
                },
                tileSize: new gmaps.Size(208, 208),
                maxZoom: 7,
                minZoom: 7
            };
            map.mapTypes.set("custom", new gmaps.ImageMapType(options));
            map.setMapTypeId("custom");
        }

        function exists(imageURL) {
            var http = new XMLHttpRequest();
            http.open('HEAD', imageURL, false);
            http.send();
            return http.status == 200;
        }


        function getNormalizedCoord(coord, zoom) {
            var y = coord.y;
            var x = coord.x;
            var tileRange = 1 << zoom;
            if (y < 0 || y >= tileRange)
                return null;
            if (x < 0 || x >= tileRange)
                return null;
            return {
                x: x,
                y: y
            };
        }

        function isMarkerIdTaken(id) {
            for (var i = 0; i < markers.length; i++) {
                if (markers[i].id == id) {
                    alert("That id is already taken!");
                    return true;
                }
            };
            return false;
        }

        return {
            map: map,
            icons: icons,
            markers: markers,
            setMarkerEvents: setMarkerEvents,
            addMarker: addMarker,
            deleteMarker: deleteMarker,
            loadMarkers: loadMarkers
        };
    };

    // Placement Map
    GameOn.PlacementMap = function (mapDivId, seats) {
        var world = new GameOn.CustomMap(mapDivId);
        //world.setMarkerEvents({
        //    click: function(e) {
        //        var marker = e.marker;
        //        if (marker.title == "Empty") {
        //            marker.title = "Reserved";
        //            marker.setIcon(world.icons.reserved);
        //        } else {
        //            marker.title = "Empty";
        //            marker.setIcon(world.icons.empty);
        //        }
        //    },
        //    rightclick: function(e) {
        //        world.deleteMarker(e.marker.id);
        //    }
        //});
        //gmaps.event.addListener(world.map, "click", function(e) {
        //    var id = prompt("Seat id:");
        //    if (id == null || id == "")
        //        return;
        //    world.addMarker(e.latLng, id, "Empty");
        //});
        //world.loadMarkers(seats);

        var dump = function() {
            var points = [];
            world.markers.forEach(function(marker) {
                var point = {
                    id: marker.id,
                    title: marker.title,
                    lat: marker.position.lat(),
                    lng: marker.position.lng()
                };
                points.push(point);
            });
            return JSON.stringify(points);
        };

        return {
            dump: dump
        };
    };

    // Seating Map
    GameOn.SeatingMap = function(mapDivId, seats, currentUser) {
        var projectors = ["138", "140", "148", "145", "143", "127", "118", "116"];
        //var userFound = found;
        var world = new GameOn.CustomMap(mapDivId);
        //var infowindow = new google.maps.InfoWindow();
        //var infobox = new InfoBox({
        //    content: '<button class="reserve-button" onclick="myFunction()">Reserve</button>',
        //    disableAutoPan: false,
        //    maxWidth: 150,
        //    pixelOffset: new google.maps.Size(0, 0),
        //    zIndex: null,
        //    boxStyle: {
        //        background: "#FFFFFF",
        //        opacity: 0.75,
        //        width: "80px",
        //        height: "30px",
        //        padding: "2px"
        //    },
        //    closeBoxMargin: "2px 2px 2px 2px",
        //    closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif",
        //    infoBoxClearance: new google.maps.Size(1, 1)
        //});
        //infowindow.setContent('<p><button onclick="myFunction()">Reserve</button><p>');
        gmaps.event.addListener(world.map, "click", function (e) {
            bootbox.dialog("Please login to choose a seat.", [
                {
                    "label": "Login",
                    "class": "primary",
                    "callback": function () {
                        window.open('/Account/Login.aspx', '_self');
                    }
                },{
                "label": "Cancel",
                "class": "danger",
                "callback": function () {
                }
            }]);
            //prompt(e.latLng);
            //var id = prompt("Seat id:");
            //if (id == null || id == "")
            //    return;
            //world.addMarker(e.latLng, id, "Empty");
        });
        //index 137, 139, 147, 144, 142, 126, 117, 115

        if (currentUser != null) {
            world.setMarkerEvents({
                click: function (e) {
                    world.markers.forEach(function (marker) {
                        if (marker.title == currentUser) {
                            if ($.inArray(marker.id, projectors) != -1) {
                                marker.title = "Projector";
                                marker.setIcon(world.icons.projector);
                            }
                            else{
                                marker.title = "Empty";
                                marker.setIcon(world.icons.empty);
                            }
                            //if (previous == "Projector") {
                            //    marker.title = "Projector";
                            //    marker.setIcon(world.icons.projector);
                            //}
                            //else {
                            //    marker.title = "Empty";
                            //    marker.setIcon(world.icons.empty);
                            //}
                            //infobox.close();
                        }
                        else if (e.marker.title == "Empty") {
                            //infowindow.open(world.map, e.marker);
                            //infobox.open(world.map, e.marker);
                            e.marker.title = currentUser;
                            e.marker.setIcon(world.icons.active);
                        }
                        else if (e.marker.title == "Projector") {
                            e.marker.title = currentUser;
                            e.marker.setIcon(world.icons.active_projector);
                        }
                        //var infowindow = new google.maps.InfoWindow({
                        //    content: " "
                        //});
                        //google.maps.event.addListener(marker, 'click', function() {
                        //    infowindow.setContent('<p>This is a projector seat, projector is provided.</p>' +
                        //                '<button onclick="myFunction()">Sit Down</button>');
                        //    infowindow.open(gmaps, marker);
                        //});
                    });
                    //Makes call to set user to the current seat.
                    var user = {};
                    user.Username = currentUser;
                    user.SeatID = e.marker.id;
                    $.ajax({
                        type: "POST",
                        url: "Map.aspx/SaveUser",
                        data: '{user: ' + JSON.stringify(user) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        sucess: function (response) {
                            alert("You have been successfully seated.");
                            window.location.reload();
                        },
                        error: function () {
                            alert("Failed to sit down, please inform an administrator or try again in a few minutes.");
                            window.location.reload();
                        }
                    });
                },
                rightclick: function (e) {
                    world.markers.forEach(function (marker) {
                        if (e.marker.title == currentUser) {
                            if ($.inArray(e.marker.id, projectors) != -1) {
                                e.marker.title = "Projector";
                                e.marker.setIcon(world.icons.projector);
                            }
                            else {
                                e.marker.title = "Empty";
                                e.marker.setIcon(world.icons.empty);
                            }
                        }
                    });
                }
            });
        }
        world.loadMarkers(seats);

        var updateMarkers = function(people) {
            people.forEach(function(person) {
                world.markers.forEach(function(marker) {
                    if (marker.id == person.id) {
                        if ($.inArray(marker.id, projectors) == -1) {
                            marker.title = person.title;
                            marker.setIcon(world.icons.full);
                        }
                        else {
                            marker.title = person.title;
                            marker.setIcon(world.icons.occupied_projector);
                        }
                    }
                    if (marker.title == currentUser) {
                        if ($.inArray(marker.id,projectors) != -1)
                            marker.setIcon(world.icons.active_projector);
                        else
                            marker.setIcon(world.icons.active);
                    }
                    if (marker.title == "Reserved")
                        marker.setIcon(world.icons.reserved);
                    if (marker.title == "Projector")
                        marker.setIcon(world.icons.projector);
                    if (marker.title == "Occupied Projector") {
                        marker.title = currentUser;
                        marker.setIcon(world.icons.occupied_projector);
                    }
                });
            });
        };
        return {
            updateMarkers: updateMarkers
        };
    };

})(window.GameOn = window.GameOn || {}, google.maps);