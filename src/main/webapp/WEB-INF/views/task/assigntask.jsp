<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="setDate()">

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
			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>


			<!-- /page header -->


			<!-- Content area -->
			<div class="content">




				<!-- Remote source -->
				<!-- <div id="modal_remote" class="modal" tabindex="-1">
					<div class="modal-dialog modal-full">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Filter</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="fromDate">From
										Date <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<input type="text" class="form-control datepickerclass"
											placeholder="From Date" id="fromDate" name="fromDate"
											autocomplete="off" onchange="trim(this)">
									</div>

									<label class="col-form-label col-lg-2" for="toDate">To
										Date <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<input type="text" class="form-control datepickerclass"
											placeholder="To Date" id="toDate" name="toDate"
											autocomplete="off" onchange="trim(this)">
									</div>

								</div>

								<div class="form-group row">

									<label class="col-form-label col-lg-2" for="periodicity">
										Select Customer <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<select name="custId" data-placeholder="Select Customer"
											id="custId"
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">

										</select>
									</div>

									<label class="col-form-label col-lg-2" for="periodicity">
										Select Service <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<select name="serviceId" data-placeholder="Select Service"
											id="serviceId"
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">

										</select>
									</div>

								</div>

								<div class="form-group row">

									<label class="col-form-label col-lg-2" for="periodicity">
										Select Activity <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<select name="serviceId" data-placeholder="Select Activity"
											id="serviceId"
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">

										</select>
									</div>

									<label class="col-form-label col-lg-2" for="periodicity">
										Select Status <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<select name="sts" data-placeholder="Select Status" id="sts"
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">

										</select>
									</div>

								</div>

							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
								<button type="button" class="btn bg-primary">Search</button>
							</div>
						</div>
					</div>
				</div> -->
				<!-- /remote source -->




				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Assign Task</h5>
						<div class="header-elements">
						<%-- 	<div class="list-icons">

								<a href="#" title="Chat/Update" data-toggle="modal"
									data-target="#modal_remote"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/filter.png"
									alt="" style="height: 26px; width: 26px;"></a> &nbsp;<a
									class="list-icons-item" data-action="collapse"></a>
							</div> --%>
						</div>
					</div>

					<form
						action="${pageContext.request.contextPath}/submitTaskAssignment"
						id="submitInsertEmpType" method="post">
						<div class="card-body">
						<div class="form-group row">
								<label class="col-form-label col-lg-1" for="service">
									Service<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="service" data-placeholder="Select Service"
										id="service"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true"
										onchange="getActivities(this.value)">
										<option value="0">Select Service</option>
										<c:forEach items="${serviceList}" var="serviceList">
											<c:choose>
												<c:when test="${serviceList.servId==servId}">
													<option selected value="${serviceList.servId}">${serviceList.servName}</option>
												</c:when>
												<c:otherwise>
													<option value="${serviceList.servId}">${serviceList.servName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>
								<div class="col-lg-2">
									<span class="validation-invalid-label" id="error_periodicity"
										style="display: none;"> Select Service</span>
								</div>


								<label class="col-form-label col-lg-1" for="activity">
									Activity <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="activity" data-placeholder="Select Activity"
										id="activity" multiple
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										
										
										
										<c:forEach items="${activityList}" var="activityList">
										<c:forEach items="${actList}" var="actList">
											<c:choose>
												<c:when test="${activityList.actiId==actList}">
													<option selected value="${activityList.actiId}">${activityList.actiName}</option>
												</c:when>
												<c:otherwise>
													<option value="${activityList.actiId}">${activityList.actiName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</c:forEach>
									</select>
								</div>

								<div class="col-lg-2">
									<span class="validation-invalid-label" id="error_activity"
										style="display: none;"> Select Activity </span>
										
								</div>


							</div>


							<div class="form-group row">



								<label class="col-form-label col-lg-1" for="service">
									Customer<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="customer" data-placeholder="Select Customer"
										id="customer" multiple
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										
										<option value="-1">All</option>

										<c:forEach items="${custList}" var="custList">
											<option value="${custList.custId}">${custList.custName}</option>
										</c:forEach>

									</select>
								</div>
								<div class="col-lg-2">
									<span class="validation-invalid-label" id="error_cust"
										style="display: none;"> Select customer </span>
								</div>
							</div>

							<div class="table-responsive">

								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th width="10%">Sr.no</th>
											<th>Task</th>
											<th>Customer</th>
											<th>Activity</th>
											<th>Year</th>
											<th>Date</th>
											<th>Alloted Hrs</th>
											<th>Actual Hrs</th>


										</tr>
									</thead>

									<c:forEach items="${taskList}" var="taskList" varStatus="count">
										<tr>
											<td>${count.index+1}&nbsp;&nbsp;<input type="checkbox"
												id="TaskId${taskList.taskId}" value="${taskList.taskId}"
												name="TaskId" class="select_all"></td>

											<td>${taskList.taskText}</td>
											<td>${taskList.custFirmName}</td>
											<td>${taskList.actiName}</td>
											<td>${taskList.finYearName}</td>
											<td>${taskList.taskStatutoryDueDate}</td>
											<td>${taskList.mngrBudHr}</td>
											<td>${taskList.empBudHr}</td>



										</tr>
									</c:forEach>
									</tbody>

								</table>

							</div>
							<br>
							<div style="text-align: center;">
								<input type="submit" class="btn btn-primary" value="Assign Task"
									id="deleteId"
									onClick="var checkedVals = $('.select_all:checkbox:checked').map(function() { return this.value;}).get();checkedVals=checkedVals.join(',');if(checkedVals==''){alert('No Rows Selected');return false;	}else{   return confirm('Are you sure want to Assign These Task');}"
									style="align-content: center; width: 113px; margin-left: 40px;">
							</div>



						</div>
					</form>
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


	<script type="text/javascript">
		$(document).ready(
				function() {
					//	$('#printtable').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});
	</script>
<script type="text/javascript">

function setDate(){
	
	
	document
	.getElementById("workDate").value="";
}

</script>
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
</body>
</html>