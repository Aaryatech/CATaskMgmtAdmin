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
			<div class="page-header page-header-light" style="display: none;">


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
						<%-- <c:if test="${addAccess == 0}"> 
							<a href="${pageContext.request.contextPath}/service"
								class="breadcrumb-elements-item"> Add Service </a>
						</c:if> --%>

					</div>

				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">

						<h5 class="card-title">Service - Activity Mapping</h5>
					</div>
					<form method="post" id="reportForm">
						<div class="card-body">
							<div class="form-group row">

								<label class="col-form-label col-lg-2" for="startDate">Start
									Date: </label>
								<div class="col-lg-3">
									<input type="text" class="form-control datepickerclass"
										name="fromDate" id="fromDate" placeholder="Task End Date">
								</div>



								<label class="col-form-label col-lg-2" for="startDate">End
									Date: </label>
								<div class="col-lg-3">
									<input type="text" class="form-control datepickerclass"
										name="toDate" id="toDate" placeholder="Task End Date">
								</div>


							</div>
							<c:if test="${userType==3 || userType==2}">
							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="employee">
									Employee <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">

									<select data-placeholder="Select Employee"
										name="empId" id="empId"
										class="form-control form-control-sm select"
										data-container-css-class="select-sm" data-fouc>
										<option value="">Select Employee</option>
										<c:forEach items="${epmList}" var="epmList">
											<option value="${epmList.empId}">
											${epmList.empName} -${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
										</c:forEach>

									</select> <!-- <span class="validation-invalid-label" id="error_locId2"
										style="display: none;">This field is required.</span> -->
								</div>
							</div>
							</c:if>


							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
								id="printtable1">
								<thead>
									<tr class="bg-blue">
										<th width="10%">Sr.no</th>
										<th>Report Name</th>
										<th class="text-center" width="10%">Actions</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td>1</td>
										<td>Task Completed</td>
										<td class="text-center"><a href="#"
											onclick="getProgReport(1,'showCompletedTaskRep')"><i
												class="icon-file-pdf " style="color: black;"></i></a> &nbsp; <a
											href="#" onclick="getProgReport(0,'showCompletedTaskRep')"><i
												class="icon-file-spreadsheet  " style="color: black;"></i></a></td>
									</tr>
									
									<tr>
										<td>2</td>
										<td>Team Leader Task Completed</td>
										<td class="text-center"><a href="#"
											onclick="getProgReport(1,'getTeamLeadCompletTask')"><i
												class="icon-file-pdf " style="color: black;"></i></a> &nbsp; <a
											href="#" onclick="getProgReport(0,'getTeamLeadCompletTask')"><i
												class="icon-file-spreadsheet  " style="color: black;"></i></a></td>
									</tr>

								</tbody>
							</table>
							<input type="hidden" id="p" name="p" value="0">
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
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>
	<!-- /page content -->


	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(prm, mapping) {
			if (prm == 1) {
				document.getElementById("p").value = "1";
			}

			var form = document.getElementById("reportForm");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "post");

			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");

			form.submit();
			document.getElementById("p").value = "0";
		}
	</script>

	<script type="text/javascript">
		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		//daterange-basic_new
		// Basic initialization
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>
</body>
</html>