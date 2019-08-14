<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib
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
			<div class="page-header page-header-light">


				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
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


						<div class="card">

							<div class="card-header header-elements-inline">
								<h6 class="card-title">Customer Detail</h6>
							</div>

							<div class="card-body">
								<form
									action="${pageContext.request.contextPath}/customerDetailList"
									id="submitInsertActivity" enctype="multipart/form-data">

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="customer">
											Customer : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Customer Name" id="customer" value="${custDetailList[0].custFirmName}" name="customer"
												autocomplete="off" onchange="trim(this)" readonly="readonly">
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="service">
											Service : </label>
										<div class="col-lg-4">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Service</option>
												<option value="2">Income Tax</option>
												<option value="3">TDS</option>
												<option value="4">GST</option>


												<c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach>
											</select>
										</div>

										<label class="col-form-label col-lg-2" for="activity">
											Activity : </label>
										<div class="col-lg-4">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1">Select Activity</option>
												<option value="2">Return Filing</option>
												<option value="3">Revised Return Filing</option>
												<option value="4">Tax Payment</option>

												<c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach>
											</select>
										</div>


									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="username">Login
											Username <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Login Username" id="username"
												name="username" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_username"
												style="display: none;">This field is required.</span>
										</div>


										<label class="col-form-label col-lg-2" for="password">Login
											Password <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Login Password" id="password"
												name="password" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_password"
												style="display: none;">This field is required.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="que1">Security
											Question 1 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Security Question 1" id="que1"
												name="que1" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_que1"
												style="display: none;">This field is required.</span>
										</div>


										<label class="col-form-label col-lg-2" for="ans1">Answer
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Answer" id="ans1" name="ans1"
												autocomplete="off" onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_ans1"
												style="display: none;">This field is required.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="que1">Security
											Question 2 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Security Question 2" id="que2"
												name="que2" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_que2"
												style="display: none;">This field is required.</span>
										</div>


										<label class="col-form-label col-lg-2" for="ans2">Answer
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Answer" id="ans2" name="ans2"
												autocomplete="off" onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_ans2"
												style="display: none;">This field is required.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="remark">Remark
											: </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Enter Remark" id="remark" name="remark"
												autocomplete="off" onchange="trim(this)">
										</div>
									</div>

									<div class="form-group row mb-0">
										<div class="col-lg-12" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											&nbsp; <a
												href="${pageContext.request.contextPath}/customerDetailList"><button
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




					<div class="col-md-12">

						<div class="card">


							<div class="card-body">

								<form
									action="${pageContext.request.contextPath}/customerDetailList"
									id="submitInsertActivity" enctype="multipart/form-data">



									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th>Activity</th>
												<th>Login</th>
												<th>Security Questions</th>
												<th class="text-center" width="10%">Actions</th>
											</tr>
										</thead>
											<tbody>
											
												<c:forEach items="${custDetailList}" var="custDetail">
										
										<tr>
											<td>${custDetail.actiName}</td>
											<td>Username : ${custDetail.loginId}<br>Password : ${custDetail.loginPass}
											</td>
											<td>Que 1 : ${custDetail.loginQue1}<br>Ans 1 : ${custDetail.loginAns1}
												<br>Que 2 : ${custDetail.loginQue2}<br>Ans 2
												: ${custDetail.loginAns2}
											</td>

											<td class="text-center"><a href="" title="Edit"><i
													class="icon-pencil7" style="color: black;"></i></a> <a href=""
												onClick="return confirm('Are you sure want to delete this record');"
												title="Delete"><i class="icon-trash"
													style="color: black;"></i> </a></td>


										</tr>
										</c:forEach>
										
</tbody>
										
									</table>


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

							$("#submitInsertActivity")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if (!$("#activityName").val()) {

													isError = true;

													$("#error_activityName")
															.show()
													//return false;
												} else {
													$("#error_activityName")
															.hide()
												}

												if (!$("#panNo").val()
														|| !validatePAN($(
																"#panNo").val())) {

													isError = true;

													$("#error_panNo").show()

												} else {
													$("#error_panNo").hide()
												}

												if (!$("#emailId").val()
														|| !validateEmail($(
																"#emailId")
																.val())) {

													isError = true;

													$("#error_emailId").show()

												} else {
													$("#error_emailId").hide()
												}

												if (!$("#phone").val()
														|| !validateMobile($(
																"#phone").val())) {

													isError = true;

													$("#error_phone").show()

												} else {
													$("#error_phone").hide()
												}

												if (!$("#address1").val()) {

													isError = true;

													$("#error_address1").show()

												} else {
													$("#error_address1").hide()
												}

												if (!$("#city").val()) {

													isError = true;

													$("#error_city").show()

												} else {
													$("#error_city").hide()
												}

												if (!$("#pincode").val()) {

													isError = true;

													$("#error_pincode").show()

												} else {
													$("#error_pincode").hide()
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

</body>
</html>