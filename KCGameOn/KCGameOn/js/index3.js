
(function (GameOn3, gmaps) {
    "use strict";

    // Custom Map
    GameOn3.CustomMap = function (mapDivId) {
        var map,
            icons = {},
            markers = [],
            markerEvents = {};

        initIcons();
        createMap();
        setCustomMapType();

        var setMarkerEvents = function (events) {
            markerEvents = events;
        };

        var addMarker = function (latLng, id, title) {
            if (isMarkerIdTaken(id))
                return;

            var marker = new gmaps.Marker({
                map: map,
                position: latLng,
                title: title,
                icon: icons.empty,
                zIndex: google.maps.Marker.MAX_ZINDEX - 1
            });
            marker.id = id;
            markers.push(marker);

            if (markerEvents.hasOwnProperty("mouseover"))
                gmaps.event.addListener(marker, "mouseover", function () { markerEvents.mouseover({ marker: marker }); });
            if (markerEvents.hasOwnProperty("mouseout"))
                gmaps.event.addListener(marker, "mouseout", function () { markerEvents.mouseout({ marker: marker }); });
            if (markerEvents.hasOwnProperty("click"))
                gmaps.event.addListener(marker, "click", function () { markerEvents.click({ marker: marker }); });
            if (markerEvents.hasOwnProperty("rightclick"))
                gmaps.event.addListener(marker, "rightclick", function () { markerEvents.rightclick({ marker: marker }); });
            if (markerEvents.hasOwnProperty("dblclick"))
                gmaps.event.addListener(marker, "dblclick", function () { markerEvents.dblclick({ marker: marker }); });
        };

        var deleteMarker = function (id) {
            for (var i = 0; i < markers.length; i++) {
                if (markers[i].id == id) {
                    markers[i].setMap(null);
                    markers.splice(i, 1);
                    return;
                }
            };
        };

        var loadMarkers = function (points) {
            points.forEach(function (point) {
                addMarker(new gmaps.LatLng(point.lat, point.lng), point.id, point.title);
            });
        };

        function initIcons() {
            var base = {
                size: new gmaps.Size(20, 20),
                origin: new gmaps.Point(0, 0),
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
                size: new gmaps.Size(22, 22), origin: base.origin, anchor: base.anchor
            };
            icons.proj_found = {
                url: "/img/proj_found.png",
                size: new gmaps.Size(22, 22), origin: base.origin, anchor: base.anchor
            };
        }

        function createMap() {
            var options = {
                draggable: false,
                center: new gmaps.LatLng(84.55, -171.5),
                zoom: 7,
                disableDefaultUI: true,
                backgroundColor: '#DDDDDD'
            };
            map = new gmaps.Map(mapDivId, options);
        }

        function setCustomMapType() {
            var images = ["7_1_1", "7_1_2", "7_1_3", "7_2_1", "7_2_2", "7_2_3", "7_3_1", "7_3_2", "7_3_3", "7_4_1", "7_4_2", "7_4_3", "7_5_1", "7_5_2", "7_5_3", "7_6_1", "7_6_2", "7_6_3"];
            var options = {
                getTileUrl: function (coord, zoom) {
                    var normalizedCoord = getNormalizedCoord(coord, zoom);
                    if (!normalizedCoord)
                        return null;
                    var image = zoom + "_" + normalizedCoord.x + "_" + normalizedCoord.y;
                    if ($.inArray(image, images) != -1) {
                        var imageURL = "/img/3rdfloor/" + image + ".png";
                        return imageURL;
                    }
                    //if (exists(imageURL)) {
                    //    return imageURL;
                    //}
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
    GameOn3.PlacementMap = function (mapDivId, seats) {
        var world = new GameOn3.CustomMap(mapDivId);
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

        var dump = function () {
            var points = [];
            world.markers.forEach(function (marker) {
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
    GameOn3.SeatingMap = function (mapDivId, seats, currentUser) {
        var projectors = ["59", "60", "64"];
        //var userFound = found;
        var world = new GameOn3.CustomMap(mapDivId);

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
            if (currentUser == null) {
                //bootbox.dialog("Please login to choose a seat.", [
                //    {
                //        "label": "Login",
                //        "class": "primary",
                //        "callback": function () {
                //            window.open('/Account/Login.aspx', '_self');
                //        }
                //    }, {
                //        "label": "Cancel",
                //        "class": "danger",
                //        "callback": function () {
                //        }
                //    }]);
                //bootbox.dialog({
                //    message: "Please login to choose a seat.",
                //    title: "Seating",
                //    buttons: {
                //        danger: {
                //            label: "Cancel",
                //            className: "btn-danger",
                //            callback: function () {
                //            }
                //        },
                //        main: {
                //            label: "Login",
                //            className: "btn-primary",
                //            callback: function () {
                //                window.open('/Account/Login.aspx', '_self');
                //            }
                //        }
                //    }
                //});
                $("#login").modal('show');
            }
        });
        world.setMarkerEvents({
            click: function (e) {
                if (currentUser != null) {
                    $.ajax({
                        type: "POST",
                        url: "Map.aspx/checkPaid",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"})
                        .success(function(data)
                        {
                            debugger;
                            if (data.d == "true") {
                                world.markers.forEach(function (marker) {
                                    if (marker.title == currentUser) {
                                        if ($.inArray(marker.id, projectors) != -1) {
                                            marker.title = "Projector";
                                            marker.setIcon(world.icons.projector);
                                        }
                                        else {
                                            marker.title = "Empty";
                                            marker.setIcon(world.icons.empty);
                                        }
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
                                });

                                //Makes call to set user to the current seat.
								if(e.marker.title == currentUser)
								{
                                var user = {};
                                user.Username = currentUser;
                                user.SeatID = e.marker.id;
                                $.ajax({
                                    type: "POST",
                                    url: "Map.aspx/SaveUser",
                                    data: '{user: ' + JSON.stringify(user) + '}',
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                })
                                .done(function (data) {
                                    //successBox();
                                    $("#success").modal('show');
                                })
                                .fail(function () {
                                    //failedBox();
                                    $("#failure").modal('show');
                                });
								}
								else
								{
								$("#failure").modal('show');
								}
                            }
                            else {
                                $("#payToSit").modal('show');
                                //bootbox.dialog({
                                //    message: "Please pay to choose a seat.  If you have already paid using cash or PayPal, please wait a few minutes before trying to sit again.  If the issue persists contact an admin.",
                                //    title: "Seating",
                                //    buttons: {
                                //        danger: {
                                //            label: "Cancel",
                                //            className: "btn-danger",
                                //            callback: function () {
                                //            }
                                //        },
                                //        main: {
                                //            label: "PayPal",
                                //            className: "btn-primary",
                                //            callback: function () {
                                //                window.open('EventRegistration.aspx', '_self');
                                //            }
                                //        }
                                //    }
                                //});
                            }
                        })
                        .fail(function(error) {
                            alert(error.message);
                        });
                    
                }
                else {
                    bootbox.dialog({
                        message: "Please login to choose a seat.",
                        title: "Seating",
                        buttons: {
                            danger: {
                                label: "Cancel",
                                className: "btn-danger",
                                callback: function () {
                                }
                            },
                            main: {
                                label: "Login",
                                className: "btn-primary",
                                callback: function () {
                                    window.open('/Account/Login.aspx', '_self');
                                }
                            }
                        }
                    });
                }
            },
            rightclick: function (e) {
                if (currentUser != null) {
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
                    var user = {};
                    user.Username = currentUser;
                    user.SeatID = e.marker.id;
                    $.ajax({
                        type: "POST",
                        url: "Map.aspx/DeleteUser",
                        data: '{user: ' + JSON.stringify(user) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        sucess: function () {
                            //alert("You have been successfully seated.");
                            //window.location.reload();
                            $("#success").modal('show');
                        },
                        error: function () {
                            //alert("Failed to sit down, please inform an administrator or try again in a few minutes.");
                            //window.location.reload();
                            $("#failure").modal('show');
                        }
                    });
                }
                else {
                }
            }
        });

        function successBox() {
            bootbox.dialog({
                message: "You have successfully been seated!",
                title: "Seating",
                buttons: {
                    main: {
                        label: "Alright!",
                        className: "btn-primary",
                        callback: function () {
                        }
                    }
                }
            });
        }

        function failedBox() {
            bootbox.dialog({
                message: "Failed to sit down, please refresh the map page and try again.",
                title: "Seating",
                buttons: {
                    main: {
                        label: "Ok!",
                        className: "btn-primary",
                        callback: function () {
                        }
                    }
                }
            });
        }

        world.loadMarkers(seats);

        function pluckByName(inArr, name) {
            for (var ind = 0; ind < inArr.length; ind++) {
                if (inArr[ind].title == name && name != "") {
                    return true;
                }
            }
            return false;
        }
        var zInd = google.maps.Marker.MAX_ZINDEX + 1;
        var updateMarkers = function (people, filtered) {
            people.forEach(function (person) {
                world.markers.forEach(function (marker) {
                    if (marker.id == person.id) {
                        if ($.inArray(marker.id, projectors) == -1 && !pluckByName(filtered, person.title)) {
                            marker.title = person.title;
                            marker.setIcon(world.icons.full);
                        }
                        else if (marker.id == person.id && $.inArray(marker.id, projectors) != -1 && pluckByName(filtered, person.title)) {
                            marker.setIcon(world.icons.proj_found);
                            marker.zIndex = zInd;
                        }
                        else if (marker.id == person.id && pluckByName(filtered, person.title) && $.inArray(marker.id, projectors) == -1) {
                            marker.title = person.title;
                            marker.setIcon(world.icons.found);
                            marker.zIndex = zInd;
                        }
                        else {
                            marker.title = person.title;
                            marker.setIcon(world.icons.occupied_projector);
                        }
                    }
                    if (marker.title == currentUser) {
                        if ($.inArray(marker.id, projectors) != -1)
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

})(window.GameOn3 = window.GameOn3 || {}, google.maps);

