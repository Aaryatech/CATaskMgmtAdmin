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
<c:url var="getCapacityBuildingDetail" value="getCapacityBuildingDetail" />
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
						<h5 class="card-title">Capacity Building</h5>

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
						<input type="hidden" id="emp_id" name="emp_id" value="${empId}">
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

										<th style="width: 300px">Name</th>
										<th style="width: 50px;">Budgeted Capacity</th>
										<th style="width: 50px">Allocated Capacity</th>
										<th style="width: 50px">Actual Hours Worked</th>
										<th style="width: 50px">% completion bar</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${capacityDetailByEmpList}"
										var="capacityDetailByEmpList" varStatus="count">
										<c:if test="${capacityDetailByEmpList.empId==empId}">
											<tr>

												<td>${capacityDetailByEmpList.empName}</td>
												<td>${capacityDetailByEmpList.bugetedCap}</td>
												<td>${capacityDetailByEmpList.allWork}</td>
												<td>${capacityDetailByEmpList.actWork}</td>
												<td><c:set var="per"
														value="${(capacityDetailByEmpList.actWork/capacityDetailByEmpList.allWork)*100}"></c:set>
													<div class="progress rounded-round">
														<div class="progress-bar bg-success"
															style="width: ${per}%">
															<span><fmt:formatNumber type="number"
																	maxFractionDigits="2" minFractionDigits="2"
																	value="${per}" />% Complete</span>
														</div>
													</div></td>
											</tr>
										</c:if>
									</c:forEach>

									<c:forEach items="${capacityDetailByEmpList}"
										var="capacityDetailByEmpList" varStatus="count">
										<c:if test="${capacityDetailByEmpList.empId!=empId}">
											<tr>

												<td>${capacityDetailByEmpList.empName}</td>
												<td>${capacityDetailByEmpList.bugetedCap}</td>
												<td>${capacityDetailByEmpList.allWork}</td>
												<td>${capacityDetailByEmpList.actWork}</td>
												<td><c:set var="per"
														value="${(capacityDetailByEmpList.actWork/capacityDetailByEmpList.allWork)*100}"></c:set>

													<div class="progress rounded-round">
														<div class="progress-bar bg-success"
															style="width: ${per}%">
															<span><fmt:formatNumber type="number"
																	maxFractionDigits="2" minFractionDigits="2"
																	value="${per}" />% Complete</span>
														</div>
													</div></td>
											</tr>
										</c:if>
									</c:forEach>



								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="card">
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
				</div>

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
		function getTaskStatusbreakdownList() {

			//alert("Hi View Orders  ");

			var membrId = document.getElementById("membrId").value;

			$("#loader1").show();

			$
					.getJSON(
							'${getTaskStatusbreakdownList}',
							{
								membrId : membrId,
								ajax : 'true',
							},

							function(data) {
								$("#breakdownTab tbody").empty();

								$
										.each(
												data,
												function(i, v) {

													if (v.overdeu > 0
															|| v.duetoday > 0
															|| v.week > 0
															|| v.month > 0) {

														var overdeu;
														var duetoday;
														var week;
														var month;

														if (v.overdeu > 0) {
															overdeu = '<a href="${pageContext.request.contextPath}/taskListForEmp?stat='
																	+ v.statusValue
																	+ '&type=1&empId='
																	+ membrId
																	+ '">'
																	+ v.overdeu
																	+ '</a>';
														} else {
															overdeu = v.overdeu;
														}

														if (v.duetoday > 0) {
															duetoday = '<a href="${pageContext.request.contextPath}/taskListForEmp?stat='
																	+ v.statusValue
																	+ '&type=2&empId='
																	+ membrId
																	+ '">'
																	+ v.duetoday
																	+ '</a>';
														} else {
															duetoday = v.duetoday;
														}
														//alert(duetoday)
														if (v.week > 0) {
															week = '<a href="${pageContext.request.contextPath}/taskListForEmp?stat='
																	+ v.statusValue
																	+ '&type=3&empId='
																	+ membrId
																	+ '">'
																	+ v.week
																	+ '</a>';
														} else {
															week = v.week;
														}

														if (v.month > 0) {
															month = '<a href="${pageContext.request.contextPath}/taskListForEmp?stat='
																	+ v.statusValue
																	+ '&type=4&empId='
																	+ membrId
																	+ '">'
																	+ v.month
																	+ '</a>';
														} else {
															month = v.month;
														}

														var tr_data = '<tr>'
																+ '<td  >'
																+ v.statusText
																+ '</td>'
																+ '<td  >'
																+ overdeu
																+ '</td>'
																+ '<td  >'
																+ duetoday
																+ '</td>'
																+ '<td  >'
																+ week
																+ '</td>'
																+ '<td  >'
																+ month
																+ '</td>'
																+ '</tr>';
														$(
																'#breakdownTab'
																		+ ' tbody')
																.append(tr_data);
													}
												});

								$("#loader1").hide();

							});

		}

		function show() {

			//alert("Hi View Orders  ");

			var fromDate = document.getElementById("fromDate").value;
			var self = document.getElementById("emp_id").value;

			$("#loader").show();

			$
					.getJSON(
							'${getCapacityBuildingDetail}',
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

													if (v.empId == self) {

														var per = (v.actWork / v.allWork) * 100
														var str = '<div class="progress rounded-round"> <div class="progress-bar bg-success" style="width: '
																+ per
																+ '%">'
																+ '<span>'
																+ per.toFixed(2)
																+ '% Complete</span> </div> </div>'

														var tr_data = '<tr>'
																+ '<td  >'
																+ v.empName
																+ '</td>'
																+ '<td  >'
																+ v.bugetedCap
																+ '</td>'
																+ '<td  >'
																+ v.allWork
																+ '</td>'
																+ '<td  >'
																+ v.actWork
																+ '</td>'
																+ '<td  >'
																+ str + '</td>'
																+ '</tr>';
														$(
																'#capTable'
																		+ ' tbody')
																.append(tr_data);
													}
												});

								$
										.each(
												data,
												function(i, v) {

													if (v.empId != self) {

														var per = (v.actWork / v.allWork) * 100
														var str = '<div class="progress rounded-round"> <div class="progress-bar bg-success" style="width: '
																+ per
																+ '%">'
																+ '<span>'
																+ per
																+ '% Complete</span> </div> </div>'

														var tr_data = '<tr>'
																+ '<td  >'
																+ v.empName
																+ '</td>'
																+ '<td  >'
																+ v.bugetedCap
																+ '</td>'
																+ '<td  >'
																+ v.allWork
																+ '</td>'
																+ '<td  >'
																+ v.actWork
																+ '</td>'
																+ '<td  >'
																+ str + '</td>'
																+ '</tr>';
														$(
																'#capTable'
																		+ ' tbody')
																.append(tr_data);
													}
												});
								$("#loader").hide();

							});

		}
	</script>



</body>
</html>