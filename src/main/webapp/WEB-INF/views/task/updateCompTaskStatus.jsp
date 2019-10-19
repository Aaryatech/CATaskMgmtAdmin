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
		<!-- 	<div class="page-header page-header-light">


				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a>  
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>


				</div>
			</div> -->
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
								<h6 class="card-title">Update Completed Task Status</h6>
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
									action="${pageContext.request.contextPath}/updateCompletdStatus"
									id="submitInsertActivity" method="post">

									<input type="hidden" id="taskId" name="taskId"
										value="${task.taskId}">

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="service">
											Task Name : </label>
										<div class="col-lg-4">

											<input type="text" class="form-control"
												placeholder="Service Name" id="serviceName"
												value="${task.taskText}" name="serviceName"
												autocomplete="off" onchange="trim(this)" readonly="readonly">
 
										</div>
</div>
<div class="form-group row">
										<label class="col-form-label col-lg-2" for="service">
											Status : </label>
										<div class="col-lg-4">

											<select name="isStatus" id="isStatus"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1" ${task.exInt2 == 1 ? 'selected' : ''}>Non Billable</option>
												<option value="2" ${task.exInt2 == 2 ? 'selected' : ''}>Invoiced</option>
												<option value="3" ${task.exInt2 == 3 ? 'selected' : ''}>-</option>


											</select>

										</div>
									</div>

									<br>
									 
									 
									<div class="form-group row mb-0">
										<div class="col-lg-12" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/completedTaskList"><button
													type="button" class="btn btn-primary">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>
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
<script type="text/javascript">
 $(document).ready(
			function() {
				//$('#bootstrap-data-table-export').DataTable();

				$("#selAll").click(
						function() {
							$('#printtable2 tbody input[type="checkbox"]')
									.prop('checked', this.checked);
						});
			});
	
	</script>
 <script type="text/javascript">
	function activityAdd(serviceId){
		alert(serviceId);
		document.getElementById("map_service_id").value=serviceId;//create this 
		var form=document.getElementById("service_list");
	    form.setAttribute("method", "post");

		form.action=("activityAdd");
		form.submit();
		
	}
	</script>

</body>
</html>