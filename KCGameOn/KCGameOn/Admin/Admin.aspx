﻿<%@ Page Title="Admin Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="KCGameOn.Admin.Admin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8" />
    <style>
        .modal-content, .modal-dialog, .modal-footer {
            background: #282828;
        }

        .modal-backdrop.in, .modal-backdrop {
            opacity: 0.5 !important;
        }

        div.dataTables_info {
            color: #33b5e5;
        }

        a {
            color: #33b5e5;
        }

        #adminusertable {
        }

        div.dataTables_filter label {
            color: #33b5e5;
            font-family: inherit;
        }

        div.dataTables_length label {
            color: #33b5e5;
        }

        #Name {
            color:white;
            align-content:center;
            font-size:large;
        }
    </style>
    <script src="js/bootbox.js?v=1.0"></script>
    <link rel="stylesheet" type="text/css" href="css/black/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="https://datatables.net/media/blog/bootstrap/DT_bootstrap.css">
    <script type="text/javascript" language="javascript" src="https://datatables.net/release-datatables/media/js/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="https://datatables.net/release-datatables/media/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            var users = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(usernames)%>
                namelist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(names)%>
                ulist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(userlist)%>
                eventids = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(eventids)%>



            $(loadDropdowns);

            $('#userDropdown').on('change', function () {
                var user = $(this).val();
                $.each(ulist, function (key, value) {
                    if (value.Username == user) {
                        $("#nameDropdown").val(value.First + ' ' + value.Last);
                        return false;
                        //$("#lastDropdown").val(value.Last);
                    }
                    else {
                        $("#nameDropdown").val("None");
                    }
                });
            });

            $('#nameDropdown').on('change', function () {
                var name = $(this).val();
                var split = name.split(" ");
                var first = split[0];
                var last = split[1];
                $.each(ulist, function (key, value) {
                    if (value.First == first && value.Last == last) {
                        $("#userDropdown").val(value.Username);
                        return false;
                    }
                    else {
                        $("#userDropdown").val("None");
                    }
                });
            });

            function loadDropdowns() {
                for (i = 0; i < users.length; i++) {
                    $('<option/>').val(users[i]).html(users[i]).appendTo('#userDropdown.dropdown');
                }

                for (i = 0; i < namelist.length; i++) {
                    $('<option/>').val(namelist[i]).html(namelist[i]).appendTo('#nameDropdown.dropdown');
                }

                for (i = 0; i < eventids.length; i++) {
                    $('<option/>').val(eventids[i]).html(eventids[i]).appendTo('#eventDropdown.dropdown');
                }
            };

            $('#cash').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                var name = $('#nameDropdown').val();
                var userObject = [];
                var payments = [];
                userObject.push(user);
                userObject.push(name);
                userObject.push("Cash");
                payments.push(userObject);
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/addPayment",
                    data: "{'data':'" + JSON.stringify(payments) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function () {
                        //$("#success").modal('show');
                        alert("Added the user payment to the database like a boss!");
                    })
                    .fail(function () {
                        //$("#failure").modal('show');
                        alert("Unable to add user payment to the database, contact Dan (or applicable engineer).");
                    });
            });

            $('#other').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                var name = $('#nameDropdown').val();
                var userObject = [];
                var payments = [];
                userObject.push(user);
                userObject.push(name);
                userObject.push("Volunteer");
                payments.push(userObject);
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/addPayment",
                    data: "{'data':'" + JSON.stringify(payments) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function () {
                        //$("#success").modal('show');
                        alert("Added the user payment to the database like a boss!");
                    })
                    .fail(function () {
                        //$("#failure").modal('show');
                        alert("Unable to add user payment to the database, contact Dan (or applicable engineer).");
                    });
            });
            
            $('#tournamentwinner').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                var name = $('#nameDropdown').val();
                var userObject = [];
                var payments = [];
                userObject.push(user);
                userObject.push(name);
                userObject.push("TournamentWinner");
                payments.push(userObject);
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/addPayment",
                    data: "{'data':'" + JSON.stringify(payments) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function () {
                        //$("#success").modal('show');
                        alert("Added the user payment to the database like a boss!");
                    })
                    .fail(function () {
                        //$("#failure").modal('show');
                        alert("Unable to add user payment to the database, contact Dan (or applicable engineer).");
                    });
            });

            $('#archiveEvent').click(function (event) {
                event.preventDefault();
                var event = $('#eventDropdown').val();
             
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/archiveEvent",
                    data: "{'data':'" + JSON.stringify(event) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function () {
                        //$("#success").modal('show');
                        alert("Successfully archived event like a boss!");
                    })
                    .fail(function () {
                        //$("#failure").modal('show');
                        alert("You lose, contact Dan (or applicable engineer).");
                    });
            });

            $('#addraffle').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/addRaffle",
                    data: "{'data':'" + JSON.stringify(user) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function () {
                        //$("#success").modal('show');
                        alert("Added the user raffle to the database like a boss!");
                    })
                    .fail(function () {
                        //$("#failure").modal('show');
                        alert("Unable to add user raffle to the database, contact Dan (or applicable engineer).");
                    });
            });

            /* Generate a random number for raffle drawing */
            $('#randNum').click(function (event) {
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/getRaffleWinner",
                    data: "{'data':''}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text"
                })
                        .done(function (winner) {
                            var winnerName = JSON.parse(winner);
                            document.getElementById('winner').innerHTML = "Winner: " + winnerName.d;
                        })
                        .fail(function () {
                            alert("We messed up.  It didn't work.  Etc.");
                        });
            });

            /* Generate a random number for raffle drawing */
            $('#randRepick').click(function (event) {
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/getRaffleWinner",
                    data: "{'data':'repick'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text"
                })
                        .done(function (winner) {
                            var winnerName = JSON.parse(winner);
                            document.getElementById('winner').innerHTML = "" + winnerName.d;
                            alert("Previous winner marked as a no show, and we're ready to pick another!");
                        })
                        .fail(function () {
                            //$("#failure").modal('show');
                            alert("We messed up.  It didn't work.  Etc.");
                        });
            });

            /* Control the Spin button */
            $('#Spin').click(function (event) {
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/loyalty",
                    data: "{'data':'spin'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text"
                })
                        .done(function (val) {
                            if (val != "Fail") {

                                //Refreshing image using javascript
                                var img = $('#prize');
                                var src = img.attr('src');
                                var i = src.indexOf('?timestamp=');
                                src = i != -1 ? src.substring(0, i) : src;
                                var d = new Date();
                                img.attr('src', "<%=imageSource%>?timestamp=" + d.getTime());
                                //End refresh image

                                document.getElementById('loyaltyWinner').style.color = "#06db06";
                                var winnerName = JSON.parse(val);
                                document.getElementById('Name').innerHTML = "" + winnerName.d;
                            } else
                                alert("User database entry not updated.  Check this guy out later.");
                        })
                        .fail(function () {
                            alert("We messed up.  It didn't work.  Etc.");
                        });
            });

            /* Control the Skip button */
            $('#Skip').click(function (event) {
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/loyalty",
                    data: "{'data':'skipSelection'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text"
                })
                        .done(function (val) {
                            if (val != "Fail") {
                                document.getElementById('loyaltyWinner').style.color = "#06db06";
                                var winnerName = JSON.parse(val);
                                document.getElementById('Name').innerHTML = "" + winnerName.d;
                            } else
                                alert("We messed up.  It didn't work.  Etc.");
                        })
                        .fail(function () {
                            alert("We messed up.  It didn't work.  Etc.");
                        });
            });

            $('#blockRegistration').click(function (event) {
                debugger;
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/blockUnblock",
                    data: "{'data':'block'}",
                    dataType: 'text',
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        alert("Registration has been blocked.");
                    },
                    failure: function () {
                        alert("Failed to block registration.");
                    }
                });
            });

            $('#sendBarcodes').click(function (event) {
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/sendBarcodes",
                    data: "{'data':''}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "text"
                })
                        .done(function () {
                            alert("Barcode emails sent.");
                        })
                        .fail(function () {
                            alert("Failed to send barcodes.");
                        });
            });

           

            $('#unblockRegistration').click(function (event) {
                event.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/blockUnblock",
                    data: "{'data':'unblock'}",
                    dataType: 'text',
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        alert("Registration has been unblocked.");
                    },
                    failure: function () {
                        alert("Failed to unblock registration.");
                    }
                });

            });

            $('#verifyPayment').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                var name = $('#nameDropdown').val();
                var userObject = [];
                var payments = [];
                userObject.push(user);
                userObject.push(name);
                payments.push(userObject);
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/validateKeys",
                    data: "{'data':'" + JSON.stringify(payments) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function () {
                        //$("#success").modal('show');
                        alert("Successfully cleared bad API keys and validate user.");
                    })
                    .fail(function () {
                        //$("#failure").modal('show');
                        alert("Failed to validate API keys.");
                    });
            });
        

            /* Default class modification */
            $.extend($.fn.dataTableExt.oStdClasses, {
                "sSortAsc": "header headerSortDown",
                "sSortDesc": "header headerSortUp",
                "sSortable": "header"
            });

            /* API method to get paging information */
            $.fn.dataTableExt.oApi.fnPagingInfo = function (oSettings) {
                return {
                    "iStart": oSettings._iDisplayStart,
                    "iEnd": oSettings.fnDisplayEnd(),
                    "iLength": oSettings._iDisplayLength,
                    "iTotal": oSettings.fnRecordsTotal(),
                    "iFilteredTotal": oSettings.fnRecordsDisplay(),
                    "iPage": Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength),
                    "iTotalPages": Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength)
                };
            }

            /* Bootstrap style pagination control */
            $.extend($.fn.dataTableExt.oPagination, {
                "bootstrap": {
                    "fnInit": function (oSettings, nPaging, fnDraw) {
                        var oLang = oSettings.oLanguage.oPaginate;
                        var fnClickHandler = function (e) {
                            e.preventDefault();
                            if (oSettings.oApi._fnPageChange(oSettings, e.data.action)) {
                                fnDraw(oSettings);
                            }
                        };

                        $(nPaging).addClass('pagination').append(
                            '<ul>' +
                                '<li class="prev disabled"><a href="#">&larr; ' + oLang.sPrevious + '</a></li>' +
                                '<li class="next disabled"><a href="#">' + oLang.sNext + ' &rarr; </a></li>' +
                            '</ul>'
                        );
                        var els = $('a', nPaging);
                        $(els[0]).bind('click.DT', { action: "previous" }, fnClickHandler);
                        $(els[1]).bind('click.DT', { action: "next" }, fnClickHandler);
                    },

                    "fnUpdate": function (oSettings, fnDraw) {
                        var iListLength = 5;
                        var oPaging = oSettings.oInstance.fnPagingInfo();
                        var an = oSettings.aanFeatures.p;
                        var i, j, sClass, iStart, iEnd, iHalf = Math.floor(iListLength / 2);

                        if (oPaging.iTotalPages < iListLength) {
                            iStart = 1;
                            iEnd = oPaging.iTotalPages;
                        }
                        else if (oPaging.iPage <= iHalf) {
                            iStart = 1;
                            iEnd = iListLength;
                        } else if (oPaging.iPage >= (oPaging.iTotalPages - iHalf)) {
                            iStart = oPaging.iTotalPages - iListLength + 1;
                            iEnd = oPaging.iTotalPages;
                        } else {
                            iStart = oPaging.iPage - iHalf + 1;
                            iEnd = iStart + iListLength - 1;
                        }

                        for (i = 0, iLen = an.length ; i < iLen ; i++) {
                            // Remove the middle elements
                            $('li:gt(0)', an[i]).filter(':not(:last)').remove();

                            // Add the new list items and their event handlers
                            for (j = iStart ; j <= iEnd ; j++) {
                                sClass = (j == oPaging.iPage + 1) ? 'class="active"' : '';
                                $('<li ' + sClass + '><a href="#">' + j + '</a></li>')
                                    .insertBefore($('li:last', an[i])[0])
                                    .bind('click', function (e) {
                                        e.preventDefault();
                                        oSettings._iDisplayStart = (parseInt($('a', this).text(), 10) - 1) * oPaging.iLength;
                                        fnDraw(oSettings);
                                    });
                            }

                            // Add / remove disabled classes from the static elements
                            if (oPaging.iPage === 0) {
                                $('li:first', an[i]).addClass('disabled');
                            } else {
                                $('li:first', an[i]).removeClass('disabled');
                            }

                            if (oPaging.iPage === oPaging.iTotalPages - 1 || oPaging.iTotalPages === 0) {
                                $('li:last', an[i]).addClass('disabled');
                            } else {
                                $('li:last', an[i]).removeClass('disabled');
                            }
                        }
                    }
                }
            });

            /* Table initialisation */
            $(document).ready(function () {
                $('#adminusertable').dataTable({
                    "sDom": "<'row'<'col-md-12'><'col-md-12'f>r>t<'row'<'col-md-12'i><'col-md-12'p>>",
                    "sPaginationType": "bootstrap",
                    "bLengthChange": false
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Success modal-->
    <div class="modal" id="success" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Success</h4>
                </div>
                <div class="modal-body" id="successMessage">
                    <p>Added the user payment to the database like a boss!</p>
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
                    <p>Unable to add user payment to the database, contact Dan (or applicable engineer).</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
        {
            if (SessionVariables.UserAdmin == 1)
            {%>
 
    <!-- tab setup -->
    <div class="container">
        <ul class="nav nav-pills">
            <li class="active">
                <a href="#UserManagement" role="tab" data-toggle="pill">
                    <i class="fa fa-envelope">User Management</i>
                </a>
            </li>
            <li>
                <a href="#EventManagement" role="tab" data-toggle="pill">
                    <i class="fa fa-cog">Event Management</i>
                </a>
            </li>
            <li>
                <a href="#Raffle" role="tab" data-toggle="pill">
                    <i class="fa fa-cog">Raffle</i>
                </a>
            </li>
            <li>
                <a href="#Loyalty" role="tab" data-toggle="pill">
                    <i class="fa fa-cog">Loyalty</i>
                </a>
            </li>
        </ul>
<div class="tab-content">
        <!--tab 1 -->
<!-- <div class="container"> -->
    <div class="tab-pane fade active in" id="UserManagement">
        <!-- <div class="row pull-left col-lg-12"> -->
            <hr />
            <div class="pull-left">
                <h3>Add User Payment:</h3>
                <label>Username:</label>
                <select id="userDropdown" class="dropdown">
                    <option selected="selected">None</option>
                </select>
                <label>Name:</label>
                <select id="nameDropdown" class="dropdown">
                    <option selected="selected">None</option>
                </select>
                <br />
                <button id="cash" class="btn btn-default pull-left">Paid Cash</button>
                <button id="other" class="btn btn-default pull-left">Volunteer</button>
                <button id="tournamentwinner" class="btn btn-default pull-left">TournamentWinner</button>
                <button id="verifyPayment" class="btn btn-default pull-left">Clear Bad Keys</button>
                
                <button id="addraffle" class="btn btn-default pull-left">Add raffle ticket</button>


                    <!-- <div class="row  col-lg-12"> -->

                    <hr />
                    <h3>User Payment Verification:</h3>
                    <table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="adminusertable">
                        <thead>
                            <tr>
                                <th>UserName</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Verified Paid</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%= AdminUserHTML%>
                        </tbody>
                    </table>

                    <!--     </div> -->
                </div>
            </div>
            <!--</div>
    <!-- tab2 -->
            <div class="tab-pane fade" id="EventManagement">
                <div class="container">
                    <div class="column">
                        <!-- <div class="row pull-left col-lg-12"> -->
                        <hr />
                        <h3>Block/Unblock Payments
                        </h3>
                        <div class="pull-left">
                            <button id="blockRegistration" class="btn pull-left btn-danger">Block Registration</button>
                            <button id="unblockRegistration" class="btn pull-left btn-success">Unblock Registration</button>
                            <button id="sendBarcodes" class="btn btn-default pull-left">Send Barcodes to All Users</button>
                        </div>
                        <!-- </div> 
                <div class="row pull-left col-lg-12"> -->
                        <hr />
                        <h3>Archive Event
                        </h3>
                        <div class="pull-left">
                            <label>Unarchived Events:</label>
                            <select id="eventDropdown" class="pull-left dropdown col-lg-12">
                                <option selected="selected">None</option>
                            </select>
                            <button id="archiveEvent" class="btn pull-left btn-danger">Archive Event</button>
                        </div>
                        <!-- </div> -->

                    </div>
                </div>
            </div>

            <!-- TAB 3 Raffle-->

            <div class="tab-pane fade" id="Raffle">
                <div class="container">
                    <div class="column">
                        <!--<div class="row pull-left col-lg-12">
                    <div class="row pull-left col-lg-12">-->
                        <hr />
                        <h3>Digital Raffle Drawing</h3>
                        <div id="winner"></div>
                        <button id="randNum" class="btn btn-default pull-left">Pick a winner</button>
                        <button id="randRepick" class="btn btn-default pull-left">Repick</button>
                        <!--</div>-->
                        <hr />
                        <h3>Raffle Verification:</h3>
                        <table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="adminusertable">
                            <thead>
                                <tr>
                                    <th>UserName</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>EventID</th>
                                    <th>Wondoor</th>
                                    <th>Wonloyalty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%= RaffleHTML%>
                            </tbody>
                        </table>
                        <!--</div>-->
                    </div>
                </div>
            </div>

            <!-- TAB 4 Loyalty-->

            <div class="tab-pane fade" id="Loyalty">
                <div class="container">
                    <div class="container">
                        <div class="row-fluid">
                            <div class="col-lg-5" id="loyaltyWinner">
                                <form class="well form-inline">
                                    <h3>Loyalty Prize Winner</h3>
                                    <p id="Name"></p>
                                    <button class="btn btn-success" id="Spin">Spin</button>
                                    <button class="btn btn-danger" id="Skip">Skip</button>
                                </form>
                            </div>
                            <div class="col-lg-5">
                                <form class="well form-inline">
                                    <h3>Prize up for grabs</h3>
                                    <center>
                                        <%--<img id="prize" src ="<%= imageSource%>"/>--%>

                                    </center>
                                    <br>
                                    <p id="Sponsor">
                                        Thanks to our sponsor, test Sponsor, for donating this.
                                    </p>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

        <%}
            else
            {%>
        <h2>You do not have the necessary privileges to view this page.</h2>
        <br />
        <%} %>
        <%} %>
        <%else
            {%>
        <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
        <br />
        <%} %>
</asp:Content>
