<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="showDiv(${custHead.custType})">



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
								<h6 class="card-title">${title}</h6>
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

								<form action="${pageContext.request.contextPath}/addCustomerHeader"
									id="submitInsertClient" method="post">

									<input type="hidden" value="${custHead.custId}" name="cust_head_id">
									
									
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="custType">Customer 
											Type <span style="color: red">*</span>:
										</label>
										<div class="form-check form-check-inline">
											<label class="form-check-label"> <input type="radio" ${custHead.custType == 0 ? 'checked' : ''}
												class="form-check-input" name="custType" id="custType" checked
												value="0" onclick="showDiv(this.value)"> Individual
											</label>
										</div>
										<div class="form-check form-check-inline">
											<label class="form-check-label"> <input type="radio" ${custHead.custType == 1 ? 'checked' : ''}
												class="form-check-input" name="custType" id="custType" value="1" onclick="showDiv(this.value)">Client
												 Group
											</label>
										</div>
									</div>


									<div class="form-group row" style="display: none" id="ihide">
										<label class="col-form-label col-lg-3" for="clientGroup">Client
											Group : </label>
										<div class="col-lg-6">
											<select name="clientGrp"
												data-placeholder="Select Client Group" id="clientGrp"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												
											<!-- 	<option value="1">Select</option> -->
												<c:forEach items="${custGrpList}" var="custGrpList">
													<c:choose>
														<c:when test="${custGrpList.custGroupId==custHead.custGroupId}">
															<option selected value="${custGrpList.custGroupId}">${custGrpList.custGroupName}</option>
														</c:when>
														<c:otherwise>
															<option value="${custGrpList.custGroupId}">${custGrpList.custGroupName}</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>

											</select>

										</div>
										<div class="col-lg-3"></div>
									</div>
									
									
									<div class="form-group row" id="hideFirm">
										<label class="col-form-label col-lg-3" for="firmName">Firm
											Name <span style="color: red">*</span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custFirmName}"
												placeholder="Enter Firm Name" id="firmName" name="firmName"
												autocomplete="off" onchange="trim(this)">
										</div>
										 <div class="col-lg-3">
											<span class="validation-invalid-label" id="error_firmName"
												style="display: none;">Please enter firm name.</span>
										</div>

									</div>
									
									


									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="assesseeName">Assessee
											Name <span style="color: red">* </span>: </label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custAssesseeName}"
												placeholder="Enter Assessee Name" id="assesseeName"
												name="assesseeName" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_assesseName"
												style="display: none;">Please enter assessee name.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="panNo">PAN
											No. <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"  value="${custHead.custPanNo}"
												placeholder="Enter Permanent Account Number (PAN)"
												id="panNo" name="panNo" autocomplete="off"
												onchange="trim(this)" maxlength="10">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_panNo"
												style="display: none;">Please enter PAN No.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="aadhar">Aadhar
											Card No. :
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custAadhar}"
												placeholder="Enter Aadhar Card Number" id="aadhar" maxlength="12"
												name="aadhar" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<!-- <span class="validation-invalid-label" id="error_aadhar"
												style="display: none;">Please enter Aadhar Card No.</span> -->
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="assesseeType">
											Type of Assessee <span style="color: red">* </span>: </label>
										<div class="col-lg-6">
											<select name="assesseeType"
												data-placeholder="Select Assessee Type" id="assesseeType"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<!-- <option value="">Select Assessee Type</option> -->
												<option value="1" ${custHead. custAssesseeTypeId == 1 ? 'selected' : ''}>Individual</option>
												<option value="2" ${custHead. custAssesseeTypeId == 2 ? 'selected' : ''}>Partnership Firm</option>
												<option value="3" ${custHead. custAssesseeTypeId == 3 ? 'selected' : ''}>Pvt Ltd</option>
												<option value="4" ${custHead. custAssesseeTypeId == 4 ? 'selected' : ''}>Public Limited</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3"></div>
									</div>
									

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="dob">Date
											of Birth <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass" value="${custHead.custDob}"
												name="dob" id="dob" placeholder="Date of Birth">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_dob"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="emailId">Email
											Id <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custEmailId}"
												placeholder="Enter Email Id" id="emailId" name="emailId"
												autocomplete="off" oninput="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_emailId"
												style="display: none;">This field is required.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="phone">Phone
											Number <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Phone Number" id="phone" name="phone"
												autocomplete="off" value="${custHead.custPhoneNo}"
												oninput="validateMobileEnterOnlyDigits(this)" maxlength="10">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_phone"
												style="display: none;">This field is required.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="address1">Address
											1 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custAddr1}"
												placeholder="Enter Address" id="address1" name="address1"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_address1"
												style="display: none;">This field is required.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="address2">Address
											2 : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custAddr2}"
												placeholder="Enter Address" id="address2" name="address2"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3"></div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="city">City
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custCity}"
												placeholder="Enter City" id="city" name="city"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_city"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="city">Pin
											code <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custPinCode}"
												placeholder="Enter Pin Code" id="pincode" name="pincode"
												autocomplete="off" onchange="trim(this)" maxlength="6">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_pincode"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="city">Nature
											of Business : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custBusinNatute}"
												placeholder="Enter Nature of Business" id="business"
												name="business" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3"></div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="salesType">DSC
											<span style="color: red">* </span>:
										</label>
										<div class="form-check form-check-inline">
											<label class="form-check-label"> <input type="radio" ${custHead.custIsDscAvail == 1 ? 'checked' : ''}
												class="form-check-input" name="dsc" id="dsc" checked
												value="1"> Available
											</label>
										</div>
										<div class="form-check form-check-inline">
											<label class="form-check-label"> <input type="radio" ${custHead.custIsDscAvail == 0 ? 'checked' : ''}
												class="form-check-input" name="dsc" id="dsc" value="0">
												Not Available
											</label>
										</div>
									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="city">File
											Path : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control" value="${custHead.custFolderId}"
												placeholder="Enter File Path" id="filePath" name="filePath"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3"></div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="city">File
											No. : </label>
										<div class="col-lg-6"> 
											<input type="text" class="form-control" value="${custHead.custFileNo}"
												placeholder="Enter File No." id="fileNo" name="fileNo"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3"></div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="city">Owner
											Partner :</label>
										<div class="col-lg-6">
											<!-- <input type="text" class="form-control"
												placeholder="Enter Owner Partner" id="ownerPartner"
												name="ownerPartner" autocomplete="off" onchange="trim(this)"> -->

											<select name="ownerPartner"
												data-placeholder="Select Owner Partner" id="ownerPartner"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

											<!-- 	<option value="">Select Owner Partner</option> -->
												<c:forEach items="${epmList}" var="epmList">
												 <c:choose>
														<c:when test="${epmList.empId==custHead.ownerEmpId}">
															<option selected value="${epmList.empId}">${epmList.empName}</option>
														</c:when>
														<c:otherwise>
															<option value="${epmList.empId}">${epmList.empName}</option>
														</c:otherwise>
													</c:choose> 
													
												</c:forEach>
												
											</select>

										</div>
										<div class="col-lg-3"></div>
									</div>


									<div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/customerList"><button
													type="button" class="btn btn-primary" id="cancelbtn">
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
	$('#aadhar').on('input', function() {
		  this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		});
	
		$(document)
				.ready(
						function($) {

							$("#submitInsertClient")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

											if($("#custType").val()==0){
												if (!$("#firmName").val()) {

													isError = true;

													$("#error_firmName").show()
													//return false;
												} else {
													$("#error_firmName").hide()
												} 
											}
											
												if (!$("#assesseeName").val()) {

													isError = true;

													$("#assesseeName").show()
													//return false;
												} else {
													$("#error_assesseName").hide()
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

														document.getElementById("submtbtn").disabled = true;
														document.getElementById("cancelbtn").disabled = true;
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
function showDiv(typdId){
	//alert("Id="+typdId);
		if (typdId == 1) {
			
			document.getElementById("ihide").style = "visible"
			document.getElementById("hideFirm").style = "display:none"
				
		} else if (typdId == 0) {
			document.getElementById("ihide").style = "display:none"
			document.getElementById("hideFirm").style = "visible"
	}
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