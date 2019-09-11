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

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/dashboard.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/plugins/visualization/echarts/echarts.min.js"></script>



<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,300,600,800,900"
	rel="stylesheet" type="text/css">

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
				<h2>Employee</h2>
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


				</div>
				/support tickets


				Quick stats boxes
				<div class="row" style="display: none;">
					<div class="col-sm-4">

						Members online
						<div class="card bg-teal-400">
							<div class="card-body">
								<div class="d-flex">
									<h3 class="font-weight-semibold mb-0">3,450</h3>
									<span
										class="badge bg-teal-800 badge-pill align-self-center ml-auto">+53,6%</span>
								</div>

								<div>
									Budgeted Capacity
									<div class="font-size-sm opacity-75"></div>
								</div>
							</div>

							<div class="container-fluid">
								<div id="dash-members-online"></div>
							</div>
						</div>
						/members online

					</div>

					<div class="col-sm-4">

						Current server load
						<div class="card bg-pink-400">
							<div class="card-body">
								<div class="d-flex">
									<h3 class="font-weight-semibold mb-0">300</h3>

								</div>

								<div>
									Allocated Capacity
									<div class="font-size-sm opacity-75"></div>
								</div>
							</div>

							<div id="server-load"></div>
						</div>
						/current server load

					</div>

					<div class="col-sm-4">

						Today's revenue
						<div class="card bg-blue-400">
							<div class="card-body">
								<div class="d-flex">
									<h3 class="font-weight-semibold mb-0">250</h3>
									<div class="list-icons ml-auto">
										<a class="list-icons-item" data-action="reload"></a>
									</div>
								</div>

								<div>
									Actual Hours Worked
									<div class="font-size-sm opacity-75"></div>
								</div>
							</div>

							<div id="today-revenue"></div>
						</div>
						/today's revenue

					</div>

				</div>
				/quick stats boxes


				<div class="card" >
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Status
										Wise Task Data</th>
									<th style="background-color: white; width: 50px;">Overdue</th>
									<th style="background-color: white; width: 50px">Due Today</th>
									<th style="background-color: white; width: 50px">Due this
										Week</th>
									<th style="background-color: white; width: 50px">Due this
										Month</th>

								</tr>
							</thead>
							<tbody>

								<tr style="background-color: #03a9f4; color: white;">
									<td>
										<div class="d-flex align-items-center">
											<div class="mr-3">
												<a href="#"
													class="btn bg-blue rounded-round btn-icon btn-sm"> <span>PC</span>
												</a>
											</div>
											<div>
												<a href="#" class="text-default font-weight-semibold " style="color:white;">Pending
													for Client</a>

											</div>
										</div>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>

								</tr>
								<tr>
									<td>
										<div class="d-flex align-items-center">
											<div class="mr-3">
												<a href="#"
													class="btn bg-danger rounded-round btn-icon btn-sm"> <span>CT</span>
												</a>
											</div>
											<div>
												<a href="#" class="text-default font-weight-semibold ">Critical task
													</a>

											</div>
										</div>
									</td>
									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>
								</tr>

							</tbody>
						</table>
					</div>
				</div>
				Hover rows
				
				Team Leader Dash
				
				Capacity Details
				<div class="card">
				<h2>Team Leader</h2>				
					<div class="card-header header-elements-sm-inline">
						<h6 class="card-title">Team Leader Capacity Details</h6>
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


				</div>
				
				<div class="form-group row" >
										<label class="col-form-label col-lg-3" for="clientGroup">Team/Self/
											Employee : </label>
										<div class="col-lg-6">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
												<option value="0">Select</option> 
												<option value="abc">Abhiman</option> 
												<option value="abc">Corpo Kin</option> 
												<option value="abc">Omni Corps</option> 
												<option value="abc">Sameer</option> 
											

											</select>

										</div>
										<div class="col-lg-3"></div>
									</div>
				
				<div class="card" >
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Status
										Wise Task Data</th>
									<th style="background-color: white; width: 50px;">Overdue</th>
									<th style="background-color: white; width: 50px">Due Today</th>
									<th style="background-color: white; width: 50px">Due this
										Week</th>
									<th style="background-color: white; width: 50px">Due this
										Month</th>

								</tr>
							</thead>
							<tbody>

								<tr style="background-color: #03a9f4; color: white;">
									<td>
										<div class="d-flex align-items-center">
											<div class="mr-3">
												<a href="#"
													class="btn bg-blue rounded-round btn-icon btn-sm"> <span>PC</span>
												</a>
											</div>
											<div>
												<a href="#" class="text-default font-weight-semibold " style="color:white;">Pending</a>

											</div>
										</div>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>

								</tr>
								<tr>
									<td>
										<div class="d-flex align-items-center">
											<div class="mr-3">
												<a href="#"
													class="btn bg-danger rounded-round btn-icon btn-sm"> <span>CT</span>
												</a>
											</div>
											<div>
												<a href="#" class="text-default font-weight-semibold ">Critical task
													</a>

											</div>
										</div>

									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>

								</tr>

							</tbody>
						</table>
					</div>
				</div>
				
				End Team Leader Dash
				
				Manager Dash
				
					Capacity Details
				<div class="card">
				<h2>Manager</h2>		
					<div class="card-header header-elements-sm-inline">
						<h6 class="card-title">Manager Capacity Details</h6>
						<div class="header-elements">
							<a
			 					class="text-default daterange-ranges font-weight-semibold cursor-pointer dropdown-toggle">
								<i class="icon-calendar3 mr-2"></i> <span></span>
							</a>
						</div>
					</div>

					<div class="card-body ">

					<div class="row">
						
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Name of
										Employee</th>
									<th style="background-color: white; width: 50px;">Budget Capacity</th>
									<th style="background-color: white; width: 50px">Allocated Capacity</th>
									<th style="background-color: white; width: 50px">Actual Hours Worked	</th>
									<th style="background-color: white; width: 50px">% completion bar</th>

								</tr>
							</thead>
							<tbody>

								<tr>
									<td>
										<a href="#" class="text-default font-weight-semibold">Abhiman</a>
									</td>

									<td>20</td>
									<td>30</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								 <tr>
									<td>
										<a href="#" class="text-default font-weight-semibold">Buis World</a>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								<tr>
									<td>
										<a href="#" class="text-default font-weight-semibold">Omni Corps</a>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								
								
								 <tr>
									<td>
										<a href="#" class="text-default font-weight-semibold">Self</a>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								<tr>
									<td>
										<a href="#" class="text-default font-weight-semibold">Total:</a>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
							</tbody>
						</table>
					
						</div>
				
						</div>
					</div>
					card body
				</div>
				Capacity 
				
				<div class="card" >
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Status
										Wise Task Data</th>
									<th style="background-color: white; width: 50px;">Overdue</th>
									<th style="background-color: white; width: 50px">Due Today</th>
									<th style="background-color: white; width: 50px">Due this
										Week</th>
									<th style="background-color: white; width: 50px">Due this
										Month</th>

								</tr>
							</thead>
							<tbody>

								<tr style="background-color: #03a9f4; color: white;">
									<td>
										<div class="d-flex align-items-center">
											<div class="mr-3">
												<a href="#"
													class="btn bg-blue rounded-round btn-icon btn-sm"> <span>PC</span>
												</a>
											</div>
											<div>
												<a href="#" class="text-default font-weight-semibold " style="color:white;">Pending</a>

											</div>
										</div>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>
								</tr>
								
								<tr>
									<td>
										<div class="d-flex align-items-center">
											<div class="mr-3">
												<a href="#"
													class="btn bg-danger rounded-round btn-icon btn-sm"> <span>CT</span>
												</a>
											</div>
											<div>
												<a href="#" class="text-default font-weight-semibold ">Critical task
													</a>

											</div>
										</div>

									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>

								</tr> 

							</tbody>
						</table>
					</div>
				</div>
				End Manager Dash
				
				
				Copy of Partners-->
				
				<div class="form-group row" >
										<label class="col-form-label col-lg-1" for="clientGroup">Month</label>
										<div class="col-lg-3">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
												<option value="0">Select</option> 
												<option value="abc">Jan</option> 
												<option value="abc">Feb</option> 
												<option value="abc">March</option> 
												<option value="abc">April</option>											
										</select>
								</div>
								
							
										<label class="col-form-label col-lg-1" for="clientGroup">Employee</label>
										<div class="col-lg-3">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
												<option value="0">Select</option> 
												<option value="abc">Abhiman</option> 
												<option value="abc">Omni Corps</option> 
												<option value="abc">Corpo Kin</option> 
												<option value="abc">Sameer</option>											
										</select>
								</div>
							<div class="col-lg-3"></div>
					</div>
					
					<div class="form-group row" >
										<label class="col-form-label col-lg-1" for="clientGroup">Client Group</label>
										<div class="col-lg-3">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
												<option value="0">Select</option> 
												<option value="abc">Birla Group of Company</option> 
												<option value="abc">Omni Corps</option> 
												<option value="abc">Corpo Kin</option> 
												<option value="abc">Buis World</option>											
										</select>
								</div>
							
										<label class="col-form-label col-lg-1" for="clientGroup">Client</label>
										<div class="col-lg-3">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
												<option value="0">Select</option> 
												<option value="abc">Birla Group of Company</option> 
												<option value="abc">Omni Corps</option> 
												<option value="abc">Corpo Kin</option> 
												<option value="abc">Buis World</option>											
										</select>
								</div>
							<div class="col-lg-3"></div>
					</div> 
				
				<div class="card">
					<div class="card-header header-elements-sm-inline">
					 <h2 class="card-title">Partner</h2>
						<div class="header-elements">
							<a
			 					class="text-default daterange-ranges font-weight-semibold cursor-pointer dropdown-toggle">
								<i class="icon-calendar3 mr-2"></i> <span></span>
							</a>
						</div>
					</div>

					<div class="card-body ">

					<div class="row">
						
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Particular
										Employee</th>
									<th style="background-color: white; width: 50px;">Amount</th>
									<th style="background-color: white; width: 50px">Narration</th>
								</tr>
							</thead>
							<tbody>

								<tr>
									<td>
										Budgeted Cost
									</td>
									<td>200000</td>
									<td></td>
									

								</tr>
								 <tr>
									<td>Actual Cost</td>
									<td>200000</td>
									<td></td>
									

								</tr>
								<tr>
									<td>Budgeted Revenue</td>
									<td>20</td>
									<td></td>
								</tr>
								
								
								 <tr>
									<td>Actual Revenue</td>
									<td>325000</td>
									<td></td>
								</tr>
								
							</tbody>
						</table>
					
						</div>
				
						</div>
					</div>
					<!-- card body -->
				</div>
				<!-- End Capacity -->
				
				<div class="form-group row" >
										<label class="col-form-label col-lg-3" for="clientGroup">Team/Self/
											Employee : </label>
										<div class="col-lg-6">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
												<option value="0">Select</option> 
												<option value="abc">Abhiman</option> 
												<option value="abc">Corpo Kin</option> 
												<option value="abc">Omni Corps</option> 
												<option value="abc">Sameer</option> 
											

											</select>

										</div>
										<div class="col-lg-3"></div>
									</div>
				
				<div class="card">
					<div class="card-header header-elements-sm-inline">
						<h6 class="card-title">Task Status Breakdown</h6>						
					</div>

					<div class="card-body ">

					<div class="row">
						
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Name of  
										Manager</th>
									<th style="background-color: white; width: 50px;">Status wise task data</th>
									<th style="background-color: white; width: 50px">Overdue</th>
									<th style="background-color: white; width: 50px">Due today</th>
									<th style="background-color: white; width: 50px">Due this week</th> 
									<th style="background-color: white; width: 50px">Due this month</th> 
								</tr>
							</thead>
							<tbody>

								<tr>
									<td><a href="#" class="text-default font-weight-semibold" onclick="goToTaskManager()">Manager A</a></td>
									<td>Pending</td>
									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td>22</td>
								</tr>							 
								
							</tbody>
						</table>
					
						</div>
				
						</div>
					</div>
					<!-- card body -->
				</div>
				
				
				
								<div class="card">
					<div class="card-header header-elements-sm-inline">
						<h6 class="card-title">Partner Capacity Details</h6>
						<div class="header-elements">
							<a
			 					class="text-default daterange-ranges font-weight-semibold cursor-pointer dropdown-toggle">
								<i class="icon-calendar3 mr-2"></i> <span></span>
							</a>
						</div>
					</div>

					<div class="card-body ">

					<div class="row">
						
					<div class="table-responsive">
						<table class="table text-nowrap">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Name of
										Employee</th>
									<th style="background-color: white; width: 50px;">Budget Capacity</th>
									<th style="background-color: white; width: 50px">Allocated Capacity</th>
									<th style="background-color: white; width: 50px">Actual Hours Worked	</th>
									<th style="background-color: white; width: 50px">% completion bar</th>

								</tr>
							</thead>
							<tbody>

								<tr>
									<td>
										<a href="#" class="text-default font-weight-semibold" onclick="goToTaskEmployee()">Manager A</a>
									</td>

									<td>20</td>
									<td>30</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								 <tr>
									<td>
										<a href="#" class="text-default font-weight-semibold" onclick="goToTaskEmployee()">Manager B</a>
									</td>

									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								<tr>
									<td>
										<a href="#" class="text-default font-weight-semibold" onclick="goToTaskEmployee()">Manager C</a>
									</td>
									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								
								
								 <tr>
									<td>
										<a href="#" class="text-default font-weight-semibold" onclick="goToTaskEmployee()">Self</a>
									</td>
									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
								<tr>
									<td>
										<a href="#" class="text-default font-weight-semibold">Total:</a>
									</td>
									<td>20</td>
									<td>35</td>
									<td>12</td>
									<td><div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div></td>

								</tr>
							</tbody>
						</table>
					
						</div>
				
						</div>
					</div>
					<!-- card body -->
				</div>
				<!--End Copy of Partners -->
				
				
				<div class="card" style="display: none;">

					<div class=table-responsive>

						<table class="table datatable-basic table-hover">
							<thead>
								<tr>
									<th style="background-color: white; width: 300px">Status
										Wise Task Data</th>
									<th style="background-color: white; width: 70px">Overdue</th>
									<th style="background-color: white; width: 70px">Due Today</th>
									<th style="background-color: white; width: 70px">Due this
										Week</th>
									<th style="background-color: white; width: 70px">Due this
										Month</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div class="d-flex align-items-center">
											<div class="d-flex align-items-center mb-3 mb-md-0">
												<a href="#" title="Unallocated Task"
													class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
													<i class="icon-user-tie"></i>
												</a>
											</div>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<div>
												<a href="#" class="text-default font-weight-semibold">Pending
													for Manager</a>
											</div>
										</div>
									</td>
									<td>20</td>
									<td>35</td>
									<td>45</td>
									<td>10</td>
								</tr>


								<tr>
									<td>
										<div class="d-flex align-items-center">
											<div class="d-flex align-items-center mb-3 mb-md-0">
												<a href="#" title="Unallocated Task"
													class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
													<i class="icon-users"></i>
												</a>
											</div>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<div>
												<a href="#" class="text-default font-weight-semibold">Pending
													for Client</a>
											</div>
										</div>
									</td>
									<td>20</td>
									<td>35</td>
									<td>45</td>
									<td>10</td>

								</tr>

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
function goToTaskManager(){
    window.location = "${pageContext.request.contextPath}/managerTask";
}

function goToTaskEmployee(){
    window.location = '${pageContext.request.contextPath}/employeeTask';
}
</script>

	<script type="text/javascript">

function daterng() {
    if (!$().daterangepicker) {
        console.warn('Warning - daterangepicker.js is not loaded.');
        return;
    }

    // Basic initialization
    $('.daterange-basic').daterangepicker({
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        opens: 'left',
        locale: {
            direction: 'rtl'
        }
    });

    // Display week numbers
    $('.daterange-weeknumbers').daterangepicker({
        showWeekNumbers: true,
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        opens: 'left',
        locale: {
            direction: 'rtl'
        }
    });

    // Button class options
    $('.daterange-buttons').daterangepicker({
        applyClass: 'btn-success',
        cancelClass: 'btn-danger',
        opens: 'left',
        locale: {
            direction: 'rtl'
        }
    });

    // Display time picker
    $('.daterange-time').daterangepicker({
        timePicker: true,
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        opens: 'left',
        locale: {
            format: 'MM/DD/YYYY h:mm a',
            direction: 'rtl'
        }
    });

    // Show calendars on left
    $('.daterange-left').daterangepicker({
        opens: 'right',
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        locale: {
            direction: 'rtl'
        }
    });

    // Single picker
    $('.daterange-single').daterangepicker({ 
        singleDatePicker: true,
        opens: 'left',
        locale: {
            direction: 'rtl'
        }
    });

    // Display date dropdowns
    $('.daterange-datemenu').daterangepicker({
        showDropdowns: true,
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        opens: 'right',
        locale: {
            direction: 'rtl'
        }
    });

    // 10 minute increments
    $('.daterange-increments').daterangepicker({
        timePicker: true,
        opens: 'right',
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        timePickerIncrement: 10,
        locale: {
            format: 'MM/DD/YYYY h:mm a',
            direction: 'rtl'
        }
    });

    // Localization
    $('.daterange-locale').daterangepicker({
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-light',
        opens: 'right',
        ranges: {
            'Сегодня': [moment(), moment()],
            'Вчера': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Последние 7 дней': [moment().subtract(6, 'days'), moment()],
            'Последние 30 дней': [moment().subtract(29, 'days'), moment()],
            'Этот месяц': [moment().startOf('month'), moment().endOf('month')],
            'Прошедший месяц': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        locale: {
            applyLabel: 'Вперед',
            cancelLabel: 'Отмена',
            startLabel: 'Начальная дата',
            endLabel: 'Конечная дата',
            customRangeLabel: 'Выбрать дату',
            daysOfWeek: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт','Сб'],
            monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
            firstDay: 1,
            direction: 'rtl'
        }
    });


    //
    // Pre-defined ranges and callback
    //

    // Initialize with options
    $('.daterange-predefined').daterangepicker(
        {
            startDate: moment().subtract(29, 'days'),
            endDate: moment(),
            minDate: '01/01/2014',
            maxDate: '12/31/2019',
            dateLimit: { days: 60 },
            ranges: {
                'Today': [moment(), moment()],
                'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                'This Month': [moment().startOf('month'), moment().endOf('month')],
                'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            },
            opens: 'right',
            applyClass: 'btn-sm bg-slate',
            cancelClass: 'btn-sm btn-light',
            locale: {
                direction: 'rtl'
            }                
        },
        function(start, end) {
            $('.daterange-predefined span').html(start.format('MMMM D, YYYY') + ' &nbsp; - &nbsp; ' + end.format('MMMM D, YYYY'));
            $.jGrowl('Date range has been changed', { header: 'Update', theme: 'bg-primary', position: 'center', life: 1500 });
        }
    );

    // Display date format
    $('.daterange-predefined span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' &nbsp; - &nbsp; ' + moment().format('MMMM D, YYYY'));


    //
    // Inside button
    //

    // Initialize with options
    $('.daterange-ranges').daterangepicker(
        {
            startDate: moment().subtract(29, 'days'),
            endDate: moment(),
            minDate: '01/01/2012',
            maxDate: '12/31/2019',
            dateLimit: { days: 60 },
            
            opens: 'right',
            applyClass: 'btn-sm bg-slate-600',
            cancelClass: 'btn-sm btn-light',
            locale: {
                direction: 'rtl'
            }
        },
        function(start, end) {
            $('.daterange-ranges span').html(start.format('MMMM D, YYYY') + ' &nbsp; - &nbsp; ' + end.format('MMMM D, YYYY'));
        }
    );

    // Display date format
    $('.daterange-ranges span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' &nbsp; - &nbsp; ' + moment().format('MMMM D, YYYY'));
};

</script>


	<script type="text/javascript">
	
	window.onload=progressChart('#goal-progress1', 38, 2, '#5C6BC0', 0.10, 'icon-checkmark4 text-indigo-400', 'Completion', '97% average');
	
	 //_RoundedProgressChart('#goal-progress', 38, 2, '#5C6BC0', 0.82, 'icon-trophy3 text-indigo-400', 'Completion', '97% average');
	
	 // Rounded progress charts
     function progressChart(element, radius, border, color, end, iconClass, textTitle, textAverage) {
        if (typeof d3 == 'undefined') {
            console.warn('Warning - d3.min.js is not loaded.');
            return;
        }

        // Initialize chart only if element exsists in the DOM
        if($(element).length > 0) {


            // Basic setup
            // ------------------------------

            // Main variables
            var d3Container = d3.select(element),
                startPercent = 0,
                iconSize = 32,
                endPercent = end,
                twoPi = Math.PI * 2,
                formatPercent = d3.format('.0%'),
                boxSize = radius * 2;

            // Values count
            var count = Math.abs((endPercent - startPercent) / 0.01);

            // Values step
            var step = endPercent < startPercent ? -0.01 : 0.01;



            // Create chart
            // ------------------------------

            // Add SVG element
            var container = d3Container.append('svg');

            // Add SVG group
            var svg = container
                .attr('width', boxSize)
                .attr('height', boxSize)
                .append('g')
                    .attr('transform', 'translate(' + (boxSize / 2) + ',' + (boxSize / 2) + ')');



            // Construct chart layout
            // ------------------------------

            // Arc
            var arc = d3.svg.arc()
                .startAngle(0)
                .innerRadius(radius)
                .outerRadius(radius - border);



            //
            // Append chart elements
            //

            // Paths
            // ------------------------------

            // Background path
            svg.append('path')
                .attr('class', 'd3-progress-background')
                .attr('d', arc.endAngle(twoPi))
                .style('fill', '#eee');

            // Foreground path
            var foreground = svg.append('path')
                .attr('class', 'd3-progress-foreground')
                .attr('filter', 'url(#blur)')
                .style('fill', color)
                .style('stroke', color);

            // Front path
            var front = svg.append('path')
                .attr('class', 'd3-progress-front')
                .style('fill', color)
                .style('fill-opacity', 1);



            // Text
            // ------------------------------

            // Percentage text value
            var numberText = d3.select(element)
                .append('h2')
                    .attr('class', 'pt-1 mt-2 mb-1')

            // Icon
            d3.select(element)
                .append('i')
                    .attr('class', iconClass + ' counter-icon')
                    .attr('style', 'top: ' + ((boxSize - iconSize) / 2) + 'px');

            // Title
            d3.select(element)
                .append('div')
                    .text(textTitle);



            // Animation
            // ------------------------------

            // Animate path
            function updateProgress(progress) {
                foreground.attr('d', arc.endAngle(twoPi * progress));
                front.attr('d', arc.endAngle(twoPi * progress));
                numberText.text(formatPercent(progress));
            }

            // Animate text
            var progress = startPercent;
            (function loops() {
                updateProgress(progress);
                if (count > 0) {
                    count--;
                    progress += step;
                    setTimeout(loops, 10);
                }
            })();
        }
    };
	
	
	</script>



	<!-- <script type="text/javascript">
	
	window.onload=dashPro();
	

    // Pie and donut charts
   function dashPro() {
    	
    	
        if (typeof echarts == 'undefined') {
            console.warn('Warning - echarts.min.js is not loaded.');
            return;
        }

        // Define elements
       
        var pie_multiples_element = document.getElementById('pie_multiples');

        // Donut multiples
        if (pie_multiples_element) {

            // Initialize chart
            var pie_multiples = echarts.init(pie_multiples_element);


            //
            // Chart config
            //

            // Top text label
            var labelTop = {
                show: true,
                position: 'center',
                formatter: '{b}\n',
                fontSize: 15,
                lineHeight: 50,
                rich: {
                    a: {}
                }
            };

            // Background item style
            var backStyle = {
                color: '#eee',
                emphasis: {
                    color: '#eee'
                }
            };

            // Bottom text label
            var labelBottom = {
                color: '#333',
                show: true,
                position: 'center',
                formatter: function (params) {
                    return '\n\n' + (100 - params.value) + '%'
                },
                fontWeight: 500,
                lineHeight: 35,
                rich: {
                    a: {}
                },
                emphasis: {
                    color: '#333'
                }
            };

            // Set inner and outer radius
            var radius = [52, 65];

            // Options
            pie_multiples.setOption({

                // Colors
                color: [
                    '#2ec7c9','#b6a2de','#5ab1ef','#ffb980','#d87a80',
                    '#8d98b3','#e5cf0d','#97b552','#95706d','#dc69aa',
                    '#07a2a4','#9a7fd1','#588dd5','#f5994e','#c05050',
                    '#59678c','#c9ab00','#7eb00a','#6f5553','#c14089'
                ],

                // Global text styles
                textStyle: {
                    fontFamily: 'Roboto, Arial, Verdana, sans-serif',
                    fontSize: 13
                },

              

              
                // Add series
                series: [
                    
                    {
                        type: 'pie',
                        center: ['50%', '73%'],
                        radius: radius,
                        hoverAnimation: false,
                        data: [
                            {name: 'other', value: 10, label: labelBottom, itemStyle: backStyle},
                            {name: 'Completion', value: 90, label: labelTop}
                        ]
                    }
                ]
            });
        }


        //
        // Resize charts
        //

        // Resize function
        var triggerChartResize = function() {
            pie_multiples_element && pie_multiples.resize();
        };

        // On sidebar width change
        $(document).on('click', '.sidebar-control', function() {
            setTimeout(function () {
                triggerChartResize();
            }, 0);
        });

        // On window resize
        var resizeCharts;
        window.onresize = function () {
            clearTimeout(resizeCharts);
            resizeCharts = setTimeout(function () {
                triggerChartResize();
            }, 200);
        };
    };
	
	</script>
 -->







</body>
</html>