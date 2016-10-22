<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="KCGameOn.Account.Profile" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript" src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">
        function checkValidInputs() {
            debugger;
            if (checkPasswordMatch() && checkEmailMatch()) {
                $('input[type="submit"]').attr('disabled', false);

            }
            else {
                $('input[type="submit"]').attr('disabled', true);
            }
        }
        function checkPasswordMatch() {
            var password = $('.NewPassword').val();
            var confirmPassword = $('.NewPasswordConfirm').val();

            if (password != confirmPassword) {

                document.getElementById('PassErrorImg').style.visibility = "visible";
                document.getElementById('PassErrorImg1').style.visibility = "visible";
                return false;
            }
            else {
                document.getElementById('PassErrorImg').style.visibility = "hidden";
                document.getElementById('PassErrorImg1').style.visibility = "hidden";
                return true;
            }
        }
        function checkEmailMatch() {
            var Email = $(".emailInput").val();
            var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

            if (!re.test(Email)) {
                document.getElementById('EmailMatch').style.visibility = "visible";
                return false;
            }
            else if (Email.length == 0) {
                return false;
            }
            else {
                document.getElementById('EmailMatch').style.visibility = "hidden";
                return true;
            }
        }
        /* Table initialisation */
        $(document).ready(function () {
            $('#adminusertable').dataTable({
                "sDom": "<'row'<'col-md-12'><'col-md-12'f>r>t<'row'<'col-md-12'i><'col-md-12'p>>",
                "sPaginationType": "bootstrap",
                "bLengthChange": false
            });
        });
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
        {%>
    <form class="well form-horizontal" runat="server" id="updatepassword">
        <div id="ProfileUpdateLeftPane" style="width: 40%; float: left;">
            <h2>Welcome,
                <asp:Literal runat="server" ID="usernameText" EnableViewState="false" />!</h2>
            <div class="control-group">
                <label class="control-label">Name</label>
                <label class="controls" style="margin-top: 5px;">
                    <asp:Literal runat="server" ID="firstNameText" EnableViewState="false" />
                    <asp:Literal runat="server" ID="lastNameText" EnableViewState="false" />
                </label>
            </div>
            <div class="control-group">
                <label class="control-label" for="emailInput">Email</label>
                <div class="controls" style="margin-top: 5px;">
                    <input id="emailInput" class="emailInput" runat="server" value="" onkeyup="checkValidInputs();" placeholder="E.g. Nick@KcGameOn.com" type="text" required="true" />
                    <img id="EmailMatch" style="visibility: hidden" src="../img/Actions-button-cancel-icon.png" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">ID/clan/gamergroup</label>
                <label class="controls" style="margin-top: 5px;">
                    <input id="sponsorText" class="CurrentPassword" runat="server" value="" onkeyup="" placeholder="ab0000000" type="text" required="true" />
                </label>
            </div>
            <div class="control-group">
                <label class="control-label">Joined Date</label>
                <label class="controls" style="margin-top: 5px;">
                    <asp:Literal runat="server" ID="joinedDateText" EnableViewState="false" />
                </label>
            </div>
            <div class="control-group">
                <label class="control-label">Subscribed</label>
                <label class="controls" style="margin-top: 5px;">
                    <input type="checkbox" id="ActiveCheckbox" runat="server" />
                </label>
            </div>
            <div class="control-group">
                <label class="control-label" for="CurrentPassword">Current Password</label>

                <div class="controls">
                    <input id="CurrentPassword" class="CurrentPassword" onkeyup="" placeholder="Min. 6 Characters" type="password" runat="server" required="true" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers" />
                    <img alt="Error" id="PassErrorImg2" style="visibility: hidden" src="../img/Actions-button-cancel-icon.png" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="NewPassword">New Password</label>

                <div class="controls">
                    <input id="NewPassword" class="NewPassword" onkeyup="checkValidInputs();" placeholder="Min. 6 Characters" type="password" runat="server" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers" />
                    <img alt="Error" id="PassErrorImg" style="visibility: hidden" src="../img/Actions-button-cancel-icon.png" />
                </div>
                <p id="P1"></p>
            </div>

            <div class="control-group">
                <label class="control-label" for="NewPasswordConfirm">
                    Password Confirmation</label>

                <div class="controls">
                    <input id="NewPasswordConfirm" class="NewPasswordConfirm" onkeyup="checkValidInputs();" placeholder="Min. 6 Characters" type="password" runat="server" />
                    <img alt="Error" id="PassErrorImg1" style="visibility: hidden" src="../img/Actions-button-cancel-icon.png" />
                </div>
                <p id="PassError"></p>
            </div>
        </div>
        <div id="ProfileUpdateRightPane" style="width: 60%; float: right;">
            <h2>Optional Information</h2>
            <div class="control-group">
                <label class="control-label">Steam Handle</label>
                <div class="controls" style="margin-top: 5px;">
                    <input id="SteamHandleTB" class="" runat="server" value="" onkeyup="" placeholder="" type="text" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Battle.net Handle</label>
                <label class="controls" style="margin-top: 5px;">
                    <input id="BattleHandleTB" class="" runat="server" value="" onkeyup="" placeholder="" type="text" />
                </label>
            </div>
            <div class="control-group">
                <label class="control-label">Origin Handle</label>
                <div class="controls" style="margin-top: 5px;">
                    <input id="OriginHandleTB" class="" runat="server" value="" onkeyup="" placeholder="" type="text" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Twitter Handle</label>
                <label class="controls" style="margin-top: 5px;">
                    <input id="TwitterHandleTB" class="" runat="server" value="" onkeyup="" placeholder="" type="text" />
                </label>
            </div>
            <div class="control-group">
                <label class="control-label">About Me</label>
                <label class="controls" style="margin-top: 5px;">
                    <textarea id="AboutMeTB" class="" runat="server" value="" onkeyup="" placeholder="" type="text"></textarea>
                </label>
            </div>

            <h3>Raffle Verification:</h3>
            <table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="adminusertable">
                <thead>
                    <tr>
                        <th>UserName</th>
                        <th>EventID</th>
                        <th>Wondoor</th>
                        <th>Wonloyalty</th>
                    </tr>
                </thead>
                <tbody>
                     <%= RaffleHTML%>
                </tbody>
            </table>
            <br />
            <h3>Raffle Table Explaination:</h3>
            <p>The first two events of the year used manual tickets, we had to import those tickets manually without an eventID, thus we used 2016 to denote both the Feb/April 2016 events.</p>
            <p>WonDoor = 1 means you won a door prize at that event, 0 = not a winner.  Wonloyalty is the data point that will change per ticket to show how many times you passed on a prize and which ticket was used to claim a prize.</p>
            <p>NOTE: Loyalty event tickets are not credited to your account until you check-in physically at the respective event.  You should have only 1 event ticket per event attended.</p>
            <p>If you have any descrepancies in the raffle tickets above, contact <a href="mailto:nick@kcgameon.com?Subject=Raffle%20Ticket%20Question" target="_top">Nick</a> immediately through email by <h3>Nov 27.</h3>
                 This is the last day we will change/work on raffle tickets.</p>
            <ul>
                <li>eventID 2016 = Feb OR April 2016 event (max 2)</li>
                <li>eventID 69 = June 13, 2016 event</li>
                <li>eventID 70 = July 30, 2016 event</li>
                <li>eventID 71 = Oct 8, 2016 event</li>
                <li>eventID 72 = Dec 3, 2016 event</li>
            </ul>
        </div>
        <div class="control-group">
            <asp:Literal runat="server" ID="ProfileUpdateMessage" EnableViewState="false" />
        </div>
        <asp:Button ID="ChangeProfileConfirm" class="btn btn-large btn-success" type="submit" Text="Submit Changes" OnClick="ChangeProfile_Click" runat="server" />
    </form>
    <%}
        else
        {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <%} %>
</asp:Content>
