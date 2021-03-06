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
<c:url var="getCostDetail" value="getCostDetail" />
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




				<style type="text/css">
.datatable-footer {
	display: none;
}

.dataTables_length {
	display: none;
}

.datatable-header {
	display: none;
}
</style>
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Cost Dashboard</h5>

					</div>
					<div class="card-body">
						<div class="form-group row">
							<label class="col-form-label col-lg-2" for="membrId">Select
								Employee <span style="color: red">* </span>:
							</label>
							<div class="col-lg-3">
								<select name="membrId" id="membrId"
									class="form-control form-control-select2 select2-hidden-accessible"
									data-fouc="" aria-hidden="true">
									<option value="0" selected>All</option>
									<c:forEach items="${empList}" var="empList">
										<%-- <c:choose>
											<c:when test="${empList.empId==empId}">
												<option value="${empList.empId}" selected>${empList.empName}</option>
											</c:when>
											<c:otherwise> --%>
										<option value="${empList.empId}">${empList.empName}</option>
										<%-- </c:otherwise>
										</c:choose> --%>
									</c:forEach>

								</select>
							</div>
							<div class="col-lg-1"></div>
							<label class="col-form-label col-lg-2" for="monthyear">Select
								Date <span style="color: red">* </span>:
							</label>
							<div class="col-lg-3">
								<input type="text" class="form-control datepickermonth"
									id="monthyear" name="monthyear">
							</div>

						</div>

						<div class="form-group row">
							<label class="col-form-label col-lg-2" for="typeId">Select
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
									<option value="0" >All Group</option>

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
							<div class="col-lg-2">
								<button type="button" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn" onclick="getCostDetail()">Search</button>
							</div>
							<div class="col-lg-3">
<span class="validation-invalid-label" id="error_msg" style="display: none;"></span>
<span class="validation-invalid-label" id="error_msg1" style="display: none;"></span>
</div>
						</div>
						<input type="hidden" id="emp_id" name="emp_id" value="${empId}">
						<div id="loader" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>

						<div class="table-responsive">
							<table class="table text-nowrap" id="costTab">
								<thead>
									<tr class="bg-blue">

										<th>Particulars</th>
										<th style="text-align: right;">Cost</th>

									</tr>
								</thead>
								<tbody>

									<tr>
										<td>Budgeted Cost</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="2"
												minFractionDigits="2"
												value="${bugetedAmtAndRevenue.bugetedCost}" /></td>
									</tr>
									<tr>
										<td>Actual Cost</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="2"
												minFractionDigits="2"
												value="${bugetedAmtAndRevenue.actualCost}" /></td>
									</tr>
									<tr>
										<td>Budgeted Revenue</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="2"
												minFractionDigits="2"
												value="${bugetedAmtAndRevenue.bugetedRev}" /></td>
									</tr>
									<tr>
										<td>Actual Revenue</td>
										<td><fmt:formatNumber type="number" maxFractionDigits="2"
												minFractionDigits="2"
												value="${bugetedAmtAndRevenue.actulRev}" /></td>
									</tr>

								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Capacity Building</h5>

					</div>
					<div class="card-body">
						<div class="form-group row">
							<label class="col-form-label col-lg-2" for="fromDate">Select
								Date <span style="color: red">* </span>:
							</label>
							<div class="col-lg-3">
								<input type="text" class="form-control daterange-basic_new"
									placeholder="From Date" id="fromDate" name="fromDate"
									autocomplete="off" onchange="trim(this)" value="${date}">
							</div>

							<div class="col-lg-3">
								<button type="button" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn" onclick="searchManagerwiseCapacityBuilding()">Search</button>
							</div>

						</div>

						<div id="loader2" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>

						<div class="table-responsive">
							<table class="table" id="capTable">
								<thead>
									<tr class="bg-blue">

										<th style="width: 300px">Name</th>
										<th style="width: 50px;">Budgeted Capacity</th>
										<th style="width: 50px">Allocated Capacity</th>
										<th style="width: 50px">Actual Hours Worked</th>
										<th style="width: 50px">% completion bar</th>

									</tr>
								</thead>
								<tbody>
									<%-- <c:forEach items="${managerListWithEmpIds}"
										var="managerListWithEmpIds" varStatus="count">
										<c:if test="${managerListWithEmpIds.ids.size()>0}">
											<tr>

												<td><a href="#"
													onclick="showManagerDetail(${managerListWithEmpIds.empId},'${managerListWithEmpIds.empName}')">${managerListWithEmpIds.empName}</a></td>
												<td>${managerListWithEmpIds.bugetedWork}</td>
												<td>${managerListWithEmpIds.allWork}</td>
												<td>${managerListWithEmpIds.actlWork}</td>
												<td><c:set var="per"
														value="${(managerListWithEmpIds.actlWork/managerListWithEmpIds.allWork)*100}"></c:set>
													<div class="progress rounded-round">
														<div class="progress-bar bg-success"
															style="width: ${per}%">
															<span><fmt:formatNumber type="number"
																	maxFractionDigits="2" minFractionDigits="2"
																	value="${per}" />% Complete</span>
														</div>
													</div></td>
											</tr>
										</c:if>
									</c:forEach> --%>

								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Task Status breakdown</h5>

					</div>
					<div class="card-body">

						<div id="loader1" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<div class="table-responsive">
							<table class="table text-nowrap" id="breakdownTab">
								<thead>
									<tr>
										<th style="background-color: white; width: 150px">Manager
											Name</th>
										<th style="background-color: white; width: 150px">Status
											Wise Task Data</th>
										<th style="background-color: white; width: 50px;">Overdue</th>
										<th style="background-color: white; width: 50px">Due
											Today</th>
										<th style="background-color: white; width: 50px">Due this
											Week</th>
										<th style="background-color: white; width: 50px">Due this
											Month</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${stswisetaskList}" var="stswisetaskList"
										varStatus="count">

										<c:forEach items="${stswisetaskList.list}" var="list">
											<c:if
												test="${list.overdeu>0 || list.duetoday>0 || list.week>0 || list.month>0}">

												<tr>
													<td>${stswisetaskList.empName}</td>

													<td>${list.statusText}</td>
													<td><c:choose>
															<c:when test="${list.overdeu>0}">
																<%-- <a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=1&empId=${stswisetaskList.empId}">${list.overdeu}</a> --%>
															
															
															<a href="#"
																onclick="showData('taskListForEmp','${list.statusValue}','1','${stswisetaskList.empId}')">${list.overdeu}</a>
															
															
															</c:when>
															<c:otherwise>
																	${list.overdeu}
														</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${list.duetoday>0}">
																<%-- <a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=2&empId=${stswisetaskList.empId}">${list.duetoday}</a> --%>
															
															
															<a href="#"
																onclick="showData('taskListForEmp','${list.statusValue}','2','${stswisetaskList.empId}')">${list.duetoday}</a>
															</c:when>
															<c:otherwise>
																	${list.duetoday}
														</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${list.week>0}">
																<%-- <a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=3&empId=${stswisetaskList.empId}">${list.week}</a> --%>
																	
																	<a href="#"
																onclick="showData('taskListForEmp','${list.statusValue}','3','${stswisetaskList.empId}')">${list.week}</a>
															</c:when>
															<c:otherwise>
																	${list.week}
														</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${list.month>0}">
																<%-- <a
																	href="${pageContext.request.contextPath}/taskListForEmp?stat=${list.statusValue}&type=4&empId=${stswisetaskList.empId}">${list.month}</a> --%>
															
															
															<a href="#"
																onclick="showData('taskListForEmp','${list.statusValue}','4','${stswisetaskList.empId}')">${list.month}</a>
															</c:when>
															<c:otherwise>
																	${list.month}
														</c:otherwise>
														</c:choose></td>


												</tr>
											</c:if>
										</c:forEach>

									</c:forEach>

								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- Hover rows -->
				<!-- Daily Work Log modal -->
				<div id="modal_small" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header bg-success">
								<h5 class="modal-title">
									<span id="taskststext"></span>
								</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div id="showManagerDetailloader" style="display: none;">
								<img
									src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table class="table text-nowrap" id="taskDetailTab">
									<thead>
										<tr>
											<th style="background-color: white; width: 150px">Employee
												Name</th>

											<th style="background-color: white; width: 50px;">Budgeted
												Capacity</th>
											<th style="background-color: white; width: 50px">Allocated
												Capacity</th>
											<th style="background-color: white; width: 50px">Actual
												Hours Worked</th>
											<th style="background-color: white; width: 50px">%
												completion bar</th>

										</tr>
									</thead>
								</table>
							</div>


							<div class="modal-footer" style="display: none;">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
								<button type="button" class="btn bg-primary">Save
									changes</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /Daily Work Log modal -->

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


	function showData(text,value,type,empId){
	
//	alert(11);
	
	window.open("${pageContext.request.contextPath}/"+text+"?stat="+value+"&type="+type+"&empId="+empId);
 
}
</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>
	<!-- /page content -->

	<script type="text/javascript">
		//datepickermonth
		// Single picker
		$('.datepickermonth').daterangepicker({
			singleDatePicker : false,
			drops:'down',
			opens:'left',
			//showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}

		});
		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			drops:'left',
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
		function searchManagerwiseCapacityBuilding() {

			//alert("Hi View Orders  ");

			var fromDate = document.getElementById("fromDate").value;

			$("#loader2").show();

			$
					.getJSON(
							'${searchManagerwiseCapacityBuilding}',
							{
								fromDate : fromDate,
								ajax : 'true',
							},

							function(data) {
								//alert(data);

								$("#capTable tbody").empty();

								$
										.each(
												data,
												function(i, v) {

													try{
														
													
													if (v.ids.length > 0) {
														
														var empDetailLink = '<a href="#"'+
														'onclick="showManagerDetail('+v.empId+',\''+v.empName+'\')">'+v.empName+'</a>';
														 
														
														var per = (v.actlWork / v.allWork) * 100
														var str = '<div class="progress rounded-round"> <div class="progress-bar bg-success" style="width: '
																+ per
																+ '%">'
																+ '<span>'
																+ per
																		.toFixed(2)
																+ '% Complete</span> </div> </div>';

														var tr_data = '<tr>'
																+ '<td  >'
																+ empDetailLink
																+ '</td>'
																+ '<td  >'
																+ v.bugetedWork 
																+ '</td>'
																+ '<td  >'
																+ v.allWork 
																+ '</td>'
																+ '<td  >'
																+ v.actlWork 
																+ '</td>'
																+ '<td  >'
																+ str + '</td>'
																+ '</tr>';
														$(
																'#capTable'
																		+ ' tbody')
																.append(tr_data);
													}
												}catch{
														
													}
												});

								$("#loader2").hide();

							});

		}

		function showManagerDetail(empId, empname) {
			
			var fromDate = document.getElementById("fromDate").value;
			document.getElementById("taskststext").innerHTML = empname;
			$("#showManagerDetailloader").show();
			$('#modal_small').modal('show');

			  $.getJSON('${showManagerDetail}', {
				fromDate : fromDate,
				empId : empId,
				ajax : 'true',

			}, function(data) {

				var dataTable = $('#taskDetailTab').DataTable();
				dataTable.clear().draw();

				$.each(data, function(i, v) {
 
					var per = (v.actWork / v.allWork) * 100
					var str = '<div class="progress rounded-round"> <div class="progress-bar bg-success" style="width: '
							+ per
							+ '%">'
							+ '<span>'
							+ per.toFixed(2)
							+ '% Complete</span> </div> </div>'
							
					dataTable.row.add(
							[ v.empName, v.bugetedCap, v.allWork, v.actWork, str

							]).draw();

				});

				$("#showManagerDetailloader").hide();
			});
 
		}

		function getCostDetail() {

			var membrId = document.getElementById("membrId").value;
			var monthyear = document.getElementById("monthyear").value;
			var typeId = document.getElementById("typeId").value;
			var groupId = document.getElementById("groupId").value;
			var clientId = document.getElementById("clientId").value;
			
			var flag=1;
			
			if(typeId==1){
				groupId=-1;
			}else{
				
				if(groupId==-1){
					//alert("Select Group");
					document.getElementById("error_msg1").innerHTML="Select Group";
					$("#error_msg1").show();
					flag=0;
				}else{
					$("#error_msg1").hide();
				}
			}
			 
			if(clientId==-1 || clientId==""){
				//alert("Select Client");
				document.getElementById("error_msg").innerHTML="Select Client";
				$("#error_msg").show();
				flag=0;
			}else{
				$("#error_msg").hide();
			}
			
			if(flag==1){
			$("#loader").show();
			$.getJSON('${getCostDetail}', {
				membrId : membrId,
				monthyear : monthyear,
				typeId : typeId,
				groupId : groupId,
				clientId : clientId,
				ajax : 'true',

			}, function(data) {

				//alert(JSON.stringify(data))
				$("#costTab tbody").empty();

				var bugetedCost = '<tr> <td>Budgeted Cost</td> <td align="right">'
						+ data.bugetedCost.toFixed(2) + '</td></tr>';
				$('#costTab' + ' tbody').append(bugetedCost);

				var actualCost = '<tr> <td>Actual Cost</td> <td align="right">'
						+ data.actualCost.toFixed(2) + '</td></tr>';
				$('#costTab' + ' tbody').append(actualCost);

				var bugetedRev = '<tr> <td>Budgeted Revenue</td> <td align="right">'
						+ data.bugetedRev.toFixed(2) + '</td></tr>';
				$('#costTab' + ' tbody').append(bugetedRev);

				var actualRev = '<tr> <td>Actual Revenue</td> <td align="right">'
						+ data.actulRev.toFixed(2) + '</td></tr>';
				$('#costTab' + ' tbody').append(actualRev);
				$("#loader").hide();
			});
			}
		}
		
		function disableGroupList() {
			var typeId = document.getElementById("typeId").value;
			
			if(typeId==1){
 				document.getElementById("groupId").disabled=true;
				getClientList(-1);
			}else{
 				var groupId = document.getElementById("groupId").value; 
				document.getElementById("groupId").disabled=false;
				var html; 
				html += '<option disabled value="0">Select Client</option>'; 
				$('#clientId').html(html);
				$("#clientId").trigger("chosen:updated");
				getClientList(groupId);
			}

		}
		
		function getClientList(groupId) {
			var typeId = document.getElementById("typeId").value;

				$
						.getJSON(
								'${getClientList}',
								{
									groupId : groupId,
									ajax : 'true',
								},

								function(data) {
									var html;
									 
									html += '<option disabled value="-1">Select Client</option>'; 
									var len = data.length;
									//alert("groupId" +groupId + " len " +len )
									//if(groupId>0 && len>0){
										if(groupId==0 && len>0 && typeId==0){
										html += '<option value="0" selected>All</option>'; 
									}else if(groupId>0 && len>0){
										html += '<option value="0" selected>All</option>'; 
									}
									for (var i = 0; i < len; i++) {
										html += '<option value="' + data[i].id + '">'
												+ data[i].name
												+ '</option>';

									}

									$('#clientId').html(html);
									$("#clientId").trigger("chosen:updated");

								});

			 
		}
	</script>
</body>
</html>