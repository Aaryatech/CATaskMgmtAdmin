<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,300,600,800,900"
	rel="stylesheet" type="text/css">
<c:url var="searchManagerwiseCapacityBuilding"
	value="searchManagerwiseCapacityBuilding" />
<c:url var="clientwisetaskcostreport" value="clientwisetaskcostreport" />
<c:url var="showManagerDetail" value="showManagerDetail" />
<c:url var="getClientList" value="getClientList" />
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
			<div class="page-header page-header-light" style="display: none;">


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

						<h5 class="card-title">Reports</h5>
					</div>
					<form method="post" id="reportForm">
						<div class="card-body">
							<div class="form-group row">

							
								<label class="col-form-label col-lg-2" for="monthyear">Select
									Date <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<input type="text" class="form-control daterange-basic_new"
										id="yearrange" name="yearrange">
								</div>
								
								<c:if test="${userType==3 || userType==2}">
								<label class="col-form-label col-lg-2" for="employee">
										Employee <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">

										<select data-placeholder="Select Employee" name="empId"
											id="empId" class="form-control form-control-sm select"
											data-container-css-class="select-sm" data-fouc>
											<option value="">Select Employee</option>
											<option value="0">All</option>
											<c:forEach items="${epmList}" var="epmList">
												<option value="${epmList.empId}">
													${epmList.empName} -${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
											</c:forEach>

										</select>
										
									</div>
									</c:if>

							</div>
							
								

							<c:if test="${userType==2}">
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="partner">
										Partner Type <span style="color: red">* </span>:
									</label>
									<div class="col-lg-3">

										<select data-placeholder="Select Partner" name="partner"
											id="partner" class="form-control form-control-sm select"
											data-container-css-class="select-sm" data-fouc>
											<option value="">Select Partner</option>
											<option value="1">Owner Partner</option>
											<option value="2">Execution Partner</option>

										</select>
									</div>
									
									<label class="col-form-label col-lg-2" for="clientId">Select
									Rate Type<span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="rateType" id="rateType"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<option value="0">Budgeted Rate</option>
										<option value="1">Actual Rate</option>
									</select>
								</div>
								</div>
								
								
								
							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="membrId">Select
									Type <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="typeId" id="typeId"
										class="form-control form-control-select2 select2-hidden-accessible"
										onchange="disableGroupList()" aria-hidden="true">
										<option value="0" selected>Group</option>
										<option value="1">Individual</option>
									</select>
								</div>
								
								<label class="col-form-label col-lg-2" for="groupId">Select
									Group <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="groupId" id="groupId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true"
										onchange="getClientList(this.value)">

										<option value="-1" selected>Select Group</option>

										<c:forEach items="${clientGroupList}" var="clientGroupList">
											<option value="${clientGroupList.id}">${clientGroupList.name}</option>
										</c:forEach>
									</select>
								</div>

							</div>
							
							<div class="form-group row">

								<label class="col-form-label col-lg-2" for="clientId">Select
									Client<span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="clientId" id="clientId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<option disabled value="-1">Select Client</option>
									</select>
								</div>
								
								
								
							</div>
								
							</c:if>



							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
								id="printtable1">
								<thead>
									<tr class="bg-blue">
										<th>Report Name</th>
										<th class="text-center" width="10%">Actions</th>
									</tr>
								</thead>

								<tbody>
									<c:if test="${userType==5}">
										<tr>

											<td>Task Completed</td>
											<td class="text-center"><a href="#"
												onclick="getProgReport(0,'showCompletedTaskRep')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a></td>
										</tr>
									</c:if>
									<c:if test="${userType==4}">
										<tr>

											<td>Team Leader Task Completed</td>
											<td class="text-center">
												<!-- <a href="#"
											onclick="getProgReport(1,'getTeamLeadCompletTask')" title="pdf"><i
												class="icon-file-pdf " style="color: black;"></i></a> &nbsp;  -->
												<a href="#"
												onclick="getProgReport(0,'getTeamLeadCompletTask')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a>
											</td>
										</tr>
									</c:if>
									<c:if test="${userType==3 || userType==2}">
										<tr>
											<td>Employee & Manager Performance</td>

											<td class="text-center">
												<!-- <a href="#" title="pdf"
											onclick="getProgReport(1,'showEmpMngrPerformncRep')" title="pdf"><i
												class="icon-file-pdf " style="color: black;"></i></a> &nbsp;  -->
												<a href="#"
												onclick="getProgReport(0,'showEmpMngrPerformncRep')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a>
											</td>
										</tr>

										<tr>

											<td>Inactive Task(Manager)</td>

											<td class="text-center">
												<!-- <a href="#" title="pdf"
											onclick="getProgReport(1,'showInactiveTaskRepForManager')" title="pdf"><i
												class="icon-file-pdf " style="color: black;"></i></a> &nbsp; -->
												<a href="#"
												onclick="getProgReport(0,'showInactiveTaskRepForManager')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a>
											</td>
										</tr>


										<tr>

											<td>Completed Task(Manager)</td>

											<td class="text-center">
												<!-- <a href="#" title="pdf"
											onclick="getProgReport(1,'showCompletedTaskRepForManager')" title="pdf"><i
												class="icon-file-pdf " style="color: black;"></i></a> &nbsp;  -->
												<a href="#"
												onclick="getProgReport(0,'showCompletedTaskRepForManager')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a>
											</td>
										</tr>

										<tr>

											<td>Employee And Manager Performance Hours(Manager)
												Header</td>

											<td class="text-center"><a href="#"
												onclick="getProgReport(0,'showMangPerfHeadList')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a></td>
										</tr>
									</c:if>
									<c:if test="${userType==2}">
										<tr>

											<td>Employee Partner Grid</td>
											<td class="text-center"><a href="#"
												onclick="getProgReport(0,'showEmployeePartnerGrid')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a></td>
										</tr>

										<tr>

											<td>Client Wise Cost and Revnue Reports</td>
											<td class="text-center"><a href="#"
												onclick="getProgReport(0,'clientwisetaskcostreport')"
												title="excel"><i class="icon-file-spreadsheet  "
													style="color: black;"></i></a></td>
										</tr>

									</c:if>

								</tbody>
							</table>
							<input type="hidden" id="p" name="p" value="0"> <input
								type="hidden" id="emp_name" name="emp_name" value="0">
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

	</div>
	<!-- /page content -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>
	<!-- /page content -->


	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(prm, mapping) {
			if (prm == 1) {
				document.getElementById("p").value = "1";
			}

			if ($("#empId option").length > 0) {
				var elm = document.getElementById('empId');
				var text = elm.options[elm.selectedIndex].innerHTML;
				document.getElementById("emp_name").value = text;
			}

			var form = document.getElementById("reportForm");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "post");

			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");

			form.submit();

			document.getElementById("p").value = "0";
		}
	</script>

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
	
	<script type="text/javascript">
		function getCostDetail(mapping) {

			var rateType = document.getElementById("rateType").value;
			var monthyear = document.getElementById("monthyear").value;
			var typeId = document.getElementById("typeId").value;
			var groupId = document.getElementById("groupId").value;
			var clientId = document.getElementById("clientId").value;

			var flag = 1;

			if (typeId == 1) {
				groupId = -1;
			} else {

				if (groupId == -1) {
					alert("Select Group");
					flag = 0;
				}
			}

			if (clientId == -1 || clientId == "") {
				alert("Select Client");
				flag = 0;
			}

			if (flag == 1) {
				/* $("#loader").show();
				$.getJSON('${clientwisetaskcostreport}', {
					rateType : rateType,
					monthyear : monthyear,
					typeId : typeId,
					groupId : groupId,
					clientId : clientId,
					ajax : 'true',

				}, function(data) {

					$("#capTable tbody").empty();

					$.each(data, function(i, v) {

						var actualRev = 0;
						if (v.taskStatus == 9) {
							actualRev = v.revenue;
						}
						var tr_data = '<tr>  <td>' + (i + 1) + '</td><td>'
								+ v.custFirmName + '</td> <td width="20%">'
								+ v.taskText + '</td> <td  >' + v.servName
								+ '</td> <td  >' + v.actiName + '</td> <td  >'
								+ v.periodicityName + '</td> <td>'
								+ v.ownerPartner + '</td>' + '<td>'
								+ v.ownerPartner + '</td>' + '<td>'
								+ v.employee + '</td>' + '<td>'
								+ v.empBugetedHrs + '</td>' + '<td>'
								+ v.empBugetedCost.toFixed(2) + '</td>'
								+ '<td>' + v.empActualHrs + '</td>' + '<td>'
								+ v.empActualCost.toFixed(2) + '</td>' + '<td>'
								+ v.mngrBugetedHrs + '</td>' + '<td>'
								+ v.mngrBugetedCost.toFixed(2) + '</td>'
								+ '<td>' + v.mngrActualHrs + '</td>' + '<td>'
								+ v.mngrActualCost.toFixed(2) + '</td>'
								+ '<td>' + v.teamLeader + '</td>' + '<td>'
								+ v.tlActualHrs + '</td>' + '<td>'
								+ v.tlActualCost.toFixed(2) + '</td>' + '<td>'
								+ v.revenue + '</td>' + '<td>' + actualRev
								+ '</td>' + '<td>' + v.googleDriveLink
								+ '</td>' + '</tr>';
						$('#capTable' + ' tbody').append(tr_data);

					});

					$("#loader").hide();
				}); */
				getProgReportNew(mapping);
			}
		}

		function disableGroupList() {
			var typeId = document.getElementById("typeId").value;

			if (typeId == 1) {
				document.getElementById("groupId").disabled = true;
				getClientList(0);
			} else {

				var groupId = document.getElementById("groupId").value;
				document.getElementById("groupId").disabled = false;
				var html;
				html += '<option disabled value="0">Select Client</option>';
				$('#clientId').html(html);
				$("#clientId").trigger("chosen:updated");
				getClientList(groupId);
			}

		}

		function getClientList(groupId) {

			$.getJSON('${getClientList}', {
				groupId : groupId,
				ajax : 'true',
			},

			function(data) {
				var html;

				html += '<option disabled value="-1">Select Client</option>';
				var len = data.length;

				if (groupId > 0 && len > 0) {

					html += '<option value="0" selected>All</option>';
				}
				for (var i = 0; i < len; i++) {
					html += '<option value="' + data[i].id + '">'
							+ data[i].name + '</option>';

				}

				$('#clientId').html(html);
				$("#clientId").trigger("chosen:updated");

			});

		}
	</script>
</body>
</html>