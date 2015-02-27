<%@ Page Title=" "Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="KCGameOn.Schedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>2015 LAN schedule</h2><br />
	<form class="well form-inline">
        
        		
        <asp:Table ID="Table1" runat="server" CellPadding ="25" border="0">
            <asp:TableRow>
                <asp:TableCell>Tournament</asp:TableCell>
                <asp:TableCell>Date</asp:TableCell>
                <asp:TableCell>Start Time</asp:TableCell>
                <asp:TableCell>Stop Time</asp:TableCell>
				<asp:TableCell>Attendance</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TRow1"></asp:TableCell>
                <asp:TableCell ID="DRow1"></asp:TableCell>
                <asp:TableCell ID="StartRow1"></asp:TableCell>
                <asp:TableCell ID="StopRow1"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TRow2"></asp:TableCell>
                <asp:TableCell ID="DRow2"></asp:TableCell>
                <asp:TableCell ID="StartRow2"></asp:TableCell>
                <asp:TableCell ID="StopRow2"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TRow3"></asp:TableCell>
                <asp:TableCell ID="DRow3"></asp:TableCell>
                <asp:TableCell ID="StartRow3"></asp:TableCell>
                <asp:TableCell ID="StopRow3"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TRow4"></asp:TableCell>
                <asp:TableCell ID="DRow4"></asp:TableCell>
                <asp:TableCell ID="StartRow4"></asp:TableCell>
                <asp:TableCell ID="StopRow4"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TRow5"></asp:TableCell>
                <asp:TableCell ID="DRow5"></asp:TableCell>
                <asp:TableCell ID="StartRow5"></asp:TableCell>
                <asp:TableCell ID="StopRow5"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TRow6"></asp:TableCell>
                <asp:TableCell ID="DRow6"></asp:TableCell>
                <asp:TableCell ID="StartRow6"></asp:TableCell>
                <asp:TableCell ID="StopRow6"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
		<p> 
			For access to the google calender, click <a href="https://www.google.com/calendar/embed?src=M2w1NzE1YW4xajdodHV0NTJrbDhmYTRodG9AZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ">HERE</a>.
 
			If you want to add it to your own calendar, click the '+ google calendar' icon in the bottom right corner.
			
        </p>
    </form>
</asp:Content>
