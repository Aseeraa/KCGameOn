<%@ Page Title="Admin Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="KCGameOn.Admin.Admin" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="UTF-8" />
    <style>
        .modal-content, .modal-dialog, .modal-footer
        {
            background: #282828;
        }

        .modal-backdrop.in, .modal-backdrop
        {
            opacity: 0.5 !important;
        }
    </style>
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
                        $("#success").modal('show');
                    })
                    .fail(function () {
                        $("#failure").modal('show');
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
                    .done(function () {
                        $("#success").modal('show');
                    })
                    .fail(function () {
                        $("#failure").modal('show');
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
