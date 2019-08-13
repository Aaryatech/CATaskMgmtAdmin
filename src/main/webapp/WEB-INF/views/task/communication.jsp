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
								<h6 class="card-title">Task Communication</h6>
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





								<!-- Basic layout -->

									<div class="card-body">
										<ul class="media-list media-chat media-chat-scrollable mb-3">
											<li
												class="media content-divider justify-content-center text-muted mx-0">Monday,
												Feb 10</li>

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
													<div class="media-chat-item">Hello, Please take follow up.</div>
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
													<a
														href="../../../../global_assets/images/demo/images/3.png">
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

													$("#error_firmName").show()
													//return false;
												} else {
													$("#error_firmName").hide()
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