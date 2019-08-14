<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>

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



			<!-- Content area -->
			<div class="content">

				<div class="card">

					<div
						class="card-body d-md-flex align-items-md-center justify-content-md-between flex-md-wrap">

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#"
								class="btn bg-transparent border-warning-400 text-warning-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-stack"></i>
							</a>
							<div class="ml-3">
								<h5 class="font-weight-semibold mb-0">750</h5>
								<span class="text-muted">Unallocated Task</span>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#"
								class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-user-tie"></i>
							</a>
							<div class="ml-3">
								<h5 class="font-weight-semibold mb-0">150</h5>
								<span class="text-muted">Pending for Manager</span>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#"
								class="btn bg-transparent border-info-400 text-info-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-users"></i>
							</a>
							<div class="ml-3">
								<h5 class="font-weight-semibold mb-0">125</h5>
								<span class="text-muted">Pending for Client</span>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#"
								class="btn bg-transparent border-danger-400 text-danger-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-warning"></i>
							</a>
							<div class="ml-3">
								<h5 class="font-weight-semibold mb-0">650</h5>
								<span class="text-muted">Critical Task</span>
							</div>
						</div>

						<div class="d-flex align-items-center mb-3 mb-md-0">
							<a href="#"
								class="btn bg-transparent border-success-400 text-success-400 rounded-round border-2 btn-icon legitRipple">
								<i class="icon-checkmark"></i>
							</a>
							<div class="ml-3">
								<h5 class="font-weight-semibold mb-0">650</h5>
								<span class="text-muted">Completed Task</span>
							</div>
						</div>

					</div>

				</div>





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


				<!-- Highlighting rows and columns -->
				<!-- <div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Task</h5></td>
								<td width="40%" align="right"></td>
							</tr>
						</table>
					</div> -->











				<!-- Hover rows -->
				<div class="card">
					<div class="card-header header-elements-inline">
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
					</div>

					<div class=table-responsive>
						<table class="table datatable-basic table-hover">
							<thead>
								<tr>
									<th style="color: white;">Customer</th>
									<th style="color: white;">Activity</th>
									<th style="color: white;">Year</th>
									<th style="color: white;">Date</th>
									<th style="color: white;">Alloted Hrs</th>
									<th style="color: white;">Actual Hrs</th>
									<th style="color: white;">Status</th>
									<th class="text-center" style="color: white;">Actions</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>ABC</td>
									<td>GST</td>
									<td>2018-19</td>
									<td>11-01-2019</td>
									<td>45</td>
									<td>52</td>
									<td><span class="badge badge-info">Pending</span></td>
									<td class="text-center">
										<%-- <div class="list-icons">
										<div class="dropdown">
											<a href="#" class="list-icons-item" data-toggle="dropdown">
												<i class="icon-menu9"></i>
											</a>

											<div class="dropdown-menu dropdown-menu-right">
												<a href="${pageContext.request.contextPath}/communication" class="dropdown-item"><i class="icon-file-pdf"></i> Export to .pdf</a>
												<a href="#" class="dropdown-item"><i class="icon-file-excel"></i> Export to .csv</a>
												<a href="#" class="dropdown-item"><i class="icon-file-word"></i> Export to .doc</a>
											</div>
										</div>
									</div> --%> <a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a>
									</td>
								</tr>


								<tr>
									<td>PQR</td>
									<td>Return Filling</td>
									<td>2018-19</td>
									<td>11-01-2019</td>
									<td>45</td>
									<td>52</td>
									<td><span class="badge badge-success">Completed</span></td>
									<td class="text-center">
										<%-- <div class="list-icons">
										<div class="dropdown">
											<a href="#" class="list-icons-item" data-toggle="dropdown">
												<i class="icon-menu9"></i>
											</a>

											<div class="dropdown-menu dropdown-menu-right">
												<a href="${pageContext.request.contextPath}/communication" class="dropdown-item"><i class="icon-file-pdf"></i> Export to .pdf</a>
												<a href="#" class="dropdown-item"><i class="icon-file-excel"></i> Export to .csv</a>
												<a href="#" class="dropdown-item"><i class="icon-file-word"></i> Export to .doc</a>
											</div>
										</div>
									</div> --%> <a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a>
									</td>
								</tr>


								<tr>
									<td>PQR</td>
									<td>Return Filling</td>
									<td>2018-19</td>
									<td>11-01-2019</td>
									<td>45</td>
									<td>52</td>
									<td><span class="badge badge-danger">Critical</span></td>
									<td class="text-center">
										<%-- <div class="list-icons">
										<div class="dropdown">
											<a href="#" class="list-icons-item" data-toggle="dropdown">
												<i class="icon-menu9"></i>
											</a>

											<div class="dropdown-menu dropdown-menu-right">
												<a href="${pageContext.request.contextPath}/communication" class="dropdown-item"><i class="icon-file-pdf"></i> Export to .pdf</a>
												<a href="#" class="dropdown-item"><i class="icon-file-excel"></i> Export to .csv</a>
												<a href="#" class="dropdown-item"><i class="icon-file-word"></i> Export to .doc</a>
											</div>
										</div>
									</div> --%> <a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a>
									</td>
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