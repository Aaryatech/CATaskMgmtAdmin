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



			<!-- Content area -->
			<div class="content">

				<div class="row">
					<div class="col-md-12">

						<div class="page-header page-header-dark" style="background-color:info;">
							<div class="page-header-content header-elements-inline">
								<div class="page-title">
									<h5>
										<i class="icon-arrow-left52 mr-2"></i> Task ID -<span
											class="font-weight-semibold"> 1 </span> &nbsp;&nbsp; Name - <span
											class="font-weight-semibold"> GST </span> <small
											class="d-block opacity-75">Owner Partner - Prakash</small>
									</h5>
								</div>

								<div class="header-elements d-flex align-items-center">

									<div class="btn" style="background-color:white;">Pending</div>
								</div>
							</div>


							<div
								class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">

							</div>

						</div>

					</div>
				</div>



				<div class="row">
					<div class="col-md-8">

						<div class="card">
							<div class="card-header header-elements-inline">
								<h5 class="card-title">Communication & Logs</h5>
							</div>



							<!-- Basic layout -->

							<div class="card-body">




								<ul class="media-list media-chat media-chat-scrollable mb-3">

									<li
										class="media content-divider justify-content-center text-muted mx-0" >

										<div class="media-body" >

											<div align="center">

												<div class="media-chat-item" style="background-color:#CD5C5C; color:white;">Task Generated<br>- ABC</div>
												<div class="font-size-sm text-muted mt-2">
													 5/8/2018 6:22 pm <a href="#"><i
														class="icon-pin-alt ml-2 text-muted"></i></a>
												</div>
											</div>

										</div>
									</li>

									




									<li
										class="media content-divider justify-content-center text-muted mx-0">

										<div class="media-body">

											<div align="center">

												<div class="media-chat-item" style="background-color:#CD5C5C; color:white;">Employee Assigned<br>- ABC</div>
												<div class="font-size-sm text-muted mt-2">
													 6/8/2018 6:22 pm <a href="#"><i
														class="icon-pin-alt ml-2 text-muted"></i></a>
												</div>
											</div>

										</div>
									</li>



									<li class="media">
										<div class="mr-3">
											<a
												href="${pageContext.request.contextPath}/resources/global_assets/images/demo/images/3.png">
												<img
												src="${pageContext.request.contextPath}/resources/global_assets/images/noimageteam.png"
												class="rounded-circle" width="40" height="40" alt="">
											</a>
										</div>

										<div class="media-body">
											<div class="media-chat-item">Hello, Please take follow
												up.</div>
											<div class="font-size-sm text-muted mt-2">
												9/8/2018 6:22 pm <a href="#"><i
													class="icon-pin-alt ml-2 text-muted"></i></a>
											</div>
										</div>
									</li>

									<li class="media media-chat-item-reverse">
										<div class="media-body">
											<div class="media-chat-item">OK</div>
											<div class="font-size-sm text-muted mt-2">
												9/8/2018 6:30 pm <a href="#"><i
													class="icon-pin-alt ml-2 text-muted"></i></a>
											</div>
										</div>

										<div class="ml-3">
											<a href="../../../../global_assets/images/demo/images/3.png">
												<img
												src="${pageContext.request.contextPath}/resources/global_assets/images/face11.jpg"
												class="rounded-circle" width="40" height="40" alt="">
											</a>
										</div>
									</li>


								</ul>

								<textarea name="enter-message" class="form-control mb-3"
									rows="3" cols="1" placeholder="Enter your message..."></textarea>

								<div class="d-flex align-items-center">
									<!-- <div class="list-icons list-icons-extended">
												<a href="#" class="list-icons-item" data-popup="tooltip"
													data-container="body" title="Send photo"><i
													class="icon-file-picture"></i></a> <a href="#"
													class="list-icons-item" data-popup="tooltip"
													data-container="body" title="Send video"><i
													class="icon-file-video"></i></a> <a href="#"
													class="list-icons-item" data-popup="tooltip"
													data-container="body" title="Send file"><i
													class="icon-file-plus"></i></a>
											</div> -->

									<button type="button"
										class="btn bg-teal-400 btn-labeled btn-labeled-right ml-auto">
										<b><i class="icon-paperplane"></i></b> Send
									</button>
								</div>



							</div>
							<!-- /basic layout -->





						</div>

					</div>


					<div class="col-md-4">
						<div class="card">
							<div class="card-header header-elements-inline">
								<h5 class="card-title">Task Status Update</h5>
							</div>

							<div class="card-body">

								<div class="form-group row">
									<label class="col-form-label col-lg-12" for="status">
										Select Status <span style="color: red">* </span>:
									</label>
									<div class="col-lg-12">
										<select name="status" data-placeholder="Select Status"
											id="status"
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">

										</select>
									</div>
								</div>


								<div class="form-group row">
									<label class="col-form-label col-lg-12" for="remark">
										Enter Remark <span style="color: red">* </span>:
									</label>
									<div class="col-lg-12">
										<input type="text" class="form-control"
											placeholder="Enter Remark" id="remark" name="remark"
											autocomplete="off" onchange="trim(this)">
									</div>
								</div>

								<div class="form-group row">
									<button class="btn btn-primary">Update</button>
									<div class="form-group row"></div>

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

													if (!$("#firmName").val()) {

														isError = true;

														$("#error_firmName")
																.show()
														//return false;
													} else {
														$("#error_firmName")
																.hide()
													}

													if (!$("#panNo").val()
															|| !validatePAN($(
																	"#panNo")
																	.val())) {

														isError = true;

														$("#error_panNo")
																.show()

													} else {
														$("#error_panNo")
																.hide()
													}

													if (!$("#emailId").val()
															|| !validateEmail($(
																	"#emailId")
																	.val())) {

														isError = true;

														$("#error_emailId")
																.show()

													} else {
														$("#error_emailId")
																.hide()
													}

													if (!$("#phone").val()
															|| !validateMobile($(
																	"#phone")
																	.val())) {

														isError = true;

														$("#error_phone")
																.show()

													} else {
														$("#error_phone")
																.hide()
													}

													if (!$("#address1").val()) {

														isError = true;

														$("#error_address1")
																.show()

													} else {
														$("#error_address1")
																.hide()
													}

													if (!$("#city").val()) {

														isError = true;

														$("#error_city").show()

													} else {
														$("#error_city").hide()
													}

													if (!$("#pincode").val()) {

														isError = true;

														$("#error_pincode")
																.show()

													} else {
														$("#error_pincode")
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