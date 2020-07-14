<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<style type="text/css">
.AnyTime-win {
	height: 430px !important;
	overflow-y: auto !important;
}
</style>
</head>

<body>
	<c:url value="/getDailyWorkLogById" var="getDailyWorkLogById"></c:url>
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>
	<c:url value="/addEmpWorkHrsNew" var="addEmpWorkHrsNew"></c:url>




	<c:url value="/getEmpWorkHoursLogs" var="getEmpWorkHoursLogs"></c:url>

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
			<!-- <div class="page-header page-header-light">


				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="#" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active"></span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>


				</div>
			</div> -->
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


						<div class="card">
							<div class="card-header header-elements-inline">
								<h6 class="card-title">
									Add Employee Hours &nbsp;<span class="validation-valid-label">Search
										employees previous work log data by work log date.(task status
										!Completed) On list, Action button Add new Hours or edit
										Existing </span>
								</h6>
								<!-- <div class="header-elements">
									<div class="list-icons">
										<a class="list-icons-item" data-action="collapse"></a>
									</div>
								</div> -->
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
									<span class="font-weight-semibold">Oh snap!</span>
									<%
										session.removeAttribute("errorMsg");
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
									<span class="font-weight-semibold">Well done!</span>
									<%
										session.removeAttribute("successMsg");
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>

								<form id="submitInsertClient">

									<input type="hidden" id="custId" name="custId" value="">

									<div class="form-group row">
										<label class="col-form-label col-xl-1" for="fromDate">Date
											<span style="color: red"></span>:
										</label>
										<div class="col-xl-3">
											<input type="text" class="form-control daterange-basic_new"
												id="fromDate" name="fromDate">
										</div>

										<label class="col-form-label col-xl-1" for="custName">Customer
											<span style="color: red"> </span>:
										</label>
										<div class="col-xl-3">
											<select name="customer" data-placeholder="Select Customer"
												id="customer"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<option value="0">Select Customer</option>
												<c:forEach items="${custHeadList}" var="custHeadList">

													<option value="${custHeadList.custId}">${custHeadList.custFirmName}</option>

												</c:forEach>

											</select>
										</div>

										<label class="col-form-label col-xl-1" for="custName">Employee
											<span style="color: red"> </span>:
										</label>
										<div class="col-xl-3">
											<select name="employee" data-placeholder="Select Employee"
												id="employee"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<option value="0">Select Employee</option>
												<c:forEach items="${epmList}" var="epmList">

													<option value="${epmList.empId}">${epmList.empName}</option>

												</c:forEach>

											</select>
										</div>



									</div>



									<div class="form-group row">
										<label class="col-form-label col-xl-1" for="service">
											Service <span style="color: red"> </span>:
										</label>
										<div class="col-xl-3">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)">
												<option value="0">Select Service</option>
												<c:forEach items="${serviceList}" var="service">

													<option value="${service. servId}">${service. servName}</option>

												</c:forEach>

											</select>
										</div>
										<!-- <div class="col-lg-3">
											<span class="validation-invalid-label" id="error_service"
												style="display: none;">Please select service.</span>
										</div> -->



										<label class="col-form-label col-xl-1" for="activity">
											Activity <span style="color: red"></span>:
										</label>
										<div class="col-xl-3">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
											</select>
										</div>
										<!-- <div class="col-lg-3">
											<span class="validation-invalid-label" id="error_activity"
												style="display: none;">Please select above service
												for corresponding activity.</span>
										</div> -->



										<div class="col-lg-1">
											<input type="button" onclick="getWorkLog()"
												class="btn bg-blue ml-3 legitRipple" value="Search">
										</div>
										<div id="loader1" style="display: none;">
											<img
												src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
												width="100px" height="100px"
												style="display: block; margin-left: auto; margin-right: auto">
										</div>
									</div>


									<%-- <div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												<!--data-toggle="modal" data-target="#modal_remote" -->
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/customerList"><button
													type="button" class="btn btn-primary" id="cancelbtn">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div> --%>
								</form>
							</div>
						</div>
						<form action="${pageContext.request.contextPath}/addEmpWorkHrs"
							method="post">
							<input type="hidden" value="${isEdit}" id="editLogid"> <input
								type="hidden" id="employeeId" name="employeeId">
							<div class="card">
								<div class="card-body">
									<div class=table-responsive>
										<table class="table datatable-basic table-hover"
											id=worklogdatatable>
											<thead>
												<tr>
													<th style="color: white;">Sr. No.<!-- <input type="checkbox"
																name="selAll" id="selAll" /> --></th>
													<th style="color: white;">Task Name</th>
													<th style="color: white;">Work Date</th>
													<th style="color: white;">Work Hours</th>
													<th style="color: white;">EmpLoyee Name</th>
													<th style="color: white;">Customer Name</th>
													<th style="color: white;">Remark</th>
													<th style="color: white;">Action</th>
												</tr>
											</thead>
											<tbody>

											</tbody>
										</table>
									</div>
									<br>

									<!-- <div class="modal-footer">
									<button type="submit" class="btn btn-link" data-dismiss="modal">Close</button>
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">Submit <i class="icon-paperplane ml-2"></i>
											</button>
								</div> -->

								</div>
							</div>
						</form>
					</div>
				</div>

				<!-- /remote source -->

				<!-- /content area -->

				<!-- Footer -->
				<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
				<!-- /footer -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>





	<script>
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
									var p = 0;
									var q = "Select Activity";
									html += '<option value="'+p+'" selected>'
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

		var emp1; //global Employee variable to fetch employee value.		

		function getWorkLog() {
			//alert("Hi")
			$("#loader1").show();
			var emp = $("#employee").val();
			var service = $("#service").val();
			var activity = $("#activity").val();
			var customer = $("#customer").val();
			var fromDate = $("#fromDate").val();

			//	alert("Data------" + emp + " " + service + " " + activity + " "+ customer);
			emp1 = document.getElementById("employeeId").value = emp;
			document.getElementById("employeeId").value = emp;

			$
					.getJSON(
							'${getEmpWorkHoursLogs}',
							{
								emp : emp,
								service : service,
								activity : activity,
								customer : customer,
								fromDate : fromDate,
								ajax : 'true',
							},

							function(data) {
								if (data.length == 0) {
									$("#loader1").hide();
								}
								var dataTable = $('#worklogdatatable')
										.DataTable();
								dataTable.clear().draw();
								var wrkDt = 0;
								$
										.each(
												data,
												function(i, v) {

													var acButton = '&nbsp;&nbsp;<a href="#" onclick="showTaskLogs('
															+ v.taskId
															+ ',\''
															+ v.taskText
															+ '\','
															+ v.exInt1
															+ ')"><i class="icon-add"  title="Add Task Hours"style="color: black;">'
															+ '</i>   &nbsp;&nbsp;<a href="#" id="edButton'
															+ v.taskId
															+ '" onclick="editWorkLog('
															+ v.workLogId
															+ ', \''
															+ v.taskText
															+ '\','
															+ v.exInt1
															+ ')"><i class=" icon-pencil7" title="Edit Current Hours" style="color: black;""></i>';

													if (v.workDate == '09-09-9999') {
														wrkDt = '';
														// $('#edButton'+v.taskId).setAttribute("disabled",true) ;
														// element.setAttribute(attributename, attributevalue)

														acButton = '&nbsp;&nbsp;<a href="#" onclick="showTaskLogs('
																+ v.taskId
																+ ',\''
																+ v.taskText
																+ '\','
																+ v.exInt1
																+ ')"><i class="icon-add" style="color: black;">'
																+ '</i>   &nbsp;&nbsp;';

													} else {
														wrkDt = v.workDate;
													}

													dataTable.row
															.add(
																	[
																			i + 1,
																			v.taskText,
																			wrkDt,
																			v.workHours,
																			v.employees,
																			v.custFirmName,
																			v.workRemark,
																			acButton ])
															.draw();
													$("#loader1").hide();
												});
								$('.datepickerclass').daterangepicker({
									singleDatePicker : true,
									selectMonths : true,
									selectYears : true,
									locale : {
										format : 'DD-MM-YYYY'
									}
								});
							});

			var logEdit = $("#editLogid").val();
			if (logEdit == 1) {
				$('#modal_small').modal('show');
			} else {
				$('#modal_small').modal('hide');
			}
		}

		//
		function showTaskLogs(taskId, taskText, emplyeId) {
			//alert(taskId+" "+taskText)
			document.getElementById("empId").value = emplyeId;

			document.getElementById("taskId").value = taskId;
			//document.getElementById("taskText").value = taskText;
			document.getElementById("taskText").innerHTML = taskText;
			$("#loader").show();
			$.getJSON('${getDailyWorkLogByTaskId}', {

				taskId : taskId,
				ajax : 'true',

			}, function(data) {

				var dataTable = $('#work_log_table').DataTable();
				dataTable.clear().draw();

				$.each(data, function(i, v) {
					//alert(JSON.stringify(v));

					dataTable.row.add([ i + 1, v.exVar1,
					// v.workDate,
					v.workHours
					//  acButton

					]).draw();
				});
			});
			document.getElementById("addEmpWorkHrs").reset();

			$('#modal_small').modal('show');

		}

		function editWorkLog(logId, taskText) {
			//alert(logId);
			//$("#loader").show();
			$("#err_wrk_log").hide()
			document.getElementById("taskText").innerHTML = taskText;
			$.getJSON('${getDailyWorkLogById}', {

				logId : logId,
				ajax : 'true',

			}, function(data) {

				//alert(JSON.stringify(data));
				document.getElementById("work_hr").value = data.workHours;
				document.getElementById("empId").value = data.empId;
				document.getElementById("taskId").value = data.taskId;
				document.getElementById("logId").value = data.workLogId;
				document.getElementById("remark").value = data.workRemark;
				document.getElementById("workDate").value = data.workDate;

			});

			$('#modal_small').modal('show');

		}
	</script>


	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							$("#selAll")
									.click(
											function() {
												$(
														'#worklogdatatable tbody input[type="checkbox"]')
														.prop('checked',
																this.checked);
											});
						});

		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>

	<!-- Daily Work Log modal -->
	<div id="modal_small" class="modal fade" tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header bg-success">
					<h5 class="modal-title">
						<span id="taskText"></span>
					</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-header">
					<form action="addEmpWorkHrs" method="post" id="addEmpWorkHrs">
						<div class="form-group row">

							<input type="hidden" name="logId" id="logId"> <input
								type="hidden" name="taskId" id="taskId"> <input
								type="hidden" id="empId" name="empId">

							<div class="form-group form-group-float col-md-3">
								<label class="form-group-float-label">Work Date</label> <input
									type="text" class="form-control datepickerclass"
									autocomplete="off" name="workDate" id="workDate"
									placeholder="Work Date">
							</div>


							<div class="form-group form-group-float col-md-3">
								<label class="form-group-float-label">Work Hours </label> <input
									type="text" class="form-control" name="workHour"
									data-mask="99:99" id="work_hr" placeholder="Work Hour" value="">
								<div class="col-md-2">
									<span class="validation-invalid-label" id="err_wrk_log"
										style="display: none; width: 180px;">Please enter
										employee work hours.</span>
								</div>
							</div>

							<div class="form-group form-group-float  col-md-4">
								<label class="form-group-float-label"> Remark</label> <input
									type="text" class="form-control" placeholder="Enter Remark"
									id="remark" name=remark autocomplete="off"
									onchange="trim(this)">
							</div>

							<div class="form-group  col-md-1">
								<label class="form-group-float-label animate is-visible">
								</label>
								<button type="button" id="submtbtn" onclick="addEmpHrs()"
									class="btn bg-info-400 legitRipple">
									<b><i class="icon-paperplane"></i></b>
								</button>
							</div>


						 

						</div>
						
						<div class="form-group row">
							<div class="form-group col-md-1">
								<div id="loader2" style="display: none;">
									<img
										src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
										width="100px" height="100px"
										style="display: block; margin-left: auto; margin-right: auto">
								</div>
							</div>

							<div class="form-group row">

								<div class="col-md-2">
									<span class="validation-invalid-label" id="err_log"
										style="display: none; width: 180px;"> Failed to Add the
										Record .. Try Again</span>
								</div>
							</div>


						</div>




						<%--  <input type="hidden" value="${isEdit}" id="editLogid"> --%>
					</form>


				</div>
				<!-- <div class="table-responsive">
								<table class="table datatable-scroller1" id="work_log_table">
									<thead>
										<tr>
											<th style="width: 350px; color: white;"></th>
											<th style="width: 350px; color: white;">Employee</th>
											<th style="width: 100px; color: white;">Date</th>
											<th style="width: 100px; color: white;">Actual Hours</th>

										</tr>
									</thead>
								</table>
							</div> -->


				<div class="modal-footer" style="display: none;">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<button type="button" class="btn bg-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End Daily Work Log modal -->

	<script type="text/javascript">
		function addEmpHrs() {
			$("#loader2").show();
			var logId = $("#logId").val();
			var taskId = $("#taskId").val();
			var empId = $("#empId").val();
			var workDate = $("#workDate").val();
			var workHour = $("#work_hr").val();
			var remark = $("#remark").val();
			
			
			//alert(workHour);

			var isError = false;
			var errMsg = "";

			if (!workHour || workHour == "") {

				isError = true;

				$("#err_wrk_log").show()

			} else {
				$("#err_wrk_log").hide()
			}

			if (!isError) {

				var x = true;
				if (x == true) {

					document.getElementById("submtbtn").disabled = true;

					//

					$
							.post(
									'${addEmpWorkHrsNew}',
									{
										logId : logId,
										taskId : taskId,
										empId : empId,
										workDate : workDate,
										workHour : workHour,
										remark : remark,
										ajax : 'true',
									},

									function(data) {
										$("#loader2").hide();
										//alert(JSON.stringify(data));

										if (data.error == true) {

											$("#err_log").show()
											document.getElementById("submtbtn").disabled = false;

											document.getElementById(
													"addEmpWorkHrs").reset();

										} else {
											$("#err_log").hide()
											getWorkLog();
											document.getElementById(
													"addEmpWorkHrs").reset();
											document.getElementById("submtbtn").disabled = false;
											$('#modal_small').modal('hide');
										}

									});
				}
			}

		}
	</script>
	<script>
		$(document).ready(function($) {
			$("#addEmpWorkHrs").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if (!$("#work_hr").val() || $("#work_hr").val() == "") {

					isError = true;

					$("#err_wrk_log").show()

				} else {
					$("#err_wrk_log").hide()
				}

				if (!isError) {

					var x = true;
					if (x == true) {

						document.getElementById("submtbtn").disabled = true;
						//document.getElementById("cancelbtn").disabled = true;
						return true;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
		//
	</script>
</body>
</html>