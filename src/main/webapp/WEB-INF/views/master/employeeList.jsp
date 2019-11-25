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
							<a href="" class="breadcrumb-item"><i class="icon-home2 mr-2"></i>
								Home</a> <span class="breadcrumb-item active"></span>
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
								<td width="60%"><h5 class="card-title">Employee ${sessionScope.errorMsg}</h5></td>
								<td width="40%" align="right">
								
								</td>
							</tr>
						</table>
					</div>
					<form method="post" id="employee_list">
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
									<th>Profile Pic</th> 
									<th>Employee Name</th>
									<th>Employee Type</th>
									<th>Date of Birth</th>
									<th>Official Email Id</th>
									<th>Contact No.</th>
									<th>Is Active</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>

							<c:forEach items="${epmList}" var="epmList" varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td class="text-center">
								
								 
									
									<c:if test="${not empty epmList.empPic}">
													<img src="${imageUrl}${epmList.empPic}"
														class="rounded-circle" width="36" height="36" alt="">
												</c:if>
									</td> 
								<td>${epmList.empName}</td>
								<td>${epmList.empType==1 ? 'Admin': epmList.empType==2 ? 'Partner' : epmList.empType==3 ? 'Manager' : epmList.empType==4 ? 'Team Leader' : epmList.empType==5 ? 'Employee' : ''}</td> 
								<td>${epmList.empDob}</td>
								<td>${epmList.empEmail}</td>
								<td>${epmList.empMob}</td>
								<td>${epmList.isActive==1 ? 'Yes': epmList.isActive==0 ? 'No' : ''}</td> 

								<td><c:if test="${editAccess==0}"><a href="${pageContext.request.contextPath}/editEmployee?empId=${epmList.empId}" title="Edit"><i class="icon-pencil7"
										style="color: black;"></i></a></c:if> 
								
									<c:if test="${deleteAccess==0}"><a href="${pageContext.request.contextPath}/deleteEmployee?empId=${epmList.exVar1}"
									onClick="return confirm('Are you sure want to delete this record');"
									title="Delete"><i class="icon-trash" style="color: black;"></i>
								</a></c:if>
								
								<a href="${pageContext.request.contextPath}/updateIsActive?empId=${epmList.exVar1}"
									onClick="return confirm('Are you sure want to Chage Status');"
									title="Active/Deactive"><i class="icon-cog5" style="color: black;"></i>
								</a></td>

							</tr>					
							</c:forEach>
						<%-- 	<tbody>


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

							</tbody> --%>
						</table>
					<input type="hidden" id="edit_employee_id" name="edit_employee_id" value="0">
					</div>
					</form>
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
	
<script type="text/javascript">
	function editEmployee(employeeId){
	//	alert(employeeId);
		document.getElementById("edit_employee_id").value=employeeId; 	//create this 
		var form=document.getElementById("employee_list");
	    form.setAttribute("method", "post");
	    
		form.action=("editEmployee");
		form.submit();
		
	}
	</script>
</body>
</html>