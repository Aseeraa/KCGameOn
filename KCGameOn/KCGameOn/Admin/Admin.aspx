<%@ Page Title="Admin Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="KCGameOn.Admin.Admin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8" />
    <script>
        $(document).ready(function () {
            var users = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(usernames)%>
                namelist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(names)%>
                ulist = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(userlist)%>

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
                        successBox();
                    })
                    .fail(function () {
                        failedBox();
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
                userObject.push("Other");
                payments.push(userObject);
                $.ajax({
                    type: "POST",
                    url: "Admin.aspx/addPayment",
                    data: "{'data':'" + JSON.stringify(payments) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                    .done(function (data) {
                        successBox();
                    })
                    .fail(function () {
                        failedBox();
                    });
            });

            function failedBox() {
                bootbox.dialog({
                    message: "Failed to add user payment, contact Dan (or applicable developer).",
                    title: "Failed",
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

            function successBox() {
                bootbox.dialog({
                    message: "Added the user payment to the database like a boss.",
                    title: "Success",
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
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {
          if (SessionVariables.UserAdmin == 1)
          {%>
    <div class="container">
        <div class="row pull-left col-lg-12">
            <hr />
            <h3>Block/Unblock Payments
            </h3>
            <div class="pull-left">
                <button id="blockRegistration" class="btn pull-left btn-danger" onclick="registrationAllowances">Block Registration</button>
                <button id="unblockRegistration" class="btn pull-left btn-success" onclick="registrationAllowances">Unblock Registration</button>
            </div>
        </div>
        <div class="row pull-left col-lg-12">
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
        </div>
        <div class="row pull-left col-lg-12">
            <hr />
            <h3>User Payment Verification:</h3>
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
            <button id="other" class="btn btn-default pull-left">Paid Online</button>
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
