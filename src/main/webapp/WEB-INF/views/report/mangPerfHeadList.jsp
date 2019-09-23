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
								<td width="60%"><h5 class="card-title">Employee Manager Performance Report
										</h5></td>
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
						<form method="post" id="reportFormDet">
							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
								id="printtable1">
								<thead>

									<tr class="bg-blue">
										<th width="10%">Sr.no</th>
										<th>Employee name</th>
										<th>No of task</th>
										<th>Budgeted Time</th>
										<th>Actual Time in selected period</th>
										<th>Actual Till date</th>
										<th>Total available hrs</th>
										<th>Action</th>


									</tr>
								</thead>
								<c:forEach items="${progList}" var="progList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${progList.empName}</td>
										<td>${progList.taskCount}</td>
										<td>${progList.allWork}</td>
										<td>0</td>
										<td>${progList.actWork}</td>
										<td>0</td>
										<td><a href="#"
											onclick="getProgReport(0,'showMangPerfHeadListDetail',${progList.empId})"
											title="excel"><i class="icon-file-spreadsheet  "
												style="color: black;"></i></a></td>


									</tr>
								</c:forEach>



							</table>

							<input type="hidden" name="fromDate" id="fromDate"
								value="${fromDate}"> <input type="hidden" name="empId"
								id="empId" value="0"> <input type="hidden" name="toDate"
								id="toDate" value="${toDate}"> <input type="hidden"
								id="p" name="p" value="0">
								 <input type="hidden"
								id="emps" name="emps" value="${emps}">
								
								<a href="#"><button onclick="getProgReportNew(0,'showEmpAndMngPerformanceRep')"
													type="button" class="btn btn-primary" id="cancelbtn">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Excel
												</button></a>
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
	<!-- /page content -->

	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(prm, mapping,empId) {
			
			//alert("hii"+empId+prm+mapping);
			if (prm == 1) {
				document.getElementById("p").value = "1";
			}

			document.getElementById("empId").value = empId;
			
			var form = document.getElementById("reportFormDet");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "post");

			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");

			form.submit();
			
			document.getElementById("p").value = "0";
			document.getElementById("empId").value = "0";
		}
	</script>
	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReportNew(prm, mapping) {
			alert("hii");
			if (prm == 1) {
				document.getElementById("p").value = "1";
			}

		
			
			var form = document.getElementById("reportFormDet");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "post");

			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");

			form.submit();
			
			document.getElementById("p").value = "0";
		}
	</script>

</body>
</html>