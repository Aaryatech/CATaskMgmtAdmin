<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_basic.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/dashboard.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/plugins/visualization/echarts/echarts.min.js"></script>



<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,300,600,800,900"
	rel="stylesheet" type="text/css">

<c:url var="getClientList" value="getClientList" />
</head>

<body onload="chkData()">

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


				<div class="row">
					<div class="col-sm-12">
						<div class="progress">
							<div class="progress-bar bg-success" style="width: 35%">
								<span>35% Complete</span>
							</div>
						</div>
					</div>
				</div>





			</div>
			<!-- /page header -->


			<style type="text/css">
h5 {
	margin-bottom: 0;
}
</style>


			<!-- Content area -->
			<div class="content">




				<style type="text/css">
.datatable-footer {
	display: none;
}

.dataTables_length {
	display: none;
}

.datatable-header {
	display: none;
}
</style>
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Employee Manager Performance Detail Report</h5>
<a
									href="${pageContext.request.contextPath}/showMangPerfHeadListDetail?fromDate=${fromDate}&toDate=${toDate}&empId=${empId}"><button
										type="button" id="excel" class="btn bg-blue ml-3 legitRipple">Excel
									</button></a>
					</div>
					<div class="card-body">
						<form
							action="${pageContext.request.contextPath}/showMangPerfHeadListDetail"
							id="submitInsertActivity" method="get">
							<div class="form-group row">
								
								<div class="col-lg-1"></div>
								

							</div>


						</form>



						<div class="table-responsive">
							<table class="table" id="capTable">
								<thead>


									<tr class="bg-blue">
										<th>Sr.No.</th>
										<th>Task Text</th>
										<th>Client Name</th>
										<th>Service</th>
										<th>Activity</th>
										<th>Task/ Periodicity</th>
										<th>Owner Partner</th>
										<th>Execution Partner</th>
										<th>Employee Name</th>
										<th>TL Name</th>
										<th>Due Date</th>
										<th>Completion Date</th>
										<th>Employee Budgeted Hrs</th>
										<th>Total Hrs Employee</th>
										<th>TL Total Hrs</th>
										<th>Manager Budgeted Hrs</th>
										<th>Manager Total Hrs</th>
										<th>Total manager hrs for selected period</th>
										<th>Total Employee hrs for selected period</th>
										<th>Total TL hrs for selected period</th>
										<th>Google Drive Link</th>

									</tr>
								</thead>
								<tbody>

									<c:forEach items="${perfList}" var="cmpTaskList"
										varStatus="count">
										<tr>
											<td>${count.index+1}</td>
											<td>${cmpTaskList.taskText}</td>
											<td>${cmpTaskList.custFirmName}</td>
											<td>${cmpTaskList.servName}</td>
											<td>${cmpTaskList.actiName}</td>
											<td>${cmpTaskList.periodicityName}</td>
											<td>${cmpTaskList.ownerPartner}</td>
											<td>${cmpTaskList.partner}</td>
											<td>${cmpTaskList.employee}</td>
											<td>${cmpTaskList.teamLeader}</td>
											<td>${cmpTaskList.taskStatutoryDueDate}</td>
											<td>${cmpTaskList.taskStartDate}</td>
											<td>${cmpTaskList.empBudHr}</td>
											<td>${cmpTaskList.employeeHrs}</td>
											<td>${cmpTaskList.teamLeaderHrs}</td>
											<td>${cmpTaskList.mngrBudHr}</td>
											<td>${cmpTaskList.managerHrs}</td>
											<td>${cmpTaskList.managerBetHrs}</td>
											<td>${cmpTaskList.empBetHrs}</td>
											<td>${cmpTaskList.tlBetHrs}</td>
											<td>${cmpTaskList.exVar1}</td>

										</tr>
									</c:forEach>


								</tbody>
							</table>

						</div>


					</div>
				</div>

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
		function chkData() {
			var x = document.getElementById("capTable").rows.length;
			//alert(x);
			if (x == 1) {

				document.getElementById("excel").disabled = true;
			}
		}
	</script>



	<script type="text/javascript">
		//datepickermonth
		// Single picker
		$('.datepickermonth').daterangepicker({
			singleDatePicker : true,

			showDropdowns : true,
			locale : {
				format : 'MM-YYYY'
			}

		});
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