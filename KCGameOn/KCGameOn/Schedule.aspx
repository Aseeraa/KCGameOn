<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="KCGameOn.Schedule" %>
<%@ Import Namespace="KCGameOn" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<head>
		
		<link rel="stylesheet" type="text/css" href="css/black/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="https://datatables.net/media/blog/bootstrap/DT_bootstrap.css">
		<script type="text/javascript" language="javascript" src="https://datatables.net/release-datatables/media/js/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="https://datatables.net/release-datatables/media/js/jquery.dataTables.js"></script>
    <style>
        div.dataTables_info {
	color: #4cff00

}
    </style>
		<script type="text/javascript" charset="utf-8">
		    /* Default class modification */
		    $.extend($.fn.dataTableExt.oStdClasses, {
		        "sSortAsc": "header headerSortDown",
		        "sSortDesc": "header headerSortUp",
		        "sSortable": "header"
		    });

		    /* API method to get paging information */
		    $.fn.dataTableExt.oApi.fnPagingInfo = function (oSettings) {
		        return {
		            "iStart": oSettings._iDisplayStart,
		            "iEnd": oSettings.fnDisplayEnd(),
		            "iLength": oSettings._iDisplayLength,
		            "iTotal": oSettings.fnRecordsTotal(),
		            "iFilteredTotal": oSettings.fnRecordsDisplay(),
		            "iPage": Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength),
		            "iTotalPages": Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength)
		        };
		    }

		    /* Bootstrap style pagination control */
		    $.extend($.fn.dataTableExt.oPagination, {
		        "bootstrap": {
		            "fnInit": function (oSettings, nPaging, fnDraw) {
		                var oLang = oSettings.oLanguage.oPaginate;
		                var fnClickHandler = function (e) {
		                    e.preventDefault();
		                    if (oSettings.oApi._fnPageChange(oSettings, e.data.action)) {
		                        fnDraw(oSettings);
		                    }
		                };

		                $(nPaging).addClass('pagination').append(
							'<ul>' +
								'<li class="prev disabled"><a href="#">&larr; ' + oLang.sPrevious + '</a></li>' +
								'<li class="next disabled"><a href="#">' + oLang.sNext + ' &rarr; </a></li>' +
							'</ul>'
						);
		                var els = $('a', nPaging);
		                $(els[0]).bind('click.DT', { action: "previous" }, fnClickHandler);
		                $(els[1]).bind('click.DT', { action: "next" }, fnClickHandler);
		            },

		            "fnUpdate": function (oSettings, fnDraw) {
		                var iListLength = 5;
		                var oPaging = oSettings.oInstance.fnPagingInfo();
		                var an = oSettings.aanFeatures.p;
		                var i, j, sClass, iStart, iEnd, iHalf = Math.floor(iListLength / 2);

		                if (oPaging.iTotalPages < iListLength) {
		                    iStart = 1;
		                    iEnd = oPaging.iTotalPages;
		                }
		                else if (oPaging.iPage <= iHalf) {
		                    iStart = 1;
		                    iEnd = iListLength;
		                } else if (oPaging.iPage >= (oPaging.iTotalPages - iHalf)) {
		                    iStart = oPaging.iTotalPages - iListLength + 1;
		                    iEnd = oPaging.iTotalPages;
		                } else {
		                    iStart = oPaging.iPage - iHalf + 1;
		                    iEnd = iStart + iListLength - 1;
		                }

		                for (i = 0, iLen = an.length ; i < iLen ; i++) {
		                    // Remove the middle elements
		                    $('li:gt(0)', an[i]).filter(':not(:last)').remove();

		                    // Add the new list items and their event handlers
		                    for (j = iStart ; j <= iEnd ; j++) {
		                        sClass = (j == oPaging.iPage + 1) ? 'class="active"' : '';
		                        $('<li ' + sClass + '><a href="#">' + j + '</a></li>')
									.insertBefore($('li:last', an[i])[0])
									.bind('click', function (e) {
									    e.preventDefault();
									    oSettings._iDisplayStart = (parseInt($('a', this).text(), 10) - 1) * oPaging.iLength;
									    fnDraw(oSettings);
									});
		                    }

		                    // Add / remove disabled classes from the static elements
		                    if (oPaging.iPage === 0) {
		                        $('li:first', an[i]).addClass('disabled');
		                    } else {
		                        $('li:first', an[i]).removeClass('disabled');
		                    }

		                    if (oPaging.iPage === oPaging.iTotalPages - 1 || oPaging.iTotalPages === 0) {
		                        $('li:last', an[i]).addClass('disabled');
		                    } else {
		                        $('li:last', an[i]).removeClass('disabled');
		                    }
		                }
		            }
		        }
		    });

		    /* Table initialisation */
		    $(document).ready(function () {
		        $('#example').dataTable({
		            "iDisplayLength": 5,
                    "order":[[0, "desc"]],
		            "sDom": "<'row'<'span8'><'span8'f>r>t<'row'<'span8'i><'span8'p>>",
                    //"dom": '<"top"i>rt<"bottom"flp><"clear">',
		            "sPaginationType": "bootstrap",
		            "oLanguage": {
		                "sLengthMenu": "_MENU_ records per page"
		            }
		        });
		    });
		</script>
</head>
<div class="container">
<h2>Upcoming Events</h2>
<table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="Table1">
	<thead>
		<tr>
			<th>Event</th>
			<th>Event Date</th>
			<th>Time</th>
		</tr>
	</thead>
	<tbody>
		<%=Schedule.ScheduleHTMLActive%>
	</tbody>
</table>
    <h2>Previous Events</h2>
    <table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="example">
	<thead>
		<tr>
			<th>Event</th>
			<th>Event Date</th>
			<th>Time</th>
			<th>Attendance</th>
		</tr>
	</thead>
	<tbody>
		<%=Schedule.ScheduleHTMLOld%>
	</tbody>
</table>
			
		</div>
</asp:Content>