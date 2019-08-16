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
						<table class="table datatable-scroller" width="100%">
							<thead>
								<tr>
									<th width="100" style="background-color: white;">Customer</th>
									<th width="500" style="background-color: white;">Service -
										Activity</th>
									<th width="30" style="background-color: white;">Narration</th>
									<th width="100" style="background-color: white;">Due Date</th>
									<th width="5" style="background-color: white;">Alloted Hrs</th>
									<th width="5" style="background-color: white;">Actual Hrs</th>
									<th width="5" style="background-color: white;">Status</th>
									<th width="5" class="text-center"
										style="background-color: white;">Actions</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>


								<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>


								<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>


<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>


<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
								</tr>

<tr>
									<td width="100">A B Shinde</td>
									<td width="500">Income Tax-Revised Return Filling-Oct-2019</td>
									<td width="30">Oct-2019</td>
									<td width="100">11-01-2019</td>
									<td width="5">45</td>
									<td width="5">52</td>
									<td width="5"><span class="badge badge-info">Pending</span></td>
									<td width="5" class="text-center"><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>
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