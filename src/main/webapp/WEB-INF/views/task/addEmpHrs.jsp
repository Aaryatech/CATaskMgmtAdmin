<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>


</head>

<body>
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>

	<c:url value="/getEmpWorkLogs" var="getEmpWorkLogs"></c:url>

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
								<h6 class="card-title">Add Employee Hours</h6>
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

								<form id="submitInsertClient">

									<input type="hidden" id="custId" name="custId" value="">

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="custName">Customer
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="customer" data-placeholder="Select Customer"
												id="customer"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<option value="" selected>Select Service</option>
												<c:forEach items="${custHeadList}" var="custHeadList">

													<option value="${custHeadList.custId}">${custHeadList.custFirmName}</option>

												</c:forEach>

											</select>
										</div>
										<div class="col-lg-3"></div>

									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Service <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)">
												<option value="" selected>Select Service</option>
												<c:forEach items="${serviceList}" var="service">

													<option value="${service. servId}">${service. servName}</option>

												</c:forEach>

											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_service"
												style="display: none;">Please select service.</span>
										</div>

									</div>
									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="activity">
											Activity <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_activity"
												style="display: none;">Please select above service
												for corresponding activity.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="custName">Employee
											Name <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="employee" data-placeholder="Select Employee"
												id="employee" 
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true" onchange="getWorkLog()">
												<option value="" selected>Select Service</option>
												<c:forEach items="${epmList}" var="epmList">

													<option value="${epmList.empId}">${epmList.empName}</option>

												</c:forEach>

											</select>
										</div>
										<div class="col-lg-3"></div>

									</div>

									<%-- <div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												<!--data-toggle="modal" data-target="#modal_remote" -->
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/customerList"><button
													type="button" class="btn btn-primary" id="cancelbtn">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div> --%>
								</form>
							</div>
						</div>
						<form action="${pageContext.request.contextPath}/addEmpWorkHrs" method="post">
						<input type="hidden" id="employeeId" name="employeeId">
						<div class="card">
							<div class="card-body">
								<div class=table-responsive>
									<table class="table datatable-basic table-hover"
										id=worklogdatatable>
										<thead>
											<tr>
												<th style="color: white;">Sr. No.<input type="checkbox"
																name="selAll" id="selAll" /></th>
												<th style="color: white;">Task Name</th>
												<th style="color: white;">Work Date</th>
												<th style="color: white;">Work Hours</th> 
												<th style="color: white;">EmpLoyee Name</th>
												<th style="color: white;">Customer Name</th>
												<th style="color: white;">Remark</th> 
												<!-- <th style="color: white;">Budget Hrs</th> -->
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
								</div>
								<br>

								<div class="modal-footer">
									<!-- <button type="submit" class="btn btn-link" data-dismiss="modal">Close</button> -->
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">Submit <i class="icon-paperplane ml-2"></i>
											</button>
								</div>

							</div>
						</div>
						</form>
					</div>
				</div>




				<!-- /remote source -->


				<!-- /content area -->


				<!-- Footer -->
				<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
				<!-- /footer -->


			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>


	<script>
		$('#statutary_endDays').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$('#mgBudgetHr').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$('#empBudgetHr').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$('#billAmt').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});

		$(document).ready(function($) {

			$("#submitInsertClient").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if ($("#service").val() == "") {

					isError = true;

					$("#error_service").show()

				} else {
					$("#error_service").hide()
				}

				if (!isError) {

					var x = true;
					if (x == true) {

						document.getElementById("submtbtn").disabled = true;
						document.getElementById("cancelbtn").disabled = true;
						return true;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
		//
	</script>


	<script>
		function getActivities(servId) {
			//alert("servId " +servId)
			if (servId > 0) {

				$.getJSON('${getActivityByService}', {
					servId : servId,
					ajax : 'true',
				},

				function(data) {
					var html;
					var p = "";
					var q = "Select Activity";
					html += '<option disabled value="'+p+'" selected>' + q
							+ '</option>';
					html += '</option>';

					var temp = 0;

					var len = data.length;
					for (var i = 0; i < len; i++) {

						html += '<option value="' + data[i].actiId + '">'
								+ data[i].actiName + '</option>';
					}

					$('#activity').html(html);
					$("#activity").trigger("chosen:updated");

				});

			}//end of if
		}

		function getWorkLog() {
			
			var emp = $("#employee").val();
			var service = $("#service").val();
			var activity = $("#activity").val();
			var customer = $("#customer").val();
			document.getElementById("employeeId").value = emp;

			//alert("Data------" + emp + " " + service + " " + activity + " "
					//+ customer);

			$.getJSON('${getEmpWorkLogs}', {
				emp : emp,
				service : service,
				activity : activity,
				customer : customer,
				ajax : 'true',
			},

			function(data) {
				var dataTable = $('#worklogdatatable').DataTable();
				dataTable.clear().draw();

				$.each(data, function(i, v) {

				//	var taskText = '<input type="text" class="form-control" id="taskText'+i+'" name="taskText'+i+'" autocomplete="off" onchange="trim(this)" value="'+v.taskText+'" disabled="disabled">'
					
				//	var employee = '<input type="text" class="form-control" id="emp'+i+'" name="emp'+i+'" autocomplete="off" onchange="trim(this)" value="'+v.employees+'" disabled="disabled">'
					
				//	var custFirmName = '<input type="text" class="form-control" id="custFirmName'+i+'" name="custFirmName'+i+'" autocomplete="off" onchange="trim(this)" value="'+v.custFirmName+'" disabled="disabled">'
					
					var workhrs = '<input type="time" class="form-control" placeholder="Enter Work Hours" id="workHr'+i+'" name="workHr'+i+'" autocomplete="off" onchange="trim(this)">'
					
					var remark = '<input type="text" class="form-control" placeholder="Enter Remark" id="remark'+i+'" name="remark'+i+'" autocomplete="off" onchange="trim(this)">'
					
					var dtpkr = '<input type="text" class="form-control datepickerclass"  placeholder="Enter Work Date" id="workdate'+i+'" name="workdate'+i+'" autocomplete="off" onchange="trim(this)">'
					
					var chk = '<input type="checkbox" id="TaskId'+i+'"  name="TaskId'+i+'" value="'+v.taskId+'" onchange="getValidate(this.value)">'
					
					dataTable.row.add(
							[ i + 1+' '+ chk, 
								v.taskText, 
								dtpkr, 
								workhrs, 
								v.employees, 
								v.custFirmName, 
								remark					

							]).draw();
				});
				$('.datepickerclass').daterangepicker({
					singleDatePicker : true,
					selectMonths : true,
					selectYears : true,
					locale : {
						format : 'DD-MM-YYYY'
					}
				}); 
			});

		}
	</script>

<script type="text/javascript">

$(document).ready(
		function() {
			

			$("#selAll").click(
					function() {
						$('#worklogdatatable tbody input[type="checkbox"]')
								.prop('checked', this.checked);
					});
		});

$('.datepickerclass').daterangepicker({
	singleDatePicker : true,
	selectMonths : true,
	selectYears : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
}); 

$('.daterange-basic_new').daterangepicker({
	applyClass : 'bg-slate-600',

	cancelClass : 'btn-light',
	locale : {
		format : 'DD-MM-YYYY',
		separator : ' to '
	}
});

function getValidate(id){
	//alert("Hi----------"+id);
	 document.getElementById("id").required=true;
}
</script>

</body>
</html>