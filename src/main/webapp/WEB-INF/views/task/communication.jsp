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



			<!-- Content area -->
			<div class="content">

				<div class="row">
					<div class="col-md-12">

						<table style="background-color: #4CAF50;" width="100%">

							<tr>
								<td style="color: white; padding: .8rem 1rem;" align="left"
									width="80%">
									<h5>
										Task ID -<span class="font-weight-semibold"> ${task.taskId} </span>
										&nbsp;&nbsp; Name - <span class="font-weight-semibold">${task.taskText}
											</span> <small class="d-block opacity-75">Owner Partner
											- Prakash</small>
									</h5>
								</td>
								<td style="color: white; padding: .8rem 1rem;">
									<div align="center">
										<div class="btn" style="background-color: white;">${task.taskStatus}</div>
										<normal class="d-block opacity-75" style="color: white;">Current
										Status</normal>
									</div>
								</td>
							</tr>

						</table>

						<br>


						<!-- <div class="page-header page-header-dark" style="height: 6rem;">
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
									<div align="center">
										<div class="btn" style="background-color: white;">Pending</div>
										<normal class="d-block opacity-75">Current Status</normal>
									</div>

								</div>
							</div>


							<div
								class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">

							</div>

						</div> -->

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


<style type="text/css">
.media-chat-scrollable {
	max-height: 209px;
	overflow: auto;
}

</style>



								<ul class="media-list media-chat media-chat-scrollable mb-3">


								<!-- 	<li
										class="media content-divider justify-content-center text-muted mx-0">Task
										Generated - ABC - 5/8/2018 6:22 pm</li> -->

									<li
										class="media content-divider justify-content-center text-muted mx-0">Employee
										Assigned - ABC - 5/8/2018 6:22 pm</li>


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
												up. <br>- A B Shinde</div>
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
											<a href="${pageContext.request.contextPath}/resources/global_assets/images/demo/images/3.png">
												<img
												src="${pageContext.request.contextPath}/resources/global_assets/images/face11.jpg"
												class="rounded-circle" width="40" height="40" alt="">
											</a>
										</div>
									</li>


								</ul>

								<!-- <textarea name="enter-message" class="form-control mb-3"
									rows="3" cols="1" placeholder="Enter your message..."></textarea>

								<div class="d-flex align-items-center">
							

									<button type="button"
										class="btn bg-teal-400 btn-labeled btn-labeled-right ml-auto">
										<b><i class="icon-paperplane"></i></b> Send
									</button>
								</div> -->
								
								
								<table width="100%">
									<tr>
										<td width="89%" ><textarea name="enter-message"
												class="form-control mb-3" rows="1" cols="1"
												placeholder="Enter your message..."></textarea></td>
										<td width="1%"></td>
										<td width="10%" align="right">
											<button type="button"
												class="btn bg-teal-400">
												<b><i class="icon-paperplane"></i></b>
											</button>
										</td>
									</tr>
								</table>



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
							<form action="${pageContext.request.contextPath}/updateTaskStatus" method="post" id="changeTask">
							<input type="hidden" value="${task.taskId}" id="taskId" name="taskId">
							
								<div class="form-group row">
									<label class="col-form-label col-lg-12" for="status">
										Select Status <span style="color: red">* </span>:
									</label>
									<div class="col-lg-12">
										<select name="status" data-placeholder="Select Status"
											id="status"
											class="form-control form-control-select2 select2-hidden-accessible"
											data-fouc="" aria-hidden="true">

											<option value="">Select Status</option>
											<c:forEach items="${statusList}" var="statusList" varStatus="count">
												<option value="${statusList.statusValue}">${statusList.statusText}</option>													
											</c:forEach>
										</select>
									</div>
								</div>


								<!-- <div class="form-group row">
									<label class="col-form-label col-lg-12" for="remark">
										Enter Remark <span style="color: red">* </span>:
									</label>
									<div class="col-lg-12">
										<input type="text" class="form-control"
											placeholder="Enter Remark" id="remark" name="remark"
											autocomplete="off" onchange="trim(this)">
									</div>
								</div> -->
								
								

								<div class="form-group row">
									<button class="btn btn-primary">Update</button>
									<div class="form-group row"></div>

								</div>
								<br><br>
								</form>
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