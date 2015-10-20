<%@ Page Title="KcGameOn Event Registration" Language="C#" EnableEventValidation="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventRegistration.aspx.cs" Inherits="KCGameOn.EventRegistration" %>

<%@ Import Namespace="KCGameOn" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
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
            min-width: 600px;
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
    </style>
    <script>

        $(document).ready(function () {
            var users = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(usernames)%>
                namelist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(names)%>
                ulist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(userlist)%>

            $(loadDropdowns);


            function calculateSum() {
                var sum = 0;
                // iterate through each td based on class and add the values
                $(".price").each(function () {
                    var value = $(this).text();
                    // add only if the value is number
                    if (!isNaN(value) && value.length != 0) {
                        sum += parseFloat(value);
                    }
                });
                $('#result').text("Total cost: $" + sum.toFixed(2));
            };

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
                debugger;
                var table = document.getElementById(tableID);
                var rowCount = table.rows.length;
                if (rowCount > 0) {
                    table.deleteRow(rowCount - 1);
                    $(calculateSum);
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
                        bootbox.alert("User is already in the table.", function () {
                        });
                    }
                    else {
                        var newRow = $('<tr><td>' + user + '</td><td>' + first + '</td><td>' + last + '</td><td class = "price">' + num.toFixed(2) + '</td></tr>');
                        $('#registrationTable').append(newRow);
                        $(calculateSum);
                    }
                }
            });
            $(".Content").hide();

            $(calculateSum);

            $('#pay').click(function (event) {
                event.preventDefault();
                var payments = []
                $('#registrationTable tbody tr').each(function () {
                    var tdArray = []
                    $(this).find('td').each(function () {
                        tdArray.push($(this).text())
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
                        failedBox();
                    });
            });
        });

        function failedBox() {
            bootbox.dialog({
                message: "Failed to proceed to checkout, please contact an administrator or try again later.",
                title: "Payment",
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

    </script>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <form action="EventRegistration.aspx" method="post" id="Form1" runat="server">
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
                <%--<button id="add" class="btn btn-default pull-right">Add User</button>--%>
                <asp:Button Text="Add User" ID="add" runat="server" class="btn btn-default pull-right" OnClick="add_Click"></asp:Button>
            </div>

            <%--<table id="registrationTable" class="table bordered-table zebra-striped pull-right">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Cost</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>--%>
            <asp:Table ID="registrationTable" runat="server" class="table bordered-table zebra-striped pull-right">
                <asp:TableRow>
                    <asp:TableCell>Username</asp:TableCell>
                    <asp:TableCell>First Name</asp:TableCell>
                    <asp:TableCell>Last Name</asp:TableCell>
                    <asp:TableCell>Cost</asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <div class="total pull-right">
                <div>
                    <h3 class="pull-right" id="result"></h3>
                </div>
                <%--<button id="delete_row" class="pull-left btn btn-default">Delete User</button>--%>
                <asp:Button Text="Delete User" ID="delete_row" runat="server" class="pull-left btn btn-default" OnClick="delete_row_Click"></asp:Button>
                <asp:Button Text="Pay Now" ID="pay" runat="server" class="btn pull-right btn-inverse" OnClick="pay_Click"></asp:Button>
            </div>

        </div>

        <%--        <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
            <input type="hidden" name="cmd" value="_s-xclick" />
            <input type="hidden" name="hosted_button_id" value="7E2DQ4F62C4L6" />
            <input id="quantityInput" type="hidden" name="quantity" value="" />
            <input type="image" src="/img/paypal.png" class="pull-right" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" />
            <img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1" />
        </form>--%>
    </form>
</asp:Content>
