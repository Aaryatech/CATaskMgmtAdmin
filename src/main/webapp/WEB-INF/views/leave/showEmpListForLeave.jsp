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
			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Employee List</h5>
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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">
									<th width="5%">Sr.no</th>
									<th>Name</th>
									<th>Email</th>
									<th>Mobile</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${empList}" var="empList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${empList.empName}</td>
										<td>${empList.empEmail}</td>
										<td>${empList.empMob}</td>
										<td class="text-center"><a
											href="${pageContext.request.contextPath}/leaveApply?empId=${empList.exVar1}"
											title="Add Leave" class=" "><i class="fas fa-walking"
												style="color: black;"></i></a> <a
											href="${pageContext.request.contextPath}/showLeaveHistList?empId=${empList.exVar1}"
											title="Leave History"><i class="icon-history"
												style="color: black;"></i></a></td>
									</tr>
								</c:forEach>


							</tbody>
						</table>
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
	<!-- /page content -->

</body>
</html>