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
	<c:url value="/getCustSignatoryBySignId" var="getCustSignatoryBySignId"></c:url>

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
			<!-- <div class="page-header page-header-light">


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
			</div> -->
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<div class="card-header header-elements-inline">
					<h6 class="card-title">Customer Signatory</h6>
					<!-- <div class="header-elements">
									<div class="list-icons">
										<a class="list-icons-item" data-action="collapse"></a>
									</div>
								</div> -->
				</div>

				<!-- Form validation -->


				<div class="row">



					<div class="col-md-12">

						<div class="card">
							<div class="card-body">


								<form method="post"
									action="${pageContext.request.contextPath}/addCustSignatory"
									id="submitInsertActivity">
									<input type="hidden" id="custId" name="custId" value="${custId}">
									<input type="hidden" id="signId" name="signId" value="0">

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="customer">
											Customer : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Customer Name" id="customer" name="customer"
												autocomplete="off" value="${custName}" onchange="trim(this)" readonly="readonly">
										</div>
									</div>

									<legend>
										class="font-weight-semibold text-uppercase font-size-sm">Signatory
										Information</legend>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="signFName">
											First Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter First Name" id="signFName"
												name="signFName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_signFName"
												style="display: none;">Please enter first name.</span>
										</div>


										<label class="col-form-label col-lg-2" for="signLName">
											Last Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Last Name" id="signLName"
												name="signLName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_signLName"
												style="display: none;">Please enter last name.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="regNo">Register
											Number <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Registration Number" id="regNo"
												name="regNo" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_regNo"
												style="display: none;">Please enter register No.</span>
										</div>


										<label class="col-form-label col-lg-2" for="desg">Designation
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Designation" id="desg" name="desg"
												autocomplete="off" onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_desg"
												style="display: none;">Please enter designation.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="signMobile">
											Contact Number <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Signatory Contact Number" id="signMobile"
												name="signMobile" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_signMobile"
												style="display: none;">Please enter contact No.</span>
										</div>

									</div>

									<legend
										class="font-weight-semibold text-uppercase font-size-sm">Contact
										Person Information</legend>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="contPerName">
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Contact Person Name" id="contPerName"
												name="contPerName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_contPerName"
												style="display: none;">Please enter name.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="contPerEmail">
											Email <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Email Address" id="contPerEmail"
												name="contPerEmail" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label"
												id="error_contPerEmail" style="display: none;">Please enter email.</span>
										</div>


										<label class="col-form-label col-lg-2" for="contPerNo">Contact
											Number <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Contact Number" id="contPerNo"
												name="contPerNo" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_contPerNo"
												style="display: none;">Please enter contact No.</span>
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
									id="submitInsertActivity1">

									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th>Signatory Name</th>
												<th>Registration No.</th>
												<th>Designation</th>
												<th>Contact Number</th>
												<th>Contact Person</th>
												<th class="text-center" width="10%">Actions</th>
											</tr>
										</thead>
		<tbody>
										<!-- <tr>
											<td>ABC</td>
											<td>123123</td>
											<td>Head</td>
											<td>9898989898</td>
											<td>Name : XYZ<br>Email : xyz@gmail.com<br>Mobile
												: 8585858585
											</td>

											<td class="text-center"><a href="" title="Edit"><i
													class="icon-pencil7" style="color: black;"></i></a> <a href=""
												onClick="return confirm('Are you sure want to delete this record');"
												title="Delete"><i class="icon-trash"
													style="color: black;"></i> </a></td>

										</tr>
 -->
										<c:forEach items="${custSignList}" var="sign">
										
										<tr>
										<td>${sign.signfName} ${sign.signlName}</td>
											<td>${sign.signRegNo}</td>
											<td>${sign.signDesign}</td>
											<td>${sign.signPhno}</td>
											<td>Name : ${sign.contactName}<br>Email : ${sign.contactEmail}<br>Mobile
												: ${sign.contactPhno}
											</td>
											<td class="text-center"><a href="#" onclick="showEdit(${sign.signId})" title="Edit"><i
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

												 if (!$("#signFName").val()) {

													isError = true;

													$("#error_signFName")
															.show()
													//return false;
												} else {
													$("#error_signFName")
															.hide()
												}

												if (!$("#signLName").val()) {

													isError = true;

													$("#error_signLName").show()

												} else {
													$("#error_signLName").hide()
												}

												if (!$("#regNo").val()) {

													isError = true;

													$("#error_regNo").show()

												} else {
													$("#error_regNo").hide()
												}

												if (!$("#desg").val()) {

													isError = true;

													$("#error_desg").show()

												} else {
													$("#error_desg").hide()
												}

												if (!$("#signMobile").val()) {

													isError = true;

													$("#error_signMobile").show()

												} else {
													$("#error_signMobile").hide()
												}

												if (!$("#contPerName").val()) {

													isError = true;

													$("#error_contPerName").show()

												} else {
													$("#error_contPerName").hide()
												}

												if (!$("#contPerEmail").val()) {

													isError = true;

													$("#error_contPerEmail").show()

												} else {
													$("#error_contPerEmail").hide()
												} 
												
												if (!$("#contPerNo").val()) {

													isError = true;

													$("#error_contPerNo").show()

												} else {
													$("#error_contPerNo").hide()
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
		
		function showEdit(signId){
			 document.getElementById("signId").value="0";
			$
			.getJSON(
					'${getCustSignatoryBySignId}',
					{
						signId : signId,
						ajax : 'true',
					},

					function(data) {
						
						//alert(JSON.stringify(data));
						 document.getElementById("signId").value=data.signId;
						 document.getElementById("contPerEmail").value=data.contactEmail;
						 document.getElementById("contPerName").value=data.contactName;
						 document.getElementById("contPerNo").value=data.contactPhno;
						 document.getElementById("remark").value=data.custRemark;
						 document.getElementById("desg").value=data.signDesign;
						 document.getElementById("signFName").value=data.signfName;
						 document.getElementById("signLName").value=data.signlName;
						 document.getElementById("signMobile").value=data.signPhno;
						 document.getElementById("regNo").value=data.signRegNo;
					}
					)
		}
	</script>

</body>
</html>