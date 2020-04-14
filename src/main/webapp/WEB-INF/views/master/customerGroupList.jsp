<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="showChatBox()">
<c:url value="/getCustListByGrpIdAjax" var="getCustListByGrpIdAjax"></c:url>
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
							<a href="" class="breadcrumb-item"><i class="icon-home2 mr-2"></i>
								Home</a> <span class="breadcrumb-item active"></span>
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

 <!-- Large modal -->
				<div id="modal_large" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 id="c_title"  class="modal-title"> </h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">
								<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="custListTable">
							<thead>
							
								<tr class="bg-blue">
							 		<th width="10%">Sr.no</th>
									<th>Firm Name</th>
									<th>Assesse Name</th>
									<th>PAN No.</th>
									<th>Email</th>
									<th>Contact</th>
									<!-- <th class="text-center" width="10%">Actions</th> -->
								</tr>
							</thead>
							<tbody>
							
							
							</tbody>
							</table>
							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /large modal -->




			<!-- Content area -->
			<div class="content">
<%-- <div id="myModal" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-success">
					<table style="background-color: #4CAF50;" width="100%">

						<tr>
							<td width="80%">
								<h5>
									Task Name - <span id="mdTaskName" class="font-weight-semibold">
									</span> <small class="d-block opacity-75" id="mdOwnerPartner">Owner
										Partner - ${task.ownerPartner} </small>
								</h5>
							</td>
							<td>
								<div align="center">
									<div class="btn" style="background-color: white;"
										id="mdTaskStatus">${task.taskStatus}</div>
									<normal class="d-block opacity-75" style="color: white;">Current
									Status</normal>
								</div>
							</td>
							<td style="color: white; padding: .8rem 1rem;">
								<a href="${pageContext.request.contextPath}/taskListForEmp"><button
													type="button" class="btn btn-primary" id="cancelbtn">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Back
												</button></a>
							</td>
						</tr>

					</table>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body" id="modalbody">
					<!-- Content will be loaded here from "remote.php" file -->
					Wait...
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>

				</div> -->
			</div>
		</div>
	</div> --%>

				<!-- Highlighting rows and columns -->
				<div class="card"><!-- <button type="button" class="btn btn-light" data-toggle="modal" data-target="#modal_large">Launch <i class="icon-play3 ml-2"></i></button> -->
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Customer Group</h5></td>
								<td width="40%" align="right"><c:if test="${addAccess==0}"><a
									href="${pageContext.request.contextPath}/customerGroupAdd"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Add
											Group</button>
								</a></c:if>
								</td>
							</tr>
						</table>
					</div>

					<div class="card-body">

						<%
							if (session.getAttribute("errorMsg") != null) {
						%>
						<div
							class="alert bg-danger text-white alert-styled-left alert-dismissible">
							<button type="button" class="close" data-dismiss="alert">
								<span>×</span>
							</button>
							<span class="font-weight-semibold"></span>
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
									<th>Name</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>
							<c:forEach items="${custGrpList}" var="custGrpList" varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td><a data-toggle="modal" onclick="getCustListbyGroupId(${custGrpList.custGroupId},'${custGrpList.custGroupName}')" data-target="#modal_large" href="#"
									
									title="List of Customer">
								${custGrpList.custGroupName}</a></td>
								
								<td class="text-center"><c:if test="${editAccess==0}"><a href="${pageContext.request.contextPath}/editCustGrp?custGrpId=${custGrpList.custGroupId}" title="Edit"><i class="icon-pencil7"
										style="color: black;"></i></a></c:if> 
								<c:if test="${deleteAccess==0}"><a href="${pageContext.request.contextPath}/deleteCustGrp?custGrpId=${custGrpList.custGroupId}"
									onClick="return confirm('Are you sure want to delete this record');"
									title="Delete"><i class="icon-trash" style="color: black;"></i>
								</a></c:if>
								
								<a   href="${pageContext.request.contextPath}/getCustListByGrpId?custGrpId=${custGrpList.custGroupId}"  
									
									target="_blank" title="List of Customer"><i class="icon-three-bars"
										style="color: black;"></i>
								</a>
								
							<%-- 	<a data-toggle="modal" data-target="#modal_large" href="${pageContext.request.contextPath}/getCustListByGrpId?custGrpId=${custGrpList.custGroupId}"
									
									title="List of Customer"><i class="icon-three-bars""
										style="color: black;"></i>
								</a> --%>
								</td>				

							</tr>
							</c:forEach>
							

							<%-- <tbody>


								<c:forEach items="${compList}" var="compList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${compList.companyName}</td>
										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editCompany?compId=${compList.exVar1}"
													title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
												<a
													href="${pageContext.request.contextPath}/editCompany?compId=${compList.exVar1}"
													title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/deleteCompany?compId=${compList.exVar1}"
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
													style="color: black;"></i> </a>
											</c:if></td>
									</tr>
								</c:forEach>

							</tbody> --%>
						</table>

					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->
		
		
		
		<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>


		
		
		
		
		

	</div>
	<!-- /page content -->

<script type="text/javascript">

function showChatBox(var1,var2,var3,var4,var5){
	/*   $("#mdTaskName").html(var3);
	   $("#mdOwnerPartner").html(var4);
	   $("#mdTaskStatus").html(var5); */
	   var1="88";
	   var2="88";
	   var strhref ="${pageContext.request.contextPath}/communication?taskId="+var1+"&empId="+var2;
	   $("#modalbody").load(strhref);
	   $("#myModal").modal("show");
	   $('#myModal').on('hidden.bs.modal', function () {
		$("#modalbody").html("");
		}); 
}
function getCustListbyGroupId(groupId,groupName){
	
	
	document.getElementById("c_title").innerHTML ="Customer List For Group-"+groupName;

	//alert("Hi");
//	$("#loader").show();
	$
			.getJSON(
					'${getCustListByGrpIdAjax}',
					{
						custGrpId : groupId,
						ajax : 'true',

					},
					function(data) {

						var dataTable = $('#custListTable').DataTable();
						dataTable.clear().draw();

						$.each(data, function(i, v) {
	  												
						/* 	var acButton = '&nbsp;&nbsp;<a href="#" onclick="editWorkLog('+ v.exVar1+')"><i class="icon-pencil7" style="color: black;">'+
							'</i>   &nbsp;&nbsp;<a href="#" )"><i class="icon-trash" style="color: black;""></i>';	 */
							dataTable.row.add(
									[ i + 1,
									  v.custFirmName,
									  v.custAssesseeName,
									  v.custPanNo,
									  v.custEmailId,
									  v.custPhoneNo
									]).draw();
						});});


	
}
</script>
</body>

</html>