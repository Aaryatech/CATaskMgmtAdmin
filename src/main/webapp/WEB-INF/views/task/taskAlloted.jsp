<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_basic.js"></script>

</head>

<body>
	
	<c:url value="/getDailyWorkLogByTaskId" var="getDailyWorkLogByTaskId"></c:url>
	<c:url value="/updateTaskStatusByTaskId" var="updateTaskStatusByTaskId"></c:url>
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>
	
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


			<style type="text/css">
h5 {
	margin-bottom: 0;
}
</style>


			<!-- Content area -->
			<div class="content">

				<div class="card">

					<div
						class="card-body d-md-flex align-items-md-center justify-content-md-between flex-md-wrap">


						<c:if test="${sysState==1}">

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Unallocated Task"
								class="btn bg-transparent border-warning-400 text-warning-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-stack"></i>
							</a>
							<div class="ml-3">
								<span class="text-muted">UT</span>
								<div>
									<h5>Unalloted Task</h5>
								</div>

							</div>
						</div>
					</c:if>
					
					<c:if test="${sysState==2}">
						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Critical Task"
								class="btn bg-transparent border-danger-400 text-danger-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-warning"></i>
							</a>
							<div class="ml-3">
								 <span class="text-muted">CT</span>
								<div>
									<h5>Critical Task</h5>
								</div>
							</div>
						</div>
					</c:if>

				<c:if test="${sysState==3}">
						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#" title="Overdue Task"
								class="btn bg-transparent border-danger-400 text-danger-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-stats-growth2"></i>
							</a>
							<div class="ml-3">
									<span class="text-muted">OD</span>
								<div>
									<h5>Overdue Task</h5>
								</div>
							</div>
						</div>
					</c:if>
				







					</div>

				</div>



				<!--/////////////////////////////////////////////////////  -->

				<!-- Remote source -->
				<div id="modal_remote" class="modal" tabindex="-1">
					<div class="modal-dialog modal-full">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Filter</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">
								<form id="filterForm">
							
									<div class="form-group row">
									<input type="hidden" id="state" value="${sysState}">
										<label class="col-form-label col-lg-2" for="service">
											Select Service : </label>
										<div class="col-lg-3">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)">

												<c:forEach items="${serviceList}" var="serv">
													<option value="${serv.servId}">${serv.servName}</option>
												</c:forEach>

											</select>
										</div>


										<label class="col-form-label col-lg-2" for="activity">
											Select Activity : </label>
										<div class="col-lg-3">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
											</select>
										</div>

									</div>

									<div class="form-group row">
									
										<label class="col-form-label col-lg-2" for="customer">
											Select Customer : </label>
										<div class="col-lg-3">
											<select name="custId" data-placeholder="Select Customer"
												id="custId"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<c:forEach items="${custGrpList}" var="custGrpList">
													<option value="${custGrpList.custId}">${custGrpList.custName}</option>
												</c:forEach>

											</select>
										</div>

									</div>
								</form>
							</div>
								
							<div class="modal-footer">
								<button type="submit" class="btn btn-link" data-dismiss="modal">Close</button>
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
								<h5 class="modal-title"><span id="taskText"></span></h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-header">
								<form action="newWorkLog" method="post">
									<div class="form-group row">

										<input type="hidden" name="taskId" id="taskId"> <input
											type="hidden" name="logId" id="logId"
											value="${workLog.workLogId}">


										<div class="form-group form-group-float col-md-2">
											<label class="form-group-float-label">Work Date</label> <input
												type="text" class="form-control datepickerclass"
												value="${workLog.workDate}" name="workDate" id="workDate"
												placeholder="Work Date">
										</div>


										<div class="form-group form-group-float  col-md-2">
											<label class="form-group-float-label">Hours </label> <input
												type="text" class="form-control"
												value="${workLog.workHours}" name="workHour"
												id="anytime-time" placeholder="Work Hour">
										</div>

										<div class="form-group form-group-float  col-md-6">
											<label class="form-group-float-label"> Remark</label> <input
												type="text" class="form-control"
												value="${workLog.workRemark}" placeholder="Enter Remark"
												id="remark" name=remark autocomplete="off"
												onchange="trim(this)">
										</div>

										<div class="form-group  col-md-1">
											<label class="form-group-float-label animate is-visible">
											</label>
											<button type="submit" id="submtbtn"
												class="btn bg-info-400 legitRipple">
												<b><i class="icon-paperplane"></i></b>
											</button>
										</div>

									</div>
								</form>


							</div>
							<div class="table-responsive">
								<table class="table datatable-scroller1" id="work_log_table">
									<thead>
										<tr>
										 	<th style="width: 350px; color: white;"></th>
											<th style="width: 350px; color: white;">Employee</th>
											<!-- <th style="width: 100px; color: white;">Date</th> -->
											<th style="width: 100px; color: white;">Hours</th>

										</tr>
									</thead>
								</table>
							</div>
							 

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
								<h5 class="modal-title">Project Financing-Internal
									Audit-text2-3</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="ManBudgetedHrs">Manager
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											placeholder="Enter Manager Budgeted Hours" id="anytime-time1"
											name="ManBudgetedHrs" autocomplete="off"
											onchange="trim(this)">
									</div>

								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="EmpBudgetedHrs">Employee
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											placeholder="Enter Employee Budgeted Hours"
											id="anytime-time2" name="EmpBudgetedHrs" autocomplete="off"
											onchange="trim(this)">
									</div>

								</div>


								<div class="form-group row">
									<label class="col-form-label col-lg-6">Work Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											placeholder="Enter Work Date" id="workDate" name="workDate"
											autocomplete="off" onchange="trim(this)">
									</div>
								</div>
								<div class="form-group row">

									<label class="col-form-label col-lg-6">Statutory Due
										Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											placeholder="Enter Statutory Due Date" id="dueDate"
											name="dueDate" autocomplete="off" onchange="trim(this)">
									</div>

								</div>


							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
								<button type="button" class="btn bg-primary">Save
									changes</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /Task Edit Log modal -->




				<style type="text/css">
.datatable-footer {
	display: none;
}

.dataTables_length {
	display: none;
}
</style>

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

					<style type="text/css">
.fab-menu-bottom-right, .fab-menu-top-right {
	right: 1.25rem;
	top: 1rem;
}
</style>

					<div class=table-responsive>

						<div class="fab-menu fab-menu-absolute fab-menu-top-right"
							data-toggle="modal" data-target="#modal_remote">
							<a title="Filter"
								class="fab-menu-btn btn bg-blue btn-float rounded-round btn-icon">
								<i class="fab-icon-open icon-filter3"></i>
							</a>
						</div>

						<table class="table datatable-basic table-hover" width="100%" id="task_info_table">
							<thead>
								<tr>
									<th style="background-color: white;">Sr. No.</th>
									<th style="background-color: white;">Customer</th>
									<th style="background-color: white;">Task Name</th>
									<th style="background-color: white;">Work Date</th>
									<th style="background-color: white;">Statutary Due Date</th>
									<!-- <th style="background-color: white;">Task Team</th> -->
									<th style="background-color: white;">Budget Hrs</th>
									<!-- <th style="background-color: white;">Task Status</th> -->								
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${taskList}" var="taskList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${taskList.custGroupName}</td>										
										<td>${taskList.taskText}(${taskList.periodicityName})</td>
										<td>${taskList.taskEndDate}</td>
										<td>${taskList.taskStatutoryDueDate}</td>
										
										<c:if test="${empType==5}">
										 	<td>${taskList.empBudHr}</td>
										</c:if>
										<c:if test="${empType==3}">
											<td>${taskList.mngrBudHr}</td>
										</c:if>

										<c:if test="${empType==4}">
											<td>NA</td>
										</c:if>
										<c:if test="${empType==2}">
											<td>NA</td>
										</c:if>
										<c:if test="${empType==1}">
											<td>NA</td>
										</c:if>

									<%-- <td id="taskStatus${taskList.taskId}" style="background-color: ${taskList.statusColor}">${taskList.taskStatus}</td> --%> 										
										<%-- <td><span class="badge badge-info"
											style="background-color:${taskList.statusColor}">${taskList.taskStatus}</span></td> --%>

										
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
				<!-- /hover rows -->





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
	
	function updateStatus(statusId, taskId){
        var selectedStatus = $("#set_status"+taskId+" option:selected").html();
		$
				.getJSON(
						'${updateTaskStatusByTaskId}',
						{
							taskId : taskId,
							statusId: statusId,
							ajax : 'true',

						},
						function(data) {	
							if(data.error==false){
							//	alert("Task Status Updated Successfully!")
                            document.getElementById("taskStatus"+taskId).innerHTML=selectedStatus;
							}
					      }); 
		
	}
	
	</script>




	<script type="text/javascript">
	
	$(document).ready(function(){
	      // setColor();
	      $('.ats_sel_status').change(function(){
	    	  var id=$(this).attr('id');
	    	  var color =  $('#'+id).find('option:selected').attr('id');
	  	      $('#'+id).css('background', color); 
	            // setColor();       
	     });
	      
	      $('.ats_sel_status').each(function(){
	    	  var id=$(this).attr('id');
	    	  var color =  $('#'+id).find('option:selected').attr('id');
	  	      $('#'+id).css('background', color); 

	    	 });
	});

	function setColor()
	{
	   // var color =  $('.sel_status').find('option:selected').attr('id');
	    //$('#'+id).css('background', color); 
	}
	    
	
	</script>

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
	function dataFilter(){		
		var state = $("#state").val();
		var service = $("#service").val();
		var activity = $("#activity").val();		
		var custId = $("#custId").val();		
		
		//alert("Dates="+service+"   "+activity+" "+custId+" "+state);
		
		
		document.getElementById("service").value=service;
		document.getElementById("activity").value=activity;
		document.getElementById("custId").value=custId;
		
		var form=document.getElementById("filterForm");
	    form.setAttribute("method", "post");
		
	    if(state==1){
			form.action=("fliterUnAllotedTaskList");
	    }
	    
	    if(state==2){
			form.action=("fliterCriticalTaskList");
	    }
	    if(state==3){
			form.action=("fliterOverdueTaskList");
	    }
	    
		form.submit();
	}
	
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
								var p = -1;
								var q = "Select Activity";
								html += '<option disabled value="'+p+'">'
										+ q + '</option>';
								html += '</option>';

								var temp = 0;
								//temp=document.getElementById("temp").value;
								//alert("temp");
								var len = data.length;
								for (var i = 0; i < len; i++) {

									/* 	if(temp==data[i].infraAreaId){
											 html += '<option selected value="' + data[i].infraAreaId + '">'
									         + data[i].infraAreaName + '</option>';
										}
											
											else{ */

									html += '<option value="' + data[i].actiId + '">'
											+ data[i].actiName
											+ '</option>';
									//}

								}

								/*        if(temp==0){
								       	//alert("If temp==0");
								       	  var x=0;
								             var y="Any Other";
								             html += '<option selected value="'+x+'">'
								             +y+'</option>';
								             html += '</option>';
								             //document.getElementById("other_area").show();
											$("#area_name_div").show();

								            
								       }else{
								       	  /* var x=0;
								             var y="Any Other";
								             html += '<option value="'+x+'">'
								             +y+'</option>';
								             html += '</option>'; */

								// } 
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
											alert("this");
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



</body>
</html>