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

								<form action="${pageContext.request.contextPath}/addNewEmployee"
									id="submitInsertClient" method="post"
									enctype="multipart/form-data">

									<input type="hidden" value="${employee.empId}"
										name="employee_id">
										
										<input type="hidden" value="${employee.empPic}"
										name="profPic">
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="profilePic">
											Profile Pic :</label>
										<div class="col-lg-6">
											<div class="input-group-btn  ">
												<c:if test="${not empty employee.empPic}">
													<img src="${imageUrl}${employee.empPic}"
														style="width: 200px; height: auto;">
												</c:if>

												<span class="filename" style="user-select: none1;"><img
													id="temppreviewimageki1" name="image1"
													class="temppreviewimageki1" alt="l"
													style="width: 200px; height: auto; display: none"> </span>
												<!-- image-preview-clear button -->
												<button type="button" title="Clear selected files"
													class="btn btn-default btn-secondary fileinput-remove fileinput-remove-button legitRipple image-preview-clear image-preview-clear1"
													id="1" style="display: none;">
													<i class="icon-cross2 font-size-base mr-2"></i> Clear
												</button>

												<div class="btn btn-primary btn-file legitRipple">
													<i class="icon-file-plus"></i> <span class="hidden-xs">Browse</span><input
														type="file" class="file-input browseimage browseimage1"
														data-fouc="" id="1" name="profilePic"
														accept=".jpg,.png,.gif">
												</div>
											</div>


										</div>

										<div class="col-lg-3"></div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="empType">Type
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="empType"
												data-placeholder="Select Employee Type" id="empType"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="">Select Employee Type</option>
												<option value="1" ${employee.empType == 1 ? 'selected' : ''}>Admin</option>
												<option value="2" ${employee.empType == 2 ? 'selected' : ''}>Partner</option>
												<option value="3" ${employee.empType == 3 ? 'selected' : ''}>Manager</option>
												<option value="4" ${employee.empType == 4 ? 'selected' : ''}>Team
													Leader</option>
												<option value="5" ${employee.empType == 5 ? 'selected' : ''}>Employee</option>


												<%-- <c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach> --%>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empType"
												style="display: none;">Please select employee type.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="empService">Service
											: </label>
										<div class="col-lg-6">
											<select name="empService" multiple="multiple"
												data-placeholder="Select Employee Service" id="empService"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">


												<c:forEach items="${serviceList}" var="serviceId">
													<c:set var="find" value="0"></c:set>
													<c:forEach items="${empSrvcIds}" var="empSrvcIds">
														<c:choose>
															<c:when test="${serviceId.servId==empSrvcIds}">
																<option Selected value="${serviceId.servId}">${serviceId.servName}</option>
																<c:set var="find" value="1"></c:set>

															</c:when>
														</c:choose>
													</c:forEach>
													<c:if test="${find==0}">
														<option value="${serviceId.servId}">${serviceId.servName}</option>
													</c:if>
												</c:forEach>


											</select>
										</div>
										<div class="col-lg-3">
											<!-- <span class="validation-invalid-label" id="error_empService"
												style="display: none;">Please select service.</span> -->
										</div>

									</div>


									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="empName">
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${employee.empName}" placeholder="Enter Name"
												id="empName" name="empName" autocomplete="off"
												onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empName"
												style="display: none;">Please enter name.</span>
										</div>

									</div>

									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="empNickname">Nick
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${employee.empNickname}"
												placeholder="Enter Nick Name" id="empNickname"
												name="empNickname" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empNickname"
												style="display: none;">Please enter nick name.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="dob">Date
											of Birth <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass"
												value="${employee.empDob}" placeholder="Enter Date of Birth"
												id="dob" name="dob" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_dob"
												style="display: none;">Please Enter Date of Birth Properly.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="phone">Contact
											Number <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${employee.empMob}"
												placeholder="Enter Contact Number" id="phone" name="phone"
												autocomplete="off"
												oninput="validateMobileEnterOnlyDigits(this)" maxlength="10">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_phone"
												style="display: none;">Please enter contact number.</span>
										</div>
									</div>

									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="empSal">
											Salary Per Month <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${employee.empSalary}" placeholder="Salary Per Month"
												id="empSal" name="empSal" autocomplete="off"
												onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empSal"
												style="display: none;">Please enter salary per month.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="email">Email
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${employee.empEmail}"
												placeholder="Enter Email Address" id="email" name="email"
												autocomplete="off" onchange="trim(this)">

										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_email"
												style="display: none;">Please enter email.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="pwd">Password
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" name="pwd" id="pwd"
												placeholder="Enter Password" value="${employee.empPass}">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_pwd"
												style="display: none;">Please enter password.</span>
										</div>
									</div>
									
									<c:if test="${isEdit==1}">
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="roleId">Role
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="roleId"
												data-placeholder="Select Employee Role" id="roleId"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="">Select Employee Type</option>	
												 <c:forEach items="${createdRoleList}" var="roleList">
													<c:choose>
													 <c:when test="${roleList.roleId==employee.empRoleId}">
														<option  Selected value="${roleList.roleId}">${roleList.roleName}</option>
													</c:when>												
													<c:otherwise>
														<option value="${roleList.roleId}">${roleList.roleName}</option>
													</c:otherwise>	
													</c:choose>											
												</c:forEach> 
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empType"
												style="display: none;">Please select employee type.</span>
										</div>

									</div>
									</c:if>

									<div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/employeeList"><button
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
	
	<script type="text/javascript">
	
	
	</script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>


	<script>
		$('#empSal').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$(document).ready(function($) {

			$("#submitInsertClient").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if ($("#empType").val() == "") {

					isError = true;

					$("#error_empType").show()
					//return false;
				} else {
					$("#error_empType").hide()
				}

				/* if (!$("#empService").val() || $("#empService").val()=="") {

					isError = true;

					$("#error_empService").show()

				} else {
					$("#error_empService").hide()
				}  */

				if (!$("#empNickname").val()) {

					isError = true;

					$("#error_empNickname").show()

				} else {
					$("#error_empNickname").hide()
				}

				if (!$("#empName").val()) {

					isError = true;

					$("#error_empName").show()

				} else {
					$("#error_empName").hide()
				}

				if (!$("#empSal").val()) {

					isError = true;

					$("#error_empSal").show()

				} else {
					$("#error_empSal").hide()
				}

				if (!$("#email").val() || !validateEmail($("#email").val())) {

					isError = true;

					$("#error_email").show()

				} else {
					$("#error_email").hide()
				}

				if (!$("#phone").val() || !validateMobile($("#phone").val())) {

					isError = true;

					$("#error_phone").show()

				} else {
					$("#error_phone").hide()
				}

				if (!$("#pwd").val()) {

					isError = true;

					$("#error_pwd").show()

				} else {
					$("#error_pwd").hide()
				}
				
				if (!$("#dob").val() ||  !checkDOB($("#dob").val())) {

					isError = true;

					$("#error_dob").show()

				} else {
					$("#error_dob").hide()
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
		function checkDOB(dateEntered) {
		//	alert("hii"+dateEntered);
			var date = dateEntered.substring(0, 2);
			var month = dateEntered.substring(3, 5);
			var year = dateEntered.substring(6, 10);

			var dateToCompare = new Date(year, month - 1, date);
			var currentDate = new Date();

			if (dateToCompare > currentDate) {
				//alert("Please enter DOB less than Current Date ");
				return false;
				document.getElementById('dob').value = "";
			}
			return true;
		}
		
		function validateEmail(email) {

			var eml = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

			if (eml.test($.trim(email)) == false) {

				return false;

			}

			return true;

		}
		function validateMobile(mobile) {
			var mob = /^[1-9]{1}[0-9]{9}$/;

			if (mob.test($.trim(mobile)) == false) {

				//alert("Please enter a valid email address .");
				return false;

			}
			return true;

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
	<script type="text/javascript">
		function readURL(input) {
			/* 
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#image1').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			} */
		}

		$("#profilePic").change(function() {

			//readURL(this);
		});

		$(function() {

			//image 1
			// Create the close button

			// Clear event
			$('.image-preview-clear').click(function() {
				var imgid = $(this).attr('id');

				$('.browseimage' + imgid).val("");
				$('.image-preview-clear' + imgid).hide();

				//$('.image-preview-input-title'+imgid).text("Browse"); 
				$('.temppreviewimageki' + imgid).attr("src", '');
				$('.temppreviewimageki' + imgid).hide();
			});
			// Create the preview image
			$(".browseimage").change(
					function() {
						var img = $('<img/>', {
							id : 'dynamic',
							width : 250,
							height : 200,
						});
						var imgid = $(this).attr('id');
						var file = this.files[0];
						var reader = new FileReader();
						// Set preview image into the popover data-content
						reader.onload = function(e) {

							//	$('.image-preview-input-title'+imgid).text("Change");
							$('.image-preview-clear' + imgid).show();
							//	$('.image-preview-filename'+imgid).val(file.name);   
							img.attr('src', e.target.result);

							$(".temppreviewimageki" + imgid).attr("src",
									$(img)[0].src);
							$(".temppreviewimageki" + imgid).show();

						}
						reader.readAsDataURL(file);
					});
			//end  
		});
	</script>

</body>
</html>