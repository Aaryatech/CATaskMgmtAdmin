<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
							<a href="#" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active"></span>
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
								<h6 class="card-title">Add Customer Activity Mapping</h6>
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

								<form action="${pageContext.request.contextPath}/addCustomerActMap"
									id="submitInsertClient" method="post">
								
									<input type="text" id="custId" name="custId" value="${cust.custId}"> 	

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="custName">Customer
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${cust.custGroupName}"
												placeholder="Customer Name" id="custName" name="custName"
												autocomplete="off" onchange="trim(this)" readonly="readonly">
										</div>
										<div class="col-lg-3"></div>

									</div>

						

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Service <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="service" data-placeholder="Select Service"
												id="service" 
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true" onchange="getActivities(this.value)">
<option value="" selected>Select Service</option>
												<c:forEach items="${serviceList}" var="service">
												
														<option value="${service. servId}">${service. servName}</option>
												
												</c:forEach>

									</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_service"
												style="display: none;">This field is required.</span>
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
												data-fouc="" aria-hidden="true" onchange="getPeriodicity(this.value)">
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_activity"
												style="display: none;">This field is required.</span>
										</div>

									</div>

									<input type="text" id="periodicityId" name="periodicityId"> 	
									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="periodicity">
											Periodicity <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" readonly="readonly"
												name="periodicity" id="periodicity" placeholder="Periodicity">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_periodicity"
												style="display: none;">This field is required.</span>
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
												style="display: none;">This field is required.</span>
										</div>

									</div>


									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="endDate">End
											Date : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass"
												name="endDate" id="endDate" placeholder="End Date">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_endDate"
												style="display: none;">This field is required.</span>
										</div>

									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="startDays">
											Statutory End Days <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Statutory End Days" id="endDays" name="endDays"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_endDays"
												style="display: none;">This field is required.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="mgBudgetHr">Manager
											Budget Hours <span style="color: red">* </span>:
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
										<label class="col-form-label col-lg-3" for="empBudgetHr">Employee
											Budget Hours <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Employee Budget Hours" id="empBudgetHr"
												name="empBudgetHr" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empBudgetHr"
												style="display: none;">This field is required.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="billAmt">Billing
											Amount <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Billing Amount" id="billAmt"
												name="billAmt" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_billAmt"
												style="display: none;">This field is required.</span>
										</div>

									</div>



									<div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn" 
												><!--data-toggle="modal" data-target="#modal_remote" -->
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/customerList"><button
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




				<!-- Remote source -->
				<div id="modal_remote" class="modal" tabindex="-1">
					<div class="modal-dialog modal-full">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Generate Task</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">


								<div class=table-responsive>
									<table class="table datatable-basic table-hover">
										<thead>
											<tr>
												<th style="color: white;">Customer</th>
												<th style="color: white;">Activity</th>
												<th style="color: white;">Year</th>
												<th style="color: white;">Periodicity</th>
												<th style="color: white;">Start Date</th>
												<th style="color: white;">End Date</th>
												<th style="color: white;">Alloted Hrs</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>ABC</td>
												<td>GST</td>
												<td>2018-19</td>
												<td>Yearly</td>
												<td>11-01-2019</td>
												<td>11-01-2019</td>
												<td>52</td>
												
											</tr>


											<tr>
												<td>ABC</td>
												<td>GST</td>
												<td>2018-19</td>
												<td>Yearly</td>
												<td>11-01-2019</td>
												<td>11-01-2019</td>
												<td>52</td>
											</tr>


											<tr>
												<td>ABC</td>
												<td>GST</td>
												<td>2018-19</td>
												<td>Yearly</td>
												<td>11-01-2019</td>
												<td>11-01-2019</td>
												<td>52</td>
											</tr>



										</tbody>
									</table>
								</div>
								<br>

								<div class="modal-footer">
									<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
									<button type="button" class="btn bg-primary">Save</button>
								</div>

							</div>
						</div>
					</div>
					<!-- /remote source -->

				</div>
				<!-- /content area -->


				<!-- Footer -->
				<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
				<!-- /footer -->


			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->
</div>
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

													if ($("#service").val() == "") {

														isError = true;

														$("#error_service")
																.show()
														//return false;
													} else {
														$("#error_service")
																.hide()
													}

													if ($("#activity").val() == "") {

														isError = true;

														$("#error_activity")
																.show()

													} else {
														$("#error_activity")
																.hide()
													}

													if ($("#periodicity").val() == "") {

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

														$("#error_endDate")
																.show()

													} else {
														$("#error_endDate")
																.hide()
													}

													if (!$("#startDays").val()) {

														isError = true;

														$("#error_startDays")
																.show()

													} else {
														$("#error_startDays")
																.hide()
													}

													if (!$("#endDays").val()) {

														isError = true;

														$("#error_endDays")
																.show()

													} else {
														$("#error_endDays")
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

													if (!$("#empBudgetHr")
															.val()) {

														isError = true;

														$("#error_empBudgetHr")
																.show()

													} else {
														$("#error_empBudgetHr")
																.hide()
													}

													if (!$("#billAmt").val()) {

														isError = true;

														$("#error_billAmt")
																.show()

													} else {
														$("#error_billAmt")
																.hide()
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
									var p = "";
									var q = "Select Activity";
									html += '<option disabled value="'+p+'" selected>'
											+ q + '</option>';
									html += '</option>';

									var temp = 0;

									var len = data.length;
									for (var i = 0; i < len; i++) {												

										html += '<option value="' + data[i].actiId + '">'
												+ data[i].actiName
												+ '</option>';	
									}

									 
									$('#activity').html(html);
									$("#activity").trigger("chosen:updated");

								});

			}//end of if
		}
			
		</script>


<script>
function getPeriodicity(actvityId){
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
							alert(JSON.stringify(data));
							document.getElementById("periodicity").value = data.periodicityName;
							document.getElementById("periodicityId").value = data.periodicityId;
						});

	}//end of if
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
</body>
</html>