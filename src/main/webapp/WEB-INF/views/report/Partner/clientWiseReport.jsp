<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/datatables_basic.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/dashboard.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/plugins/visualization/echarts/echarts.min.js"></script>



<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,300,600,800,900"
	rel="stylesheet" type="text/css">
<c:url var="searchManagerwiseCapacityBuilding"
	value="searchManagerwiseCapacityBuilding" />
<c:url var="clientwisetaskcostreport" value="clientwisetaskcostreport" />
<c:url var="showManagerDetail" value="showManagerDetail" />
<c:url var="getClientList" value="getClientList" />
</head>

<body onload="chkData()">

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


				<div class="row">
					<div class="col-sm-12">
						<div class="progress">
							<div class="progress-bar bg-success" style="width: 35%">
								<span>35% Complete</span>
							</div>
						</div>
					</div>
				</div>





			</div>
			<!-- /page header -->


			<style type="text/css">
h5 {
	margin-bottom: 0;
}
</style>


			<!-- Content area -->
			<div class="content">




				<!-- <style type="text/css">
.datatable-footer {
	display: none;
}

.dataTables_length {
	display: none;
}

.datatable-header {
	display: none;
}
</style> -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Client wise Task Cost Report</h5>

					</div>
					<div class="card-body">
						<form method="post" id="reportFormDet">
							<div class="form-group row">

								<label class="col-form-label col-lg-2" for="monthyear">Select
									Date <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<input type="text" class="form-control daterange-basic_new"
										id="monthyear" name="monthyear">
								</div>
								<div class="col-lg-1"></div>
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
								<div class="col-lg-1"></div>
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
								<div class="col-lg-2">
									<select name="clientId" id="clientId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<option disabled value="-1">Select Client</option>
									</select>
								</div>
								<div class="col-lg-3">
									<button type="button" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn"
										onclick="getCostDetail()">Search
										</button>
										
										<button type="button" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn1"
										onclick="getProgReportNew('showClientwisetaskcostreport')">
										Excel</button>
								</div>

							</div>
							<input type="hidden" id="emp_id" name="emp_id" value="${empId}">
							<div id="loader" style="display: none;">
								<img
									src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>
						</form>
						<div class="table-responsive">
							<table  class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1" id="capTable">
								<thead>
									<tr class="bg-blue">

										<th width="7%">SR.No.</th>
										<th>Client Name</th>
										<th>Task Name</th>
										<th>Service</th>
										<th>Activity</th>
										<th>Periodicity</th>
										<th>Owner Partner</th>
										<th>Execution Partner</th>
										<th>Employee Name</th>
										<th>Employee Budgeted Hrs</th>
										<th>Employee Budgeted Cost</th>
										<th>Employee Actual Hrs</th>
										<th>Employee Actual Cost</th>
										<th>Manager Budgeted Hrs</th>
										<th>Manager Budgeted Cost</th>
										<th>Manager Actual Hrs</th>
										<th>Manager Actual Cost</th>
										<th>TL Name</th>
										<th>TL Hrs</th>
										<th>TL Cost</th>
										<th>Budgeted Revenue</th>
										<th>Actual Revenue</th>
										<th>Google Drive link</th>
									</tr>
								</thead>
								<tbody>


								</tbody>
							</table>
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
	<!-- /page content -->
<script type="text/javascript">
		function chkData() {
			var x = document.getElementById("capTable").rows.length;
			
			if (x == 1) {
				//alert(x);

				document.getElementById("submtbtn1").disabled = true;
			}
			else{
				document.getElementById("submtbtn1").disabled = false;
			}
		}
	</script>
	<script type="text/javascript">
		//datepickermonth
		// Single picker
		$('.datepickermonth').daterangepicker({
			singleDatePicker : true,

			showDropdowns : true,
			locale : {
				format : 'MM-YYYY'
			}

		});
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
		function getCostDetail() {

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
				 $("#loader").show();
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

					
					chkData();
					
				}); 
				$("#loader").hide();
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
	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReportNew(mapping) {

			var form = document.getElementById("reportFormDet");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "post");

			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");

			form.submit();

		}
	</script>
	
</body>
</html>