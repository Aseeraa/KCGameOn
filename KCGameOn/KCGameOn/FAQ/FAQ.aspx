<%@ Page Title="GameOn FAQ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="KCGameOn.FAQ.FAQ" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <head>
        <script type="text/javascript">
            jQuery(document).ready(function () {
                jQuery(".Content").hide();
                //toggle the componenet with class msg_body
                jQuery(".Menubody-trigger").click(function () {
                    // For Nav Labels
                    if ($(this).hasClass("Menubody-trigger-active")) {
                        $(this).removeClass("Menubody-trigger-active");
                        $(this).parent().find('.Content').stop(true, true).slideUp(500);
                    }
                    else {
                        $(this).addClass("Menubody-trigger-active");
                        $(this).parent().find('.Content').stop(true, true).slideDown(500);
                        //$(this).parent().find('.Content2').hide();
                    }
                });
            });
        </script>
    </head>

    <h2>FAQ</h2>
    <br />
    <form class="well form-inline">
        <div class="UImenu">
            <div class="UImenuItem">
                <label class="Menubody-trigger">What is KCGAMEON?</label>
                <div class="Content">
                    <p>
                        KCGAMEON started as a LAN (Local Area Network) party. It is basically a bunch of gamers who pack up their computers, 
            (BYOC = Bring your own computer), set it up in a room with many other gamers, plug into a network connection, 
            and play games until their eyes bleed. Both men and women attend LANs, some LANs include tournaments in which 
            the winner may win a prize. Usually there is food provided. Over the last few years we have expanded our event to encompass all forms of gaming - PC, Console, Boardgames and Card games.
                    </p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">How many events are their a year?</label>
                <div class="Content">
                    <p>There are SIX events each year. They are roughly 6-8 weeks apart. During the summer we tend to spread them out little more due to folks being on vacations and what not.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">How much does it cost and who do I pay?</label>
                <div class="Content">
                    <p>
                        There is a cost of $15 to attend each LAN.
			<p>This website will allow you to pay via paypal (dalha_is@hotmail.com) or bitcoin when you register for the next LAN.</p>
                        <p>If you wish to pre-pay in cash, there will be a list of persons to pay in each e-blast prior to the event.</p>
                        <p>You also have the option to pay $20 at registration table as you walk in the door - but this does not guarantee you a seat.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Why do you charge for the LAN?</label>
                <div class="Content">
                    <p>We wanted to create something to give back to the gamer, so we decided the best way to do that is by giving away GREAT prizes at the end of each year.</p>
                    <p>The majority of the money goes into those "Loyalty Event" prizes.  A portion also goes to purchasing candy/snacks and sometimes we need to buy more infrastructure - new cat5/multiplugs/etc.  We are fortunate enough to have our building expenses and dinner paid for through sponsorship!</p>
                    <p>The Staff does not make a dime.  The LAN does not exist to make money off of the gamer - we are only here to network and above all - HAVE FUN!</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Are they safe?</label>
                <div class="Content">
                    <p>No alcohol, drugs or weapons are allowed, just gaming.</p>
                    <p>The worst thing that could happen is...you could get a tooth ache, carpal tunnel syndrome or tennis elbow.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">What are my odds of winning a prize?</label>
                <div class="Content">
                    <p>Well, it all depends on how many prizes we get from our current sponsors and how many we purchase out right, but typically it is 4-8 door prizes per event.</p>
                    <p>Keep in mind, not all of our sponsors contribute through products. Our "Loyalty Event" is where you have the largest percent chance to get a prize.  The more events you make during the year, the more chances you have to win!</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Who sponsors KCGAMEON?</label>
                <div class="Content">
                    <p>Please see our current sponsor list, shown <a href="../Sponsors.aspx">HERE</a>.</p>
                    <p>We try to get additional sponsors all the time, so this is always changing.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">What is this "Loyalty Event" you always talk about at each LAN?</label>
                <div class="Content">
                    <p>The "Loyalty Event" is always the last event of each year (usually first weekend of December).</p>
                    <p>Each LAN, after we confirm you have paid, you will receive a blue ticket.  You write your name on the ticket and we put these tickets into a bucket for prizes.  We use this bucket for that event's door prize selection.  After the door prize drawings are over, we put all the names back into the bucket and the bucket is kept in a secret, safe place until the first weekend of December.</p>
                    <p>With all tickets combined for the first five events of the year, we start drawing names for prizes.  We bring prizes out one at a time and typically from least value to most valuable - so you don't know what is coming next..and if your name is called, you have an option.  Say 'yes' and take the current prize or say 'no' and decline the prize.  All tickets drawn are thrown out, so if you only have two tickets and this is your second ticket drawn, you better take the prize.  We keep drawing until someone says yes to each prize.  Keep in mind - once you take a prize, you are also done - so if your name comes up again, you are no longer eligible for any other prize.  It creates some mystery and fun while encouraging everyone to come to each LAN to get five total tickets to increase your chances.</p>
                    <p>We typically have 40+ prizes valued at $50 or more.  I expect that to continue to grow as our numbers have doubled in the last two years.  Some of our larger prizes have included various laptops, tablets, barebones computers, etc.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">What tournaments do you run at KCGAMEON?</label>
                <div class="Content">
                    <p>This is largely dependent on user interest.  Currently, <a href="http://www.ransomgaming.com">Ransom Gaming</a> is running a League of Legends tournament at each LAN.</p>
                    <p>If you have a favorite game and you want to get a tournament going, just let us know and we will get signups going at the registration desk.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I bring an extra server?</label>
                <div class="Content">
                    <p>Only if you request and get approved by the staff.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I refer a new gamer even if I haven't been to a LAN?</label>
                <div class="Content">
                    <p>Yes, have them contact a staff member for details and to answer any questions.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I refer more than one gamer to the LAN?</label>
                <div class="Content">
                    <p>Yes, have them each contact a staff member.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I pay for a friend?</label>
                <div class="Content">
                    <p>Yes, you sure can. Please put their name in the description on paypal. This way we know it is for.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">How can I support KCGAMEON?</label>
                <div class="Content">
                    <p>You can help support GameOn by purchasing products from our sponsors. If you see them in person be sure to thank them for their support.</p>
                    <p>Invite your friends, defeat that nerdist perception and make them aware this is a pretty cool event!</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">How many people need to attend before an event is cancelled?</label>
                <div class="Content">
                    <p>We need a minimum of 30 person pay for the event fee. We have had to cancel events in the past, but it has been many years since we did. :)</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">How do I cancel?</label>
                <div class="Content">
                    <p>You must email a staff person with the words "cancel and your gamer-name" before the event. If you don't, your money may be forfeited. If you do contact a staff person, then your next event you attend will be paid.</p>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
