﻿<%@ Page Title="Venue2" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Venue2.aspx.cs" Inherits="KCGameOn.FAQ.Venue2" %>

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
    <img src="/img/2702.png" />
    <center>
        <h2><b>Travel and Venue Information:</b></h2>
    </center>
    <form class="well form-inline">

        <table style="width: 100%" id="example">

            <tr>
                <th>
                    <p>
                        <h3>Address:</h3>
                    </p>
                    <p><a href="https://www.google.com/maps/place/KCI+Expo+Center/@39.307019,-94.6850167,17z/data=!4m5!3m4!1s0x87c05e8149321a0d:0x3307d3c3cf3af9ec!8m2!3d39.307019!4d-94.682828?hl=en">11730 NW Ambassador Dr, Kansas City, MO 64153</a></p>
                    <p>Located in North Kansas City, MO (nearly the centerpoint of the KC Metro) - our venue is right off of I-35 and Armour Road, just north of downtown KCMO.  There is no public transportation to this area on Saturdays so you will need to drive/carpool to the event.</p>
                    <p>Please park in any legal spot around the building that is available.  You can park temporarily outside the entrance of the building to drop off your stuff and check-in, but you must move your vehicle as soon as possible.  Security will keep the firelane clear if your car is parked there for more than 10 minutes.</p>
                    <p>We have no special discounts or sponsorships with hotels at this time.</p>
                    <p>
                        <h3>Rules:</h3>
                    </p>
                    <p>No alcohol is allowed in the venue</p>
                    <p>No smoking of any kind (cig/vape/other) is allowed on the campus - please use your car or walk across the street (west of Walker Rd)</p>
                    <p>No derogatory, defamation, racist or otherwise offensive words will be used at KCGameOn.  You will get one warning, unless otherwise blatently over the line, then you will be asked to leave immediately.</p>
                </th>
                <th>
                    <p>
                        <iframe width="600" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.com/maps/embed/v1/place?q=39.307019,-94.6850167&key=AIzaSyAN0om9mFmy1QN6Wf54tXAowK4eT0ZUPrU"></iframe>
                    </p>

                </th>
            </tr>
        </table>

    </form>
</asp:Content>
