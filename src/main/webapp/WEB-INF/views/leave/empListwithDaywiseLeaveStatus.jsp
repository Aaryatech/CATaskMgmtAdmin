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
			<!-- <div class="page-header page-header-light">

				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>

						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>

				</div>
			</div> -->
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Employee Leave Record</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div>
						</div> -->
					</div>

					<div class="card-body">
						<form
							action="${pageContext.request.contextPath}/empListwithDaywiseLeaveStatus"
							id="submitInsertLeave" method="get">
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
									out.println(session.getAttribute("errorMsg"));
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
									out.println(session.getAttribute("successMsg"));
								%>
							</div>
							<%
								session.removeAttribute("successMsg");
								}
							%>

							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="fromDate">Select
									Date <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<input type="text" class="form-control daterange-basic_new"
										placeholder="From Date" id="fromDate" name="fromDate"
										autocomplete="off" onchange="trim(this)"
										value="${fromDate}">
								</div>

								 <div class="col-lg-3">
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">Search</button>
								</div>

							</div>
							 

							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
								id="printtable1">
								<thead>
									<tr class="bg-blue">
										<th width="5%">Sr. No.</th>
										<th>Employee Name</th>

										<c:forEach items="${empListWithDateList.dateslist}"
											var="dateslist">
											<th>${dateslist}</th>
										</c:forEach>

									</tr>
								</thead>
								<tbody>

									<c:forEach
										items="${empListWithDateList.empListWithDateWiseDetailLst}"
										var="list" varStatus="count">
										<tr>
											<td>${count.index+1}</td>
											<td width="30%">${list.empName}</td>
											<c:forEach items="${list.atndsList}" var="atndsList">
												<c:choose>
													<c:when test="${atndsList.sts eq 'AB'}">
														<td style="background-color: red;color: white;">${atndsList.sts}</td>
													</c:when>
													<c:when test="${atndsList.sts eq 'HO'}">
														<td style="background-color:green;color: white;">${atndsList.sts}</td>
													</c:when>
													<c:when test="${atndsList.sts eq 'H'}">
														<td style="background-color:yellow;">${atndsList.sts}</td>
													</c:when>
													<c:otherwise>
														<td>${atndsList.sts}</td>
													</c:otherwise>
												</c:choose>


											</c:forEach>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</form>
					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
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
</body>
</html>