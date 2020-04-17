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
								class="breadcrumb-item active">Activity</span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>


				</div>
			</div> -->
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
								<h6 class="card-title">${title}</h6>
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
									<span class="font-weight-semibold"> </span>
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
									<span class="font-weight-semibold"> </span>
									<%
										session.removeAttribute("successMsg");
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>

								<form action="${pageContext.request.contextPath}/addNewActivity"
									id="submitInsertActivity" method="post">

									<input type="hidden" id="activity_id" name="activity_id"
										value="${activity.actiId}">

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Service : </label>
										<div class="col-lg-6">

											<input type="text" class="form-control"
												placeholder="Service Name" id="serviceName"
												value="${service.servName}" name="serviceName"
												autocomplete="off" onchange="trim(this)" readonly="readonly">

											<input type="hidden" id="service_id" name="service_id"
												value="${service.servId}">

										</div>
									</div>

									<hr>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="activityName">Activity
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${activity.actiName}"
												placeholder="Enter Activity Name" id="activityName"
												name="activityName" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label"
												id="error_activityName" style="display: none;">Please
												enter activity name.</span>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="periodicity">
											Periodicity<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<select name="periodicity"
												data-placeholder="Select Periodicity" id="periodicity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="">Select Periodicity</option>

												<c:forEach items="${periodList}" var="list">
													<c:choose>
														<c:when
															test="${list.periodicityId == activity.periodicityId}">
															<option selected value="${list.periodicityId}">${list.periodicityName}</option>
														</c:when>
														<c:otherwise>
															<option value="${list.periodicityId}">${list.periodicityName}</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>

											</select>


										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_periodicity"
												style="display: none;">Please select periodicity.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="serviceDesc">Activity
											Description : </label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${activity.actiDesc}"
												placeholder="Enter Activity Description" id="activityDesc"
												name="activityDesc" autocomplete="off" onchange="trim(this)">
										</div>
									</div>


									<div class="form-group row mb-0">
										<div class="col-lg-12" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											&nbsp; <a href="${pageContext.request.contextPath}/activity"><button
													type="button" class="btn btn-primary">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div>

									<br>
									<div class="form-group row">
										<div class="col-lg-12" align="center">
											<table
												class="table table-bordered table-hover datatable-button-html5-basic  datatable-button-print-columns1"
												id="printtable1">
												<thead>

													<tr class="bg-blue">
														<th width="10%">Sr.no</th>
														<th>Activity Name</th>
														<th>Description</th>
														<th>Periodicity</th>
														<th>Status</th>
														<th class="text-center" width="10%">Actions</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${actList}" var="actList"
														varStatus="count">
														<tr>
															<td>${count.index+1}</td>
															<td>${actList.actiName}</td>
															<td>${actList.actiDesc}</td>
															<td>${actList.periodicityName}</td>
															<td><c:choose>
																	<c:when test="${actList.exInt1==0}">
															InActive
															</c:when>
																	<c:otherwise>
															Active
															</c:otherwise>
																</c:choose></td>
															<td><c:if test="${editAccess==0}">
																	<a
																		href="${pageContext.request.contextPath}/editActivity?actiId=${actList.actiId}"
																		title="Edit"><i class="icon-pencil7"
																		style="color: black;"></i></a>
																</c:if> <c:if test="${deleteAccess==0}">
																	<%-- <a
																		href="${pageContext.request.contextPath}/deleteActivity/${actList.actiId}"
																		onClick="return confirm('Are you sure want to delete this record');"
																		title="Delete"><i class="icon-trash"
																		style="color: black;"></i></a> --%>
																		<a href="javascript:void(0)"
class="list-icons-item text-danger-600 bootbox_custom"
data-uuid="${actList.actiId}" data-popup="tooltip"
title="" data-original-title="Delete"><i class="icon-trash"
													style="color: black;"></i></a>
														
																</c:if> <c:if test="${editAccess==0}">
																	<c:choose>
																		<c:when test="${actList.exInt1==1}">
																			<a
																				href="${pageContext.request.contextPath}/activeDeactiveActivity?actiId=${actList.actiId}"><i
																				class="fas fa-toggle-on" style="color: green;"></i>
																			</a>
																		</c:when>
																		<c:otherwise>
																			<a
																				href="${pageContext.request.contextPath}/activeDeactiveActivity?actiId=${actList.actiId}"><i
																				class="fas fa-toggle-off" style="color: red;"></i> </a>
																		</c:otherwise>
																	</c:choose>
																</c:if></td>
														</tr>
													</c:forEach>
												</tbody>


											</table>
										</div>
									</div>

								</form>
								<p class="desc text-danger fontsize11">Notice : * Fields are
									mandatory.</p>
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
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>

<script>
// Custom bootbox dialog
$('.bootbox_custom')
.on(
'click',
function() {
var uuid = $(this).data("uuid") // will return the number 123
bootbox.confirm({
title : 'Confirm ',
message : 'Are you sure you want to delete selected records ?',
buttons : {
confirm : {
label : 'Yes',
className : 'btn-success'
},
cancel : {
label : 'Cancel',
className : 'btn-link'
}
},
callback : function(result) {
if (result) {
location.href = "${pageContext.request.contextPath}/deleteActivity/"
+ uuid;

}
}
});
});
</Script>

	<script>
		$(document).ready(function($) {

			$("#submitInsertActivity").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if (!$("#activityName").val()) {

					isError = true;

					$("#error_activityName").show()
					//return false;
				} else {
					$("#error_activityName").hide()
				}

				if ($("#periodicity").val() == "" || !$("#periodicity").val()) {

					isError = true;

					$("#error_periodicity").show()

				} else {
					$("#error_periodicity").hide()
				}

				if (!isError) {

					var x = true;
					if (x == true) {

						document.getElementById("submtbtn").disabled = true;
						return true;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
		//
	</script>

</body>
</html>