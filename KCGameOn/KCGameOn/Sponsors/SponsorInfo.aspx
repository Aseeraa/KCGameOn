<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SponsorInfo.aspx.cs" Inherits="KCGameOn.Sponsors.SponsorInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        p, th {
            text-align: left;
        }

        tr {
border-bottom: 2pt solid white;
border-top: 2pt solid white;
padding: 10pt 15pt 15pt 15pt;

}
    </style>
    <h2><b>Sponsorship Tiers:</b></h2>
    <br />
    <form class="well form-inline">

        <!-- <p><b>Platinum Level:</b></p><br/> -->
        <table style="width: 100%" cellpadding="10" cellspacing="40" border="0" id="example">
            <tr>
                <td>
                    <p>
                        <h2>Event Sponsor - $3000</h2>
                    </p>
                    <p>Limit: 2</p>
                </td>
                <td>
                    <ul>
                        <li>Company Logo and Descriptor on dedicated sponsor page</li>
                        <li>Logo Placement on front page of KCGameOn.com</li>
                        <li>Logo on Sponsor page as Event Sponsor</li>
                        <li>Mention in all email newsletters to KCGameOn database of gamers</li>
                        <li>Two Combined marketing posts to Facebook and Twitter Pages</li>
                        <li>Logo placed on twitch streams between matches during tournament</li>
                        <li>Logo placed on twitch stream for tournament next to ours during live stream.</li>
                        <li>Placement of one banner in a high traffic location when you enter the hall</li>
                        <li>Registration table sponsor standee</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>Logo on event signage where appropriate</li>
                        <li>6' wide exhibitor booth with 2 chairs</li>
                        <li>4 event passes</li>

                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <ul>

                        <li>Logo Placement on front page of KCGameOn.com</li>

                        <li>Mention in all email newsletters to KCGameOn database of gamers</li>
                        <li>Two Combined marketing posts to Facebook and Twitter Pages</li>
                        <li>Logo placed on twitch streams between matches during tournament</li>

                        <li>Placement of one banner in the hall</li>
                        <li>Registration table sponsor standee</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>Logo on event signage where appropriate</li>

                        <li>3 event passes</li>

                    </ul>
                </td>
                <td>
                    <p>
                        <h2>Dinner Sponsor - $1500</h2>
                    </p>
                    <p>Limit: 3</p>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        <h2>Snack Sponsor - $700</h2>
                    </p>
                    <p>Limit: 2</p>
                </td>
                <td>
                    <ul>

                        <li>Mention in one email newsletters to KCGameOn database of gamers</li>
                        <li>Two Combined marketing posts to Facebook and Twitter Pages</li>
                        <li>Logo placed on twitch streams between matches during tournament</li>

                        <li>Placement of one banner in the hall</li>
                        <li>Registration table sponsor standee</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>Logo on event signage where appropriate</li>

                        <li>3 event passes</li>

                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <ul>

                        <li>Logo on sponsor page as Platinum Sponsor</li>

                        <li>Mention in one email newsletter to KCGameOn database of gamers</li>

                        <li>Logo placed on twitch streams between matches during tournament</li>

                        <li>Placement of one banner in the hall</li>
                        <li>Registration table sponsor standee</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>Logo on event signage where appropriate</li>

                        <li>2 event passes</li>

                    </ul>
                </td>
                <td>
                    <p>
                        <h2>Platinum Sponsor - $1000</h2>
                    </p>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        <h2>Gold Sponsor - $500</h2>
                    </p>
                </td>
                <td>
                    <ul>

                        <li>Logo on sponsor page as Gold Sponsor</li>

                        <li>Mention in one email newsletter to KCGameOn database of gamers</li>

                        <li>Logo placed on twitch streams between matches during tournament</li>


                        <li>Registration table sponsor standee</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>


                        <li>2 event passes</li>

                    </ul>
                </td>
            </tr>
            <tr>

                <td>
                    <ul>



                        <li>Mention in one email newsletter to KCGameOn database of gamers</li>

                        <li>Logo placed on twitch streams between matches during tournament</li>
                        <li>Portion of funds go to tournament prize</li>
                        <li>Tournament 'Presented By' (all forms of media)</li>
                        <li>Placement of one banner near tournament gamers</li>

                        <li>Verbal appreciation during announcements and prize giveaways</li>

                        <li>2 event passes</li>

                    </ul>
                </td>
                <td>
                    <p>
                        <h2>Tournament Sponsor - $500</h2>
                    </p>
                    <p>Limit: 3</p>
                </td>
            </tr>
            <tr>
                <td>
                    <p>
                        <h2>Exhibitor Booth - $500</h2>
                    </p>
                    <p>6'x 3' table</p>
                </td>
                <td>
                    <ul>
                        <li>Logo placed on the exhibitor page</li>
                        <li>Ability to sell goods/services (food/drink is not allowed to be sold per venue)</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>6' wide exhibitor booth with 2 chairs</li>

                        <li>2 event passes</li>

                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <ul>
                        <li>Logo placed on the exhibitor page</li>
                        <li>Ability to sell goods/services (food/drink is not allowed to be sold per venue)</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>3' wide exhibitor booth with 1 chair</li>

                        <li>1 event pass</li>

                    </ul>
                </td>
                <td>
                    <p>
                        <h2>Exhibitor Booth - $250</h2>
                    </p>
                    <p>3'x 3' table</p>
                </td>

            </tr>
            <tr>
                <td>
                    <p>
                        <h2>Social Media Tournament Sponsor - $250</h2>
                    </p>

                </td>
                <td>
                    <ul>

                        <li>Logo placed on twitch streams between matches during tournament</li>
                        <li>Placement of one banner near tournament gamers</li>
                        <li>Verbal appreciation during announcements and prize giveaways</li>
                        <li>1 event pass</li>

                    </ul>
                </td>
            </tr>
        </table>

    </form>


</asp:Content>
