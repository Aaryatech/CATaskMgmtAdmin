<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<c:url var="getSubmoduleList" value="/getSubmoduleList" />
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
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>

					<%-- <div class="breadcrumb justify-content-center">
						<a href="${pageContext.request.contextPath}/showEmpTypeList"
							class="breadcrumb-elements-item"> Employee Type List</a>

					</div>
 --%>

				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


						<div class="card">
							<div class="card-header header-elements-inline">
								<h6 class="card-title">Assign Role to Employees</h6>
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

								<form
									action="${pageContext.request.contextPath}/submitAssignedRole"
									id="submitInsertEmpType" method="post">
									
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="empIds">Employee Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-10">
									<select name="empIds" data-placeholder="Select Employees"
												id="empIds" multiple="multiple"
												class="form-control form-control-sm select"
												aria-hidden="true" data-container-css-class="select-sm"
												data-fouc>

												<c:forEach items="${empList}" var="emp">
													<option value="${emp.empId}">${emp.empName}</option>
												</c:forEach>
											
									</select>
											</div>
								    </div>
											
											<div class="form-group row">
										<label class="col-form-label col-lg-2" for="roleName">Role to be Assigned <span style="color: red">* </span>:
										</label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Role Name"  readonly id="roleName" maxlength="15"
												name="roleName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label"  id="error_empTypeName"
												style="display: none;">This field is required.</span>
										</div>
									</div>
											
											
											<div class="col-md-12" style="text-align: center;">
<input type="hidden"   id="roleId"
										name="roleId" value="0">
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">
											Submit <i class="icon-paperplane ml-2"></i>
										</button>
										<a href="${pageContext.request.contextPath}/showCreateRole"><button
												type="button" class="btn btn-primary">Cancel</button></a>

									</div>

									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th width="10%">Sr. No.</th>
												<th>Role Name</th>
												<th width="10%">Select Role</th>

											</tr>
										</thead>
										<tbody>


																<c:forEach items="${createdRoleList}"
																		var="createdRoleList" varStatus="count">
																		<tr>
																			<td style="text-align: center; "><c:out value="${count.index+1}" /></td>
																			<td><c:out value="${createdRoleList.roleName}" /></td>
																			<td style="text-align: center; "><a title="Select Role" rel="tooltip"
																				data-color-class="detail"
																				data-animate=" animated fadeIn "
																				href="#" onclick="seleRole(${createdRoleList.roleId},'${createdRoleList.roleName}')"
																				  data-original-title="Edit"><i class="icon-user-check" style="color: black;"></i></a></td>
																		</tr>


																	</c:forEach>


										</tbody>
									</table>
									</form>
									<%-- <span class="form-text text-muted">* If Want To Access
										Add, Edit,Delete Then View Access is Compulsory</span>
									<div class="form-group row">
										<div class="col-lg-10">
											<span class="validation-invalid-label" id="error_checkbox"
												style="display: none;">Check Minimum One Checkbox</span>
										</div>
									</div>
									<br>

									<div class="col-md-12" style="text-align: center;">

										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">
											Submit <i class="icon-paperplane ml-2"></i>
										</button>
										<a href="${pageContext.request.contextPath}/showEmpTypeList"><button
												type="button" class="btn btn-primary">Cancel</button></a>

									</div> --%>
								
							</div>
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
	
	
	<script>
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			checkSame();
			return;
		}
function seleRole(roleId,roleName){
	document.getElementById("roleId").value=roleId;
	document.getElementById("roleName").value=roleName;
}
  </script>

	

</body>
</html>