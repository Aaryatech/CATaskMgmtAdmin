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
			<%-- <div class="page-header page-header-light">


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
					<div class="breadcrumb justify-content-center">
						<c:if test="${addAccess == 0}"> 
							<a href="${pageContext.request.contextPath}/service"
								class="breadcrumb-elements-item"> Add Service </a>
						</c:if>

					</div>

				</div>
			</div> --%>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Customer List </h5></td>
								<%-- <td width="40%" align="right">
								<c:if test="${addAccess==0}"><a
									href="${pageContext.request.contextPath}/customerAdd"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Add
											Customer</button>
								</a></c:if></td> --%>
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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
							
								<tr class="bg-blue">
							 		<th width="10%">Sr.no</th>
									<th>Firm Name</th>
									<!-- <th>Customer Group</th> -->
									<th>Assesse Name</th>
									<th>PAN No.</th>
									<th>Email</th>
									<th>Contact</th>
									<!-- <th class="text-center" width="10%">Actions</th> -->
								</tr>
							</thead>
							<c:forEach items="${custHeadList}" var="custHeadList" varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td>${custHeadList.custFirmName}</td>
								<%-- <td>${custHeadList.custGroupName}</td> --%>
								<td>${custHeadList.custAssesseeName}</td>
								<td>${custHeadList.custPanNo}</td>
								<td>${custHeadList.custEmailId}</td>
								<td>${custHeadList.custPhoneNo}</td>


								<%-- <td><c:if test="${custHeadList.isActive==1}"><a
									href="${pageContext.request.contextPath}/customerActivityAddMap?custId=${custHeadList.exVar1}"
									title="Map Activity"><i class="icon-add"
										style="color: black;"></i></a> </c:if>
										
										<a
									href="${pageContext.request.contextPath}/showCustomerActivityMap?custId=${custHeadList.exVar1}"
									title="Mapped Activity List"><i class="icon-three-bars""
										style="color: black;"></i></a>
										
									
										<c:if test="${deleteAccess==0}"><a href="${pageContext.request.contextPath}/deletCust?custId=${custHeadList.exVar1}"
									onClick="return confirm('Are you sure want to delete this record');"
									title="Delete"><i class="icon-trash" style="color: black;"></i>
								</a></c:if>
								<c:choose>
												<c:when test="${custHeadList.isActive==1}">
													<c:if test="${editAccess==0}">
										
										<a href="${pageContext.request.contextPath}/editCust?custId=${custHeadList.exVar1}" title="Edit"><i
										class="icon-pencil7" style="color: black;"></i></a></c:if>
													<a
														href="${pageContext.request.contextPath}/activeDeactiveCustomer?custId=${custHeadList.exVar1}"><i
														class="fas fa-toggle-on" title="Active" style="color:green;"></i> </a>
												</c:when>
												<c:otherwise>
													<a
														href="${pageContext.request.contextPath}/activeDeactiveCustomer?custId=${custHeadList.exVar1}"><i
														class="fas fa-toggle-off" title="Deactive"  style="color: red;"></i> </a>
												</c:otherwise>
											</c:choose>
								</td> --%>

							</tr>
							</c:forEach>
						

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