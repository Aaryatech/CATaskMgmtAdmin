<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
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

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
 <script src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_advanced.js"></script>
        <script src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_extension_buttons_init.js"></script>
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
<%-- 			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>
 --%>

			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Generate Yearly Tasks, One Time</h5>
						<div class="header-elements">
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
									<span class="font-weight-semibold">Oh !</span>
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
									<span class="font-weight-semibold"></span>
									<%
										out.println(session.getAttribute("successMsg"));
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%> 


					<form action="${pageContext.request.contextPath}/submitGenTask"
						id="submitGenTaskForm" method="post">
			
					<%-- </form>

					<form
						action="${pageContext.request.contextPath}/submitTaskAssignment"
						id="submitInsertAssignTask" method="post"> --%>
						<div class="card-body">
							<div class="form-group row">

								<label class="col-form-label col-lg-2 u" style="font-style: italic;" for="startDate">Financial Year
									${finYear.finYearName}</label>
									
										<div id="loader1" style="display: none;z-index:99999; padding-top: 30px;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: 250px; margin-right: auto">
						</div>
								<!-- <div class="col-lg-4">2021-22
									<input type="text" class="form-control datepickerclass1"
										name="workDate" id="workDate" placeholder="Task Work Date"
										autocomplete="off">
								</div> -->


								<%-- <label class="col-form-label col-lg-2" for="locId2">
									Employee <span style="color: red">* </span>:
								</label>
								<div class="col-lg-4">

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
										
								</div> --%>
							</div>

							<span class="validation-invalid-label" id="error_chk"
									style="display: none;">Please select some Activities.</span>
							<div class="table-responsive">

								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="printtable_assignTask">
									<thead>
										<tr class="bg-blue">
											<th width="10%">Sr.no</th>
											<th>Customer</th>
											
											<th>Activity</th>
											<th>ALL<input type="checkbox"  
												name="selAll" id="selAll" /></th>
											<th>Service</th>
											<th>Periodicity</th>
											<th>Due Days</th>
											<th>Budget Hours</th>
											<th>Billing Amt</th>
										</tr>
									</thead>
<c:set var="pageNo" value="0"></c:set>
									<c:forEach items="${mapDataList}" var="dataList" varStatus="count">
										<tr id="${dataList.mappingId}">
											<td>${count.index+1}</td>
<c:set var="pageNo" value="${pageNo+1}"></c:set>

											<td>${dataList.custFirmName}&nbsp;&nbsp;</td>
											
											<td>
											<a href="#"
											onclick="showEditTask(${dataList.mappingId},'${dataList.actvManBudgHr}','${dataList.actvEmpBudgHr}',${dataList.actvStatutoryDays},${dataList.actvBillingAmt},'${dataList.custFirmName}','${dataList.actiName}')" title="Edit"><i
												class="icon-pencil7" style="color: red;"
												data-toggle="modal" data-target="#modal_edit"></i>${dataList.actiName}</a></td>
													<td><input type="checkbox"
												id="mapping${dataList.mappingId}" value="${dataList.mappingId}"
												name="mappingId" class="select_all"  ></td>
												<td>${dataList.servName}</td>
										
											<td>${dataList.periodicityName}</td>
											<td>${dataList.actvStatutoryDays}</td>
											<td>M:${dataList.actvManBudgHr} E:${dataList.actvEmpBudgHr}</td>
											<td>${dataList.actvBillingAmt}</td>

										</tr>
									</c:forEach>
									</tbody>

								</table>
								
							</div>
							



						</div>
					



				<!-- Task Edit modal -->
				
				<div id="modal_edit" class="modal fade" tabindex="-1">
				
									<div class="modal-dialog">
						<div class="modal-content">
					

							<div class="modal-header bg-success">
								<h5 class="modal-title">Edit Mapping</h5> &nbsp;&nbsp;
								<h6 style="color: brown"
								 id="custName"> </h6> -- &nbsp;&nbsp;
								<h6  style="color: brown" id="actiName"> </h6>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

								<!-- <form action="submitUpdatedTask" method="post"> -->
								
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="ManBudgetedHrs">Manager
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control" data-mask="999:99"
											placeholder="Enter Manager Budgeted Hours" id="edit_mngrtime"
											name="edit_mngrtime" 
											autocomplete="off">
									</div>

								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="EmpBudgetedHrs">Employee
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" data-mask="999:99" class="form-control"
											placeholder="Enter Employee Budgeted Hours" id="edit_emptime"
											 name="edit_emptime"
											autocomplete="off">
									</div>

								</div>
								
								<div class="form-group row">

										<label class="col-form-label col-lg-6" for="due_Days">
												Due Days :
											</label>
											<div class="col-lg-6">
												<input type="text" name="due_Days" data-placeholder="Due Days"
													 id="due_Days" value=""
													class="form-control">
												
											</div>

										</div>
								
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
									
<input type="hidden" id="mappingId" name="mappingId" value="0">
								 <div class="modal-footer">
										<button type="button" id="editMapSaveButton" class="btn bg-primary" onclick="saveEditeMapping()">Save
											Changes</button><button type="button" class="btn btn-link"
											data-dismiss="modal">Close</button>
										
									</div>
							
							</div>
						</div>
					</div>
					
				</div>
				<!-- /Task Edit Log modal -->
				<span class="validation-invalid-label" id="error_chk1"
									style="display: none;">Please select some Activities.</span>
					<div style="text-align: center;">
								<input type="button" class="btn btn-primary" value="Generate Tasks"
									id="genYearlyTaskBtn"
									style="align-content: center; width: 130px; margin-left: 20px;">
							</div>
							<br/>
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
	
	function showEditTask(mappingId,actvManBudgHr,actvEmpBudgHr,actvStatutoryDays,actvBillingAmt,custName,actiName){
		//alert("mappingId"+mappingId);
		document.getElementById("edit_emptime").value=actvEmpBudgHr;
		document.getElementById("edit_mngrtime").value=actvManBudgHr;
		document.getElementById("bilAmt").value=actvBillingAmt;
		document.getElementById("due_Days").value=actvStatutoryDays;
		document.getElementById("mappingId").value=mappingId;
		//document.getElementById("custName").value=custName;
		//document.getElementById("actiName").value=actiName;
		document.getElementById("custName").innerHTML=custName;
		document.getElementById("actiName").innerHTML=actiName;

		
	}
	function saveEditeMapping(){
		$("#loader1").show();
	     $(':input[type="button"]').prop('disabled', true);

	$.ajax({
	       type: "POST",
	            url: "${pageContext.request.contextPath}/saveEditeMapping",
	            data: $("#submitGenTaskForm").serialize(),
	            dataType: 'json',
	    success: function(data){
	    	//alert(data);
	    	$("#loader1").hide();
	    	window.location.reload(true);
	    }
	    }).done(function() {
	    	$("#loader1").hide();
	    	window.location.reload(true);
	    });
	}
	</script>
	<script type="text/javascript">
	
							$("#genYearlyTaskBtn")
									.click(function(){
												var isError = false;
												var errMsg = "";
												var emps = $("#empId2").val();

												var checked = $("#submitGenTaskForm input:checked").length > 0;
												if (!checked) {
													$("#error_chk").show();
													$("#error_chk1").show();
													isError = true;
												} else {
													$("#error_chk").hide();
													$("#error_chk1").hide();
													isError = false;
												}
												//alert("checked" +checked);
												
												
												
														
												if(isError==false)
													$("#submitGenTaskForm").submit();
														
												
						});
	</script>

	<script type="text/javascript">
			
		$(document).ready(
		
				function() {
					
					//
					$('#printtable_assignTask').dataTable({
					    "bPaginate": false,
					   /*  "scrollX": true,
						"scrollY": '65vh',
						"scrollCollapse": true,
						"paging": false, 
						fixedColumns: {
							"leftColumns": 1,
							"rightColumns": 3,
						},*/
					  	dom: 'Bfrtip',
					    buttons: [
				            'copyHtml5',
				            'excelHtml5',
				            'csvHtml5',
				            'pdfHtml5'
				        ]
					});
					//
					
					//	$('#printtable').DataTable();
			
					$("#selAll").click(
							function() {
								$('#printtable_assignTask tbody input[type="checkbox"]')
										.prop('checked', this.checked);
								 
							});
					 
				});
	</script>
	
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>
	<!-- /page content -->

</body>
</html>