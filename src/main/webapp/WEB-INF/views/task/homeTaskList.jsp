<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-1.8.2.min.js"></script>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<script
	src="${pageContext.request.contextPath}/resources/assets/js/jquery.popupoverlay.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_basic.js"></script>
	<style type="text/css">
	.select2-search--dropdown.select2-search--hide{
	display: block;
	}
	
	</style>
<style>
.modal {
	position: fixed !important;
	bottom: 0 !important;
	top: auto !important;
	right: 0 !important;
	left: auto !important;
	margin: 0px !important;
	/* width: auto !important;
	height: auto !important; */
	width: 600px;;
	height: 700px;
}
/* .modal-body-one{padding: 0px;}
.content-one {padding: 0.25rem 1.25rem;}
.modal-header-one .close { color: inherit; position: absolute; right: 10px; 
top: 10px; font-size: 26px; z-index: 10; background: #FFF; padding: 10px; 
border-radius: 50%; display: inline-block; height: 40px; opacity: 1; 
width: 40px; line-height: 0px; text-align: center;} */
/* 
.modal-body{padding: 0px !important;}
.content {padding: 0.25rem 1.25rem !important;}
.modal-header .close { color: inherit !important; position: absolute !important; right: 10px !important; 
top: 10px !important; font-size: 26px !important; z-index: 10 !important; background: #FFF !important; padding: 10px !important; 
border-radius: 50% !important; display: inline-block !important; height: 40px !important; opacity: 1 !important; 
width: 40px; line-height: 0px !important; text-align: center !important;} */
#modal_remote {
	position: fixed !important;
	bottom: 0 !important;
	top: auto !important;
	right: 0 !important;
	left: auto !important;
	margin: 0px !important;
	width: 720px !important;
	height: auto !important;
}

.modal-dialog {
	padding-top: 80px !important;
}

.AnyTime-win {
	height: 320px !important;
	overflow-y: auto !important;
	width: 300px;
}

.form-group {
	margin-bottom: 0.25rem !important;
}

.datatable-scroller1 tbody {
	overflow: auto;
	height: 100px;
}

.datatable-scroller1 thead {
	overflow: auto;
	height: 100px;
}

.datatable-scroller1 th, .datatable-scroller1 td {
	padding: 5px;
	text-align: left;
	width: 200px;
}

h5 {
	margin-bottom: 0;
}

/* .datatable-footer {
	display: none;
} */

/* .dataTables_length {
	display: none;
}
 */
.fab-menu-bottom-right, .fab-menu-top-right {
	right: 1.25rem;
	top: 1rem;
}


</style>
</head>

<body>
	<c:url value="/getDailyWorkLogByTaskId" var="getDailyWorkLogByTaskId"></c:url>
	<c:url value="/updateTaskStatusByTaskId" var="updateTaskStatusByTaskId"></c:url>
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>
	<c:url value="/getTaskByTaskIdForEdit" var="getTaskByTaskIdForEdit"></c:url>
	<c:url value="/submitUpdatedTask" var="submitUpdatedTask"></c:url>
	<c:url value="/deleteWorkLog" var="deleteWorkLog"></c:url>

	<c:url value="/activeTaskListForEmp" var="activeTaskListForEmp"></c:url>
	<c:url value="/fliterTaskList" var="fliterTaskList"></c:url>
	<c:url value="/newWorkLog" var="newWorkLog"></c:url>

	<c:url value="/completeAndDeliverTask" var="completeAndDeliverTask"></c:url>

<c:url value="/getDailyWorkLogCountForTask" var="getDailyWorkLogCountForTask"></c:url>

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

			<!-- Content area -->
			<div class="content">

				<!-- <div class="card">

					<div
						class="card-body d-md-flex align-items-md-center justify-content-md-between flex-md-wrap">


						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Unallocated Task"
								class="btn bg-transparent border-warning-400 text-warning-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-file-plus"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">Gen</span>
								<div>
									<h5>50</h5>
								</div>


							</div>
						</div>


						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Unallocated Task"
								class="btn bg-transparent border-warning-400 text-warning-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-stack"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">UT</span>
								<div>
									<h5>750</h5>
								</div>


							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Pending for Manager"
								class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-user-tie"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">PM</span>
								<div>
									<h5>150</h5>
								</div>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Pending for Partner"
								class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-user-check"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">PP</span>
								<div>
									<h5>125</h5>
								</div>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Pending for Team Lead"
								class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-tree7"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">PTL</span>
								<div>
									<h5>125</h5>
								</div>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Pending for Client"
								class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-users"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">PC</span>
								<div>
									<h5>125</h5>
								</div>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Critical Task"
								class="btn bg-transparent border-danger-400 text-danger-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-warning"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">CT</span>
								<div>
									<h5>650</h5>
								</div>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Overdue Task"
								class="btn bg-transparent border-danger-400 text-danger-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-stats-growth2"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">OD</span>
								<div>
									<h5>350</h5>
								</div>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Other Task"
								class="btn bg-transparent border-pink-400 text-pink-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-flickr2"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">OT</span>
								<div>
									<h5>350</h5>
								</div>
							</div>
						</div>
					</div>
				</div> -->

				<!-- Remote source -->
<!-- 				<div id="modal_remote" class="modal" tabindex="-1">
 -->					
     <div id="basic" class="well">
 
<!--  <div class="modal-dialog modal-full">
 -->		
 
  <div class="">
 
 				<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Filter</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								      <button class="basic_close btn btn-default">Close</button>
								
							</div>

							<div class="modal-body">
								<form id="filterForm">

									<div class="form-group row">
										<label class="col-form-label col-md-2" for="fromDate">Due
											Date Range :
										</label>
										<div class="col-md-10">
											<input type="text" class="form-control daterange-basic_new"
												id="fromDate" name="fromDate">
										</div>
									</div>

									<div class="row">

										<label class="col-form-label col-lg-2" for="service">
											Service : </label>
										<div class="col-lg-4">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)">
												<option value="0">Select Service</option>
												<c:forEach items="${serviceList}" var="serv">
													<option value="${serv.servId}">${serv.servName}</option>
												</c:forEach>

											</select>
										</div>


										<label class="col-form-label col-lg-2" for="activity">
											Activity : </label>
										<div class="col-lg-4">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
											</select>
										</div>

									</div>

									<div class="form-group row">

										<label class="col-form-label col-lg-2" for="status">
											Status : </label>
										<div class="col-lg-4">
											<select name="sts" data-placeholder="Select Status"
												id="stats"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true" name="stats">

												<option value="0">Select Status</option>
												<c:forEach items="${statusList}" var="statusList">
													<option value="${statusList.statusValue}">${statusList.statusText}</option>
												</c:forEach>

											</select>
										</div>

										<label class="col-form-label col-lg-2" for="customer">
											Customer : </label>
										<div class="col-lg-4">
											<select name="custId" data-placeholder="Select Customer"
												id="custId"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<option value="0">Select Customer</option>
												<c:forEach items="${custGrpList}" var="custGrpList">
													<option value="${custGrpList.custId}">${custGrpList.custName}</option>
												</c:forEach>

											</select>
										</div>

									</div>
								</form>
							</div>

							<div class="modal-footer">
<!-- 								<button type="submit" class="btn btn-link" data-dismiss="modal">Close</button>
 -->								
       <button class="basic_close btn btn-default">Close</button>
 
 <button type="submit" class="btn bg-primary" id="submtbtn"
									onclick="dataFilter()">Search</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /remote source -->

				<!-- Highlighting rows and columns -->
				<!-- <div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Task</h5></td>
								<td width="40%" align="right"></td>
							</tr>
						</table>
					</div> -->


				<!-- Daily Work Log modal -->
				<div id="modal_small" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header bg-success">
								<h5 class="modal-title">
									<span id="taskText"></span>
								</h5>
								<button type="button" class="close" data-dismiss="modal" onclick="hideValidtn()">&times;</button>
							</div>

							<div class="modal-header" id="divElement">
								<!-- <form id="newWorkLog"> -->
								<div class="form-group row">

									<div class="col-lg-12" style="display: none;" id="sucessmsg">
										<div
											class="alert bg-success text-white alert-styled-left alert-dismissible">
											<button type="button" class="close" data-dismiss="alert">
												<span>&times;</span>
											</button>
											<span class="font-weight-semibold">Work Log Saved
												successfully.</span>
										</div>
									</div>

									<div class="col-lg-12" style="display: none;"
										id="del_sucess_msg">
										<div
											class="alert bg-success text-white alert-styled-left alert-dismissible">
											<button type="button" class="close" data-dismiss="alert">
												<span>&times;</span>
											</button>
											<span class="font-weight-semibold">Work Log Deleted
												successfully.</span>
										</div>
									</div>


									<div class="col-lg-12" style="display: none;" id="del_fail_msg">
										<div
											class="alert bg-danger text-white alert-styled-left alert-dismissible">
											<button type="button" class="close" data-dismiss="alert">
												<span>×</span>
											</button>
											<span class="font-weight-semibold">Oh snap! Work Log
												Fail to Deleted</span>
										</div>
									</div>

									<input type="hidden" name="taskId" id="taskId"> <input
										type="hidden" name="logId" id="logId"
										value="${workLog.workLogId}">


									<div class="form-group form-group-float col-md-3">
										<label class="form-group-float-label">Work Date</label> <input
											type="text" class="form-control datepickerclass1"
											value="${workLog.workDate}" name="workDate" id="workDate"
											placeholder="Work Date">
										<div class="col-md-3">
											<span class="validation-invalid-label" id="err_wrkdate_log"
												style="display: none; width: 180px;">Please enter
												employee work hours.</span>
										</div>
									</div>


									<div class="form-group form-group-float  col-md-3">
										<label class="form-group-float-label">Hours </label> <input
											type="text" class="form-control" value="${workLog.workHours}"
											name="workHour" id="any_time" placeholder="Work Hour"
											data-mask="99:99">
										<div class="col-md-2">
											<span class="validation-invalid-label" id="err_wrk_log"
												style="display: none; width: 180px;">Please enter
												employee work hours.</span>
										</div>

									</div>

									<div class="form-group form-group-float  col-md-3">
										<label class="form-group-float-label"> Remark</label> <input
											type="text" class="form-control"
											value="${workLog.workRemark}" placeholder="Enter Remark"
											id="remark" name=remark autocomplete="off"
											onchange="trim(this)">
									</div>

									<div class="form-group  col-md-1">
										<label class="form-group-float-label animate is-visible">
										</label>
										<button type="submit" id="submtbtnlog"
											onclick="addNewWorkLog()" class="btn bg-info-400 legitRipple">
											<b><i class="icon-paperplane"></i></b>
										</button>
									</div>

								</div>
								<!-- </form> -->


							</div>
							<!-- <div class="table-responsive">
								<table class="table datatable-scroller1" id="work_log_table">
									<thead>
										<tr>
											<th style="width: 350px; color: white;">Sr.No.</th>
											<th style="width: 350px; color: white;">Employee</th>
											<th style="width: 100px; color: white;">Date</th>
											<th style="width: 100px; color: white;">Actual Hours</th>

										</tr>
									</thead>
								</table>
							</div> -->

							<!-- Solid tabs title -->
							<!-- <div class="mb-3 mt-2">
		<h6 class="mb-0 font-weight-semibold">
		Solid tabs
		</h6>
		<span class="text-muted d-block">Add visual difference to the tabs</span>
		</div> -->
							<!-- /solid tabs title -->

							<!-- Solid tabs -->
							<div class="row">
								<div class="col-md-12">
									<!-- <div class="card"> -->
									<!-- <div class="card-header header-elements-inline">
					<h6 class="card-title">Solid tabs</h6>
				</div> -->

									<div class="card-body">
										<ul class="nav nav-tabs nav-tabs-solid border-0">
											<li class="nav-item"><a href="#solid-tab1"
												class="nav-link active" data-toggle="tab">Total Log</a></li>
											<li class="nav-item"><a href="#solid-tab2"
												class="nav-link" data-toggle="tab">Date Wise Log</a></li>
										</ul>

										<div class="tab-content">
											<div class="tab-pane fade show active" id="solid-tab1">
												<%-- Add solid background color to the tabs with <code>.nav-tabs-solid .border-0</code> classes. --%>
												<div class="table-responsive">
													<table class="table datatable-scroller1"
														id="work_log_table1">
														<thead>
															<tr>
																<th style="width: 350px; color: white;">Sr.No.</th>
																<th style="width: 350px; color: white;">Employee</th>
																<th style="width: 100px; color: white;">Actual
																	Hours</th>
															</tr>
														</thead>
														<tbody>
														</tbody>
													</table>
												</div>
											</div>

											<div class="tab-pane fade" id="solid-tab2">
												<!-- Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid laeggin. -->
												<div class="table-responsive"
													style="height: 300px !important">
													<table class="table datatable-scroller1"
														id="work_log_table2">
														<thead>
															<tr>
																<th style="width: 80px; color: white;">Sr.No.</th>
																<th style="width: 150px; color: white;">Date</th>
																<th style="width: 250px; color: white;">Employee</th>
																<th style="width: 150px; color: white;">Work Hours</th>
																<th style="width: 100px; color: white;">Action</th>
															</tr>
														</thead>

														<!-- 	<tfoot>
						<tr>
								<th style="width: 80px; color: white;">Sr.No.</th>
								<th style="width: 150px; color: white;">Date</th>
								<th style="width: 250px; color: white;">Employee</th>				
								<th style="width: 150px; color: white;">Work Hours</th>
								</tr>
						</tfoot>		 -->
													</table>
												</div>
											</div>


										</div>
									</div>
									<!-- </div> -->
								</div>
							</div>
							<!-- /solid tabs -->

							<div class="modal-footer" style="display: none;">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
								<button type="button" class="btn bg-primary">Save
									changes</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /Daily Work Log modal -->

				<!-- Task Edit modal -->
				<div id="modal_edit" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">

							<div class="modal-header bg-success">
								<h5 class="modal-title">Edit Task</h5>
								<p id="ed_task_name" style="color:red;"></p>
								<p id="ed_task_cust" style="color:brown;"></p>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

								<!-- <form action="submitUpdatedTask" method="post"> -->
								<input type="hidden" id="taskId1" name="taskId1" value=0>
								<c:if test="${empType==5}">
								<input type="hidden" readonly class="form-control" data-mask="999:99"
											placeholder="Enter Manager Budgeted Hours" id="edit_mngrtime"
											name="manBudHr"
											autocomplete="off">
											
											<input type="hidden" readonly data-mask="999:99" class="form-control"
											placeholder="Enter Employee Budgeted Hours" id="edit_emptime"
											 name="empBudHr"
											autocomplete="off">
											
											<input type="hidden" readonly class="form-control datepickerclass"
										 
											placeholder="Enter Statutory Due Date" id="dueDate"
											name="dueDate" autocomplete="off">
											
								</c:if>
								<c:choose>
								<c:when test="${empType==5}">
								<div class="form-group row" id="div1" style="display: none">
									<label class="col-form-label col-lg-6" for="ManBudgetedHrs">Manager
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control" data-mask="999:99"
											placeholder="Enter Manager Budgeted Hours" id="edit_mngrtime"
											name="manBudHr"  
											autocomplete="off">
									</div>

								</div>
								</c:when>
								
								<c:otherwise>
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="ManBudgetedHrs">Manager
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control" data-mask="999:99"
											placeholder="Enter Manager Budgeted Hours" id="edit_mngrtime"
											name="manBudHr"  
											autocomplete="off">
											<span style="display: none;" class="validation-invalid-label" id="err_mHr"
												>Please select manager budget hours</span>
									</div>

								</div>
								
								</c:otherwise>
								</c:choose>
								<c:choose>
								<c:when test="${empType==5}">
								
								<div class="form-group row" id="div2" style="display: none">
									<label class="col-form-label col-lg-6" for="EmpBudgetedHrs">Employee
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" data-mask="999:99" class="form-control"
											placeholder="Enter Employee Budgeted Hours" id="edit_emptime"
										  name="empBudHr"
											autocomplete="off">
									</div>

								</div>
								</c:when>
								
								<c:otherwise>
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="EmpBudgetedHrs">Employee
										Budgeted Hours : </label>
										
									<div class="col-lg-6">
										<input type="text" data-mask="999:99" class="form-control"
											placeholder="Enter Employee Budgeted Hours" id="edit_emptime"
											 name="empBudHr"
											autocomplete="off">
											<span style="display: none;" class="validation-invalid-label" id="err_eHr"
												>Please select emp budget hours</span>
									</div>

								</div>
								</c:otherwise>
								</c:choose>
								<c:choose>
								<c:when test="${empType==5}">
										<div class="form-group row" id="div3" style="display: none">

									<label class="col-form-label col-lg-6">Statutory Due
										Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
										 
											placeholder="Enter Statutory Due Date" id="dueDate"
											name="dueDate" autocomplete="off">
									</div>

								</div>
								</c:when>
								<c:otherwise>
								<div class="form-group row">

									<label class="col-form-label col-lg-6">Statutory Due
										Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
										 
											placeholder="Enter Statutory Due Date" id="dueDate"
											name="dueDate" autocomplete="off">
									</div>

								</div>
								
								</c:otherwise>
							
								</c:choose>
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6">Work Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											placeholder="Enter Work Date" 
											id="workDate1" name="workDate" autocomplete="off">
									</div>
								</div>
								<c:choose>
									<c:when test="${empType==5}">

										<div class="form-group row" style="display:none">

											<label class="col-form-label col-lg-6" for="activity">
												Employee <span style="color: red">* </span>:
											</label>
											<div class="col-lg-6">
												<select name="emp" data-placeholder="Select Activity"
													  id="emp" multiple
													disabled="disabled"
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" aria-hidden="true">
												</select>
												
												
											</div>

										</div>

									</c:when>
									
									<c:when test="${empType!=5}">
										<div class="form-group row">

											<label class="col-form-label col-lg-6" for="emp">
												Employee :
											</label>
											<div class="col-lg-6">
												<select name="emp" data-placeholder="Select Employee"
													  id="emp" multiple
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" aria-hidden="true">
												</select>
												<span style="display: none;" class="validation-invalid-label" id="err_tTeam"
												>Please select task team</span>
											</div>

										</div>
									</c:when>
								</c:choose>
								
								<!--Add/Edit Billing Amount 11-01-2020 -->
								<c:choose>
									<c:when test="${empType==5}">

										<div class="form-group row" style="display:none">

											<label class="col-form-label col-lg-6" for="bilAmt">
												Billing Amount :
											</label>
											<div class="col-lg-6">
												<input type="text" name="bilAmt" data-placeholder="Billing Amount"
													  id="bilAmt"
													readonly="readonly">
												
											</div>

										</div>

									</c:when>
									
									<c:when test="${empType!=5}">
										<div class="form-group row">

										<label class="col-form-label col-lg-6" for="bilAmt">
												Billing Amount :
											</label>
											<div class="col-lg-6">
												<input type="text" name="bilAmt" data-placeholder="Billing Amount"
													  id="bilAmt" value=""
													class="form-control">
												
											</div>

										</div>
									</c:when>
								</c:choose>

								 <div class="modal-footer">
										<button type="button" class="btn bg-primary" onclick="submitResponse()">Save
											Changes</button><button type="button" class="btn btn-link"
											data-dismiss="modal">Close</button>
										
									</div>
								<!-- </form> -->
							</div>
						</div>
					</div>
				</div>
				<!-- /Task Edit Log modal -->

				<!-- Basic tables title -->
				<!-- <div class="mb-3 text-right"
					style="position: fixed; z-index: 55555555; margin-left: 75%; margin-top:29%;">

					<div class="fab-menu  fab-menu-absolute1 fab-menu-top-right1"
						data-toggle="modal" data-target="#modal_remote">
						<a title="Filter"
							class="fab-menu-btn btn bg-blue btn-float rounded-round btn-icon">
							<i class="fab-icon-open icon-filter3"></i>
						</a>
					</div>
				</div> -->
				<!-- /basic tables title -->
				<!-- Hover rows -->
				<div class="card">


					<%-- <div class="card-header header-elements-inline">
						<h5 class="card-title">Task</h5>
						<div class="header-elements">
							<div class="list-icons">

								<a href="#" title="Chat/Update" data-toggle="modal"
									data-target="#modal_remote"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/filter.png"
									alt="" style="height: 26px; width: 26px;"></a> &nbsp;<a
									class="list-icons-item" data-action="collapse"></a>
							</div>
						</div>
					</div> --%>

					<div id="loader1" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>

					<div class=table-responsive>
						<!-- <input type="text" id="search" placeholder="Type to search"> -->
						<div class="row">
							<!-- <div class="col-md-6">
								<div id="work_log_table_filter" class="dataTables_filter">
									<label><span>Search:</span> <input type="text" class=""
										id="search" placeholder="Type to search..."
										aria-controls="work_log_table"> </label>
								</div>
							</div> -->
							<div class="col-md-6">
							</div>
							<div class="col-md-6   "> 
								<!-- Basic tables title -->
								<div class="  text-right" >

									<div class="pr-1 pt-1 fab-menu  fab-menu-absolute1 fab-menu-top-right1"
										data-toggle="modal" data-target="#modal_remote">
										<!-- <a title="Filter"
											class="fab-menu-btn btn bg-blue btn-float rounded-round btn-icon">
											<i class="fab-icon-open icon-filter3"></i>
										</a> -->
										    <a class="initialism basic_open" href="#basic">Filter</a>
										
									</div>
								</div>
								<!-- /basic tables title -->
							</div>
						</div>
	<!-- <table
							class="table datatable-basic datatable-generated table-hover"
							width="100%" id="task_info_table"> -->
		<div class="table-responsive">
						<table class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1" width="100%" id="task_info_table">
							<thead>
								<tr>
									<th style="background-color: white;">Sr. No.</th>
									<th style="background-color: white;">Customer</th>
									<!-- 	<th style="background-color: white;">Service - Activity</th> -->
									<th style="background-color: white;">Task Name</th>
									<th style="background-color: white;">Work Date</th>
									<th style="background-color: white;">Statutary Due Date</th>
									<th style="background-color: white;">Task Team</th>
									<th style="background-color: white;">Budget Hrs</th>
									<th style="background-color: white;">Task Status</th>
									<th style="background-color: white;">Change Status</th>
									<th class="text-center" style="background-color: white;">Actions</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${taskList}" var="taskList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${taskList.custGroupName}</td>

										<td><a href="#"
											onclick="showTaskLogs(${taskList.taskId}, '${taskList.taskText}')">${taskList.taskText}(${taskList.periodicityName})</a></td>

										<td>${taskList.taskEndDate}</td>
										<td>${taskList.taskStatutoryDueDate}</td>
										<td>${taskList.employees}</td>
										<td>M-${taskList.mngrBudHr} E-${taskList.empBudHr}</td>

										<td id="taskStatus${taskList.taskId}"
											style="color: ${taskList.statusColor};font-weight: bold;">${taskList.taskStatus}</td>

										<td align="center"><select name="set_status"
											onClick1="updateStatus_new11(this.value, ${taskList.taskId })"
											id="set_status${taskList.taskId}"
											data-id="${taskList.taskId}"
											class="form-control  ats_sel_status ">
												<option selected disabled data-statusColor="black"
													value="-1">Select Status</option>
												<c:forEach items="${statusList}" var="statusList">

													<c:choose>
														<c:when
															test="${statusList.statusText eq taskList.taskStatus}">
															<option data-statusColor="${statusList.statusColor}"
																value="${statusList.statusValue}" selected>${statusList.statusText}</option>
														</c:when>
														<c:otherwise>
															<option data-statusColor="${statusList.statusColor}"
																value="${statusList.statusValue}">${statusList.statusText}</option>
														</c:otherwise>

													</c:choose>

												</c:forEach>
										</select></td>

										<td class="text-center"><a class="chatmodallink mr-2"
											onclick="showChatBox('${taskList.exVar1}','${taskList.exVar2}','${taskList.taskText}','${taskList.ownerPartner}','${taskList.taskStatus}')"
											href="#" title="Chat/Update"><i class="icon-comments"
												style="color: green;"></i></a> <a href="#"
											onclick="showEditTask(${taskList.taskId},'${taskList.taskText}','${taskList.custGroupName}')" title="Edit"><i
												class="icon-pencil7" style="color: black;"
												data-toggle="modal" data-target="#modal_edit"></i></a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
						</div>
					</div>
				</div>
				<!-- /hover rows -->

				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->
			<!-- Sachin 26-11-2019 <button type="button" class="btn btn-light"  data-toggle="modal" data-target="#modal_form_inline"><i class="icon-play3 ml-2"></i></button>
 -->
			<div id="modal_form_inline" class="modal fade" tabindex="-1">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Add a deliverable link to complete
								Task</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<form action="#" class="row modal-body form-horizontal">
							<!-- <label>Deliverable link</label> -->
							<div class="col-md-9">
								<input type="hidden" id="task_comp_id" name="task_comp_id"
									value="0"> <input type="text" id="del_link"
									name="del_link" placeholder="deliverable link"
									class="form-control">
								<!-- <textarea class="form-control" wrap="soft"   placeholder="deliverable link" id="del_link" name="del_link" class="form-control mb-4 mr-sm-2 ml-sm-4 mb-sm-0"></textarea> -->
							</div>
							<div class="col-md-3">
								<button type="button" onclick="completeAndDelLink()"
									class="btn bg-primary ml-sm-2 mb-sm-0">
									Save<i class="icon-plus22	"></i>
								</button>
								
							</div>
						</form>
					</div>
				</div>
			</div>



<div id="modal_form_inline1" class="modal fade" tabindex="-1">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="show_alert1"> 	<span id="show_alert" style="color:red;"
												class="validation-invalid-label"  
												 > </span> </h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						
					</div>
				</div>
			</div>

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
    $(document).ready(function () {
      $('#basic').popup();
    });
    
    </script>
	
	<script type="text/javascript">
var status;
function getActiveHomeTasks() {
	//alert("In getActiveHomeTasks 675");
	var emp = ${empType};
	$("#loader1").show();
	
	$
			.getJSON(
					'${activeTaskListForEmp}',
					{

						//empId : empId,
						ajax : 'true',

					},
					function(data) {
					
						//alert(JSON.stringify(data.taskList))			
						append(data);
						/* $("#task_info_table tbody").empty();

						 
								
								//alert("list2:"+JSON.stringify(data.statusMstrList));	
								var sel_html ='';
								if(data.statusMstrList[0].statusText == data.taskList[0].taskStatus){
								
									for (var j = 0; j < data.statusMstrList.length; j++) {								
									sel_html += '<option selected data-statusColor="'+data.statusMstrList.statusColor+'" value="' +data.statusMstrList[j].statusValue + '">'
	 									+ data.statusMstrList[j].statusText + '</option>';
	                                 }
								}else{
									for (var j = 0; j < data.statusMstrList.length; j++) {								
										sel_html += '<option  data-statusColor="'+data.statusMstrList.statusColor+'" value="' +data.statusMstrList[j].statusValue + '">'
		 									+ data.statusMstrList[j].statusText + '</option>';
		                                 }
								} 
								
								
						
						for (var i = 0; i < data.taskList.length; i++) {
							
							
							var tr_data = '<tr> <td>'+(i+1)+'</td>'+
							'<td>'+data.taskList[i].custGroupName+'</td>'+
							'data-toggle="modal" data-target="#modal_small"'+
							'<td  onclick="showTaskLogs('+data.taskList[i].taskId+',\''+data.taskList[i].taskText+'\')"><a href="#" onclick="showTaskLogs('+data.taskList[i].taskId+',\''+data.taskList[i].taskText+'\')">'+data.taskList[i].taskText+'</a></td>'+
							'<td>'+data.taskList[i].taskEndDate+'</td>'+
							'<td>'+data.taskList[i].taskStatutoryDueDate+'</td>'+
							'<td>'+data.taskList[i].employees+'</td>'+
							'<td> M-'+data.taskList[i].mngrBudHr+' E-'+data.taskList[i].empBudHr+'</td>'+
							'<td id="taskStatus'+data.taskList[i].taskId+'" style="color: '+data.taskList[i].statusColor+';font-weight: bold;">'+data.taskList[i].taskStatus+'</td>'+
					
 '<td class="container1"> <select onclick="updateStatus_new(this.value,'+data.taskList[i].taskId+')"  class="form-control id="set_status'+data.taskList[i].taskId+'" data-id="'+data.taskList[i].taskStatus+'" ats_sel_status">'+sel_html+'</select></td>'+
							
 
 
 '<td class="text-center"><a class="chatmodallink" href="#"  onclick="showChatBox(\''+data.taskList[i].exVar1+'\',\''+data.taskList[i].exVar2+'\')" data-href="${pageContext.request.contextPath}/communication?taskId='+data.taskList[i].exVar1+'&empId='+data.taskList[i].exVar2+'" href1="${pageContext.request.contextPath}/communication?taskId='+data.taskList[i].exVar1+'&empId='+data.taskList[i].exVar2+'" title="Chat/Update"><i class="icon-comments" style="color: green;" ></i></a>'+
 '&nbsp;&nbsp;<a href="#" onclick="showEditTask('+data.taskList[i].taskId+')" title="Edit"><i class="icon-pencil7" style="color: black;" data-toggle="modal" data-target="#modal_edit"></i></a></td>'+'</tr>';
							
							$('#task_info_table' + ' tbody').append(tr_data);
						
						} */
						
				
	});

}
function dataFilter(){
	
	var fromDate = $("#fromDate").val();
	var service = $("#service").val();
	var activity = $("#activity").val();
	var custId = $("#custId").val();		
	var stats = $("#stats").val();
	//alert("Dates="+fromDate+" "+service+"   "+activity+" "+custId);
	$("#loader1").show();
	
	$
			.getJSON(
					'${fliterTaskList}',
					{

						fromDate : fromDate,
						service : service,
						activity : activity,
						custId : custId,
						stats : stats,
						ajax : 'true',

					},
					function(data) {
						append(data);
					});
	 //$("#basic").modal("hide");
	// dataFilter()
	      //$('#basic').popup();
	
	

	// $("#modal_edit").modal("hide");
	 
}



function append(data){
	//$("#loader1").show();
	//alert("In append");
	//alert(JSON.stringify(data))	;
	//alert(data.taskList.length)
	if(data.taskList.length<1){
		$("#loader1").hide();
	}
	//$("#task_info_table tbody").empty();
	$("#task_info_table").empty();
	$('#task_info_table').DataTable().destroy();
	 
	$('#task_info_table').append($('<tbody>'));  
	 
			
			//alert("list2:"+JSON.stringify(data.statusMstrList));	
			var sel_html ='';
			/*if(data.statusMstrList[0].statusText == data.taskList[0].taskStatus){ 
			
				for (var j = 0; j < data.statusMstrList.length; j++) {								
				sel_html += '<option selected data-statusColor="'+data.statusMstrList.statusColor+'" value="' +data.statusMstrList[j].statusValue + '">'
						+ data.statusMstrList[j].statusText + '</option>';
                 }
			}else{
				for (var j = 0; j < data.statusMstrList.length; j++) {								
					sel_html += '<option  data-statusColor="'+data.statusMstrList.statusColor+'" value="' +data.statusMstrList[j].statusValue + '">'
							+ data.statusMstrList[j].statusText + '</option>';
                     }
			}  */
			
			sel_html += '<option  data-statusColor="black" disabled selected value="-1">Select Status</option>';
			for (var j = 0; j < data.statusMstrList.length; j++) {								
				sel_html += '<option  data-statusColor="'+data.statusMstrList.statusColor+'" value="' +data.statusMstrList[j].statusValue + '">'
						+ data.statusMstrList[j].statusText + '</option>';
                 }		
	
	for (var i = 0; i < data.taskList.length; i++) {
		
		
		if(data.taskList[i].taskEndDate==null){
			//alert("Null Date")
			data.taskList[i].taskEndDate='';
		}
		var tr_data = '<tr> <td>'+(i+1)+'</td>'+
		'<td>'+data.taskList[i].custGroupName+' '+data.taskList[i].taskId+'</td>'+
		'data-toggle="modal" data-target="#modal_small"'+
		'<td  onclick="showTaskLogs('+data.taskList[i].taskId+',\''+data.taskList[i].taskText+'\')"><a href="#" onclick="showTaskLogs('+data.taskList[i].taskId+',\''+data.taskList[i].taskText+'\')">'+data.taskList[i].taskText+'</a></td>'+
		'<td>'+data.taskList[i].taskEndDate+'</td>'+
		'<td>'+data.taskList[i].taskStatutoryDueDate+'</td>'+
		'<td>'+data.taskList[i].employees+'</td>'+
		'<td> M-'+data.taskList[i].mngrBudHr+' E-'+data.taskList[i].empBudHr+'</td>'+
		'<td id="taskStatus'+data.taskList[i].taskId+'" style="color: '+data.taskList[i].statusColor+';font-weight: bold;">'+data.taskList[i].taskStatus+'</td>'+

'<td class="container1"> <select onchange="updateStatus_new(this.value,'+data.taskList[i].taskId+')"  class="form-control ats_sel_status1" id="set_status'+data.taskList[i].taskId+'" data-id="'+data.taskList[i].taskStatus+'" >'+sel_html+'</select></td>'+
		


'<td class="text-center"><a class="chatmodallink mr-2" href="#"  onclick="showChatBox(\''+data.taskList[i].exVar1+'\',\''+data.taskList[i].exVar2+'\',\''+data.taskList[i].taskText+'\',\''+data.taskList[i].ownerPartner+'\',\''+data.taskList[i].taskStatus+'\')" data-href="${pageContext.request.contextPath}/communication?taskId='+data.taskList[i].exVar1+'&empId='+data.taskList[i].exVar2+'" href1="${pageContext.request.contextPath}/communication?taskId='+data.taskList[i].exVar1+'&empId='+data.taskList[i].exVar2+'" title="Chat/Update"><i class="icon-comments" style="color: green;" ></i></a>'+
' <a href="#"  onclick="showEditTask('+data.taskList[i].taskId+',\''+data.taskList[i].taskText+'\',\''+data.taskList[i].custGroupName+'\')" title="Edit"><i class="icon-pencil7" style="color: black;" data-toggle="modal" data-target="#modal_edit"></i></a></td>'+'</tr>';
	

		
		
	//	$('#task_info_table' + ' tbody').append(tr_data);
		$('#task_info_table').find('tbody').append(tr_data); 
		
		 
	}
	
	$("#loader1").hide();
	//$('#task_info_table').addClass('datatable-button-html5-basic');
	$('#task_info_table').DataTable().draw();
	 

	 



}

</script>



	<script type="text/javascript">
	
	function showChatBox(var1,var2,var3,var4,var5){
		//alert(var1+':'+var2);
		 
		 //   var title = "var3;
		 //   var title = "Greetings";
		 //   var body = "Welcome to ASPSnippets.com";
		  // mdTaskName
		  $("#mdTaskName").html(var3);
		   $("#mdOwnerPartner").html(var4);
		   $("#mdTaskStatus").html(var5);
		   
		  //  $("#myModal .modal-title").html(title);
		  //  $("#myModal .modal-body").html(body);
		   var strhref ="${pageContext.request.contextPath}/communication?taskId="+var1+"&empId="+var2;
		   $("#modalbody").load(strhref);
		   $("#myModal").modal("show");
		   $('#myModal').on('hidden.bs.modal', function () {
			$("#modalbody").html("");
			}); 
	}
	function showEditTask(taskId,taskName,custName) {
		//alert("HI"+taskId);
			//alert("jj");
			       // $("#modal_edit").remove();

			$("#err_tTeam").hide();
			$("#err_eHr").hide();
			$("#err_mHr").hide();
			
			document.getElementById("edit_emptime").value=null;
			document.getElementById("edit_mngrtime").value=null;
				//alert("errordata"+data.task.taskEndDate);
			document.getElementById("workDate1").value=null;
			document.getElementById("dueDate").value=null;
			
			document.getElementById("taskId1").value=0;
			document.getElementById("bilAmt").value=0;
			$('#emp').html(null);
			$("#emp").trigger("chosen:updated");
			document.getElementById("ed_task_name").innerHTML="";
			document.getElementById("ed_task_cust").innerHTML="";

			document.getElementById("ed_task_name").innerHTML="Task: "+taskName;
			document.getElementById("ed_task_cust").innerHTML="Cust: "+custName;

			$
					.getJSON(
							'${getTaskByTaskIdForEdit}',
							{
								taskId : taskId,				
								ajax : 'true',

							},
							function(data) {
								
								//alert(JSON.stringify(data));
								/* if(${empType!=5}){
								  document.getElementById("div1").style.display = "block";
								  document.getElementById("div2").style.display = "block";
								  document.getElementById("div3").style.display = "block";
								} */

								document.getElementById("edit_emptime").value=data.task.empBudHr;
								document.getElementById("edit_mngrtime").value=data.task.mngrBudHr;
  								//alert("errordata"+data.task.taskEndDate);
								document.getElementById("workDate1").value=data.task.taskEndDate;
								document.getElementById("dueDate").value=data.task.taskStatutoryDueDate;
								
								document.getElementById("taskId1").value=data.task.taskId;
								document.getElementById("bilAmt").value=data.task.billingAmt;
								var html;
								 
								var len = data.empList.length;
								
								for (var i = 0; i < len; i++) {
									var flag=0;
								 for(var j = 0; j < data.empId.length; j++){
															
									 if(data.empList[i].empId==data.empId[j]){
										 		flag=1;							 
									 }															
								 }
                                 if(flag==1){
								 html += '<option selected value="' +data.empList[i].empId + '">'
									+ data.empList[i].empName + '</option>';
                                 }else{
                                	 html += '<option  value="' +data.empList[i].empId + '">'
 									+ data.empList[i].empName + '</option>';
                                 }
									
								}
								$('#emp').html(html);
								$("#emp").trigger("chosen:updated");
						 });
		}
	</script>


	<script type="text/javascript">
	
	function submitResponse(){
		//alert("flag ***"+flag);
		//alert("Hiii");
		var empBudHr = document.getElementById("edit_emptime").value;
			var manBudHr = document.getElementById("edit_mngrtime").value;
			var workDate=document.getElementById("workDate1").value ;//create this
			var dueDate=document.getElementById("dueDate").value;//create this
			var taskId1=document.getElementById("taskId1").value ;
			//var emp=document.getElementById("emp").value ;
			var emp=$("#emp").val();
			var bilAmt=document.getElementById("bilAmt").value ;
			//alert("Hi " +JSON.stringify(emp));
			
 		 var valid = true;
			if (empBudHr == null || empBudHr == "") {
				valid = false;
				//alert("Ok")
				$("#err_eHr").show()
			} 
			else{
				$("#err_eHr").hide()
			}
			
			 if (manBudHr == null || manBudHr == "") {
				valid = false;
				$("#err_mHr").show()
 			}else{
 				$("#err_mHr").hide();
 			}
			 
			 if (dueDate == null || dueDate == "") {
				valid = false;
 			}
 			if (taskId1 == 0 || taskId1 == "") {
				valid = false;
 			}
 			if (emp ==null || emp == "") {
				valid = false;
				$("#err_tTeam").show();
 			}else{
 				$("#err_tTeam").hide();
 			}
//alert(valid);
			if(valid == true){
				$("#loader1").show();
				$.post('${submitUpdatedTask}', {
					empBudHr : empBudHr,
					manBudHr : manBudHr,
					workDate : workDate,
					dueDate  : dueDate,
					taskId1  : taskId1,
					emp      : JSON.stringify(emp),
					bilAmt   : bilAmt,
					ajax : 'true',
				},

				function(data) {

					if (data.error == false) {
						getActiveHomeTasks();
						//$('#modal_edit').modal('hide')
						//alert("saved");
						 $("#modal_edit").modal("hide");
					} else {
						//alert("not saved");
					}

				});
			}
			
	}
	
	function updateStatus_new(statusId, taskId){
		 $('#modal_form_inline').modal('hide');
		 document.getElementById("del_link").value="";
	//alert(statusId+" "+taskId);
	//alert(" In updateStatus_new +966");
	//var x=  ($(this).attr("#data-id"));
		//alert("In updateStatus_new "+taskId);
		//alert("In updateStatus_new statusId "+statusId);
        var selectedStatus = $("#set_status"+taskId+" option:selected").html();
      alert("Selected status" +selectedStatus);
        var color =  $('#set_status'+taskId).val();
        if(parseInt(statusId) === 9){
  		  $('#modal_form_inline').modal('show');
  			document.getElementById("task_comp_id").value = taskId;		
  	  }else{
  		//alert("JJJ")
        $("#loader1").show();
		$
				.getJSON(
						'${updateTaskStatusByTaskId}',
						{
							taskId : taskId,
							statusId: statusId,
							selectedStatus : selectedStatus,
							ajax : 'true',

						},
						function(data) {
							// alert("data "+JSON.stringify(data));
							if(data.error==false){
								getActiveHomeTasks();
							//	alert("Task Status Updated Successfully!")
                           // document.getElementById("taskStatus"+taskId).innerHTML=selectedStatus;
                          // var color =  $('#set_status'+taskId).find('option:selected').attr('data-statusColor');
                          
                           //$('#taskStatus'+taskId).css('background', color); 
                            
							}
					      }); 
  	  }//end of else
	}
	
	
	$(document).ready(function(){
	      // setColor();
	      //set_status
	       $('#modal_form_inline').modal('hide');
		   document.getElementById("del_link").value="";
	      $('.ats_sel_status').change(function(e){
	    		//alert(" In ats_sel_status change +999");
	    	  var id = $(this).data("id") // will return the number 123
	    	//alert("Id " +id);
	    	  var value1 = $("#set_status"+id).val();
	    	 // alert(value)
	    	 var statusText = $("#set_status"+id+" option:selected").text();
	    	  //alert("Ok")
	    	 // alert("statusText " +statusText);
	    	  //Sachin 26-11-2019
	    	  if(parseInt(value1) === 9){
	    		  //alert("Ok1")
	    		  $('#modal_form_inline').modal('show');
	    			document.getElementById("task_comp_id").value = id;	
	    			document.getElementById("task_comp_text").value = id;	
	    	  }else{
	    		 // alert("Ok2")
	    		  updateStatus_new(value1, id);
	    	  }
	    	 // 
	    	  
	      });
	});
 function completeAndDelLink(){
	var taskId= document.getElementById("task_comp_id").value;
	var delLink= document.getElementById("del_link").value;
	var linkOk=0;
	var mob = /\//i;
    if (mob.test($.trim(delLink)) == false) {
//alert("Please enter proper link");
  $('#modal_form_inline1').modal('show');
  document.getElementById("show_alert").innerHTML="Please enter proper link";
  //Please add work hours in Daily work log for this task before completing.
linkOk=0;
    }else{
    	linkOk=1;
}
	//alert(linkOk)
	if(linkOk==1)
	$
	.getJSON(
			'${getDailyWorkLogCountForTask}',
			{
				taskId : taskId,
				ajax : 'true',
			},
			function(data) {
				//alert(JSON.stringify(data));
				

				
				if(data==0){
			  		  $('#modal_form_inline1').modal('show');
			  		  document.getElementById("show_alert").innerHTML="Please add work hours in Daily work log for this task before completing.";

			  							//alert("Please add entry in work log for the selected task")
				}
				else{
				if(delLink==null || delLink==""){
					//alert("Please provide deliverable link");
			  		  document.getElementById("show_alert").innerHTML="Please provide deliverable link.";

				}else{
					$
					.getJSON(
							'${completeAndDeliverTask}',
							{
								taskId : taskId,
								delLink : delLink,
								 
								
								ajax : 'true',
							},
							function(data) {
								//alert(JSON.stringify(data));
								
								 $('#modal_form_inline').modal('hide');
								 document.getElementById("del_link").value="";
								getActiveHomeTasks();
							});
				}//end of else
					
				}//end of else one
			});
	document.getElementById("del_link").value="";
 }
	function setColor()
	{
	   // var color =  $('.sel_status').find('option:selected').attr('id');
	    //$('#'+id).css('background', color); 
	}
    
	var task;  //task Text 
	function showTaskLogs(taskId,taskText) {
		
		var empTyp = ${empType};	
		var sesEmp = ${sessEmpId};
		
		try{
			$("#sucessmsg").hide();
			$("#del_sucess_msg").hide();
			$("#del_fail_msg").hide();
			}catch (e) {
				// TODO: handle exception
			}
		
		document.getElementById("taskId").value = taskId;		
		
		task = document.getElementById("taskText").innerHTML = taskText;
		
		$("#loader").show();
		$
				.getJSON(
						'${getDailyWorkLogByTaskId}',
						{
							taskId : taskId,				
							ajax : 'true',

						},
						function(data) {
							//alert("LogList:"+JSON.stringify(data.logList));
							var dataTable = $('#work_log_table1').DataTable();
							dataTable.clear().draw();
							var sr=0;
							$.each(data.logList, function(i, v) {								
								if(empTyp==2){
									if(v.exInt1!=1){
										sr=sr+1;
										dataTable.row.add(
												[ 	sr,
													v.exVar1,
													v.workHours
												]).draw();
									}
									
								}
								if(empTyp==3){
									if(v.exInt1!=2 && v.exInt1!=1 ){
										sr=sr+1;
										dataTable.row.add(
												[ 	sr,
													v.exVar1,
													v.workHours
												]).draw();
									}
									
								}
									
								if(empTyp==4){
									if(v.exInt1!=3 && v.exInt1!=2 && v.exInt1!=1 ){
										sr=sr+1;
										dataTable.row.add(
												[ 	sr,
													v.exVar1,
													v.workHours
												]).draw();
									}
									
								}
								if(empTyp==5){
									if(v.exInt1==5 && sesEmp==v.empId){
										sr=sr+1;
										dataTable.row.add(
												[ 	sr,
													v.exVar1,
													v.workHours
												]).draw();
									}
									
								}
								});
							
							var dataTable2 = $('#work_log_table2').DataTable();										
							dataTable2.clear().draw();
							sr=0;
							$.each(data.perDayLog, function(i, v) {
								var acButton='<td class="text-center"><a href="#" onclick="calEditWorkLog('+v.workLogId+','+v.taskId+',\''+v.workDate+'\', \''+v.workHours+'\')" title="Edit"><i class="icon-pencil7" style="color: black;" data-toggle="modal"></i></a>'+
								'&nbsp;&nbsp;<a href="#" onClick="calDelWorkLog('+v.workLogId+', '+v.taskId+')" title="Delete"><i class="icon-trash" style="color: black;" data-toggle="modal"></i></a></td>'
								if(empTyp==2){
									if(v.empType!=1){
										sr=sr+1;
										dataTable2.row.add(
												[ 	sr,
													v.workDate,
													v.empName,
													v.workHours,
													acButton
												]).draw();
									}
									
								}
								if(empTyp==3){
								
									if(v.empType!=2 && v.empType!=1 ){
										sr=sr+1;
										dataTable2.row.add(
												[ 	sr,
													v.workDate,
													v.empName,
													v.workHours,
													acButton
												]).draw();
									}
									
								}
									
								if(empTyp==4){
									if(v.empType!=3 && v.empType!=2 && v.empType!=1 ){
										sr=sr+1;
										dataTable2.row.add(
												[ 	sr,
													v.workDate,
													v.empName,
													v.workHours
												]).draw();
									}
									
								}
								if(empTyp==5){
									if(v.empType==5 && sesEmp==v.empId){
										sr=sr+1;
										dataTable2.row.add(
												[ 	sr,
													v.workDate,
													v.empName,
													v.workHours,
													acButton
												]).draw();
									}
									
								}
								});						
						});
		
		
		$('#modal_small').modal('show'); 
	}
	
// Delete Work Log
function calDelWorkLog(logId, taskId) {	
	var empTyp = ${empType};
	var sesEmp = ${sessEmpId};
	var x=false;
	if(logId!=0){
		x=confirm("Are you sure want to delete this record");
	}
	if(x==true)
	$
	.getJSON(
			'${deleteWorkLog}',
			{				
				logId : logId,
				taskId : taskId,
				ajax : 'true',

			},
			function(data) {
				
				
				
				var dataTable = $('#work_log_table1').DataTable();
				dataTable.clear().draw();
				var sr=0;
				$.each(data.logList, function(i, v) {								
					if(empTyp==2){
						
						if(v.exInt1!=1){
							sr=sr+1;
							dataTable.row.add(
									[ 	sr,
										v.exVar1,
										v.workHours
									]).draw();
						}
						
					}
					if(empTyp==3){
						if(v.exInt1!=2 && v.exInt1!=1 ){
							sr=sr+1;
							dataTable.row.add(
									[ 	sr,
										v.exVar1,
										v.workHours
									]).draw();
						}
						
					}
						
					if(empTyp==4){
						if(v.exInt1!=3 && v.exInt1!=2 && v.exInt1!=1 ){
							sr=sr+1;
							dataTable.row.add(
									[ 	sr,
										v.exVar1,
										v.workHours
									]).draw();
						}
						
					}
					if(empTyp==5){
						if(v.exInt1==5 && sesEmp==v.empId){
							sr=sr+1;
							dataTable.row.add(
									[ 	sr,
										v.exVar1,
										v.workHours
									]).draw();
						}
						
					}
					});
				
				var dataTable2 = $('#work_log_table2').DataTable();										
				dataTable2.clear().draw();
				
				if(data.inf.error){
					delFailMsg(); 	
				}else{
					showDelMsg();					
				}
				sr=0;
				$.each(data.perDayLog, function(i, v) {
					var acButton='<td class="text-center"><a href="#" onclick="calEditWorkLog('+v.workLogId+','+v.taskId+',\''+v.workDate+'\', \''+v.workHours+'\')" title="Edit"><i class="icon-pencil7" style="color: black;" data-toggle="modal"></i></a>'+
					'&nbsp;&nbsp;<a href="#" onClick="calDelWorkLog('+v.workLogId+', '+v.taskId+')" title="Delete"><i class="icon-trash" style="color: black;" data-toggle="modal"></i></a></td>'
					if(empTyp==2){
						if(v.empType!=1){
							sr=sr+1;
							dataTable2.row.add(
									[ 	sr,
										v.workDate,
										v.empName,
										v.workHours,
										acButton
									]).draw();
						}
						
					}
					if(empTyp==3){
						
						if(v.empType!=2 && v.empType!=1 ){
							sr=sr+1;
							dataTable2.row.add(
									[ 	sr,
										v.workDate,
										v.empName,
										v.workHours,
										acButton
									]).draw();
						}
						
					}
						
					if(empTyp==4){
						if(v.empType!=3 && v.empType!=2 && v.empType!=1 ){
							sr=sr+1;
							dataTable2.row.add(
									[ 	sr,
										v.workDate,
										v.empName,
										v.workHours
									]).draw();
						}
						
					}
					if(empTyp==5){
						if(v.empType==5 && sesEmp==v.empId){
							sr=sr+1;
							dataTable2.row.add(
									[ 	sr,
										v.workDate,
										v.empName,
										v.workHours,
										acButton
									]).draw();
						}
						
					}
					});	
			});
	
}
//Edit Work Log
function calEditWorkLog(logId, taskId, workDate, workHr, workRemark) {
	
	//alert("Log Id---------------"+logId+" - "+taskId+" - "+workDate+" - "+workHr);
	var empTyp = ${empType};
	var sesEmp = ${sessEmpId};	
	
	$("#logId").val(logId);
	$("#taskId").val(taskId);
	$("#any_time").val(workHr);
	$("#workDate").val(workDate);
	$("#remark").val(workRemark);
}
	
//Add Work Log
function addNewWorkLog(){
	
	document.getElementById("submtbtnlog").disabled = true;	
	
	var empTyp = ${empType};
	var sesEmp = ${sessEmpId};	
	
	var logId = $("#logId").val();
	var taskId = $("#taskId").val();
	var workHrs = $("#any_time").val();
	var workDate = $("#workDate").val();
	var remark = $("#remark").val();
	
	
	
	if(workDate!=null && workDate==""){
	//	alert("Please enter Work Date!");
		$("#err_wrkdate_log").show()
	}
	if(workHrs!=null && workHrs==""){
		//alert("Please enter Work Hours!");
		$("#err_wrk_log").show()
	}else{
		$("#err_wrkdate_log").hide()
		$("#err_wrk_log").hide()
		
	$("#loader").show();
	$
	.getJSON(
			'${newWorkLog}',
			{
				taskId : taskId,
				logId : logId,
				workHrs : workHrs,
				workDate : workDate,
				remark : remark,				
				ajax : 'true',

			},
			function(data) {
				
			
				
			var dataTable = $('#work_log_table1').DataTable();
			dataTable.clear().draw();			
			
			showMsg();//show success message
			
			 if(data!=null){
				 document.getElementById("submtbtnlog").disabled = false;
				 
			 }
			var sr=0;
			$.each(data.logList, function(i, v) {
				if(empTyp==2){
					if(v.exInt1!=1){
						sr=sr+1;
						dataTable.row.add(
								[ 	sr,
									v.exVar1,
									v.workHours
								]).draw();
					}
					
				}
				if(empTyp==3){
					if(v.exInt1!=2 && v.exInt1!=1 ){
						sr=sr+1;
						dataTable.row.add(
								[ 	sr,
									v.exVar1,
									v.workHours
								]).draw();
					}
					
				}
					
				if(empTyp==4){
					if(v.exInt1!=3 && v.exInt1!=2 && v.exInt1!=1 ){
						sr=sr+1;
						dataTable.row.add(
								[ 	sr,
									v.exVar1,
									v.workHours
								]).draw();
					}
					
				}
				if(empTyp==5){
					if(v.exInt1==5 && sesEmp==v.empId){
						sr=sr+1;
						dataTable.row.add(
								[ 	sr,
									v.exVar1,
									v.workHours
								]).draw();
					}
					
				}
				});
			
			var dataTable2 = $('#work_log_table2').DataTable();
			dataTable2.clear().draw();
			sr=0;
			$.each(data.perDayLog, function(i, v) {
				var acButton='<td class="text-center"><a href="#" onclick="calEditWorkLog('+v.workLogId+','+v.taskId+',\''+v.workDate+'\', \''+v.workHours+'\')" title="Edit"><i class="icon-pencil7" style="color: black;" data-toggle="modal"></i></a>'+
				'&nbsp;&nbsp;<a href="#" onClick="calDelWorkLog('+v.workLogId+', '+v.taskId+')" title="Delete"><i class="icon-trash" style="color: black;" data-toggle="modal"></i></a></td>'
				if(empTyp==2){
					if(v.empType!=1){
						sr=sr+1;
						dataTable2.row.add(
								[ 	sr,
									v.workDate,
									v.empName,
									v.workHours,
									acButton
								]).draw();
					}
					
				}
				if(empTyp==3){
					
					if(v.empType!=2 && v.empType!=1 ){
						sr=sr+1;
						dataTable2.row.add(
								[ 	sr,
									v.workDate,
									v.empName,
									v.workHours,
									acButton
								]).draw();
					}
					
				}
					
				if(empTyp==4){
					if(v.empType!=3 && v.empType!=2 && v.empType!=1 ){
						sr=sr+1;
						dataTable2.row.add(
								[ 	sr,
									v.workDate,
									v.empName,
									v.workHours,
									acButton
								]).draw();
					}
					
				}
				if(empTyp==5){
					if(v.empType==5 && sesEmp==v.empId){
						sr=sr+1;
						dataTable2.row.add(
								[ 	sr,
									v.workDate,
									v.empName,
									v.workHours,
									acButton
								]).draw();
					}
					
				}
				
			});								
							document.getElementById("taskText").innerHTML = task;			
			 
		 });
	$("#any_time").val('');
	$("#workDate").val('');
	$("#remark").val('');
	$("#logId").val(0);
	}
	
	//document.getElementById("submtbtnlog").disabled = false;
}

function hideValidtn(){
	$("#err_wrkdate_log").hide()
	$("#err_wrk_log").hide()
	document.getElementById("submtbtnlog").disabled = false;
}
</script>

	<script type="text/javascript">
	
	//For Work Log
	var start = moment().subtract(3, 'days');
    var end = moment();
$('.datepickerclass1').daterangepicker({
	singleDatePicker : true,
	selectMonths : true,
	selectYears : true,
	minDate: start,
	maxDate: end,
	drops:'down',
	locale : {
		format : 'DD-MM-YYYY'
	}
});


		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			drops:'down',
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		//daterange-basic_new
		// Basic initialization
		$('.daterange-basic_new').daterangepicker({
			//applyClass : 'bg-slate-600',
			 autoApply:true,
			 opens:'left',
			 drops:'down', //up
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>

	<script type="text/javascript">	
	function showMsg(){
		setTimeout(function(){
			$('#sucessmsg').fadeOut('fast');
			}, 3000);
		 $("#sucessmsg").show();
	}
	
	function showDelMsg(){
		setTimeout(function(){
			$('#del_sucess_msg').fadeOut('fast');
			}, 3000);
		 $("#del_sucess_msg").show();
	}
	
	function delFailMsg(){
		setTimeout(function(){
			$('#del_fail_msg').fadeOut('fast');
			}, 3000);
		 $("#del_fail_msg").show();
	}
	
	
	</script>


	<script type="text/javascript">
	
	
	function getActivities(servId) {
		//alert("servId " +servId)
		if (servId > 0) {

			$
					.getJSON(
							'${getActivityByService}',
							{
								servId : servId,
								ajax : 'true',
							},

							function(data) {
								var html;
								var p = "0";
								var q = "Select Activity";
								html += '<option value="'+p+'">'
										+ q + '</option>';
								html += '</option>';

								var temp = 0;
								
								var len = data.length;
								for (var i = 0; i < len; i++) {
									html += '<option value="' + data[i].actiId + '">'
											+ data[i].actiName
											+ '</option>';

								}

								$('#activity').html(html);
								$("#activity").trigger("chosen:updated");

							});

		}//end of if
	}
	</script>

	<script type="text/javascript">

	$(document)
			.ready(
					function($) {
						
						//getActiveHomeTasks();
						
				$("#filterForm")
						.submit(
								function(e) {
									var isError = false;
									var errMsg = "";
									
									///alert("Hi"+from_date);
									
										var from_date = document.getElementById("fromDate").value;
						 				var to_date = document.getElementById("toDate").value;
						 				
						 		        var fromdate = from_date.split('-');
						 		        from_date = new Date();
						 		        from_date.setFullYear(fromdate[2],fromdate[1]-1,fromdate[0]);
						 		        var todate = to_date.split('-');
						 		        to_date = new Date();
						 		        to_date.setFullYear(todate[2],todate[1]-1,todate[0]);
						 		        if (from_date > to_date ) 
						 		        {										 		           
											$("#error_start_date").show();
										 	$("#error_end_date").show();
										 	return false;
						 		           
						 		        }else {
						 					$("#error_start_date").hide();
						 					$("#error_end_date").hide();
						 				}
										
								
									if (!isError) {

										var x = true;
										if (x == true) {
											//alert("this");
											document
													.getElementById("submtbtn").disabled = true;
											return true;
										}
										//end ajax send this to php page
									}
									return false;
					});
});
//
	</script>
	<script type="text/javascript">
	
	
	
	</script>

	<script type="text/javascript">	
	function getDataTaskWise() {
		//alert("Hi");
		$("#loader").show();
		$
				.getJSON(
						'${getDailyWorkLogByEmpId}',
						{

							//empId : empId,
							ajax : 'true',

						},
						function(data) {
						

							/* if (data == "") {
								alert("No records found !!");						

							} */

							var dataTable = $('#printtable1').DataTable();
							dataTable.clear().draw();

							$.each(data, function(i, v) {
		  												
								var acButton = '&nbsp;&nbsp;<a href="#" onclick="editWorkLog('+ v.exVar1+')"><i class="icon-pencil7" style="color: black;">'+
								'</i>   &nbsp;&nbsp;<a href="#" )"><i class="icon-trash" style="color: black;""></i>';	
								dataTable.row.add(
										[ i + 1,
										  v.workDate,
										  v.workHours,
										  v.workRemark,
										  acButton
										
										]).draw();
							});});

	}
	
	
	
	function editWorkLog(logId){
		//alert("LogId--"+logId);
		window.open("${pageContext.request.contextPath}/editWorkLogById?logId="+logId);
		
	}
	</script>
	<script>
	 
	//Search Filter 
	var $rows = $('#task_info_table tr');
$('#search').keyup(function() {
    
    var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
        reg = RegExp(val, 'i'),
        text;
    
    $rows.show().filter(function() {
        text = $(this).text().replace(/\s+/g, ' ');
        return !reg.test(text);
    }).hide();
});

$(document).ready(function(){	
	 
});
</script>
	<!-- Modal HTML -->
	<div id="myModal" class="modal fade" tabindex="-1">
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
								<%-- <a href="${pageContext.request.contextPath}/taskListForEmp"><button
													type="button" class="btn btn-primary" id="cancelbtn">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Back
												</button></a> --%>
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
	</div>
<script type="text/javascript">
$('#submtbtn').on('click', function() {
	$.blockUI({ 
	    message: '<i class="icon-spinner4 spinner"></i>',
	    timeout: 5000, //unblock after 2 seconds
	    overlayCSS: {
	        backgroundColor: '#1b2024',
	        opacity: 0.8,
	        cursor: 'wait'
	    },
	    css: {
	        border: 0,
	        color: '#fff',
	        padding: 0,
	        backgroundColor: 'transparent'
	    }
	});
});

</script>
</body>
</html>