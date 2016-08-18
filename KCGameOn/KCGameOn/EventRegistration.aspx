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

        #bottomtext
        {
            width: auto;
            min-width: 800px;
            max-width: 800px;
            margin-bottom: 20px;
            align-content:center
            color: red
            
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
        var amount = 15.00;
        var checkIn = <%= checkInDay%>
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
                    sum += amount + 15 * (remainingEvents-1);
                }
                else {
                    sum += amount;
                }
            });
            $('.extralife').find('input[type="checkbox"]').each(function () {
                if ($(this).prop('checked') == true) {
                    sum += 10;
                }
                else {
                    sum = sum;
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
                $("#userDropdown").val("<%=SessionVariables.UserName %>");
                $("#userDropdown").trigger("change");
                $('#add').trigger("click");
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
                if ($('#registrationTable tr').size() > 1) {
                    $('#pay').removeAttr('disabled');
                }
                else {
                    $('#pay').attr('disabled', 'disabled');
                }
                if ($('#registrationTable tr').size() == 1) {
                    $('#delete_row').attr('disabled', 'disabled');
                    $('#result').text("");
                }
                else {
                    $('#delete_row').removeAttr('disabled');
                }

            });

            $('#add').click(function (event) {
                event.preventDefault();
                var user = $('#userDropdown').val();
                var name = $('#nameDropdown').val();
                var split = name.split(" ");
                var first = split[0];
                var last = split[1];
                if (checkIn == true) {
                    amount = 20.00
                }
                if (user != "None" && name != "None") {
                    if ($('#registrationTable tr > td:contains(' + user + ') + td:contains(' + first + ') + td:contains(' + last + ')').length) {
                        //bootbox.alert("User is already in the table.", function () {
                        //});
                        $("#userInTable").modal('show');
                    }
                    else {
                        var newRow = $('<tr><td>' + user + '</td><td>' + first + '</td><td>' + last + '</td><td class = "price">' + amount.toFixed(2) + '</td><td class="fullyear">' + '<input type="checkbox" value="checked" onclick="calculateSum();"></td><td class="extralife">' + '<input type="checkbox" value="checked" onclick="calculateSum();"></td>' + '</tr>');
                        $('#registrationTable').append(newRow);
                        calculateSum();
                    }
                }
                if ($('#registrationTable tr').size() > 1) {
                    $('#pay').removeAttr('disabled');
                }
                else {
                    $('#pay').attr('disabled', 'disabled');
                }
                if ($('#registrationTable tr').size() == 1) {
                    $('#delete_row').attr('disabled', 'disabled');
                    $('#result').text("");
                }
                else {
                    $('#delete_row').removeAttr('disabled');
                }
            });
            $(".Content").hide();
            //$(calculateSum);

            $('#pay').click(function (event) {
                event.preventDefault();
                var payments = []
                var fullYear = false;
                $('#registrationTable tbody tr').each(function () {
                    $(this).find('input[type="checkbox"]').eq(0).each(function () {
                        if ($(this).prop('checked') == true) {

                            fullYear = true;
                        }
                        else {
                            fullYear = false;
                        }
                    });
                    $(this).find('input[type="checkbox"]').eq(1).each(function () {
                        if ($(this).prop('checked') == true) {

                            extraLife = true;
                        }
                        else {
                            extraLife = false;
                        }
                    });
                    var tdArray = []
                    tdArray.push(fullYear);
                    $(this).find('td').each(function () {
                        tdArray.push($(this).text());
                    })
                    tdArray.push(extraLife);
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
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
{%>
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
            <h3>Start Here:</h3>
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
                        <th>Remaining Year?</th>
                        <th>Extra Life Donation</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="total pull-right">
                <div>
                    <h3 class="pull-right" id="result"></h3>
                </div>
                <button id="delete_row"  disabled="disabled" class="pull-left btn btn-default">Delete User</button>

                <button id="pay" disabled="disabled" class="btn pull-right btn-inverse">Pay Now</button>
            </div>
            <div id="bottomtext" class="pull-right">
                <br />
                <h3>Please add yourself and any other guests you wish to pay for, then click PAY NOW</h3>
                <h3>After you pay, click the link back to the map and take a seat <b>immediately.</b></h3>
                <br />
                <h5>If you pay for more than one ticket, you will need to have that person log in and sit in their seat as well.</h5>
                <h5>An email with the easy check-in barcode will be sent to your email after you take a seat.</h5>
            </div>
        </form>
    </div>
    
    <%} %>
    <%else
    { %>
		<div align=center>
			<h2>There are currently no events available for registration, please check back closer to the event date or when the announcement email has been sent.</h2>
			<br />
		</div>
        <%} %>
    <% }
        else { %>
    
    <h2>Please <a href="/Account/Login.aspx">login</a> to start the registration process.</h2>
    <% } %>
</asp:Content>
