<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeaturedCharity.aspx.cs" Inherits="KCGameOn.FeaturedCharity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        table {
            border-collapse: collapse;
            border-spacing: 0;
            margin: auto;
        }

        th, td {
            text-align: left;
        }
    </style>
    <img src="/img/charity.jpg" />
    <center>
        <h2><b>Featured Charity: Play to Beat Cancer</b></h2>
    </center>
    <form class="well form-inline">

        <table style="width: 100%" id="example">

            <tr>
                <th>
                   
                    <p>We at Play To Beat Brain cancer, a non-profit charity, work to raise money to help those in need.   The money we raise goes to help those in need.  Those that are struggling with medical debt due to Brain Cancer.</p>
                    <p> We do this by having tabletop tournaments, twitch stream events, sporting events and carnivals.</p>
                    <p>The money we raise goes to help those in need.  Those that are struggling with medical debt due to Brain Cancer.</p>
                    <p>Come by our table, buy a ticket to play a game or two, win a prize, or just come by to talk.  We are here to play games, have fun and maybe help relieve someone’s stress.  We will have a few different games to play, video and other.  We will also have some items for sale.</p>
                    <p></p>
                    <p><a href="https://www.facebook.com/PTBBC1/"><img src="/icon/soc1.png" /></a> 
                    <a href="https://twitter.com/playtobeat_bc"><img src="/icon/twitter.png" /></a> 
                    <a href="https://www.twitch.tv/playtobeat_bc"><img src="/icon/twitch.png"></a>
                       | <a href="http://www.pttbc.org">Website</a>
                    </p>
                    <hr />
                    <p>If you have a gaming related charity you would like to represent at a future event, please contact me at <a href="nick [at] kcgameon.com"
   rel="nofollow"
   onclick="this.href='mailto:' + 'webmaster' + '@' + 'kcgameon.com'">HERE</a></p>
                  </th>
                <th>
                    <p>
                        <img src="/img/ptbbclogo.png" />
                    </p>

                </th>
            </tr>
        </table>

    </form>
</asp:Content>
