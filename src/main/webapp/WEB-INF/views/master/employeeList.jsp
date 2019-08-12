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
							<a href="" class="breadcrumb-item"><i class="icon-home2 mr-2"></i>
								Home</a> <span class="breadcrumb-item active"></span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>

					</div>
					<div class="breadcrumb justify-content-center">
						<%-- <c:if test="${addAccess == 0}"> 
							<a href="${pageContext.request.contextPath}/service"
								class="breadcrumb-elements-item"> Add Service </a>
						</c:if> --%>

					</div>

				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Employee</h5></td>
								<td width="40%" align="right"><a
									href="${pageContext.request.contextPath}/employeeAdd"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Add
											Employee</button>
								</a></td>
							</tr>
						</table>
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
									<th width="10%">Sr.no</th>
									<th>Profile Pic</th>
									<th>Employee Name</th>
									<th>Employee Type</th>
									<th>Date of Birth</th>
									<th>Official Email Id</th>
									<th>Contact No.</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>

							<tr>
								<td>1</td>
								<td class="text-center"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/face11.jpg"
									class="rounded-circle" width="36" height="36" alt=""></td>
								<td>ABC</td>
								<td>Owner</td>
								<td>15/08/1990</td>
								<td>abc@gmail.com</td>
								<td>9898989898</td>

								<td class="text-center"><a href="#" class="dropdown-item"><i
										class="icon-database-edit2"></i> Edit</a> <a href="#"
									class="dropdown-item"
									onClick="return confirm('Are you sure want to delete this record');"><i
										class="icon-trash"></i> Delete</a></td>

							</tr>

							<tr>
								<td>2</td>
								<td class="text-center"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/face11.jpg"
									class="rounded-circle" width="36" height="36" alt=""></td>
								<td>XYZ</td>
								<td>Manager</td>
								<td>10/05/1988</td>
								<td>xyz@gmail.com</td>
								<td>9898989898</td>

								<td class="text-center"><a href="#" class="dropdown-item"><i
										class="icon-database-edit2"></i> Edit</a> <a href="#"
									class="dropdown-item"
									onClick="return confirm('Are you sure want to delete this record');"><i
										class="icon-trash"></i> Delete</a></td>

							</tr>

							<tr>
								<td>3</td>
								<td class="text-center"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/face11.jpg"
									class="rounded-circle" width="36" height="36" alt=""></td>
								<td>PQR</td>
								<td>Employee</td>
								<td>25/12/1988</td>
								<td>pqr@gmail.com</td>
								<td>9898989898</td>

								<!-- <td><a href="" title="Edit"><i class="icon-pencil7"
										style="color: black;"></i></a> <a href=""
									onClick="return confirm('Are you sure want to delete this record');"
									title="Delete"><i class="icon-trash" style="color: black;"></i>
								</a></td> -->

								<td class="text-center"><a href="#" class="dropdown-item"><i
										class="icon-database-edit2"></i> Edit</a> <a href="#"
									class="dropdown-item"
									onClick="return confirm('Are you sure want to delete this record');"><i
										class="icon-trash"></i> Delete</a></td>

							</tr>

							<tbody>


								<c:forEach items="${compList}" var="compList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${compList.companyName}</td>
										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editCompany?compId=${compList.exVar1}"
													title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
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



		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>








	</div>
	<!-- /page content -->

</body>
</html>