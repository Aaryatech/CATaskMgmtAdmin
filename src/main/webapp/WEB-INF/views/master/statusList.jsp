<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>

	<!-- Main navbar -->
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<!-- /main navbar -->


	<!-- Page content -->
	<div class="page-content">

		<!-- Main sidebar -->
		<jsp:include page="/WEB-INF/views/include/left.jsp"></jsp:include>
		<!-- /main sidebar -->


		<!-- Main content -->
		<div class="content-wrapper">

			<!-- Page header -->
			<div class="page-header page-header-light">

<%-- 
				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>

					</div>
					<div class="breadcrumb justify-content-center">
						<c:if test="${addAccess == 0}"> 
							<a href="${pageContext.request.contextPath}/service"
								class="breadcrumb-elements-item"> Add Service </a>
						</c:if>

					</div>

				</div> --%>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						
						 <table  width="100%">
						 <tr  width="100%">
						 <td width="60%"><h5 class="card-title">Custom Status List</h5></td>
						 <td  width="40%" align="right"><c:if test="${addAccess==0}"><a href="${pageContext.request.contextPath}/addStatus"
								class="breadcrumb-elements-item"> <button
													type="button" class="btn btn-primary">
													Add Status
												</button> </a></c:if></td>
						 </tr>
						 </table>	
					</div>
					
					<form method="post" id="service_list">
					<div class="card-body">

						<%
							if (session.getAttribute("errorMsg") != null) {
						%>
						<div
							class="alert bg-danger text-white alert-styled-left alert-dismissible">
							<button type="button" class="close" data-dismiss="alert">
								<span>×</span>
							</button>
							<span class="font-weight-semibold"> </span>
							<%
							out.println(session.getAttribute("errorMsg"));
							%>
						</div>

						<%
							session.removeAttribute("errorMsg");
							}
						%>
						<%
							if (session.getAttribute("successMsg") != null) {
						%>
						<div
							class="alert bg-success text-white alert-styled-left alert-dismissible">
							<button type="button" class="close" data-dismiss="alert">
								<span>×</span>
							</button>
							<span class="font-weight-semibold"></span>
							<%
							out.println(session.getAttribute("successMsg"));
							%>
						</div>
						<%
							session.removeAttribute("successMsg");
							}
						%>
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">
									<th width="10%">Sr.no</th>
									<th>Status</th>
									<th>Status Description</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>
							<c:forEach items="${statusList}" var="statusList" varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td>${statusList.statusText}</td>
								<td>${statusList.statusDesc}</td>
								<td><c:if test="${editAccess==0}"><a href="${pageContext.request.contextPath}/editStatus?statusId=${statusList.statusMstId}" title="Edit"><i class="icon-pencil7"
										style="color: black;"></i></a> </c:if>
								<c:if test="${deleteAccess==0}"><%-- <a
									href="${pageContext.request.contextPath}/deleteStatus?statusId=${statusList.statusMstId}" 
									onClick="return confirm('Are you sure want to delete this record');"
									title="Delete"><i class="icon-trash" style="color: black;"></i>
								</a> --%>
								
								 <a href="javascript:void(0)"
class="list-icons-item text-danger-600 bootbox_custom"
data-uuid="${statusList.statusMstId}" data-popup="tooltip"
title="" data-original-title="Delete"><i class="icon-trash" style="color: black;"></i></a>
								
								</c:if></td>
							</tr>
							</c:forEach>										
						</table>
					</div>
					
					</form>
					
				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
</body>
<script>
// Custom bootbox dialog
$('.bootbox_custom')
.on(
'click',
function() {
var uuid = $(this).data("uuid") // will return the number 123
bootbox.confirm({
title : 'Confirm ',
message : 'Are you sure you want to delete selected records ?',
buttons : {
confirm : {
label : 'Yes',
className : 'btn-success'
},
cancel : {
label : 'Cancel',
className : 'btn-link'
}
},
callback : function(result) {
if (result) {
location.href = "${pageContext.request.contextPath}/deleteStatus?statusId="
+ uuid;

}
}
});
});
</Script>
</html>