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


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Task</h5></td>
								<td width="40%" align="right"></td>
							</tr>
						</table>
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


						<div class="col-lg-12" align="center">
							<button type="submit" class="btn bg-blue ml-3 legitRipple"
								id="submtbtn">Search</button>
						</div>
						<br>

						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
							id="printtable">
							<thead>
								<tr class="bg-blue">
									<th width="10%">Sr.no</th>
									<th>Customer Name</th>
									<th>Activity Name</th>
									<th>Year</th>
									<th>Start Date</th>
									<th>End Date</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td>1</td>
									<td>ABC</td>
									<td>GST</td>
									<td>2018-19</td>
									<td>11-01-2019</td>
									<td>11-03-2019</td>

									<td><a
										href="${pageContext.request.contextPath}/communication"
										title="Chat/Update"><i class="icon-pencil7"
											style="color: black;"></i></a></td>

								</tr>
							</tbody>
						</table>
						<br>

					</div>

				</div>
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