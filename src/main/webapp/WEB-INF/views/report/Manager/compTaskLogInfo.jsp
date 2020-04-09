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
.btn{
max-height: 38px !important;
}
</style>


			<!-- Content area -->
			<div class="content">




				<!-- <style type="text/css">
.datatable-footer {
	display: none;
}

.dataTables_length {
	display: none;
}

.datatable-header {
	display: none;
}
</style> -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Manager Task Completed: Detail Work Log Report <b>${taskLogList[0].taskText}</b></h5>

					</div>
					<div class="card-body">
						<form
							action="#"
							id="submitInsertActivity" method="get">
							<%-- <div class="form-group row">

								<label class="col-form-label col-lg-2" for="monthyear">Select
									Date <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<input type="text" class="form-control daterange-basic_new"
										id="monthyear" name="monthyear" value="${yearrange}">
								</div>
								<div class="col-lg-1"></div>
								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">Search</button>

								<div class="col-lg-1"></div>
								<a
									href="${pageContext.request.contextPath}/showCompletedTaskRepForManager?fromDate=${fromDate}&toDate=${toDate}"><button
										type="button" id="excel" class="btn bg-blue ml-3 legitRipple">Excel
									</button></a>

							</div> --%>
							<div class="form-group row">
							<div class="col-lg-8">		
							 <p> <b>Customer Name:</b> ${firmName} <b>Activity Name:</b> ${actiName}</p> 
</div>
<div class="col-lg-4">	
<a
									href="${pageContext.request.contextPath}/getTaskLogEmpInfoListByTaskId?firmName=${firmName}&actiName=${actiName}&taskId=${taskId}&driveLink=abc"><button
										type="button" id="excel" class="btn bg-blue ml-1 legitRipple">Excel
									</button></a>
								
							<input type="hidden" name="firmName" id="firmName"
								value="${firmName}"> <input type="hidden" name="actiName"
								id="actiName" value="${actiName}">
								
								<input type="hidden" name="taskId" id="taskId"
								value="${taskId}"> <input type="hidden" name="driveLink"
								id="driveLink" value="abc">
									</div>
								
</div>
						</form>



						<div class="table-responsive">
							<table class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1" id="capTable">
								<thead>
									<tr class="bg-blue">
										<th>Sr.No.</th>
										<th>Employee Type</th>
										<th>Employee Name</th>
										<th>Work Hours</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${taskLogList}" var="taskLogList"
										varStatus="count">
										<tr>
											<td>${count.index+1}</td>
											<c:if test="${taskLogList.empType==5}">
												<td>Employee</td>
											</c:if>
											<c:if test="${taskLogList.empType==3}">
												<td>Manager</td>
											</c:if>
											<c:if test="${taskLogList.empType==4}">
												<td>Team Leader</td>
											</c:if>
											<td>${taskLogList.empName}</td>
											<td>${taskLogList.workHrs}</td>
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