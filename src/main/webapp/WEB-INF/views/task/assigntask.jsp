<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
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
			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>


			<!-- /page header -->


			<!-- Content area -->
			<div class="content">




				<!-- Remote source -->
				<div id="modal_remote" class="modal" tabindex="-1">
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
				</div>
				<!-- /remote source -->




				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Assign Task</h5>
						<div class="header-elements">
							<div class="list-icons">

								<a href="#" title="Chat/Update" data-toggle="modal"
									data-target="#modal_remote"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/filter.png"
									alt="" style="height: 26px; width: 26px;"></a> &nbsp;<a
									class="list-icons-item" data-action="collapse"></a>
							</div>
						</div>
					</div>


					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
								id="printtable">
								<thead>
									<tr class="bg-blue">
										<th width="10%">Sr.no</th>
										<th>Customer</th>
										<th>Activity</th>
										<th>Year</th>
										<th>Date</th>
										<th>Alloted Hrs</th>
										<th>Actual Hrs</th>
										<th>Status</th>
										<th class="text-center" width="10%">Actions</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td>1&nbsp;<input type="checkbox" id="taskcheck"
											name="taskcheck"></td>
										<td>ABC</td>
										<td>GST</td>
										<td>2018-19</td>
										<td>11-01-2019</td>
										<td>45</td>
										<td>52</td>
										<td><span class="badge badge-info">Pending</span></td>
										<td class="text-center"><a href="#" class="dropdown-item"
											title="Task detail"><i class="fa fa-list-alt"></i> </a></td>

									</tr>
								</tbody>
							</table>
						</div>
						<br>
						<div style="text-align: center;">
							<a
								href="${pageContext.request.contextPath}/selectEmployeeToAssigTask"><button
									type="button" class="btn btn-primary">Assign To
									Employee</button></a>
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