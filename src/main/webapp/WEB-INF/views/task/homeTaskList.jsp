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
<style>
.modal {
	position: fixed !important;
	bottom: 0 !important;
	top: auto !important;
	right: 0 !important;
	left: auto !important;
	margin: 0px !important;
	width: auto !important;
	height: auto !important;
}
</style>
</head>

<body>
	<c:url value="/getDailyWorkLogByTaskId" var="getDailyWorkLogByTaskId"></c:url>
	<c:url value="/updateTaskStatusByTaskId" var="updateTaskStatusByTaskId"></c:url>
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>
	<c:url value="/getTaskByTaskIdForEdit" var="getTaskByTaskIdForEdit"></c:url>

	<c:url value="/submitUpdatedTask" var="submitUpdatedTask"></c:url>


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
										<label class="col-form-label col-lg-2" for="fromDate">Due
											Date Range <span style="color: red">* </span>:
										</label>
										<div class="col-lg-3">
											<input type="text" class="form-control daterange-basic_new"
												id="fromDate" name="fromDate">
										</div>
									</div>

									<div class="form-group row">

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



										<label class="col-form-label col-lg-2" for="status">
											Select Status : </label>
										<div class="col-lg-3">
											<select name="sts" data-placeholder="Select Status" id="sts"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">All</option>
												<option value="2">Generated</option>
												<option value="3">Unallocated</option>
												<option value="4">Critical</option>
												<option value="4">Overdue</option>
												<option value="4">Pending for Manager</option>
												<option value="4">Pending for Partner</option>
												<option value="4">Pending for Team Lead</option>
												<option value="4">Pending for Client</option>
												<option value="4">Completed</option>
												<option value="4">Inactive</option>
												<option value="4">Other</option>

											</select>
										</div>

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
								<h5 class="modal-title">
									<span id="taskText"></span>
								</h5>
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
											<th style="width: 100px; color: white;">Actual Hours</th>

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
								<h5 class="modal-title">Edit Task</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

								<!-- 								<form action="submitUpdatedTask" method="post">
 -->
								<input type="hidden" id="taskId1" name="taskId1" value=0>
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="ManBudgetedHrs">Manager
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											placeholder="Enter Manager Budgeted Hours" id="anytime-time1"
											onchange="submitResponse()" name="manBudHr"
											autocomplete="off">
									</div>

								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-6" for="EmpBudgetedHrs">Employee
										Budgeted Hours : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											placeholder="Enter Employee Budgeted Hours"
											id="anytime-time2" onchange="submitResponse()"
											name="empBudHr" autocomplete="off">
									</div>

								</div>


								<div class="form-group row">
									<label class="col-form-label col-lg-6">Work Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											placeholder="Enter Work Date" onchange="submitResponse()"
											id="workDate1" name="workDate" autocomplete="off">
									</div>
								</div>
								<div class="form-group row">

									<label class="col-form-label col-lg-6">Statutory Due
										Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											onchange="submitResponse()"
											placeholder="Enter Statutory Due Date" id="dueDate"
											name="dueDate" autocomplete="off">
									</div>

								</div>

								<div class="form-group row">

									<label class="col-form-label col-lg-6" for="activity">
										Employee <span style="color: red">* </span>:
									</label>
									<div class="col-lg-6">
										<select name="emp" data-placeholder="Select Activity"
											onchange="submitResponse()" id="emp" multiple
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">
										</select>
									</div>

								</div>

								<!-- <div class="modal-footer">
										<button type="button" class="btn btn-link"
											data-dismiss="modal">Close</button>
										<button type="submit" class="btn bg-primary">Save
											changes</button>
									</div>
								</form> -->
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

						<table class="table datatable-basic table-hover" width="100%"
							id="task_info_table">
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
										<%-- data-toggle="modal" data-target="#modal_small" --%>
										<td><a href="#"
											onclick="showTaskLogs(${taskList.taskId }, '${taskList.taskText}')">${taskList.taskText}(${taskList.periodicityName})</a></td>

										<td>${taskList.taskEndDate}</td>
										<td>${taskList.taskStatutoryDueDate}</td>
										<td>${taskList.employees}</td>
										<td>M-${taskList.mngrBudHr} E-${taskList.empBudHr}</td>

										<%-- <c:if test="${empType==5}">
											<td>E-${taskList.empBudHr}</td>
										</c:if>
										<c:if test="${empType==3}">
											<td>M-Hr-${taskList.mngrBudHr}</td>
										</c:if>

										<c:if test="${empType==4}">
											<td>NA</td>
										</c:if>
										<c:if test="${empType==2}">
											<td>NA</td>
										</c:if>
										<c:if test="${empType==1}">
											<td>NA</td>
										</c:if> --%>

										<!-- <td data-toggle="modal" data-target="#modal_remote_log">0</td> -->
										<!-- <td>0</td> -->


										<td id="taskStatus${taskList.taskId}"
											style="color: ${taskList.statusColor};font-weight: bold;">${taskList.taskStatus}</td>
										<td align="center"><select name="set_status"
											onClick1="updateStatus_new(this.value, ${taskList.taskId })"
											id="set_status${taskList.taskId}"
											data-id="${taskList.taskId}"
											class="form-control  ats_sel_status ">

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
													<%-- <option value="${statusList.statusValue}">${statusList.statusText}${taskList.taskStatus}</option> --%>
												</c:forEach>

												<!-- <option class="opt"
													style="background: blue; font-size: 20px;" value="1"
													id="Blue">Allocated</option>
												<option class="opt"
													style="background: Orange; font-size: 20px;" value="2"
													id="Orange">Pending For Manager</option>
												<option class="opt"
													style="background: Gray; font-size: 20px;" value="3"
													selected id="Gray">Pending for TL</option>
												<option class="opt"
													style="background: Green; font-size: 20px;" value="4"
													id="Green">Completed</option> -->

										</select></td>


										<%-- <td><span class="badge badge-info"
											style="background-color:${taskList.statusColor}">${taskList.taskStatus}</span></td> --%>

										<td class="text-center"><a class="chatmodallink"
											data-href="${pageContext.request.contextPath}/communication?taskId=${taskList.exVar1}&empId=${taskList.exVar2}"
											href1="${pageContext.request.contextPath}/communication?taskId=${taskList.exVar1}&empId=${taskList.exVar2}"
											title="Chat/Update"><i class="icon-comments"
												style="color: green;"></i></a> &nbsp;&nbsp; <a href="#"
											onclick="showEditTask(${taskList.taskId})" title="Edit"><i
												class="icon-pencil7" style="color: black;"
												data-toggle="modal" data-target="#modal_edit"></i></a></td>
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
	
	
	function showEditTask(taskId) {
		//alert("HI"+taskId);
			
			$
					.getJSON(
							'${getTaskByTaskIdForEdit}',
							{
								taskId : taskId,				
								ajax : 'true',

							},
							function(data) {
								
								//alert(JSON.stringify(data));
								
								document.getElementById("anytime-time1").value=data.task.mngrBudHr;
								document.getElementById("anytime-time2").value=data.task.empBudHr;
  								//alert("errordata"+data.task.taskEndDate);
								document.getElementById("workDate1").value=data.task.taskEndDate;
								document.getElementById("dueDate").value=data.task.taskStatutoryDueDate;
								
								document.getElementById("taskId1").value=data.task.taskId;
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
		var empBudHr = document.getElementById("anytime-time1").value;
			var manBudHr = document.getElementById("anytime-time2").value;
			var workDate=document.getElementById("workDate1").value ;//create this
			var dueDate=document.getElementById("dueDate").value;//create this
			var taskId1=document.getElementById("taskId1").value ;
			//var emp=document.getElementById("emp").value ;
			var emp=$("#emp").val();
			//alert("Hi " +JSON.stringify(emp));
			
 		 var valid = true;
			if (empBudHr == null || empBudHr == "") {
				valid = false;
			 
			} else if (manBudHr == null || manBudHr == "") {
				valid = false;
 			}
 			else if (workDate == null || workDate == "") {
				valid = false;
 			}
 			else if (dueDate == null || dueDate == "") {
				valid = false;
 			}
 			else if (taskId1 == 0 || taskId1 == "") {
				valid = false;
 			}
 			else if (emp ==null || emp == "") {
				valid = false;
 			}

			if(valid == true){
				$.post('${submitUpdatedTask}', {
					empBudHr : empBudHr,
					manBudHr : manBudHr,
					workDate : workDate,
					dueDate  : dueDate,
					taskId1  : taskId1,
					emp      : JSON.stringify(emp),
					ajax : 'true',
				},

				function(data) {

					if (data.error == false) {

						//alert("saved");
					} else {
						//alert("not saved");
					}

				});
			}
		  
	}
	
	function updateStatus_new(statusId, taskId){
	//alert(statusId+" "+taskId)
        var selectedStatus = $("#set_status"+taskId+" option:selected").html();
        //var color =  $('#set_status'+taskId).val();
        
      
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
                            var color =  $('#set_status'+taskId).find('option:selected').attr('data-statusColor');
                          
                            $('#taskStatus'+taskId).css('background', color); 
                            
							}
					      }); 
		
	}
	
	
	$(document).ready(function(){
	      // setColor();
	      //set_status
	      $('.ats_sel_status').change(function(e){
	    	  var id = $(this).data("id") // will return the number 123
	    	  var value = $("#set_status"+id).val();
	    	  updateStatus_new(value, id)
	      });
	       
	     /*  $('.ats_sel_status_nouse').change(function(){
	    	  var id=$(this).attr('id');
	    	  var color =  $('#'+id).find('option:selected').attr('id');
	  	      $('#'+id).css('background', color); 
	  	      //
	  	      $('#taskStatus'+id).css('background', color); 
	            // setColor();       
	     });
	      
	      $('.ats_sel_status_nouse').each(function(){
	    	  var id=$(this).attr('id');
	    	  var color =  $('#'+id).find('option:selected').attr('id');
	  	      $('#'+id).css('background', color); 

	    	 }); */
	});

	function setColor()
	{
	   // var color =  $('.sel_status').find('option:selected').attr('id');
	    //$('#'+id).css('background', color); 
	}
	    
	function showTaskLogs(taskId, taskText) {
		//alert("HI:"+taskText);
		var empType = ${empType};
		//alert("Emp Type------"+empType)
		document.getElementById("taskId").value = taskId;
		//document.getElementById("taskText").value = taskText;
		document.getElementById("taskText").innerHTML = taskText;
		$("#loader").show();
		$
				.getJSON(
						'${getDailyWorkLogByTaskId}',
						{
							taskId : taskId,				
							ajax : 'true',

						},
						function(data) {
						

							/* if (data == "") {
								alert("No records found !!");						

							} */

							var dataTable = $('#work_log_table').DataTable();
							dataTable.clear().draw();

							$.each(data, function(i, v) {
								//alert(JSON.stringify(v));
		  											
								dataTable.row.add(
										[ 	i + 1,
											v.exVar1,
											 // v.workDate,
											  v.workHours
										//  acButton
										
										]).draw();
							});});
		
		
		$('#modal_small').modal('show');
		
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
		
		var fromDate = $("#fromDate").val();
		//var toDate = $("#toDate").val();
		
		var service = $("#service").val();
		var activity = $("#activity").val();
		
		var custId = $("#custId").val();		
		
		//alert("Dates="+fromDate+" "+toDate+"  "+service+"   "+activity+" "+custId);
		
		document.getElementById("fromDate").value=fromDate;//create this
		//document.getElementById("toDate").value=toDate;//create this
		document.getElementById("service").value=service;//create this
		document.getElementById("activity").value=activity;//create this
		document.getElementById("custId").value=custId;//create this
		
		var form=document.getElementById("filterForm");
	    form.setAttribute("method", "post");

		form.action=("fliterTaskList");
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
	<script>
$(document).ready(function(){
	$('.chatmodallink').click(function(){
		//alert(1);
	var href=	$(this).attr("data-href") // will return the string "123"
//alert(href);
	   var title = "Greetings";
       var body = "Welcome to ASPSnippets.com";

       $("#myModal .modal-title").html(title);
       //$("#myModal .modal-body").html(body);
       $("#modalbody").load(href);
       $("#myModal").modal("show");
		
	});
	
	$('#myModal').on('hidden.bs.modal', function () {
		$("#modalbody").html("");
		})
});
</script>
	<!-- Modal HTML -->
	<div id="myModal" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<!--   <h5 class="modal-title">Ajax Loading Demo</h5> -->
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body" id="modalbody">
					<!-- Content will be loaded here from "remote.php" file -->
					Wait...
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>

</body>
</html>