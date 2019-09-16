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
<c:url var="getTeamLeadCompletTaskReport" value="getTeamLeadCompletTaskReport" />
<c:url var="getTaskStatusbreakdownList"
	value="getTaskStatusbreakdownList" />
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






				<!-- Capacity Details -->
				<!-- <div class="card">
					<div class="card-header header-elements-sm-inline">
						<h6 class="card-title">Capacity Details</h6>
						<div class="header-elements">
							<a
								class="text-default daterange-ranges font-weight-semibold cursor-pointer dropdown-toggle">
								<i class="icon-calendar3 mr-2"></i> <span></span>
							</a>
						</div>
					</div>

					<div class="card-body ">


						<div class="row">

							<div class=" col-sm-3 d-flex align-items-center mb-3 mb-md-0">
								<a href="#"
									class="btn bg-transparent border-indigo-400 text-indigo-400 rounded-round border-2 btn-icon">
									<i class="icon-alarm-add"></i>
								</a>
								<div class="ml-3">
									<h5 class="font-weight-semibold mb-0">1,132</h5>
									<span class="text-muted">Budgeted Capacity</span>
								</div>
							</div>

							<div class=" col-sm-3 d-flex align-items-center mb-3 mb-md-0">
								<a href="#"
									class="btn bg-transparent border-indigo-400 text-indigo-400 rounded-round border-2 btn-icon">
									<i class="icon-tree7"></i>
								</a>
								<div class="ml-3">
									<h5 class="font-weight-semibold mb-0">1,132</h5>
									<span class="text-muted">Allocated Capacity</span>
								</div>
							</div>

							<div class=" col-sm-3 d-flex align-items-center mb-md-0">
								<a href="#"
									class="btn bg-transparent border-indigo-400 text-indigo-400 rounded-round border-2 btn-icon">
									<i class=icon-history></i>
								</a>
								<div class="ml-3">
									<h5 class="font-weight-semibold mb-0">06:25:00</h5>
									<span class="text-muted">Actual Hours Worked</span>
								</div>
							</div>



							<div class=" col-sm-3 align-items-center "
								style="margin-top: 15px;">
								<div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div>

							</div>


						</div>
					</div>
					card body


				</div> -->
				<!-- /support tickets -->


				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Team Leader Task Completed Report</h5>

					</div>
					<div class="card-body">
						<div class="form-group row">
							<label class="col-form-label col-lg-2" for="fromDate">Select
								Date <span style="color: red">* </span>:
							</label>
							<div class="col-lg-3">
								<input type="text" class="form-control daterange-basic_new"
									placeholder="From Date" id="fromDate" name="fromDate"
									autocomplete="off" onchange="trim(this)" value="">
							</div>

							<div class="col-lg-3">
								<button type="button" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn" onclick="show()">Search</button>
							</div>

						</div>
						<%-- <input type="hidden" id="emp_id" name="emp_id" value="${empId}"> --%>
						<div id="loader" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>

						<div class="table-responsive">
							<table class="table" id="capTable">
								<thead>
									<tr class="bg-blue">

										<th style="width: 30px">Sr. No.</th>										
										<th style="width: 50px;">Client Name</th>
										<th style="width: 50px">Service</th>
										<th style="width: 50px">Activity</th>
										<th style="width: 50px">Task/ Periodicity</th>
										<th style="width: 50px">Execution partner</th>
										<th style="width: 50px">Manager Name</th>
										<th style="width: 50px">TL Name</th>
										<th style="width: 50px">Due date</th>
										<th style="width: 50px">Completion date</th>
										<th style="width: 50px">Employee Budgeted Hrs</th>
										<th style="width: 50px">Total Hrs Employee</th>
										<th style="width: 50px">TL Hrs total</th>
										<th style="width: 50px">TL Hrs for the selected period</th>
									</tr>
								</thead>
								<tbody>
									

									


								</tbody>
							</table>
						</div>
					</div>
				</div>
				<%-- <div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Task Status breakdown</h5>

					</div>
					<div class="card-body">
						<c:if test="${empSes.empType!=5}">
							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="fromDate">Select
									Employee <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="membrId" id="membrId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<c:forEach items="${empList}" var="empList">
											<c:choose>
												<c:when test="${empList.empId==empId}">
													<option value="${empList.empId}" selected>${empList.empName}</option>
												</c:when>
												<c:otherwise>
													<option value="${empList.empId}">${empList.empName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>

								<div class="col-lg-3">
									<button type="button" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn" onclick="getTaskStatusbreakdownList()">Search</button>
								</div>

							</div>
						</c:if>
						<div id="loader1" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<div class="table-responsive">
							<table class="table text-nowrap" id="breakdownTab">
								<thead>
									<tr>
										<th style="background-color: white; width: 300px">Status
											Wise Task Data</th>
										<th style="background-color: white; width: 50px;">Overdue</th>
										<th style="background-color: white; width: 50px">Due
											Today</th>
										<th style="background-color: white; width: 50px">Due this
											Week</th>
										<th style="background-color: white; width: 50px">Due this
											Month</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${stswisetaskList}" var="stswisetaskList"
										varStatus="count">
										<c:if
											test="${stswisetaskList.overdeu>0 || stswisetaskList.duetoday>0 || stswisetaskList.week>0 || stswisetaskList.month>0}">
											<tr>
												<td>${stswisetaskList.statusText}</td>
												<td><c:choose>
														<c:when test="${stswisetaskList.overdeu>0}">
															<a
																href="${pageContext.request.contextPath}/taskListForEmp?stat=${stswisetaskList.statusValue}&type=1&empId=${empId}">${stswisetaskList.overdeu}</a>
														</c:when>
														<c:otherwise>
																	${stswisetaskList.overdeu}
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${stswisetaskList.duetoday>0}">
															<a
																href="${pageContext.request.contextPath}/taskListForEmp?stat=${stswisetaskList.statusValue}&type=2&empId=${empId}">${stswisetaskList.duetoday}</a>
														</c:when>
														<c:otherwise>
																	${stswisetaskList.duetoday}
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${stswisetaskList.week>0}">
															<a
																href="${pageContext.request.contextPath}/taskListForEmp?stat=${stswisetaskList.statusValue}&type=3&empId=${empId}">${stswisetaskList.week}</a>
														</c:when>
														<c:otherwise>
																	${stswisetaskList.week}
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${stswisetaskList.month>0}">
															<a
																href="${pageContext.request.contextPath}/taskListForEmp?stat=${stswisetaskList.statusValue}&type=4&empId=${empId}">${stswisetaskList.month}</a>
														</c:when>
														<c:otherwise>
																	${stswisetaskList.month}
														</c:otherwise>
													</c:choose></td>
											</tr>
										</c:if>
									</c:forEach>



								</tbody>
							</table>
						</div>
					</div>
				</div> --%>

				<!-- Hover rows -->


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
	<script type="text/javascript">
		
		function show() {

			//alert("Hi View Orders  ");

			var fromDate = document.getElementById("fromDate").value;

			$("#loader").show();

			$
					.getJSON(
							'${getTeamLeadCompletTaskReport}',
							{
								fromDate : fromDate,
								ajax : 'true',
							},

							function(data) {
								$("#capTable tbody").empty();

								$
										.each(
												data,
												function(i, v) {
													
									
												});
								$("#loader").hide();

							});

		}
	</script>



</body>
</html>