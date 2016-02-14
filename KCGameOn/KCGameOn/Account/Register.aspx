<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="KCGameOn.Account.Register" %>
<%@ Import Namespace="KCGameOn.Account" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style>
        .listdiv {
              width: 400px;
            }
 
            .listh2 {
              font: 200 20px/1.5 Helvetica, Verdana, sans-serif;
              color: #33b5e5;
              margin: 0;
              padding: 0;
            }

            .registerh3 {
              font: 200 25px/1.5 Helvetica, Verdana, sans-serif;
              font-style:italic;
              color: #33b5e5;
              margin: 0;
              padding: 0;
            }
 
            .listul {
              list-style-type: none;
              margin: 0;
              padding: 0;
            }
 
            .listli {
              font: 200 15px/1.5 Helvetica, Verdana, sans-serif;
              border-bottom: 1px solid #ccc;
              padding: 5px;
            }
 
            .listli:last-child {
              border: none;
            }
 
            .listli:hover {
              font-size: 20px;
              background: #33b5e5;
              color: #FFFFFF;
              padding: 5px;
            }
    </style>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">
        function checkValidInputs() {
            debugger;
            if (checkUsername() && checkPasswordMatch() && checkEmailMatch() && checkAnswer()) {
                $('input[type="submit"]').attr('disabled', false);

            }
            else {
                $('input[type="submit"]').attr('disabled', true);
            }
        }
        function disableSubmit() {
            $('input[type="submit"]').attr('disabled', true);
        }
        function checkAnswer() {
            var answer = $('.SecretAnswer').val();
            if (answer.length == 0) {
                return false;
            }
            else {
                return true;
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
        function checkUsername() {
            var Username = $(".inputUser").val();
            var re = /\s/;

            if (Username.length == 0 || re.test(Username)) {
                document.getElementById('UsernameMatch').style.visibility = "visible";
                return false;
            }
            else {
                document.getElementById('UsernameMatch').style.visibility = "hidden";
                return true;
            }
        }
        function checkEmailMatch() {
            var Email = $(".inputEmail").val();
            var confirmEmail = $(".inputEmail1").val();
            var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

            if (Email != confirmEmail || !re.test(Email)) {
                document.getElementById('EmailMatch').style.visibility = "visible";
                document.getElementById('EmailConfError').style.visibility = "visible";
                return false;
            }
            else if (Email.length == 0 || confirmEmail.length == 0) {
                return false;
            }
            else {
                document.getElementById('EmailMatch').style.visibility = "hidden";
                document.getElementById('EmailConfError').style.visibility = "hidden";
                return true;
            }
        }
        function showImage(id, visible) {
            var img = document.getElementById(id)
            img.style.visibility = (visible ? 'visible' : 'hidden');
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <%if (!RegistrationSucess){ %>
<center><legend><h3 class="registerh3"> Create your KCGameOn Account </h3></legend></center>
<div class="row-fluid" >
    <div class="span6">
    <form class="well form-horizontal" runat="server" id="contactformvalidation">
        <%if (RegisterErrorString != null && RegisterErrorString != ""){ %>
            <div class="alert alert-error"><%=RegisterErrorString%></div>
        <%} %>
        
        <br />
        <div class="control-group">
            <label class="control-label" for="inputFirst">First Name</label>
            <div class="controls">
                <input id="inputFirst" runat="server" placeholder="First Name" type="text" required>
            </div>


        </div>

        <div class="control-group">
            <label class="control-label" for="inputLast">Last Name</label>

            <div class="controls">
                <input id="inputLast" runat="server" placeholder="Last Name" type="text" required>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="inputEmail">Email</label>
            <div class="controls">
                <input id="inputEmail" class="inputEmail" runat="server" onkeyup="checkValidInputs();" placeholder="E.g. Nick@KcGameOn.com" type="text" required>
                <img id="EmailMatch" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for=
            "inputEmail">Email Confirmation</label>

            <div class="controls">
                <input id="inputEmail1" class="inputEmail1" runat="server" onkeyup="checkValidInputs();" placeholder=
                "E.g. Nick@KcGameOn.com" type="text" required>
                <img id="EmailConfError" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
            </div>
            <p id="EmailError"></p>
        </div>

        <div class="control-group">
            <label class="control-label" for="inputUser">Username</label>

            <div class="controls">
                <input id="inputUser" class="inputUser" runat="server" onkeyup="checkValidInputs();" placeholder="KcGameOn Username" type="text" required>
                <img id="UsernameMatch" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="inputPassword">Password</label> 

            <div class="controls">
                <input id="Password" class="Password" onkeyup="checkValidInputs();" placeholder="Min. 6 Characters" type="password" runat="server" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers">
                <img id="PassErrorImg" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
            </div>
            <p id="P1"></p>
        </div>

        <div class="control-group">
            <label class="control-label" for=
            "inputPassword">Password Confirmation</label> 

            <div class="controls">
                <input id="Password1" class="Password1" onkeyup="checkValidInputs();" placeholder="Min. 6 Characters" type="password" runat="server" required>
                <img id="PassErrorImg1" style="visibility:hidden" src="../img/Actions-button-cancel-icon.png" />
            </div>
            <p id="PassError"></p>
        </div>
        <div class="control-group">
            <label class="control-label" for="inputCerner">Cerner ID or Sponsor</label>

            <div class="controls">
                <input id="inputCerner" runat="server" placeholder="ex. ne013424 or Sponsor name" type="text" required>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="inputLast">SecretQuestion</label>
             <div class="controls">
                 <asp:DropDownList ID="DropDownList1" runat="server">
                 <asp:ListItem>Color or make of your first car?</asp:ListItem>
                 <asp:ListItem>Favorite movie?</asp:ListItem>
                 <asp:ListItem>Favorite pet’s name?</asp:ListItem>
                 <asp:ListItem>Favorite sports team?</asp:ListItem>
                 <asp:ListItem>Favorite eSports team?</asp:ListItem>  
                 <asp:ListItem>Favorite Game?</asp:ListItem> 
                 </asp:DropDownList>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="inputLast">Feed me your Answer</label>

            <div class="controls">
                <input id="SecretAnswer" class="SecretAnswer" onkeyup="checkValidInputs();" runat="server" placeholder="E.g. Hegde" type="password" required>
            </div>
        </div>
        <!--<div class="control-group">
            <label class="control-label" for="inputLast">Are You Human?</label>

            <div class="controls">
				<input runat="server" placeholder="Put any sponsor in this box" type="text" required>
                <div class="g-recaptcha" data-sitekey="6LdyHwMTAAAAANbhWjVZ720wOmNiBt-CO7l60sDg"></div>
            </div>
        </div>-->
		<div class="control-group">
            <label class="control-label" for="inputHuman"></label>
            <div class="controls">
                <input id="HumanValidation" runat="server" placeholder="3 + 5 = ?" type="text" required>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
            
                <label class="checkbox"><input type="checkbox">
                I agree not to <a href="#">Game Alone</a></label> <br /><br />
                <asp:Button ID="SignInButton" class="btn btn-large btn-success" type="submit" Text="Sign Up!" onclick="SignButton_Click" runat="server"/>
            </div>
        </div>
    </form>
</div>
<div class="span5 offset12">
    <center> 
        <div class="listdiv">
            <h2 class="listh2">Commandments of Gaming</h2>
            <ul class="listul">
               <li class="listli">Gaming is thy holy pastime, thou shalt not have outdoor activities before thee.</li>
               <li class="listli">Thou shalt not be fanboyish in the name of gaming.</li>
                <li class="listli">Remember though keep holy the game release dates.</li>
                <li class="listli">Honor thy PC and thy console.</li>
                <li class="listli">Thou shalt not kill steal.</li>
                <li class="listli">Thou shalt not frag... without gloating in the aftermath</li>
                <li class="listli">Thou shalt lose graciously; thou shalt not whine when fragged.</li>
                <li class="listli">Thou shalt accept thy dice rolls as the will of the Gods.</li>
                <li class="listli">Thou shalt teabag only in the wake of unquestionable ownage.</li>
                <li class="listli">Thou shalt not cheat nor support the farming of gold.</li>
                <li class="listli">Thou shalt not covet thy neighbor's rocket launcher; though shalt not covet thy neighbors epic mount, nor his video card, nor his high score.</li>
            </ul>
        </div>
    </center>
</div>
<%} else {%>
    <div class="alert alert-info">
        <button class="close" data-dismiss="alert" type="button">×</button> <strong>Confirmation:</strong>
            A confirmation email has been sent to your
            email.<br>
            Thank you for your registration. <%if (Register.checkInDay){ %><br /><br />Click <a href="/Checkin.aspx">here</a> to continue the checkin process.  Make sure you activate your account first.<%}%>
    </div>
<%}%>
</asp:Content>