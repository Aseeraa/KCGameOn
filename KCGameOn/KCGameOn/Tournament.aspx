<%@ Page Title=" " Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tournament.aspx.cs" Inherits="KCGameOn.Tournament" %>

<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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

    <%if (!String.IsNullOrEmpty(SessionVariables.UserName))
      {%>
    <h2>Event Tournaments</h2>
    <br />
    <form class="well form-inline">
        <p>Current tournaments happening at KCGameOn LAN events.<br />
        </p>
        <div class="UImenu">
            <div class="UImenuItem">
                <label class="Menubody-trigger">League of Legends</label>
                <div class="Content">
                    <p>Coming soon!</p>

                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Counter Strike</label>
                <div class="Content">
                    <p>Coming soon!</p>
                </div>
            </div>
            <div class="UImenuItem">
                <label class="Menubody-trigger">Hearthstone</label>
                <div class="Content">
                    <p>Coming soon!</p>
                </div>
            </div>
        </div>
        <br />
        If you want to request a tournament for a particular game, please let us know and we will work on getting one set up!
    </form>
    <%}
      else
      {%>
    <h2>Please <a href="/Account/Login.aspx">login</a> to view this page.</h2>
    <br />
    <%} %>
</asp:Content>
