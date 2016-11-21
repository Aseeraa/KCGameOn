<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Jersey.aspx.cs" Inherits="KCGameOn.Jersey" %>

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
    
    
    <p><center>
    <img src="/img/wearingjersey.jpg" />
    
        <h2><b>KCGameON Jersey Info:</b></h2>
    </p>
    </center>
    <form class="well form-inline">
        <div class="row">
        
                <div class="col-sm-3">
                    <center><a href="/img/hockeyjersey.png"><p>Hockey Jersey</p><img src="/img/hockeyjersey.png" style="padding-top: 5px" /></a></center>
                    
                </div>
       
                <div class="col-sm-5">
                    <center><a href="/img/tshirtjersey.png"><p>Tshirt Jersey</p><img src="/img/tshirtjersey.png" style="padding-top: 5px" /></a></center>
                    
                </div>
              
                <div class="col-sm-3">
                    <center><a href="/img/baseballjersey.png"><p>Baseball Jersey</p><img src="/img/baseballjersey.png" style="padding-top: 5px" /></a></center>
                    
                </div>
          
    
               
            </div>
        
        <table style="width: 100%" id="example">

            <tr>
                <th>
                    <p>
                        <h3>Jersey Types:</h3>
                    </p>
                    <p>Hockey($80)</p>
                    <p>Tshirt($50)</p>
                    <p>Baseball jersey($80)</p>
                    <p>pay via paypal: payments@kcgameon.com</p>
                    <p>
                        <h3>Order form info:</h3>
                    </p>
                    <p>Custom Name (game name)</p>
                    <p>Size</p>
                    <p>Number</p>
                    <p>Once the payment is received through paypal, we will order the jersey.  It normally takes 4-6 weeks and will deliver at the next KCGameOn event!</p>
                </th>
                <th>
                    <p>
                        <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSfdd7hF2pFevw2dTDnAhlOFx43WCN6LrYMitwbyG7Sql_eLCw/viewform?embedded=true" width="600" height="400" frameborder="0" marginheight="0" marginwidth="0">Loading...</iframe>
                    </p>

                </th>
            </tr>
        </table>

    </form>

</asp:Content>
