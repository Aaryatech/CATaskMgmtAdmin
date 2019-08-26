<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>


	<c:url value="/getActivityByService" var="getActivityByService"></c:url>

	<c:url value="/getPeridicityByActivity" var="getPeridicityByActivity"></c:url>
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
								<h6 class="card-title">Add Manual Task</h6>
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

								<form action="${pageContext.request.contextPath}/addManualTask"
									id="submitInsertClient" method="post">




									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="locId2">
											Employee <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">

											<select multiple="multiple"
												data-placeholder="Select Employee" name="empId2" id="empId2"
												class="form-control form-control-sm select"
												data-container-css-class="select-sm" data-fouc>
												<option value="">Select Employee</option>
												<c:forEach items="${epmList}" var="epmList">
													<option value="${epmList.empId}">
														${epmList.empName} -${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
												</c:forEach>

											</select>

										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_emp"
												style="display: none;">Please Employee.</span>
										</div>
									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Customer<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<select name="customer" data-placeholder="Select Customer"
												id="customer"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"><c:forEach
													items="${custList}" var="custList">
													<option value="${custList.custId}">${custList.custFirmName}</option>
												</c:forEach>

											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_cust"
												style="display: none;">Please select customer </span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Service<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)"><c:forEach
													items="${serviceList}" var="serviceList">
													<option value="${serviceList.servId}">${serviceList.servName}</option>
												</c:forEach>

											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_periodicity"
												style="display: none;">Please Select Service</span>
										</div>
									</div>

									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="activity">
											Activity <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getPeriodicity(this.value)">
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_activity"
												style="display: none;">Please select above service
												for corresponding activity.</span>
										</div>

									</div>

									<input type="hidden" id="periodicityId" name="periodicityId">
									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="periodicity">
											Periodicity <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" readonly="readonly"
												name="periodicity" id="periodicity"
												placeholder="Periodicity">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_periodicity"
												style="display: none;">Please select above activity
												for corresponding periodicity.</span>
										</div>

									</div>


									<%-- 	<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Financial Year : </label>
										<div class="col-lg-6">
											<select name="fyYear" data-placeholder="Select Year"
												id="fyYear"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)"><c:forEach
													items="${fyList}" var="fyList">
													<option value="${fyList.finYearId}">${fyList.finYearName}</option>
												</c:forEach>

											</select>
										</div>
									</div> --%>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="statutary_endDays">
											Statutory End Days <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Statutory End Days" id="statutary_endDays"
												name="statutary_endDays" autocomplete="off"
												onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label"
												id="error_stat_endDays" style="display: none;">Please
												enter statutory end days.</span>
										</div>

									</div>


									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="startDate">Start
											Date <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass"
												name="startDate" id="startDate" placeholder="Start Date">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_startDate"
												style="display: none;">Please enter start date.</span> <span
												class="validation-invalid-label" id="error_start_date"
												style="display: none;">Start date must be greater
												than end date.</span>
										</div>

									</div>




									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="endDate">Task
											End Date <span style="color: red">* </span>:
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
										<label class="col-form-label col-lg-3" for="manHrs">Manager
											Budget Hours<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Manager Budget Hours" id="mgBudgetHr"
												name="mgBudgetHr" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_mgBudgetHr"
												style="display: none;">This field is required.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="empHrs">Employee
											Budget Hours<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Employee Budget Hours" id="empBudgetHr"
												name="empBudgetHr" autocomplete="off" onchange="trim(this)">
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
											<a href="#"><button type="button" class="btn btn-primary">
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
		$('#statutary_endDays').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$('#mgBudgetHr').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$('#empBudgetHr').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$(document)
				.ready(
						function($) {

							$("#submitInsertClient")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if ($("#service").val() == "") {

													isError = true;

													$("#error_service").show()

												} else {
													$("#error_service").hide()
												}

												if ($("#empId2").val() == "") {

													isError = true;

													$("#error_emp").show()

												} else {
													$("#error_emp").hide()
												}

												if ($("#customer").val() == "") {

													isError = true;

													$("#error_cust").show()

												} else {
													$("#error_cust").hide()
												}

												if (!$("#periodicity").val()
														|| $("#activity").val() == "") {

													isError = true;

													$("#error_activity").show()

												} else {
													$("#error_activity").hide()
												}

												if (!$("#periodicity").val()) {

													isError = true;

													$("#error_periodicity")
															.show()

												} else {
													$("#error_periodicity")
															.hide()
												}

												if (!$("#startDate").val()) {

													isError = true;

													$("#error_startDate")
															.show()

												} else {
													$("#error_startDate")
															.hide()
												}

												if (!$("#endDate").val()) {

													isError = true;

													$("#error_endDate").show()

												} else {
													$("#error_endDate").hide()
												}

												var from_date = document
														.getElementById("startDate").value;
												var to_date = document
														.getElementById("endDate").value;

												var fromdate = from_date
														.split('-');
												from_date = new Date();
												from_date.setFullYear(
														fromdate[2],
														fromdate[1] - 1,
														fromdate[0]);
												var todate = to_date.split('-');
												to_date = new Date();
												to_date.setFullYear(todate[2],
														todate[1] - 1,
														todate[0]);
												if (from_date > to_date) {
													$("#error_start_date")
															.show();
													$("#error_end_date").show();
													$("#error_startDate")
															.hide();
													$("#error_endDate").hide();
													return false;

												} else {
													$("#error_start_date")
															.hide();
													$("#error_end_date").hide();
												}
												////////

												if (!$("#statutary_endDays")
														.val()) {

													isError = true;

													$("#error_stat_endDays")
															.show()

												} else {
													$("#error_stat_endDays")
															.hide()
												}

												if (!$("#mgBudgetHr").val()) {

													isError = true;

													$("#error_mgBudgetHr")
															.show()

												} else {
													$("#error_mgBudgetHr")
															.hide()
												}

												if (!$("#empBudgetHr").val()) {

													isError = true;

													$("#error_empHrs").show()

												} else {
													$("#error_empHrs").hide()
												}

												if (!isError) {

													var x = true;
													if (x == true) {

														document
																.getElementById("submtbtn").disabled = true;
														document
																.getElementById("cancelbtn").disabled = true;
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
	<script>
		function getActivities(servId) {
			//alert("servId " +servId)
			if (servId > 0) {

				$.getJSON('${getActivityByService}', {
					servId : servId,
					ajax : 'true',
				},

				function(data) {
					var html;
					var p = "";
					var q = "Select Activity";
					html += '<option disabled value="'+p+'" selected>' + q
							+ '</option>';
					html += '</option>';

					var temp = 0;

					var len = data.length;
					for (var i = 0; i < len; i++) {

						html += '<option value="' + data[i].actiId + '">'
								+ data[i].actiName + '</option>';
					}

					$('#activity').html(html);
					$("#activity").trigger("chosen:updated");

				});

			}//end of if
		}

		//
		function getPeriodicity(actvityId) {
			//alert("Activity---"+actvityId);

			if (actvityId > 0) {

				$
						.getJSON(
								'${getPeridicityByActivity}',
								{
									actvityId : actvityId,
									ajax : 'true',
								},

								function(data) {
									//alert(JSON.stringify(data));
									document.getElementById("periodicity").value = data.periodicityName;
									document.getElementById("periodicityId").value = data.periodicityId;
								});

			}//end of if
		}
	</script>
</body>
</html>