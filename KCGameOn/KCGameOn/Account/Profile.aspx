<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="KCGameOn.Account.Profile" %>

<%@ Import Namespace="KCGameOn" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="HeadContent">

    <script type="text/javascript" src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">
        function checkValidInputs() {
            debugger;
            if (checkPasswordMatch()) {
                $('input[type="submit"]').attr('disabled', false);

            }
            else {
                $('input[type="submit"]').attr('disabled', true);
            }
        }
        function checkPasswordMatch() {
            var password = $('.Password').val();
            var confirmPassword = $('.Password1').val();

            if (password != confirmPassword) {

                document.getElementById('PassErrorImg').style.visibility = "visible";
                document.getElementById('PassErrorImg1').style.visibility = "visible";
                return false;
            }
            else if (password.length == 0 || confirmPassword.length == 0)
            {
                return false;
            }
            else {
                document.getElementById('PassErrorImg').style.visibility = "hidden";
                document.getElementById('PassErrorImg1').style.visibility = "hidden";
                return true;
            }
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="MainContent">
        <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
          {%>
    <form class="well form-horizontal" runat="server" id="updatepassword">
    <h2>Welcome, <asp:Literal runat="server" id="usernameText" EnableViewState="false" />!</h2>
    <div class="control-group">
        <label class="control-label">Name</label>
        <label class="controls" style="margin-top: 5px;">
            <asp:Literal runat="server" id="firstNameText" EnableViewState="false" /> <asp:Literal runat="server" id="lastNameText" EnableViewState="false" />
        </label>
    </div>
    <div class="control-group">
        <label class="control-label">Email</label>
        <label class="controls" style="margin-top: 5px;">
            <asp:Literal runat="server" id="emailText" EnableViewState="false" />
        </label>
    </div>
    <div class="control-group">
        <label class="control-label">Sponsor</label>
        <label class="controls" style="margin-top: 5px;">
            <asp:Literal runat="server" id="sponsorText" EnableViewState="false" />
        </label>
    </div>
    <div class="control-group">
        <label class="control-label">Joined Date</label>
        <label class="controls" style="margin-top: 5px;">
            <asp:Literal runat="server" id="joinedDateText" EnableViewState="false" />
        </label>
    </div>
    <div class="control-group">
        <label class="control-label" for="inputPassword">Password</label> 

        <div class="controls">
            <input id="Password" class="Password" onkeyup="checkValidInputs();" placeholder="Min. 6 Characters" type="password" runat="server" required="true" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers" />
            <img alt="Error" id="PassErrorImg" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
        </div>
        <p id="P1"></p>
    </div>

    <div class="control-group">
        <label class="control-label" for=
        "inputPassword">Password Confirmation</label> 

        <div class="controls">
            <input id="Password1" class="Password1" onkeyup="checkValidInputs();" placeholder="Min. 6 Characters" type="password" runat="server" required="true" />
            <img alt="Error" id="PassErrorImg1" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
        </div>
        <p id="PassError"></p>
    </div>
    <asp:Button ID="ChangeProfileConfirm" class="btn btn-large btn-success" type="submit" Text="Change Password" onclick="ChangeProfile_Click" runat="server"/>
    </form>
    <%}
          else
          {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <%} %>
</asp:content>
