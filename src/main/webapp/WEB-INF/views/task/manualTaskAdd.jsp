<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<div class="page-header page-header-light">


				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Client</span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>


				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


						<div class="card">
							<div class="card-header header-elements-inline">
								<h6 class="card-title">Add New Task</h6>
								<!-- <div class="header-elements">
									<div class="list-icons">
										<a class="list-icons-item" data-action="collapse"></a>
									</div>
								</div> -->
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

								<form action="#"
									id="submitInsertTask">


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="firmName">Select Customer 
											 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="customer"
												data-placeholder="Select Customer" id="customer"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Customer</option>
												<option value="2">ABC</option>
												<option value="3">PQR</option>
												<option value="4">XYZ</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_customer"
												style="display: none;">This field is required.</span>
										</div>

									</div>


									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="assesseeName">Select Service
											<span style="color: red">* </span>: </label>
										<div class="col-lg-6">
											<select name="service"
												data-placeholder="Select Service" id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Service</option>
												<option value="2">Income Tax</option>
												<option value="3">TDS</option>
												<option value="4">GST</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_service"
												style="display: none;">This field is required.</span></div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="panNo">Select Activity
											 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="activity"
												data-placeholder="Select Activity" id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Activity</option>
												<option value="2">Return Filing	</option>
												<option value="3">Revised Return Filing	</option>
												<option value="4">Tax Payment</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_activity"
												style="display: none;">This field is required.</span>
										</div>
									</div>
									
									
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="panNo">Select Periodicity
											 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="periodicity"
												data-placeholder="Select Periodicity" id="periodicity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Periodicity</option>
												<option value="2">Yearly	</option>
												<option value="3">Monthly	</option>
												<option value="4">Weekly</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_periodicity"
												style="display: none;">This field is required.</span>
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="panNo">Select Financial Year
											 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="finYear"
												data-placeholder="Select Financial Year" id="finYear"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Financial Year</option>
												<option value="2">2017-2018	</option>
												<option value="3">2018-2019	</option>
												<option value="4">2019-2020</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_finYear"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="endDate">Task End Date
										 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass"
												name="endDate" id="endDate" placeholder="Task End Date">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_endDate"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="manHrs">Manager Budget Hours
											:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Manager Budget Hours" id="manHrs" name="manHrs"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_manHrs"
												style="display: none;">This field is required.</span>
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="empHrs">Employee Budget Hours
											:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Employee Budget Hours" id="empHrs" name="empHrs"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empHrs"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									<div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="#"><button
													type="button" class="btn btn-primary">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div>
								</form>
							</div>
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


	<script>
		$(document)
				.ready(
						function($) {

							$("#submitInsertClient")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if ($("#customer").val()==1) {

													isError = true;

													$("#error_customer").show()
													//return false;
												} else {
													$("#error_customer").hide()
												}

												if ($("#service").val()==1
														) {

													isError = true;

													$("#error_service").show()

												} else {
													$("#error_service").hide()
												}

												if ($("#activity").val()==1
														) {

													isError = true;

													$("#error_activity").show()

												} else {
													$("#error_activity").hide()
												}

												if ($("#periodicity").val()==1
														) {

													isError = true;

													$("#error_periodicity").show()

												} else {
													$("#error_periodicity").hide()
												}

												if ($("#finYear").val()==1) {

													isError = true;

													$("#error_finYear").show()

												} else {
													$("#error_finYear").hide()
												}

												
												if (!isError) {

													var x = true;
													if (x == true) {

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