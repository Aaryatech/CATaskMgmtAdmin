<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_basic.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/dashboard.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/plugins/visualization/echarts/echarts.min.js"></script>



<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,300,600,800,900"
	rel="stylesheet" type="text/css">
<c:url var="getCapacityBuildingDetail" value="getCapacityBuildingDetail" />
<c:url var="getTaskStatusbreakdownList"
	value="getTaskStatusbreakdownList" />
<c:url var="showManagerDetail" value="showManagerDetail" />
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
			<div class="page-header page-header-light" style="display: none;">


				<div class="row">
					<div class="col-sm-12">
						<div class="progress">
							<div class="progress-bar bg-success" style="width: 35%">
								<span>35% Complete</span>
							</div>
						</div>
					</div>
				</div>





			</div>
			<!-- /page header -->


			<style type="text/css">
h5 {
	margin-bottom: 0;
}
</style>


			<!-- Content area -->
			<div class="content">




				<style type="text/css">
.datatable-footer {
	display: none;
}

.dataTables_length {
	display: none;
}

.datatable-header {
	display: none;
}
</style>






				<!-- Capacity Details -->
				<!-- <div class="card">
					<div class="card-header header-elements-sm-inline">
						<h6 class="card-title">Capacity Details</h6>
						<div class="header-elements">
							<a
								class="text-default daterange-ranges font-weight-semibold cursor-pointer dropdown-toggle">
								<i class="icon-calendar3 mr-2"></i> <span></span>
							</a>
						</div>
					</div>

					<div class="card-body ">


						<div class="row">

							<div class=" col-sm-3 d-flex align-items-center mb-3 mb-md-0">
								<a href="#"
									class="btn bg-transparent border-indigo-400 text-indigo-400 rounded-round border-2 btn-icon">
									<i class="icon-alarm-add"></i>
								</a>
								<div class="ml-3">
									<h5 class="font-weight-semibold mb-0">1,132</h5>
									<span class="text-muted">Budgeted Capacity</span>
								</div>
							</div>

							<div class=" col-sm-3 d-flex align-items-center mb-3 mb-md-0">
								<a href="#"
									class="btn bg-transparent border-indigo-400 text-indigo-400 rounded-round border-2 btn-icon">
									<i class="icon-tree7"></i>
								</a>
								<div class="ml-3">
									<h5 class="font-weight-semibold mb-0">1,132</h5>
									<span class="text-muted">Allocated Capacity</span>
								</div>
							</div>

							<div class=" col-sm-3 d-flex align-items-center mb-md-0">
								<a href="#"
									class="btn bg-transparent border-indigo-400 text-indigo-400 rounded-round border-2 btn-icon">
									<i class=icon-history></i>
								</a>
								<div class="ml-3">
									<h5 class="font-weight-semibold mb-0">06:25:00</h5>
									<span class="text-muted">Actual Hours Worked</span>
								</div>
							</div>



							<div class=" col-sm-3 align-items-center "
								style="margin-top: 15px;">
								<div class="progress rounded-round">
									<div class="progress-bar bg-success" style="width: 35%">
										<span>35% Complete</span>
									</div>
								</div>

							</div>


						</div>
					</div>
					card body


				</div> -->
				<!-- /support tickets -->
 
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Task Status breakdown</h5>

					</div>
					<div class="card-body">

						<div id="loader1" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<div class="table-responsive">
							<table class="table text-nowrap" id="breakdownTab">
								<thead>
									<tr>
										<th style="background-color: white; width: 150px">Manager
											Name</th>
										<th style="background-color: white; width: 150px">Status
											Wise Task Data</th>
										<th style="background-color: white; width: 50px;">Overdue</th>
										<th style="background-color: white; width: 50px">Due
											Today</th>
										<th style="background-color: white; width: 50px">Due this
											Week</th>
										<th style="background-color: white; width: 50px">Due this
											Month</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${stswisetaskList}" var="stswisetaskList"
										varStatus="count">

										<c:forEach items="${stswisetaskList.list}" var="list">
											<c:if
												test="${list.overdeu>0 || list.duetoday>0 || list.week>0 || list.month>0}">

												<tr>
													<td><a href="#"
														onclick="showManagerDetail(${list.statusValue},${stswisetaskList.empId},'${list.statusText}')">${stswisetaskList.empName}</a></td>

													<td>${list.statusText}</td>
													<td><c:choose>
															<c:when test="${list.overdeu>0}">
																<a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=1&empId=${stswisetaskList.empId}">${list.overdeu}</a>
															</c:when>
															<c:otherwise>
																	${list.overdeu}
														</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${list.duetoday>0}">
																<a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=2&empId=${stswisetaskList.empId}">${list.duetoday}</a>
															</c:when>
															<c:otherwise>
																	${list.duetoday}
														</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${list.week>0}">
																<a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=3&empId=${stswisetaskList.empId}">${list.week}</a>
															</c:when>
															<c:otherwise>
																	${list.week}
														</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${list.month>0}">
																<a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=4&empId=${stswisetaskList.empId}">${list.month}</a>
															</c:when>
															<c:otherwise>
																	${list.month}
														</c:otherwise>
														</c:choose></td>


												</tr>
											</c:if>
										</c:forEach>

									</c:forEach>

								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- Hover rows -->
				<!-- Daily Work Log modal -->
				<div id="modal_small" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header bg-success">
								<h5 class="modal-title">
									<span id="taskststext"></span>
								</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div id="showManagerDetailloader" style="display: none;">
								<img
									src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table class="table text-nowrap" id="taskDetailTab">
									<thead>
										<tr>
											<th style="background-color: white; width: 150px">Employee
												Name</th>

											<th style="background-color: white; width: 50px;">Overdue</th>
											<th style="background-color: white; width: 50px">Due
												Today</th>
											<th style="background-color: white; width: 50px">Due
												this Week</th>
											<th style="background-color: white; width: 50px">Due
												this Month</th>

										</tr>
									</thead>
								</table>
							</div>


							<div class="modal-footer" style="display: none;">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
								<button type="button" class="btn bg-primary">Save
									changes</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /Daily Work Log modal -->

				<!-- /highlighting rows and columns -->

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
	<!-- /page content -->

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
		function showManagerDetail(value,empId, taskststext) {

			document.getElementById("taskststext").innerHTML = taskststext;
			 $("#showManagerDetailloader").show();
			 $('#modal_small').modal('show');
			 
			  $.getJSON('${showManagerDetail}', {
				status : value,
				empId : empId,
				ajax : 'true',

			}, function(data) {

				/* $("#taskDetailTab tbody").empty(); */

				var dataTable = $('#taskDetailTab').DataTable();
				dataTable.clear().draw();
				
				  $.each(data, function(i, v) {
					  
					/* var tr_data = '<tr>'
						+ '<td  >'
						+ v.empName
						+ '</td>'
						+ '<td  >'
						+ v.overdeu
						+ '</td>'
						+ '<td  >'
						+ v.duetoday
						+ '</td>'
						+ '<td  >'
						+ v.week
						+ '</td>'
						+ '<td  >'
						+ v.month 
						+ '</td>'
						+ '</tr>';
				$(
						'#taskDetailTab'
								+ ' tbody')
						.append(tr_data);
				alert(tr_data) */
				
				dataTable.row.add(
						[  
						  v.empName,
						  v.overdeu,
						  v.duetoday,
						  v.week,v.month
						
						]).draw();
				
				});  
				
				
				$("#showManagerDetailloader").hide();
			});  

			
		}
	</script>


</body>
</html>