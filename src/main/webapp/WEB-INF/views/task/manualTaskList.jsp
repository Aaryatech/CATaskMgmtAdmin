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
							<a href="#" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active"></span>
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
								<td width="60%"><h5 class="card-title">Manual Task
										List</h5></td>
								<td width="40%" align="right"></td>
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
									<th>Customer Name</th>
									<th>Service Name</th>
									<th>Task Text</th>
									<th>Team</th>
									<th>Statutory Due Date</th>
									<th>Work Date</th>
									<th>Periodicity</th>

									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>
							<c:forEach items="${taskList}" var="taskList" varStatus="count">
								<tr>
									<td>${count.index+1}</td>
									<td>${taskList.custFirmName}</td>
									<td>${taskList.servName}</td>
									<td>${taskList.taskText}</td>
									<td>${taskList.employees}</td>
 									<td>${taskList.taskStatutoryDueDate}</td>
									<td>${taskList.taskEndDate}</td>
									<td>${taskList.periodicity_name}</td>

									<td><a
										href="${pageContext.request.contextPath}/updateManualTaskStatus?taskId=${taskList.exVar1}&stat=1"
										title="Approve Task"><i class="icon-checkmark4 "
											style="color: black;"></i></a> &nbsp; <a
										href="${pageContext.request.contextPath}/updateManualTaskStatus?taskId=${taskList.exVar1}&stat=0"
										title="Disapprove Task"><i class="icon-cancel-square"
											style="color: black;"></i></a> &nbsp;<c:if test="${editAccess == 0}"> <a
										href="${pageContext.request.contextPath}/editTask?taskId=${taskList.exVar1}&flag=1"
										title="Edit Task"><i 	class="icon-pencil7"  style="color: black;"
											></i></a></c:if></td>

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