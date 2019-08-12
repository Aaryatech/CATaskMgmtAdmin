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
								class="breadcrumb-item active">Activity</span>
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
								<h6 class="card-title">Add Activity</h6>
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

								<form
									action="${pageContext.request.contextPath}/submitInsertActivity"
									id="submitInsertActivity" method="post"
									enctype="multipart/form-data">

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Service : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Service Name" id="serviceName"
												name="serviceName" autocomplete="off" onchange="trim(this)">
										</div>
									</div>

									<hr>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="activityName">Activity
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Activity Name" id="activityName"
												name="activityName" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label"
												id="error_activityName" style="display: none;">This
												field is required.</span>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="serviceDesc">
											Periodicity : </label>
										<div class="col-lg-6">
											<select id="periodicity" name="periodicity"
												class="form-control">
												<option value="">select</option>
											</select>


										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="serviceDesc">Activity
											Description : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Activity Description" id="activityDesc"
												name="activityDesc" autocomplete="off" onchange="trim(this)">
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
												href="${pageContext.request.contextPath}/showCompanyList"><button
													type="button" class="btn btn-primary">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div>

									<br>
									<div class="form-group row">
										<table
											class="table table-bordered table-hover datatable-highlight1 "
											id="printtable1">
											<thead>
												<tr class="bg-blue">
													<th width="10%">Sr.no</th>
													<th>Activity Name</th>
													<th>Description</th>
													<th>Periodicity</th>
													<th class="text-center" width="10%">Actions</th>
												</tr>
											</thead>

											<tr>
												<td>1</td>
												<td>Return Filing</td>
												<td>Return Filing</td>
												<td>Return Filing</td>
												<td><a href="" title="Edit"><i class="icon-pencil7"
														style="color: black;"></i></a> <a href=""
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
														style="color: black;"></i> </a></td>
											</tr>

											<tr>
												<td>2</td>
												<td>Revised Return Filing</td>
												<td>Revised Return Filing</td>
												<td>Return Filing</td>
												<td><a href="" title="Edit"><i class="icon-pencil7"
														style="color: black;"></i></a> <a href=""
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
														style="color: black;"></i> </a></td>
											</tr>

											<tr>
												<td>3</td>
												<td>Tax Payment</td>
												<td>Tax Payment</td>
												<td>Return Filing</td>
												<td><a href="" title="Edit"><i class="icon-pencil7"
														style="color: black;"></i></a> <a href=""
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
														style="color: black;"></i> </a></td>
											</tr>

											<%-- <tbody>

								<c:forEach items="${compList}" var="compList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${compList.companyName}</td>
										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editCompany?compId=${compList.exVar1}"
													title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/deleteCompany?compId=${compList.exVar1}"
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
													style="color: black;"></i> </a>
											</c:if></td>
									</tr>
								</c:forEach>

							</tbody> --%>
										</table>
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