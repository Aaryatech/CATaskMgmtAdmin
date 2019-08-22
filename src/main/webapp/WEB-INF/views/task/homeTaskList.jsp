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
									<label class="col-form-label col-lg-2" for="fromDate"><!-- Due Date Range --> Due-
									 From Date <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<input type="text" class="form-control datepickerclass"
											id="fromDate" name="fromDate">
									</div>
									<!-- <div class="col-lg-3">																							
											<span class="validation-invalid-label" id="error_start_date"
												style="display: none;">Start date must be greater than end date.</span>
									</div> -->

								<label class="col-form-label col-lg-2" for="toDate">Due-
										To Date <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">
										<input type="text" class="form-control datepickerclass"
											id="toDate" name="toDate">
									</div>									
									
									<!-- <div class="col-lg-3">																							
											<span class="validation-invalid-label" id="error_end_date"
												style="display: none;">To date must be smaller than from date.</span>
										</div> -->
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
										Select Status :
									</label>
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
												<option value="${custGrpList.custGroupId}">${custGrpList.custGroupName}</option>
											</c:forEach>

										</select>
									</div>

								</div>
								</form>
							</div>

							<div class="modal-footer">
								<button type="submit" class="btn btn-link" data-dismiss="modal">Close</button>
								<button type="submit" class="btn bg-primary" id="submtbtn" onclick="dataFilter()">Search</button>
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



				<!-- Remote source DAILY WORK LOG-->
				<div id="modal_remote_log" class="modal" tabindex="-1">
					<div class="modal-dialog modal-full">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Daily Work Log</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">


								<table style="background-color: #4CAF50;" width="100%">

									<tr>
										<td style="color: white; padding: .8rem 1rem;" align="left"
											width="80%">
											<h5>
												Task ID -<span class="font-weight-semibold"> 1 </span>
												&nbsp;&nbsp; Name - <span class="font-weight-semibold">
													GST </span> <small class="d-block opacity-75">Owner
													Partner - Prakash</small>
											</h5>
										</td>
										<td style="color: white; padding: .8rem 1rem;">
											<div align="center">
												<div class="btn" style="background-color: white;">Pending</div>
												<normal class="d-block opacity-75" style="color: white;">Current
												Status</normal>
											</div>
										</td>
									</tr>

								</table>

								<br>

								<div class="form-group row">

									<label class="col-form-label col-lg-3" for="workDate">
										Work Date : </label>
									<div class="col-lg-3">
										<input type="text" class="form-control datepickerclass"
											name="workDate" id="workDate" placeholder="Work Date">
									</div>


									<label class="col-form-label col-lg-4" for="workDate" align="right" >
										<h4>Total Work Hours :</h4> </label> <label class="col-form-label col-lg-2"
										for="workDate"> <h4>50</h4> </label>


								</div>

								<div class="form-group row">

									<label class="col-form-label col-lg-3" for="workDate">
										Work Hours : </label>
									<div class="col-lg-3">
										<input type="text" class="form-control"
											placeholder="Enter Hours" id="hrs" name="hrs"
											autocomplete="off" onchange="trim(this)">
									</div>

									<button type="button" class="btn bg-primary">Add</button>
								</div>




								<div class="card">

									<div class="card-body">
										<ul class="nav nav-tabs nav-tabs-highlight">
											<li class="nav-item"><a href="#taskwise"
												class="nav-link active" data-toggle="tab">Taskwise</a></li>
											<li class="nav-item"><a href="#datewise"
												class="nav-link" data-toggle="tab">Datewise</a></li>

										</ul>

										<div class="tab-content">
											<div class="tab-pane fade show active" id="taskwise">


												<table
													class="table table-bordered table-hover datatable-highlight1   datatable-button-print-columns1"
													id="printtable1">
													<thead>
														<tr class="bg-blue">
															<th width="10%">Sr.no</th>
															<th>Date</th>
															<th>Work Hours</th>
															<th class="text-center" width="10%">Actions</th>
														</tr>
													</thead>
													<tr>
														<td>1</td>
														<td>11-05-2018</td>
														<td>35</td>
														<td><a href="#" title="Edit"><i
																class="icon-pencil7" style="color: black;"></i></a> <a
															href="#"
															onClick="return confirm('Are you sure want to delete this record');"
															title="Delete"><i class="icon-trash"
																style="color: black;"></i> </a></td>
													</tr>
													
													<tr>
														<td>2</td>
														<td>12-05-2018</td>
														<td>40</td>
														<td><a href="#" title="Edit"><i
																class="icon-pencil7" style="color: black;"></i></a> <a
															href="#"
															onClick="return confirm('Are you sure want to delete this record');"
															title="Delete"><i class="icon-trash"
																style="color: black;"></i> </a></td>
													</tr>
													


												</table>



											</div>

											<div class="tab-pane fade" id="datewise">
											
											
											<table
													class="table table-bordered table-hover datatable-highlight1   datatable-button-print-columns1"
													id="printtable1">
													<thead>
														<tr class="bg-blue">
															<th width="10%">Sr.no</th>
															<th>Task Id</th>
															<th>Task Name</th>
															<th>Date</th>
															<th>Work Hours</th>
															<th class="text-center" width="10%">Actions</th>
														</tr>
													</thead>
													<tr>
														<td>1</td>
														<td>105</td>
														<td>Income Tax - Return Filling - Oct-2019</td>
														<td>11-05-2019</td>
														<td>35</td>
														<td><a href="#" title="Edit"><i
																class="icon-pencil7" style="color: black;"></i></a> <a
															href="#"
															onClick="return confirm('Are you sure want to delete this record');"
															title="Delete"><i class="icon-trash"
																style="color: black;"></i> </a></td>
													</tr>
													
													<tr>
														<td>1</td>
														<td>225</td>
														<td>GST - GST - Oct-2019</td>
														<td>11-05-2019</td>
														<td>45</td>
														<td><a href="#" title="Edit"><i
																class="icon-pencil7" style="color: black;"></i></a> <a
															href="#"
															onClick="return confirm('Are you sure want to delete this record');"
															title="Delete"><i class="icon-trash"
																style="color: black;"></i> </a></td>
													</tr>
													


												</table>
											
											</div>


										</div>
									</div>
								</div>






							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /remote source DAILY WORK LOG-->




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

						<table class="table datatable-basic table-hover" width="100%">
							<thead>
								<tr>
									<th style="background-color: white;">Customer</th>
									<th style="background-color: white;">Service - Activity</th>
									<th style="background-color: white;">Task Name</th>
									<th style="background-color: white;">Due Date</th>
									<th style="background-color: white;">Work Date</th>
									<th style="background-color: white;">Alloted Hrs</th>
									<th style="background-color: white;">Actual Hrs</th>
									<th style="background-color: white;">Status</th>
									<th class="text-center" style="background-color: white;">Actions</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${taskList}" var="taskList" varStatus="count">
								<tr>
									<td>${taskList.custGroupName}</td>
									<td>${taskList.servName}-${taskList.actiName}</td>
									<td>${taskList.taskText}</td>
									<td>${taskList.taskStatutoryDueDate}</td>
									<td>${taskList.taskEndDate}</td>
									
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
									
									<td data-toggle="modal" data-target="#modal_remote_log">0</td>
									
									<td><span class="badge badge-info">${taskList.taskStatus}</span></td>
									
									<td class="text-center"><a
										href="${pageContext.request.contextPath}/communication?taskId=${taskList.taskId}"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
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
		var toDate = $("#toDate").val();
		
		var service = $("#service").val();
		var activity = $("#activity").val();
		
		var custId = $("#custId").val();		
		
		//alert("Dates="+fromDate+" "+toDate+"  "+service+"   "+activity+" "+custId);
		
		document.getElementById("fromDate").value=fromDate;//create this
		document.getElementById("toDate").value=toDate;//create this
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
	<script>
	$(document)
			.ready(
					function($) {
				$("#filterForm")
						.submit(
								function(e) {
									var isError = false;
									var errMsg = "";
									
									alert("Hi"+from_date);
									
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
</body>
</html>