﻿<%@ Page Title="KcGameOn Account Recovery" Language="C#" EnableEventValidation="false"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountManagement.aspx.cs" Inherits="KCGameOn.Account.AccountManagement" %>
<%@ Import Namespace="KCGameOn.Account" %>
<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        function checkRecoveryPasswordMatch() {
            var password = $('.inputRecoveryNewPass').val();
            var confirmPassword = $('.inputConfirmRecoverNewPass').val();

            if (password != confirmPassword) {
                $('input[type="submit"]').attr('disabled', true);
                document.getElementById('PassErrorImg').style.visibility = "visible";
                document.getElementById('PassErrorImg1').style.visibility = "visible";
            }
            else {
                $('input[type="submit"]').attr('disabled', false);
                document.getElementById('PassErrorImg').style.visibility = "hidden";
                document.getElementById('PassErrorImg1').style.visibility = "hidden";
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
            var Email = $('.inputRecoveryEmail').val();
            var Email1 = $('.inputRecoveryEmail1').val();
            if ((Radiovalue == 1 && (Email.length == 0 || Email == null)) || (Radiovalue == 2 && (Email1.length == 0 || Email1 == null))) {
                $('input[type="submit"]').attr('disabled', true);
            }
            else {
                $('input[type="submit"]').attr('disabled', false);
            }
        }
        jQuery(document).ready(function () {
            jQuery(".Content").hide('slow');
            //$(".Content1").hide('slow');
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
        $(document).ready(function () {
            $('.ExpandAll1').click(function () {
                $(".Content1").hide('slow');
            });
        });
        $(document).ready(function () {
            $(".Content1").hide('slow');
           // $(".Content").hide('slow');
            $('.Menubody-trigger1').click(function () {
                $(this).addClass("Menubody-trigger-active");
                $(this).parent().find('.Content1').stop(true, true).slideDown(500);
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
        <%if (Request.Form["sequence"] == null || Request.Form["sequence"].Length == 0 || SessionVariables.iSeq == 1)
          { %>
            <form class="well form-inline" runat="server">
                <h3>Having trouble signing in?</h3>
                <br />
                <div class="UImenu">
                    <div class="UImenuItem">
                        <input type="radio" name="RadioRecovery" value="1" class="ExpandAll1 Menubody-trigger" onclick="RadioControl();"/>
                        <label>I don't know my Password.</label>
                        <div class="Content">
                            <div class="control-group" style="margin-left: 40px;">
                                <p>To reset your password, enter the email address you used to create a KcGameOn account.</p>
                                <%if(recoveryError.Text.CompareTo("") == 1){ %>
                                    <br /><div class="alert alert-error"><asp:Literal ID="recoveryError" runat="server"/></div>
                                <%} %>
                                <label class="control-label" for="RecoverEmail"><h4>Email Address</h4></label>
                                <div class="controls">
                                    <input id="Email" name="inputRecoveryEmail" class= "inputRecoveryEmail" runat="server" placeholder="Email" type="text" onkeyup="RadioControl();"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="UImenu">
                    <div class="UImenuItem">
                        <input type="radio" name="RadioRecovery" class="ExpandAll Menubody-trigger1" value="2" onclick="RadioControl();" />
                        <label>I don't know my UserName.</label>
                        <div class="Content1">
                            <div class="control-group" style="margin-left: 40px;">
                                <p>Enter the email address you used to create a KcGameOn account.</p>
                                <%if(recoveryError.Text.CompareTo("") == 1){ %>
                                    <br /><div class="alert alert-error"><asp:Literal ID="Literal1" runat="server"/></div>
                                <%} %>
                                <label class="control-label" for="RecoverEmail"><h4>Email Address</h4></label>
                                <div class="controls">
                                    <input id="UserNameEmail" name="inputRecoveryEmail1" class= "inputRecoveryEmail1" runat="server" placeholder="Email" type="text" onkeyup="RadioControl();"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
               
                <br />
               <br />
               <input type="hidden" name="sequence" value="1"/>
               <asp:Button ID="AccountRecovery" name="AccountRecovery" Class="btn btn-inverse" runat="server" Text="Submit" OnClick="Recovery_Click"/>
          </form>
        <%}
          else if ((Request.Form["sequence"].CompareTo("1") == 0 && Request.Form["RadioRecovery"].CompareTo("1") == 0) || (SessionVariables.iSeq == 2 && Request.Form["RadioRecovery"].CompareTo("1") == 0))
          { %>
                <form class="well form-inline" runat="server">
                    <h3>Having trouble signing in?</h3>
                    <br />
                    An email has been sent to your email address.  Please read that email, copy the code and paste it into "Verification Code" field.
                    <%if(recoveryError1.Text.CompareTo("") == 1){ %>
                        <div class="alert alert-error"> <asp:Literal ID="recoveryError1" runat="server"/> </div>
                    <%} %>
                    <div class="control-group">
                        <label class="control-label" for="ResetCode"><h4>Verification Code</h4></label>
                        <div class="controls">
                            <input id="inputCode" name="inputCode" class="inputCode" runat="server" placeholder="Code" type="text" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputRecoverNewPass">New Password</label>
                        <div class="controls">
                            <input id="inputRecoveryNewPass" name="inputRecoveryNewPass" class="inputRecoveryNewPass" runat="server" placeholder="New Password" type="password" onkeyup="checkRecoveryPasswordMatch();" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers"/>
                            <img id="PassErrorImg" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label" for="inputConfirmRecoverNewPass">Confirm Password</label>
                        <div class="controls">
                            <input id="inputConfirmRecoverNewPass" name="inputConfirmRecoverNewPass" class="inputConfirmRecoverNewPass" runat="server" placeholder="Confirm Password" type="password" onkeyup="checkRecoveryPasswordMatch();" required/>
                            <img id="PassErrorImg1" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
                        </div>
                    </div>
                    <br />
                    <input type="hidden" name="sequence" value="2"/>
                    <input type="hidden" name="RadioRecovery" value="1" />
                    <input type="hidden" name="RecoveryEmail" value=<%=Request.Form["ctl00$MainContent$Email"]%> />
                    <asp:Button ID="Button1" name="AccountRecovery" Class="btn btn-inverse" runat="server" Text="Continue" OnClick="Recovery_Click"/>
                    </form>
        <%}else if ((Request.Form["sequence"].CompareTo("2") == 0 && Request.Form["RadioRecovery"].CompareTo("1") == 0) || (SessionVariables.iSeq == 3 && Request.Form["RadioRecovery"].CompareTo("1") == 0)) { %>
            <div class="alert alert-info">
                Password Reset Tips and Info! <br />
                <li>Password reset successful. <br /></li>
                <li>Good Job, Now write this down.<br /></li>
                <li>Use KeePass next time to store your password<br /></li>
            </div>
        <%} %>
    <%} %>
</asp:Content>