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
                    <p>KCGAMEON started as a LAN (Local Area Network) party in 2005. It is basically a small group of gamers who pack up their computers, 
            (BYOC = Bring your own computer), set up their rigs by plugging into a local network, and would play games until their eyes bleed. A lot of things have changed since the days of 30 players.</p>
                    <p>Over the last few years we have expanded our event to encompass all forms of gaming/fun - PC, console, hand-held gaming, tabletop and tinyWhoop (drones).</p>
                    <p>Both men and women attend these events, which include tournaments for various games.  Some of these tournaments have prizes. </p>
                    <p>We typically provide food and snacks/drinks/candy throughout the event.</p>
                    
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
                    <p>There is a cost of $20 for BYOC and $15 for everyone else at this event (including spectators).
			        <p>This website will allow you to pay via paypal when you <a href="http://kcgameon.com/EventRegistration.aspx">register</a> for the next event.</p>
                    <p>You also have the option to pay $25 at registration table as you walk in the door - but this does not guarantee you a seat.  The $25 dollars goes for everyone, both BYOC and all over players/spectators.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Why do you charge for this event?</label>
                <div class="Content">
                    <p>We know that in order to retain players over time, we must provide value for the player.</p>
                    <p>A portion also goes to purchasing candy/snacks and sometimes we need to buy more infrastructure - new cat5/multiplugs/etc.  We are fortunate enough to have our building expenses and dinner paid for through sponsorship!</p>
                    <p>The staff does not make a dime.  The event does not exist to make money off of the gamer - we are only here to network and above all - HAVE FUN!</p>
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
                    <p>Well, it all depends on how many prizes we get from our current sponsors and how many we purchase out right, but typically it is 10-20 door prizes per event.</p>
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
                <label class="Menubody-trigger">What is this "Loyalty Event?"</label>
                <div class="Content">
                    <p>The "Loyalty Event" WAS always the last event of each year (usually first weekend of December).</p>
                    <p>We have now discontinued the loyalty event.  This is an unfortunate side effect to our growth, but we do play to still give away prizes.</p>
                    <p>The new format will pick names and the player will have to pick up the prize.  No more sitting around for two hours - we have gaming to do! </p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">What tournaments do you run at KCGAMEON?</label>
                <div class="Content">
                    <p>This is largely dependent on user interest.  Here is a <a href="http://kcgameon.com/Tournaments.aspx">current list</a> of all of the tournaments at this event.</p>
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
                <label class="Menubody-trigger">Can I refer a new gamer even if I haven't been to a KCGO event?</label>
                <div class="Content">
                    <p>Absolutely, please feel free to use social media to spread the good word as well.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I refer more than one gamer to the KCGO event?</label>
                <div class="Content">
                    <p>Absolutely, please feel free to use social media to spread the good word as well.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I pay for a friend?</label>
                <div class="Content">
                    <p>Yes, you sure can. When going through the <a href="http://kcgameon.com/EventRegistration.aspx">registration process</a>, just be sure to add their name to your checkout before hitting the PAY NOW button.</p>
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
                    <p>We need a minimum of 30 person pay for the event fee. We have had to cancel events in the past, but it has been many, many years since we did. :)</p>
                    <p>Take a look at the <a href="http://kcgameon.com/Schedule.aspx">schedule</a> page for a long history of attendence counts.</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Can I cancel?</label>
                <div class="Content">
                    <p>Due to the overwhelming number of players, we no longer accept cancellations.  Please be sure you can make it before you buy a ticket.</p>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
