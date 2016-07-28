<%@ Page Title="Travel" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Travel.aspx.cs" Inherits="KCGameOn.FAQ.Travel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    table {
    /* cellspacing */
    border-collapse: collapse;
    border-spacing: 0;
    margin:auto;
    
}
th, td {
     
    text-align:left;
}
</style>
    <img src="/img/2702.png" />
<center><h2><b>Travel and Venue Information:</b></h2></center>
<form class="well form-inline">	
    
    <table style="width:100%" id="example">
	
	    <tr>
		    <th>
                <p>address:</p>
                <p><a href="https://www.google.com/maps/place/2702+Rock+Creek+Pkwy,+Kansas+City,+MO+64117/@39.151148,-94.547333,17z/data=!3m1!4b1!4m5!3m4!1s0x87c0f9f67a2fffe5:0xf2cfbbd58020c35!8m2!3d39.151148!4d-94.547333?hl=en">2702 Rock Creek Parkway, North Kansas City, MO 64117</a></p>
			    <p>Located in North Kansas City, MO (nearly the centerpoint of the KC Metro) - our venue is right off of I-35 and Armour Road, just north of downtown KCMO.  There is no public transportation to this area on Saturdays so you will need to drive/carpool to the event.</p>
                <p>Please park in any legal spot around the building that is available.  You can park temporarily outside the entrance of the building to drop off your stuff and check-in, but you must move your vehicle as soon as possible.  Security will keep the firelane clear if your car is parked there for more than 10 minutes.</p>
                <p>We do not have any special discounts or sponsorships with hotels at this time because this event is only 15 hours long.  Feel free to come and go during the event whenever you please.  If you are interested in staying overnight, let us know and with enough interest, we can visit with area hotels.</p>
		    </th>
		    <th>
			    <p><iframe width="600" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://my.ctrlq.org/maps/#roadmap|18|39.15034591368102|-94.54685690789984"></iframe></p>
			
		    </th>
		   	    </tr>
    </table>
   <!-- <center>
	<p>Webmasters: Hrishikesh Patel, Dan Robison
    <p>Also a giant thank you to those who assist us at the various campuses collecting money for the LAN:</p>
    <table style="width:30%" cellpadding="20" cellspacing="10" border="0" id="example" >
	
	    <tr>
		    <td>Mike Rooney - WHQ</td>
			<td>Mason Payne - IC</td>
		</tr>
		<tr>
			<td>Ryan Robertson - IC</td>
			<td>Nick O’Brien - Oaks</td>
		</tr>
		</table>
	<br />


    <p>...and a special THANKS! and mad props to everyone who sticks around to help clean up after the event.</p>
    </center> -->
</form>
</asp:Content>
