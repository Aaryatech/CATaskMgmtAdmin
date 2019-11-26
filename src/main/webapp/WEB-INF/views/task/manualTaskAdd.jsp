<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
 
<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>


	<c:url value="/getActivityByService" var="getActivityByService"></c:url>

	<c:url value="/getPeridicityByActivity" var="getPeridicityByActivity"></c:url>
	
	
	<c:url value="/getCountofManagers" var="getCountofManagers"></c:url>
	
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
								class="breadcrumb-item active">Client</span>
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
									<span class="font-weight-semibold">Oh snap!</span>
									<%
									session.getAttribute("successMsg");
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
									session.getAttribute("successMsg");
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>

								<form action="${pageContext.request.contextPath}/addManualTask"
									id="submitInsertClient" method="post">



									<input type="hidden" name="taskId" value="${task.taskId}">
									<input type="hidden" name="taskType" value="${taskType}">

									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="locId2">
											Employee <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">

											<select multiple="multiple"
												data-placeholder="Select Employee" name="empId2" id="empId2"
												class="form-control form-control-sm select"
												data-container-css-class="select-sm" data-fouc>
												<option value="">Select Employee</option>

												<c:forEach items="${epmList}" var="epmList">
													<c:set var="flag" value="0"></c:set>
													<c:forEach items="${empIntList}" var="empIntList"
														varStatus="count2">
														<c:choose>
															<c:when test="${empIntList==epmList.empId}">
																<option selected value="${epmList.empId}">${epmList.empName}
																	-${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
																<c:set var="flag" value="1"></c:set>
															</c:when>
															<c:otherwise>

															</c:otherwise>
														</c:choose>
													</c:forEach>
													<c:choose>
														<c:when test="${flag==0}">
															<option value="${epmList.empId}">${epmList.empName}
																-${epmList.empType==1 ? 'ADM': epmList.empType==2 ? 'PT' : epmList.empType==3 ? 'MG' : epmList.empType==4 ? 'TL' : epmList.empType==5 ? 'EMP' : ''}</option>
														</c:when>
													</c:choose>
												</c:forEach>
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_emp"
												style="display: none;">Please Select Employee.</span>
												<span class="validation-invalid-label" id="error_emp_mng"
												style="display: none;">Please Select a Manager (MG).</span>
												
										</div>
									</div>




									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Customer<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<select name="customer" data-placeholder="Select Customer"
												id="customer"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<c:forEach items="${custList}" var="custList">

													<c:choose>
														<c:when test="${task.custId==custList.custId}">
															<option selected value="${custList.custId}"><c:out
																	value="${custList.custFirmName}" /></option>
															<c:set var="flag" value="1"></c:set>
														</c:when>
														<c:otherwise>
															<option value="${custList.custId}">${custList.custFirmName}</option>

														</c:otherwise>
													</c:choose>
												</c:forEach>

											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_cust"
												style="display: none;">Please Select customer </span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Service<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)">

												<c:forEach items="${serviceList}" var="serviceList">

													<c:choose>
														<c:when test="${task.servId==serviceList.servId}">
															<option selected value="${serviceList.servId}">${serviceList.servName}</option>

														</c:when>
														<c:otherwise>
															<option value="${serviceList.servId}">${serviceList.servName}</option>

														</c:otherwise>
													</c:choose>
												</c:forEach>




											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_periodicity"
												style="display: none;">Please Select Service</span>
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
												data-fouc="" aria-hidden="true" onchange="getPeriodicity()">
											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_activity"
												style="display: none;">Please Select Above Service
												for Corresponding Activity.</span>
										</div>

									</div>

									<input type="hidden" id="periodicityId" name="periodicityId">
									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="periodicity">
											Periodicity <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control" readonly="readonly"
												name="periodicity" id="periodicity"
												placeholder="Periodicity">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label"
												id="error_periodicity1" style="display: none;">Please
												Select Above Service & Activity for corresponding
												Periodicity.</span>
										</div>

									</div>


									<%-- 	<div class="form-group row">
										<label class="col-form-label col-lg-3" for="service">
											Financial Year : </label>
										<div class="col-lg-6">
											<select name="fyYear" data-placeholder="Select Year"
												id="fyYear"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)"><c:forEach
													items="${fyList}" var="fyList">
													<option value="${fyList.finYearId}">${fyList.finYearName}</option>
												</c:forEach>

											</select>
										</div>
									</div> --%>


									<c:if test="${isEdit==0}">

										<div class="form-group row">
											<label class="col-form-label col-lg-3"
												for="statutary_endDays"> Statutory End Days <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control"
													placeholder="Statutory End Days" id="statutary_endDays"
													name="statutary_endDays" autocomplete="off" value=0
													onchange="trim(this)">
											</div>
											<div class="col-lg-3">
												<span class="validation-invalid-label"
													id="error_stat_endDays" style="display: none;">Please
													enter statutory end days.</span>
											</div>

										</div>
									</c:if>


									<c:if test="${isEdit==1}">

										<div class="form-group row">

											<label class="col-form-label col-lg-3" for="startDate">Statutory
												Due Date <span style="color: red">* </span>:
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control datepickerclass"
													value="${task.taskStatutoryDueDate}" name="statDate"
													id="statDate" placeholder="Start Date">
											</div>

											<div class="col-lg-3">
												<span class="validation-invalid-label" id="error_statDate"
													style="display: none;">Please enter Statutory Due
													Date.</span>
											</div>

										</div>
									</c:if>


									<div class="form-group row">

										<label class="col-form-label col-lg-3" for="startDate">Start
											Date <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass"
												value="${task.taskStartDate}" name="startDate"
												id="startDate" placeholder="Start Date">
										</div>

										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_startDate"
												style="display: none;">Please enter end date.</span> <span
												class="validation-invalid-label" id="error_start_date"
												style="display: none;">Start date must be smaller
												than Work date.</span>
										</div>

									</div>


									<c:if test="${isEdit==0}">

										<div class="form-group row">
											<label class="col-form-label col-lg-3" for="endDate">Task
												Work Date </label>
											<div class="col-lg-6">
												<input type="text" class="form-control datepickerclass"
													value="${task.taskEndDate}" name="endDate" id="endDate"
													placeholder="Task End Date">
											</div>
											<div class="col-lg-3">
												<span class="validation-invalid-label" id="error_endDate"
													style="display: none;">This field is required.</span> <span
													class="validation-invalid-label" id="error_end_date"
													style="display: none;">Work date must be greater than
													start date.</span>
											</div>
										</div>
									</c:if>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="manHrs">Manager
											Budget Hours<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Manager Budget Hours" id="mgBudgetHr"
												value="${task.mngrBudHr}" name="mgBudgetHr" data-mask="99:99"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_mgBudgetHr"
												style="display: none;">This field is required.</span>
										</div>
									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="empHrs">Employee
											Budget Hours<span style="color: red">* </span> :
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter Employee Budget Hours" id="empBudgetHr"
												value="${task.empBudHr}" name="empBudgetHr" data-mask="99:99"
												autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empHrs"
												style="display: none;">This field is required.</span>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="billAmt">Billing
											Amount <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												value="${task.billingAmt}"
												placeholder="Enter Billing Amount" id="billAmt"
												name="billAmt" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_billAmt"
												style="display: none;">Please enter billing amount.</span>
										</div>

									</div>


									<div class="form-group row mb-0">
										<div class="col-lg-10 ml-lg-auto">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<c:if test="${taskType==1}">
												<a href="${pageContext.request.contextPath}/manualTaskList"><button
														type="button" class="btn btn-primary">
														<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
														Cancel
													</button></a>
											</c:if>
											<c:if test="${taskType==2}">
												<a
													href="${pageContext.request.contextPath}/inactiveTaskList"><button
														type="button" class="btn btn-primary">
														<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
														Cancel
													</button></a>
											</c:if>
										</div>
									</div>
								</form>
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
	$('#empId2').on(
			'change',
			function() {
				//alert("JJ");
				//alert($("#empId2").val());
			});
	
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
		

		$(document)
				.ready(
						function($) {

							$("#submitInsertClient")
									.submit(
											function(e) {
											//	alert("in submit");
												var isError = false;
												var errMsg = "";

												if ($("#service").val() == "") {
 
													isError = true;

													$("#error_service").show()

												} else {
													$("#error_service").hide()
												}

												if ($("#empId2").val() == "") {
 													isError = true;

													$("#error_emp").show()

												} else {
													$("#error_emp").hide()
												}

												if ($("#customer").val() == "") {
 													isError = true;

													$("#error_cust").show()

												} else {
													$("#error_cust").hide()
												}

												if (!$("#periodicity").val()
														|| $("#activity").val() == "") {
 													isError = true;

													$("#error_activity").show()

												} else {
													$("#error_activity").hide()
												}

												if (!$("#periodicity").val()) {
 													isError = true;

													$("#error_periodicity1")
															.show()

												} else {
													$("#error_periodicity1")
															.hide()
												}

												if (!$("#startDate").val()) {
 													isError = true;

													$("#error_startDate")
															.show()

												} else {
													$("#error_startDate")
															.hide()
												}
												
												
												
												if(${isEdit}==1){
												if (!$("#statDate").val()) {
 													isError = true;

													$("#error_statDate")
															.show()

												} else {
													$("#error_statDate")
															.hide()
												}
												}
												if(${isEdit}==0){

												var from_date = document
														.getElementById("startDate").value;
												var to_date = document
														.getElementById("endDate").value;

												var fromdate = from_date
														.split('-');
												from_date = new Date();
												from_date.setFullYear(
														fromdate[2],
														fromdate[1] - 1,
														fromdate[0]);
												var todate = to_date.split('-');
												to_date = new Date();
												to_date.setFullYear(todate[2],
														todate[1] - 1,
														todate[0]);
												if (from_date > to_date) {
 													$("#error_start_date")
															.show();
													$("#error_end_date").show();
													$("#error_startDate")
															.hide();
													$("#error_endDate").hide();
													return false;

												} else {
													$("#error_start_date")
															.hide();
													$("#error_end_date").hide();
												}
												////////
												}
												if(${isEdit}==0){
												if (!$("#statutary_endDays")
														.val()) {
													//alert("in statutary_endDays");
													isError = true;

													$("#error_stat_endDays")
															.show()

												} else {
													$("#error_stat_endDays")
															.hide()
												}
												}

												if (!$("#mgBudgetHr").val()) {
 													isError = true;

													$("#error_mgBudgetHr")
															.show()

												} else {
													$("#error_mgBudgetHr")
															.hide()
												}

												if (!$("#empBudgetHr").val()) {

													isError = true;
 													$("#error_empHrs").show()

												} else {
													$("#error_empHrs").hide()
												}
												
												if (!$("#billAmt").val()) {

													isError = true;

													$("#error_billAmt")
															.show()

												} else {
													$("#error_billAmt")
															.hide()
												}  

												var empIds=$("#empId2").val();
												
												$.getJSON('${getCountofManagers}',
								{
									empIds : JSON.stringify(empIds),
									ajax : 'true',
								},

								function(data) {
									//alert(JSON.stringify(data));
									if (data == 0) {
											isError = true;
										$("#error_emp_mng").show()

									} else {
										$("#error_emp_mng").hide()
									}
								});

												
												
												if (!isError) {

													var x = true;
													if (x == true) {

														document
																.getElementById("submtbtn").disabled = true;
														document
																.getElementById("cancelbtn").disabled = true;
														return true;
													}
													//end ajax send this to php page
												}
												return false;
											});
						});
		//
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
	<script>
		function getActivities(servId) {
			//alert("servId " +servId)
			var actId=${task.actvId}
					//alert(actId);
			
			
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
					
					//alert("hii ")
					var len = data.length;
					
					for (var i = 0; i < len; i++) {
					
						 if(data[i].actiId==actId){
							  
							// alert("matched"+data[i].actiId);
						 		flag=1;							 
					 }	

						 if(flag==1){
							 var flag=0;
						html += '<option selected value="' + data[i].actiId + '">'
								+ data[i].actiName + '</option>';
								
					}else{
						html += '<option value="' + data[i].actiId + '">'
						+ data[i].actiName + '</option>';
						}
					}

					$('#activity').html(html);
					$("#activity").trigger("chosen:updated");
					getPeriodicity();
				});

			}//end of if
		}

		//
		function getPeriodicity() {
		
		var actvityId=document.getElementById("activity").value;
	//	alert("Activity---"+actvityId);

			if (actvityId > 0) {

				$
						.getJSON(
								'${getPeridicityByActivity}',
								{
									actvityId : actvityId,
									ajax : 'true',
								},

								function(data) {
									//alert(JSON.stringify(data));
									document.getElementById("periodicity").value = data.periodicityName;
									document.getElementById("periodicityId").value = data.periodicityId;
								});

			}//end of if
		}
	</script>
</body>
</html>