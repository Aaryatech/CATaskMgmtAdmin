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

<c:url var="getClientList" value="getClientList" />
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
			<style type="text/css">
h5 {
	margin-bottom: 0;
}

.btn {
	max-height: 38px !important;
}
</style>


			<!-- Content area -->
			<div class="content">
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Employee Performance-
Total Capacity Utilization</h5>

					</div>
					<div class="card-body">
						<form
							action="${pageContext.request.contextPath}/getAllEmployeeCapacityDetail"
							id="submitInsertActivity" method="get">
							<div class="form-group row">

								<label class="col-form-label col-lg-2" for="monthyear">Select
									Date <span style="color: red">* </span>:
								</label>
								<div class="col-lg-2">
									<input type="text" class="form-control daterange-basic_new"
										id="monthyear" name="monthyear" value="${yearrange}">
								</div>
								<!-- <div class="col-lg-1"></div> -->
								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">Search</button>

								<!-- <div class="col-lg-1"></div> -->
								<a
									href="${pageContext.request.contextPath}/getAllEmployeeCapacityDetailExcel"><button
										type="button" id="excel" class="btn bg-blue ml-3 legitRipple">Excel
									</button></a>

							</div>
							<!-- 							<div class="form-group row"></div>
 -->

							<input type="hidden" name="fromDate" id="fromDate"
								value="${fromDate}"> <input type="hidden" name="toDate"
								id="toDate" value="${toDate}">

							<div id="loader" style="display: none;">
								<img
									src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>
						</form>



						<div class="table-responsive">
							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
								id="capTable">
								<thead>
									<tr class="bg-blue">
										<th>Sr.No.</th>
										<th>Employee Name</th>
										<th>Budgeted Capacity</th>
										<th>Alloted Capacity</th>
										<th>Utilized Capacity</th>
										<th>Budgeted vs Alloted</th>
										<th>Budgeted vs Utilized</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${empCapList}" var="empCapList"
										varStatus="count">
										<tr>
											<td>${count.index+1}</td>
											<td>${empCapList.empName}</td>
											<td>${empCapList.bugetedCap}</td>
											<td>${empCapList.allWork}</td>
											<td>${empCapList.actWork}</td>
											<c:set var="color-a" value=""></c:set>
											<c:set var="color-b" value=""></c:set>
											<c:set var="a"
												value="${empCapList.bugetedCap-empCapList.allWork}"></c:set>
											<c:set var="b"
												value="${empCapList.bugetedCap-empCapList.actWork}"></c:set>

											<c:choose>
												<c:when test="${a > 0}">
													<td style="background-color: red;"><fmt:formatNumber
															type="number" maxFractionDigits="3"
															value="${empCapList.bugetedCap-empCapList.allWork}" /></td>
												</c:when>
												<c:when test="${a < 0}">
													<td style="background-color: green;"><fmt:formatNumber
															type="number" maxFractionDigits="3"
															value="${empCapList.bugetedCap-empCapList.allWork}" /></td>
												</c:when>
												<c:otherwise>
													<td><fmt:formatNumber type="number"
															maxFractionDigits="3"
															value="${empCapList.bugetedCap-empCapList.allWork}" /></td>
												</c:otherwise>
											</c:choose>




											<c:choose>
												<c:when test="${b > 0}">
													<td style="background-color: red;"><fmt:formatNumber
															type="number" maxFractionDigits="3"
															value="${empCapList.bugetedCap-empCapList.actWork}" /></td>
												</c:when>
												<c:when test="${b < 0}">
													<td style="background-color: green;"><fmt:formatNumber
															type="number" maxFractionDigits="3"
															value="${empCapList.bugetedCap-empCapList.actWork}" /></td>
												</c:when>
												<c:otherwise>
													<td><fmt:formatNumber type="number"
															maxFractionDigits="3"
															value="${empCapList.bugetedCap-empCapList.actWork}" /></td>
												</c:otherwise>
											</c:choose>

											<%-- <c:if test="${b > 0}">
												<c:set var="color-b" value="red"></c:set>
											</c:if>
											<c:if test="${b < 0}">
												<c:set var="color-b" value="green"></c:set>
											</c:if>

											<td style="background-color: ${color-b}"><fmt:formatNumber
													type="number" maxFractionDigits="3"
													value="${empCapList.bugetedCap-empCapList.actWork}" /></td>
 --%>


											<%-- 											<td>${empCapList.bugetedCap-empCapList.actWork}</td>
 --%>
										</tr>
									</c:forEach>


								</tbody>
							</table>

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
	<!-- /page content -->

	<script type="text/javascript">
		function chkData() {
			var x = document.getElementById("capTable").rows.length;
			//alert(x);
			if (x == 1) {

				document.getElementById("excel").disabled = true;
			}
		}
	</script>



	<script type="text/javascript">
		//datepickermonth
		// Single picker
		$('.datepickermonth').daterangepicker({
			singleDatePicker : true,

			showDropdowns : true,
			locale : {
				format : 'MM-YYYY'
			}

		});
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