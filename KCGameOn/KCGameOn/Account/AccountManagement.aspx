<%@ Page Title="KcGameOn Account Recovery" Language="C#" EnableEventValidation="false"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="KCGameOn.Account.AccountManagement" %>
<%@ Import Namespace="KCGameOn.Account" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        function checkRecoveryPasswordMatch() {
            var password = $('.inputRecoveryNewPass').val();
            var confirmPassword = $('.inputConfirmRecoverNewPass').val();

            if (password != confirmPassword) {
                $('input[type="submit"]').attr('disabled', true);
            }
            else {
                $('input[type="submit"]').attr('disabled', false);
            }

        }
        function checkPasswordMatch() {
            var password = $('.inputNewPassword').val();
            var confirmPassword = $('.inputConfirmNewPassword').val();

            if (password != confirmPassword) {
                $('input[type="submit"]').attr('disabled', true);

                document.getElementById('PassErrorImg').style.visibility = "visible";
                document.getElementById('PassErrorImg1').style.visibility = "visible";

            }
            else if (password.length == 0 || confirmPassword.length == 0) {
                $('input[type="submit"]').attr('disabled', true);
            }
            else {
                $('input[type="submit"]').attr('disabled', false);

                document.getElementById('PassErrorImg').style.visibility = "hidden";
                document.getElementById('PassErrorImg1').style.visibility = "hidden";
            }
        }
        function RadioControl() {
            var Radiovalue = $('input[name="RadioRecovery"]:checked').val();
            if (Radiovalue == 1) {
                var Email = $('.inputRecoveryEmail').val();
                if (Email.length == 0 || Email == null)
                    $('input[type="submit"]').attr('disabled', true);
                else
                    $('input[type="submit"]').attr('disabled', false);
            }
            else {
                $('input[type="submit"]').attr('disabled', false);
            }
        }
        jQuery(document).ready(function () {
            jQuery(".Content").hide();
            //toggle the componenet with class msg_body
            jQuery(".Menubody-trigger").click(function () {
                $(this).addClass("Menubody-trigger-active");
                $(this).parent().find('.Content').stop(true, true).slideDown(500);
            });
        });
        $(document).ready(function () {
            $('.ExpandAll').click(function () {
                $(".Content").hide('slow');
            });
        });
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <%if (AccountManagements == "changepassword"){ %>
        <%if(!ChangePasswordSucess){ %>
            <form class="well form-inline" runat="server">
                <h2>KcGameOn Password Change.</h2>
                <br/>
                <br/>
                <h3 style="color:red"><%=ChangePasswordErrorString%></h3>   
                <div class="control-group">
                    <label class="control-label" for="inputCurrentPassword">Current Password</label>
                    <div class="controls">
                        <input id="inputCurrentPassword" runat="server" placeholder="Current Password" type="password" required>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputNewPassword">New Password</label>
                    <div class="controls">
                        <input id="inputNewPassword" class= "inputNewPassword" runat="server" onkeyup="checkPasswordMatch();" placeholder="New Password" type="password" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers" />
                        <img id="PassErrorImg" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputConfirmNewPassword">Confirm New Password</label>
                    <div class="controls">
                       <input id="inputConfirmNewPassword" class="inputConfirmNewPassword" runat="server" onkeyup="checkPasswordMatch();" placeholder="Confirm New Password" type="password" required />
                        <img id="PassErrorImg1" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
                    </div>
                </div>
                <br />
                <asp:Button ID="PasswordChange" Class="btn btn-inverse" runat="server" Text="Submit" OnClick="PasswordChange_Click"/>
            </form>
        <%} else{ %>
            <div class="alert alert-info">
                <asp:Literal ID="ltMessage" runat="server">You have Successfully changed your Password!.</asp:Literal>
            </div>
        <%} %>
    <%}else if(AccountManagements == "recovery"){ %>
        
        <form class="well form-inline" runat="server">
        <%if (Request.Form["sequence"] == null ||  Request.Form["sequence"].Length == 0){ %>
                <h3>Having trouble signing in?</h3>
                <br />
                <div class="UImenu">
                    <div class="UImenuItem">
                        <input type="radio" name="RadioRecovery" value="1" class="Menubody-trigger" onclick="RadioControl();"/>
                        <label>I don't know my Password.</label>
                        <div class="Content">
                            <div class="control-group" style="margin-left: 40px;">
                                <p>To reset your password, enter the email address you used to create a KcGameOn account.</p>
                                <label class="control-label" for="RecoverEmail"><h4>Email Address</h4></label>
                                <div class="controls">
                                <input id="Email" name="inputRecoveryEmail" class= "inputRecoveryEmail" runat="server" placeholder="Email" type="text" onkeyup="RadioControl();"/>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="radio" name="RadioRecovery" class="ExpandAll" value="2" onclick="RadioControl();" />
                <label>I don't know my UserName.</label>
               <br />
               <br />
               <input type="hidden" name="sequence" value="1" />
               <asp:Button ID="AccountRecovery" name="AccountRecovery" Class="btn btn-inverse" runat="server" Text="Submit" OnClick="Recovery_Click"/>
        <%}else if(Request.Form["sequence"].CompareTo("1") == 0 && Request.Form["RadioRecovery"].CompareTo("1") == 0){ %>
                    <h3>Having trouble signing in?</h3>
                    <br />
                    An email has been sent to your email address.  Please read that email, copy the code and paste it into "Verification Code" field.
                    <div class="control-group">
                        <label class="control-label" for="ResetCode"><h4>Varification Code</h4></label>
                        <div class="controls">
                            <input id="inputCode" name="inputCode" class="inputCode" runat="server" placeholder="Code" type="text" />
                        </div>
                    </div>
                    <br />
                    <input type="hidden" name="sequence" value="2" />
                    <asp:Button ID="Button1" name="AccountRecovery" Class="btn btn-inverse" runat="server" Text="Continue" OnClick="Recovery_Click"/>
        <%}else if(Request.Form["sequence"].CompareTo("2") == 0 && Request.Form["RadioRecovery"].CompareTo("1") == 0){ %>
                    <h3>Having trouble signing in?</h3>
                    <div class="control-group">
                        <label class="control-label" for="inputRecoverNewPass">New Password</label>
                        <div class="controls">
                            <input id="inputRecoveryNewPass" name="inputRecoveryNewPass" class="inputRecoveryNewPass" runat="server" placeholder="New Password" type="password" onkeyup="checkRecoveryPasswordMatch();" />
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label" for="inputConfirmRecoverNewPass">Confirm Password</label>
                        <div class="controls">
                            <input id="inputConfirmRecoverNewPass" name="inputConfirmRecoverNewPass" class="inputConfirmRecoverNewPass" runat="server" placeholder="Confirm Password" type="password" onkeyup="checkRecoveryPasswordMatch();"/>
                        </div>
                    </div>
                    <input type="hidden" name="sequence" value="3" />
                    <asp:Button ID="Button2" name="AccountRecovery" Class="btn btn-inverse" runat="server" Text="Submit" OnClick="Recovery_Click"/>
        <%} %>
        </form>
    <%} %>
</asp:Content>