<%@ Page Title="KcGameOn Event Registration" Language="C#" EnableEventValidation="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventRegistration.aspx.cs" Inherits="KCGameOn.EventRegistration" %>

<%@ Import Namespace="KCGameOn" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .modal-content, .modal-dialog, .modal-footer
        {
            background: #282828;
        }

        .modal-backdrop.in, .modal-backdrop
        {
            opacity: 0.5 !important;
        }

        #field-body
        {
            max-width: 1140px;
            margin: auto;
            margin: 10px;
            min-height: 400px;
            height: auto;
        }

        #fields
        {
            width: auto;
            max-width: 220px;
            margin: auto;
            margin-right: 15px;
        }

        #registrationTable
        {
            width: auto;
            min-width: 800px;
            max-width: 800px;
            margin-bottom: 20px;
        }

        .total
        {
            margin: 5px;
            height: auto;
            max-width: 300px;
            width: auto;
        }

        .modal-content, .modal-dialog, .modal-footer
        {
            background: #282828;
        }

        .modal-dialong
        {
            top: 50%;
        }

        .fullyear
        {
            text-align: center;
        }
    </style>
    <script>
        function calculateSum() {
            var sum = 0;
            // iterate through each td based on class and add the values
            //$(".price").each(function () {
            //    var value = $(this).text();
            //    // add only if the value is number
            //    if (!isNaN(value) && value.length != 0) {
            //        sum += parseFloat(value);
            //    }
            //});

            $('.fullyear').find('input[type="checkbox"]').each(function () {
                if ($(this).prop('checked') == true) {

                    sum += 15.00 * remainingEvents;
                }
                else {
                    sum += 15.00;
                }
            });
            $('#result').text("Total cost: $" + sum.toFixed(2));
        };

        $(document).ready(function () {
            var users = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(usernames)%>
                namelist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(names)%>
                ulist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(userlist)%>
                remainingEvents = <%= remainingEvents%>

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
            };

            function deleterow(tableID) {
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                if (rowCount > 0) {
                    table.deleteRow(rowCount - 1);
                    calculateSum();
                }
            }

            $('#delete_row').click(function (event) {
                event.preventDefault();
                deleterow('registrationTable');
            });

            $('#add').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                var name = $('#nameDropdown').val();
                var split = name.split(" ");
                var first = split[0];
                var last = split[1];
                var num = 15.00;
                if (user != "None" && name != "None") {
                    if ($('#registrationTable tr > td:contains(' + user + ') + td:contains(' + first + ') + td:contains(' + last + ')').length) {
                        //bootbox.alert("User is already in the table.", function () {
                        //});
                        $("#userInTable").modal('show');
                    }
                    else {
                        var newRow = $('<tr><td>' + user + '</td><td>' + first + '</td><td>' + last + '</td><td class = "price">' + num.toFixed(2) + '</td><td class="fullyear">' + '<input type="checkbox" value="checked" onclick="calculateSum();">' + '</tr>');
                        $('#registrationTable').append(newRow);
                        calculateSum();
                    }
                }
            });
            $(".Content").hide();
            //$(calculateSum);

            $('#pay').click(function (event) {
                event.preventDefault();
                var payments = []
                var fullYear = false;
                $('#registrationTable tbody tr').each(function () {
                    $(this).find('input[type="checkbox"]').each(function () {
                        if ($(this).prop('checked') == true) {

                            fullYear = true;
                        }
                        else {
                            fullYear = false;
                        }
                    });
                    var tdArray = []
                    tdArray.push(fullYear);
                    $(this).find('td').each(function () {
                        tdArray.push($(this).text());
                    })
                    payments.push(tdArray)
                })
                $.ajax({
                    type: "POST",
                    url: "EventRegistration.aspx/BuyTickets",
                    data: "{'data':'" + JSON.stringify(payments) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function (data) { window.location.href = data.d; })
                    .fail(function () {
                        $("#failure").modal('show');
                    });
            });
        });
    </script>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <!-- Success modal-->
    <div class="modal" id="failure" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Failed</h4>
                </div>
                <div class="modal-body" id="failureMessage">
                    <p>Failed to proceed to checkout, please contact an administrator or try again later.</p>
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
    <!-- Success modal-->
    <div class="modal" id="userInTable" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">User Exists</h4>
                </div>
                <div class="modal-body" id="userExistsMessage">
                    <p>The specified user already exists in the table.</p>
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
    <%if (!SessionVariables.registrationBlocked)
          {%>
    <div id="field-body">
        <div id="fields" class="pull-left">
            <h3>Pay for another user:</h3>
            <label>Username:</label>
            <select id="userDropdown" class="dropdown">
                <option selected="selected">None</option>
            </select>
            <label>Name:</label>
            <select id="nameDropdown" class="dropdown">
                <option selected="selected">None</option>
            </select>
            <br />
            <button id="add" class="btn btn-default pull-right">Add User</button>
        </div>
        <form id="Form1" runat="server">
            <table id="registrationTable" class="table bordered-table zebra-striped pull-right">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Cost per event</th>
                        <th>Pay for all remaining 2016 events?</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="total pull-right">
                <div>
                    <h3 class="pull-right" id="result"></h3>
                </div>
                <button id="delete_row" class="pull-left btn btn-default">Delete User</button>

                <button id="pay" class="btn pull-right btn-inverse">Pay Now</button>
            </div>
        </form>
    </div>
    <%} %>
    <%else
    { %>
    
        <h2>There are currently no events available for registration, please check back closer to the event date or when the announcement email has been sent.</h2>
        <br />
        <%} %>
</asp:Content>
