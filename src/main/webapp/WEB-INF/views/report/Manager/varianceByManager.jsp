<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>


</head>

<body onload="chkData(${listSize})">
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>

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
								<td width="60%"><h5 class="card-title">Statutory Date
										Variation By Manager Report</h5></td>
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
							<span class="font-weight-semibold"> </span>
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
							<span class="font-weight-semibold"> </span>
							<%
								out.println(session.getAttribute("successMsg"));
							%>
						</div>
						<%
							session.removeAttribute("successMsg");
							}
						%>
						<form
							action="${pageContext.request.contextPath}/showVarianceByManger"
							id="submitInsertEmpType">


							<div class="form-group row">
								<label class="col-form-label col-lg-1" for="service">
									Service<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="service" data-placeholder="Select Service"
										id="service"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true"
										onchange="getActivities(this.value)">
										<option value="0">Select Service</option>
										<c:forEach items="${serviceList}" var="serviceList">
											<c:choose>
												<c:when test="${serviceList.servId==servId}">
													<option selected value="${serviceList.servId}">${serviceList.servName}</option>
												</c:when>
												<c:otherwise>
													<option value="${serviceList.servId}">${serviceList.servName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>


								<label class="col-form-label col-lg-1" for="activity">
									Activity <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="activity" data-placeholder="Select Activity"
										id="activity"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">


									</select>
								</div>


								<label class="col-form-label col-lg-1" for="customer">
									Customer<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="customer" data-placeholder="Select Customer"
										id="customer"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<option value="0">Select Customer</option>

										<c:if test="${custId==-1}">
											<option selected value="-1">All</option>

										</c:if>
										<c:if test="${custId!=-1}">
											<option value="-1">All</option>

										</c:if>
										<c:forEach items="${custList}" var="custList">

											<c:choose>
												<c:when test="${custId==custList.custId}">
													<option selected value="${custList.custId}"><c:out
															value="${custList.custFirmName}" /></option>
												</c:when>
												<c:otherwise>
													<option value="${custList.custId}"><c:out
															value="${custList.custFirmName}" /></option>

												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>

							</div>



							<div class="form-group row">
								<label class="col-form-label col-lg-1" for="mangId">
									Manager <span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="mangId" data-placeholder="Select Manager"
										id="mangId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<option value="0">Select Manager</option>
										<c:forEach items="${empList}" var="managerList">
											<c:choose>
												<c:when test="${managerList.empId==mangId}">
													<option selected value="${managerList.empId}">${managerList.empName}</option>
												</c:when>
												<c:otherwise>
													<option value="${managerList.empId}">${managerList.empName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>

								<div class="col-lg-2" align="center">
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn">
										Search <i class="icon-paperplane ml-2"></i>
									</button>
								</div>

								<div class="col-lg-1" align="center">
									<a
										href="${pageContext.request.contextPath}/getVarianceByManagerExcel?custId=${custId}&servId=${servId}&mangId=${mangId}&actId=${actId}"><button
											type="button" id="excel" class="btn bg-blue ml-3 legitRipple">Excel
										</button></a>

								</div>
							</div>

							<input type="hidden" name="actId" id="actId" value="${actId}">
						</form>

						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>

								<tr class="bg-blue">
									<th width="10%">Sr.no</th>
									<th>Task Text</th>
									<th>Client Name</th>
									<th>Service</th>
									<th>Activity</th>
									<th>Task/Periodicity</th>
									<th>Owner Partner</th>
									<th>Employee Name</th>
									<th>TL Name</th>
									<th>Manager Name</th>
									<th>Work Date</th>
									<th>Completion Date</th>
									<th>Original Due Date</th>
									<th>Due Date</th>
									<th>Variation(Days)</th>
									<th>Status</th>


									<th>Drive Link</th>

									<!-- <th class="text-center" width="10%">Actions</th> -->
								</tr>
							</thead>
							<c:forEach items="${varianceList}" var="varianceList"
								varStatus="count">
								<tr>
									<td>${count.index+1}</td>
									<td>${varianceList.taskText}</td>
									<td>${varianceList.custFirmName}</td>
									<td>${varianceList.servName}</td>
									<td>${varianceList.actiName}</td>
									<td>${varianceList.periodicityName}</td>
									<td>${varianceList.partner}</td>
									<td>${varianceList.employee}</td>
									<td>${varianceList.teamLeader}</td>
									<td>${varianceList.manager}</td>
									<td>${varianceList.taskEndDate}</td>
									<td>${varianceList.completionDate}</td>
									<td>${varianceList.taskStartDate}</td>
									<td>${varianceList.taskStatutoryDueDate}</td>
									<td>${varianceList.varianceDays}</td>
									<td>${varianceList.tskStatus}</td>
									<td>${varianceList.exVar1}</td>
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

<script type="text/javascript">
	function chkData(x) {
		//var x = document.getElementById("printtable1").rows.length;
		//alert(x);
		if (x == 0) {

			document.getElementById("excel").disabled = true;
		}
	}
</script>
<script type="text/javascript">
	function getActivities(servId) {

		var actId = document.getElementById("actId").value;

		if (servId > 0) {

			$
					.getJSON(
							'${getActivityByService}',
							{
								servId : servId,
								ajax : 'true',
							},

							function(data) {
								var html;

								var temp = 0;

								//alert("list " +list);
								var len = data.length;

								//alert("len1 " +len1);
								for (var i = 0; i < len; i++) {
									var flag = 0;

									if (data[i].actiId == actId) {
										flag = 1;
									}

									if (flag == 1) {

										html += '<option selected value="' + data[i].actiId + '">'
												+ data[i].actiName
												+ '</option>';

									} else {

										html += '<option value="' + data[i].actiId + '">'
												+ data[i].actiName
												+ '</option>';

									}

								}

								$('#activity').html(html);
								$("#activity").trigger("chosen:updated");

							});

		}

		//}//end of if
	}
</script>


</html>