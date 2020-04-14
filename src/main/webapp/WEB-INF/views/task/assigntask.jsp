<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<style type="text/css">
.dataTables_length{display:none !important;}
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

.AnyTime-win {
	height: 320px !important;
	overflow-y: auto !important;
	width: 300px;
}
</style>
<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="setDate()">
	<c:url value="/getCountofPartner" var="getCountofPartner"></c:url>

	<c:url value="/updateTaskAssignPage" var="updateTaskAssignPage"></c:url>

	<c:url value="/getCountofManagers" var="getCountofManagers"></c:url>
		<c:url value="/getServicesandCustByPeriodId" var="getServicesandCustByPeriodId"></c:url>
	
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
<%-- 			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>
 --%>

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
										Select  <span style="color: red">* </span>:
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
									<span class="font-weight-semibold">Well Done!</span>
									<%
										out.println(session.getAttribute("successMsg"));
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%> 


					<form action="${pageContext.request.contextPath}/assignTask"
						id="submitInsertEmpType1">
						<div class="card-body">

							<div class="form-group row">
								<label class="col-form-label col-lg-1" for="periodicityId">Periodicity<span style="color: red">* </span> :
								</label>
								<div class="col-lg-2">
									<select name="periodicityId" data-placeholder="Select Service"
										id="periodicityId" onchange="showServices()"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">

										<option selected value="0"></option>
										<c:forEach items="${periodList}" var="periodList">
											<c:choose>
												<c:when test="${periodList.periodicityId==perdId}">
													<option selected value="${periodList.periodicityId}">${periodList.periodicityName}</option>
												</c:when>
												<c:otherwise>
													<option value="${periodList.periodicityId}">${periodList.periodicityName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>
								
								
								<label class="col-form-label col-lg-1" for="service">
									Service<span style="color: red">* </span> :
								</label>
								<div class="col-lg-2">
									<select name="service" data-placeholder="Select Service"
										id="service"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">

										<option value="0">All</option>
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
								
								<label class="col-form-label col-lg-1" for="customer">
									Customer<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="customer" data-placeholder="Select Customer"
										id="customer"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">

										<option value="0">All</option>
										<c:forEach items="${custList}" var="custList">

											<c:choose>
												<c:when test="${custId==custList.custId}">
													<option selected value="${custList.custId}"><c:out
															value="${custList.custFirmName}" /></option>

												</c:when>
												<c:otherwise>
													<option value="${custList.custId}"><c:out
															value="${custList.custFirmName}" /></option>
												</c:otherwise>
											</c:choose>
										</c:forEach>




									</select>
								</div>
								
								<div class="col-lg-2">
								<button type="submit" class="btn btn-primary"
										id="submtbtn">
										Search <!-- <i class="icon-paperplane ml-2"></i> -->
									</button>
								
								</div>
								

							</div>


							<div class="form-group row mb-0">
								<div class="col-lg-12" align="center">
									<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
									
<div id="loader1" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="100px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
								</div>
							</div>
						</div>
					</form>

					<form
						action="${pageContext.request.contextPath}/submitTaskAssignment"
						id="submitInsertAssignTask" method="post">
						<div class="card-body">
							<div class="form-group row">

								<label class="col-form-label col-lg-1" for="startDate">Work
									Date: </label>
								<div class="col-lg-2">
									<input type="text" class="form-control datepickerclass1"
										name="workDate" id="workDate" placeholder="Task Work Date"
										autocomplete="off">
								</div>


								<label class="col-form-label col-lg-1" for="locId2">
									Employee <span style="color: red">* </span>:
								</label>
								<div class="col-lg-6">

									<select multiple="multiple" data-placeholder="Select Employee"
										name="empId2" id="empId2"
										class="form-control form-control-sm select"
										data-container-css-class="select-sm" data-fouc>
										<option value="">Select Employee</option>
										<c:forEach items="${epmList}" var="epmList">
											<option value="${epmList.empId}">${epmList.empName}
												-${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
										</c:forEach>

									</select> <span class="validation-invalid-label" id="error_locId2"
										style="display: none;">Please Select the Employees.</span>
										<span
												class="validation-invalid-label" id="error_emp_mng"
												style="display: none;">Please Select a Partner (PT).</span>
										
								</div>
								<div class="col-lg-2">
								<input type="button" class="btn btn-primary" value="Assign Task"
									id="deleteId"
									>
							</div>
							</div>
<br>
							<br>
							<span class="validation-invalid-label" id="error_chk"
									style="display: none;">Please Select the Tasks.</span>
									
									<span
												class="validation-valid-label"  
												 > First check the tasks to assign and then select employees and assign. To edit a task click on Activity name</span>
							<div class="table-responsive">

								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="printtable_assignTask">
									<thead>
										<tr class="bg-blue">
											<th width="10%">Sr.no</th>
											<th>Task </th>
											<th>Customer</th>
											<th><input type="checkbox"  
												name="selAll" id="selAll" /></th>
											<th>Activity</th>
											<th>Year</th>
											<th>Statutory Due Date</th>
											<th>Budget Hrs MNG</th>
											<th>Budget Hrs EMP</th>


										</tr>
									</thead>

									<c:forEach items="${taskList}" var="taskList" varStatus="count">
										<tr>
											<td>${count.index+1}</td>

											<td>${taskList.taskText}&nbsp;&nbsp;${taskList.taskId}</td>
											<td>${taskList.custFirmName}</td>
											<td><input type="checkbox"
												id="TaskId${taskList.taskId}" value="${taskList.taskId}"
												name="TaskId" class="select_all"  ></td>
											<td><a href="#" data-toggle="modal" data-target="#modal_edit"
											onclick="showEditTask(${taskList.taskId},'${taskList.mngrBudHr}','${taskList.empBudHr}','${taskList.taskStatutoryDueDate}','${taskList.taskEndDate}','${taskList.taskSubline}','${taskList.custFirmName}','${taskList.actiName}')" title="Edit">${taskList.actiName}</a></td>
											
											<td>${taskList.finYearName}</td>
											<td>${taskList.taskStatutoryDueDate}</td>
											<td>${taskList.mngrBudHr}</td>
											<td>${taskList.empBudHr}</td>
										</tr>
									</c:forEach>
									</tbody>

								</table>
								
							</div>
							



						</div>
					</form>
				</div>


<div id="modal_edit" class="modal fade" tabindex="-1">
				
									<div class="modal-dialog">
						<div class="modal-content">
					

							<div class="modal-header bg-success">
								<h5 class="modal-title">Edit Task</h5> &nbsp;&nbsp;
								<h6 style="color: brown"
								 id="custName"> </h6> &nbsp;&nbsp; 
								<h6  style="color: brown" id="actiName"> </h6>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

								<!-- <form action="submitUpdatedTask" method="post"> -->
								<input type="hidden" id="taskId1" name="taskId1" value=0>
								
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="ManBudgetedHrs">Manager
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control" data-mask="999:99"
											placeholder="Enter Manager Budgeted Hours" id="edit_mngrtime"
											name="manBudHr" 
											autocomplete="off">
											<span id="mHr" style="display: none; color:red;"
												class="validation-valid-label"  
												 > This field is required</span>
									</div>

								</div>
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="EmpBudgetedHrs">Employee
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" data-mask="999:99" class="form-control"
											placeholder="Enter Employee Budgeted Hours" id="edit_emptime"
											  name="empBudHr"
											autocomplete="off">
											<span id="eHr" style="display: none; color:red;"
												class="validation-valid-label"  
												 > This field is required</span>
											
									</div>

								</div>
								<div class="form-group row">

									<label class="col-form-label col-lg-6">Statutory Due
										Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
										 
											placeholder="Enter Statutory Due Date" id="dueDate"
											name="dueDate" autocomplete="off">
									</div>
									<span id="dDate" style="display: none; color:red;"
												class="validation-valid-label"  
												 > This field is required</span>

								</div>
								
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6">Work Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											placeholder="Enter Work Date" 
											id="workDate1" name="workDate1" autocomplete="off">
									</div>
									
								</div>
								
								<!--Add/Edit Billing Amount 11-01-2020 -->
										<div class="form-group row">

										<label class="col-form-label col-lg-6" for="bilAmt">
												Billing Amount :
											</label>
											<div class="col-lg-6">
												<input type="text" name="bilAmt" data-placeholder="Billing Amount"
													 id="bilAmt" value="" maxlength="7"
													class="form-control">
												
											</div>
											

										</div>

							</div>
							
							 <div class="modal-footer">
										<button type="submit" class="btn bg-primary" onclick="submitResponse()">Save
											Changes</button><button type="button" class="btn btn-link"
											data-dismiss="modal">Close</button>
										
									</div>
						</div>
					</div>
					
				</div>
				<!-- /Task Edit Log modal -->

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
	function showEditTask(taskId,mngHr,empHr,dueDate,workDate,billAmt,custName,actiName){
		$("#loader1").show();
		document.getElementById("edit_emptime").value=empHr;
		document.getElementById("edit_mngrtime").value=mngHr;
		document.getElementById("workDate1").value=workDate;
		document.getElementById("dueDate").value=dueDate;
		
		document.getElementById("taskId1").value=taskId;
		document.getElementById("bilAmt").value=billAmt;
		document.getElementById("custName").innerHTML="Customer Name- "+custName;
		document.getElementById("actiName").innerHTML="Activity Name- "+actiName;
		//var table = $('#example').DataTable();
		$("#loader1").hide();
	}
	
	function showServices() {
		//alert("servId " +servId)
		$("#loader1").show();
     var periodcityId = $("#periodicityId").val();

		if (periodcityId > 0) {

			$
					.getJSON(
							'${getServicesandCustByPeriodId}',
							{
								periodcityId : periodcityId,
								ajax : 'true',
							},

							function(data) {
								var html="";
								var p = "0";
								html += '<option  value="'+p+'" selected>ALL</option>';
								html += '</option>';

								var temp = 0;

								var len = data.servList.length;
								if(len==0){
									$("#loader1").hide();
								}
								for (var i = 0; i < len; i++) {												

									html += '<option value="' + data.servList[i].servId + '">'
											+ data.servList[i].servName
											+ '</option>';	
								}

								 
								$('#service').html(html);
								$("#service").trigger("chosen:updated");

								
								//new
								html="";
								 p = "0";
								html += '<option  value="'+p+'" selected>ALL</option>';
								html += '</option>';

							

								 len = data.custList.length;
								if(len==0){
									$("#loader1").hide();
								}
								for (var i = 0; i < len; i++) {												

									html += '<option value="' + data.custList[i].custId + '">'
											+ data.custList[i].custFirmName
											+ '</option>';	
								}

								 
								$('#customer').html(html);
								$("#customer").trigger("chosen:updated");

								
							});

		}//end of if
		$("#loader1").hide();
	}
	
							$("#deleteId")
									.click(function(){
												var isError = false;
												var errMsg = "";
												var emps = $("#empId2").val();

												var checked = $("#submitInsertAssignTask input:checked").length > 0;
												if (!checked) {
													$("#error_chk").show()
													isError = true;
												} else {
													$("#error_chk").hide()
													isError = false;
												}
												//alert("checked" +checked);
												if (emps == null || emps == "") {
													isError = true;
													$("#error_locId2").show()
												} else {
													$("#error_locId2").hide()
												}
												
												$.getJSON('${getCountofPartner}',
														{
															empIds : JSON.stringify(emps),
															ajax : 'true',
															 //async: false,
														},

														function(data) {
															//alert(JSON.stringify(data));
															if (data == 0) {
																	isError = true;
																$("#error_emp_mng").show();
																//alert(11);
																return false;

															} else {
																$("#error_emp_mng").hide();
																isError = false;
																var errMsg = "";
																var emps = $("#empId2").val();

																var checked = $("#submitInsertAssignTask input:checked").length > 0;
																if (!checked) {
																	$("#error_chk").show()
																	isError = true;
																} else {
																	$("#error_chk").hide()
																	isError = false;
																}
																//alert("checked" +checked);
																if (emps == null || emps == "") {
																	isError = true;
																	$("#error_locId2").show()
																} else {
																	$("#error_locId2").hide()
																}
															}
														
												if(isError==false)
													$("#submitInsertAssignTask").submit();
														});
												
						});
	</script>

	<script type="text/javascript">
	/* var rows_selected = [];
	var countChecked = function($table, checkboxClass) {
		  if ($table) {
		    // Find all elements with given class
		    var chkAll = $table.find(checkboxClass);
		    // Count checked checkboxes
		    var checked = chkAll.filter(':checked').length;
		    // Count total
		    var total = chkAll.length;    
		    // Return an object with total and checked values
		    return {
		      total: total,
		      checked: checked
		    }
		  }
		}
		$(document).on('click', '.select_all', function() {
		  var result = countChecked($('#printtable1'), '.select_all');
		   alert(result.checked+":"+result.total);
		  
		});
		$(document).on('click', '#selAll', function() {
			  var result = countChecked($('#printtable1'), '.select_all');
			   alert(result.checked+":"+result.total);
			  
			}); */
			
			
		$(document).ready(
		
				function() {
					
			/*  $('#printtable_assignTask').dataTable({
					    "bPaginate": false,
					  	dom: 'Bfrtip',
					    buttons: [
				            'copyHtml5',
				            'excelHtml5',
				            'csvHtml5',
				            'pdfHtml5'
				        ]
					});  */
					 
					
					//	$('#printtable').DataTable();
			
					$("#selAll").click(
							function() {
								$('#printtable_assignTask tbody input[type="checkbox"]')
										.prop('checked', this.checked);
								 
							});
				});
	</script>
	<script type="text/javascript">
		function setDate() {

			document.getElementById("workDate").value = "";
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

		$('.datepickerclass1').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			autoUpdateInput : false,
			//autoApply:false,
			//startDate :NULL,
			locale : {
				format : 'DD-MM-YYYY'

			}
		});

		$('input[name="workDate"]').on('apply.daterangepicker',
				function(ev, picker) {
					$(this).val(picker.startDate.format('DD-MM-YYYY'));
				});

		$('input[name="workDate"]').on('cancel.daterangepicker',
				function(ev, picker) {
					$(this).val('');
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
		
		
		$('#bilAmt').on('input', function() {
			  this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
			});
		
		
		function submitResponse(){
			var empBudHr = document.getElementById("edit_emptime").value;
				var manBudHr = document.getElementById("edit_mngrtime").value;
				var workDate=document.getElementById("workDate1").value ;//create this
				var dueDate=document.getElementById("dueDate").value;//create this
				var taskId1=document.getElementById("taskId1").value ;
				var bilAmt=document.getElementById("bilAmt").value ;
				
	 		 var valid = true;
				if (empBudHr == null || empBudHr == "") {
					valid = false;
					$("#eHr").show();
					//alert("In")
				} else {
					$("#eHr").hide();
				}
				 
				if (manBudHr == null || manBudHr == "") {
					valid = false;
					$("#mHr").show();
				}
					else {
						$("#mHr").hide();
					}
	 			 if (dueDate == null || dueDate == "") {
					valid = false;
					$("#dDate").show();
	 			}else{
	 				$("#dDate").hide();
	 			}
	 			if (taskId1 == 0 || taskId1 == "") {
					valid = false;
	 			}
	//alert(valid);
				if(valid == true){
					$("#loader1").show();
					$.post('${updateTaskAssignPage}', {
						empBudHr : empBudHr,
						manBudHr : manBudHr,
						workDate : workDate,
						dueDate  : dueDate,
						taskId1  : taskId1,
						bilAmt   : bilAmt,
						ajax : 'true',
					},

					function(data) {

						if (data.error == false) {
							$("#loader1").hide();
							//$('#modal_edit').modal('hide')
							//alert("saved");
							window.location.reload()
						} else {
							$("#loader1").hide();
						}

					});
				}
		}
		
	</script>
</body>
</html>