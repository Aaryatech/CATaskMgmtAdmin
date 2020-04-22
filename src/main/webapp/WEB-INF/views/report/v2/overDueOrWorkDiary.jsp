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
						<h5 class="card-title">${reportTitle}- <b>${empData.empName}</b></h5>

					</div>
					<div class="card-body">
						<form
							action="${pageContext.request.contextPath}/getOvDueOrWorkLDiEmpFdTd/${reportType}"
							id="submitInsertActivity" method="get">
							<div class="form-group row">

								<label class="col-form-label col-lg-2" for="monthyear">Select
									Date <span style="color: red">* </span>:
								</label>
								<div class="col-lg-2">
									<input type="text" class="form-control daterange-basic_new"
										id="monthyear" name="monthyear" value="${yearrange}">
								</div>

								<label class="col-form-label col-lg-2" for="employee">
									Employee <span style="color: red">* </span>:
								</label>
								<div class="col-lg-2">

									<select data-placeholder="Select Employee" name="empId"
										id="empId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">

										<c:forEach items="${epmList}" var="epmList">
											<c:choose>
												<c:when test="${empId==epmList.empId}">
													<option selected value="${epmList.empId}">${epmList.empName}
														-${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
												</c:when>
												<c:otherwise>

													<option value="${epmList.empId}">${epmList.empName}
														-${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
												</c:otherwise>

											</c:choose>
										</c:forEach>

									</select>
								</div>
								<!-- </div>

									<div class="form-group row"> -->
								<!-- <div class="col-lg-1"></div> -->
								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">Search</button>

								<!-- <div class="col-lg-1"></div> -->
								<a
									href="${pageContext.request.contextPath}/getOvDueOrWorkLDiEmpFdTdExcel?fromDate=${fromDate}&toDate=${toDate}&empId=${empId}&reportType=${reportType}"><button
										type="button" id="excel" class="btn bg-blue ml-3 legitRipple">Excel
									</button></a>
							</div>

							<div class="form-group row"></div>


							<%-- 	<input type="hidden" name="fromDate" id="fromDate"
								value="${fromDate}"> <input type="hidden" name="toDate"
								id="toDate" value="${toDate}"> --%>
							<%-- <input type="hidden" name="reportType" id="reportType"
								value="${reportType}"> --%>
							<div id="loader" style="display: none;">
								<img
									src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>
						</form>

						<!-- 	<span style="color: green">This report for completed tasks
							between selected range and employee/manager contribution </span>: -->

						<div class="table-responsive">
							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
								id="capTable">
								<thead>
									<tr class="bg-blue">
										<th>Sr.No.</th>
										<th>Task Text</th>
										<th>Client Name</th>
										<th>Service</th>
										<th>Activity</th>
										<th>Periodicity</th>
										<th>Owner Partner</th>
										<th>Execution Partner</th>
										<th>Employee Name</th>
										<th>TL Name</th>
										<th>Manager Name</th>
										
											<c:if test="${reportType==1}">
												<th>Due Date</th>
											    <th>Work Date</th>
											    <th>Status</th>
											</c:if>
										<c:if test="${reportType==2}">
											<th>Work Hour</th>
										</c:if>
									</tr>
								</thead>
								<tbody>
									<c:if test="${reportType==2}">
										<c:forEach items="${taskReportList}" var="taskRep"
											varStatus="count">
											<tr>
												<td>${count.index+1}</td>
												<td>${taskRep.taskText}</td>
												<td>${taskRep.custFirmName}</td>
												<td>${taskRep.servName} ${taskRep.taskId}</td>
												<td>${taskRep.actiName}</td>
												<td>${taskRep.periodicityName}</td>
												<td>${taskRep.ownPartner}</td>
												<td>${taskRep.partner}</td>
												<td>${empData.empName}</td>
												<td>${taskRep.teamLeader}</td>
												<td>${taskRep.manager}</td>
												<td>${taskRep.workHours}</td>
												
											</tr>
										</c:forEach>
									</c:if>
									
									<c:if test="${reportType==1}">
										<c:forEach items="${taskReportList}" var="taskRep"
											varStatus="count">
											<tr>
												<td>${count.index+1}</td>
												<td>${taskRep.taskText}</td>
												<td>${taskRep.custFirmName}</td>
												<td>${taskRep.servName}</td>
												<td>${taskRep.actiName}</td>
												<td>${taskRep.periodicityName}</td>
												<td>${taskRep.ownPartner}</td>
												<td>${taskRep.partner}</td>
												<td>${empData.empName}</td>
												<td>${taskRep.teamLeader}</td>
												<td>${taskRep.manager}</td>
												<td>${taskRep.taskStatutoryDueDate}</td>
												<td>${taskRep.taskWorkDate}</td>
												<td>${taskRep.statusText}</td>
											</tr>
										</c:forEach>


									</c:if>
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