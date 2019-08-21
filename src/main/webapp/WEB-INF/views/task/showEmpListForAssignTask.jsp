<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<c:url var="getFreeEmployeeList" value="/getFreeEmployeeList" />
<c:url var="moveEmp" value="/moveEmp" />
<c:url var="deleteEmp" value="/deleteEmp" />
<c:url var="getEmployeeAllocatedHistory"
	value="/getEmployeeAllocatedHistory" />
</head>
<style>
* {
	box-sizing: border-box;
}

.myInput {
	background-image: url('https://www.w3schools.com/css/searchicon.png');
	background-position: 8px 5px;
	background-repeat: no-repeat;
	width: 20%;
	font-size: 12px;
	padding: 5px 5px 5px 40px;
	border: 1px solid #ddd;
	border-radius: 20px;
	margin-bottom: 12px;
}

#myTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 18px;
}

#myTable th, #myTable td {
	text-align: left;
	padding: 12px;
}

#myTable tr {
	border-bottom: 1px solid #ddd;
}

#myTable tr.header, #myTable tr:hover {
	background-color: #f1f1f1;
}
</style>
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
								<h6 class="card-title">Task Allotment</h6>
								<!-- 	<div class="header-elements">
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
									action="${pageContext.request.contextPath}/submitProjectAllotment"
									id="submitInsertEmpType" method="post">


									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="empType">Type
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<select name="empType"
												data-placeholder="Select Employee Type" id="empType"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="">Select Employee Type</option>
												<option value="1" ${employee.empType == 1 ? 'selected' : ''}>Admin</option>
												<option value="2" ${employee.empType == 2 ? 'selected' : ''}>Partner</option>
												<option value="3" ${employee.empType == 3 ? 'selected' : ''}>Manager</option>
												<option value="4" ${employee.empType == 4 ? 'selected' : ''}>Team
													Leader</option>
												<option value="5" ${employee.empType == 5 ? 'selected' : ''}>Employee</option>

											</select>
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_empType"
												style="display: none;">Please select employee type.</span>
										</div>

									</div>





									<div class="form-group" style="text-align: center;">


										<button type="button" class="btn bg-blue ml-3 legitRipple"
											id="searchbtn" onclick="getFreeEmployeeList()">Search</button>

									</div>
									<br>

									<div id='loader' style='display: none;'>
										<img
											src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
											width="150px" height="150px"
											style="display: block; margin-left: auto; margin-right: auto">
									</div>

									<div class="row">
										<div class="col-md-5">
											<input type="text" id="printtable1" class="myInput"
												onkeyup="myFunction()" placeholder="Search for employee.."
												title="Type in a name">
											<div class="table-responsive">
												<table
													class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
													id="printtable1">
													<thead>
														<tr class="bg-blue">
															<th width="20%">Sr. No. <input type="checkbox"
																name="selAll" id="selAll" /></th>
															<th>Employee Name</th>

															<th width="15%" style="text-align: center;">Action</th>
														</tr>
													</thead>
													<tbody>

													</tbody>
												</table>
											</div>
										</div>
										<div class="col-md-1" style="text-align: center;">
											<a onclick="moveEmp()"><i
												class="icon-drag-right "></i></a>
										</div>

										<div class="col-md-6">
											<input type="text" id="myInput1" class="myInput"
												onkeyup="myFunction1()" placeholder="Search for employee.."
												title="Type in a name">
											<div class="table-responsive">
												<table
													class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
													id="printtable2">
													<thead>
														<tr class="bg-blue">
															<th width="20%">Sr. No.</th>
															<th>Employee Name</th>

															<th width="10%" style="text-align: center;">Action</th>
														</tr>
													</thead>
													<tbody>


													</tbody>
												</table>
											</div>
										</div>
									</div>
									<br>
									<div class="form-group" style="text-align: center;">
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">
											Submit <i class="icon-paperplane ml-2"></i>
										</button>
										<a href="${pageContext.request.contextPath}/assignTask"><button
												type="button" class="btn bg-blue ml-3 legitRipple"
												id="searchbtn">Cancel</button></a>
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
	<script type="text/javascript">
	$(document).ready(
			function() {
				//$('#bootstrap-data-table-export').DataTable();

				$("#selAll").click(
						function() {
							$('#printtable1 tbody input[type="checkbox"]')
									.prop('checked', this.checked);
						});
			});
	
		function getFreeEmployeeList() {

			var catId = document.getElementById("empType").value;

			if (catId == "") {
				$("#error_empType").show();
			} else {

				$("#error_empType").hide();

				$("#loader").show();
				//alert(selectedValues);
				$.getJSON('${getFreeEmployeeList}', {
					catId : catId,
					ajax : 'true',

				}, function(data) {
					$("#loader").hide();
					//alert("hii");
					//alert(data);
					for (var i = 0; i < data.length; i++) {
						var tr_data = '<tr>'
						+ '<td  >'
						+ (i + 1) 
						+ ' '
						+ '<input type="checkbox" class="chk" name="empIds" id="empIds'+i+'" value="'+data[i].empId+'" data-empName="'+data[i].empName+'"  />'
						+'</td>'
								+ '<td  >' + data[i].empName + '</td>'
								+ '<td  ></td>' + '</tr>';
								$('#printtable1' + ' tbody').append(
										tr_data);
						//alert(data[i].empName);
					}

				});

			}
		}

		function moveEmp() {

			var index = "-1";
			$('.chk:checkbox:checked')
					.each(
							function(i) {
								var val = $(this).val();

								if (val != 'on') {
								
									index = index + "," + val;
								}
							});
			
			
			//alert("index**"+index);
				$("#loader").show();
				$
						.getJSON(
								'${moveEmp}',
								{

									empId : index,
									ajax : 'true',

								},
								function(data) {
									alert(data);
									alert("tot data is "+JSON.stringify(data));

									$("#loader").hide();
									$("#printtable1 tbody").empty();

									
										for (var i = 0; i < data.bsyList.length; i++) {
											var tr_data = '<tr>'
											+ '<td  >'
											+ (i + 1) 
											+ ' '
											+ '<input type="checkbox" class="chk" name="empIds" id="empIds'+i+'" value="'+data.bsyList[i].empId+'" data-empNname="'+data.bsyList[i].empName+'"   />'											+'</td>'
													+ '<td  >' + data.bsyList[i].empName + '</td>'
													+ '<td  ></td>' + '</tr>';
													$('#printtable1' + ' tbody').append(
															tr_data);
											//alert(data[i].empName);
										}

									$("#printtable2 tbody").empty();
									
								
										for (var i = 0; i < data.freeList.length; i++) {
											var tr_data = '<tr>'
											+ '<td  >'
											+ (i + 1) 
											+ ' '
											+ '<input type="checkbox" class="chk" name="empIds" id="empIds'+i+'" value="'+data.freeList[i].empName+'" data-empNname="'+data.freeList[i].empName+'"   />'											+'</td>'
											+'</td>'
													+ '<td  >' + data.freeList[i].empName + '</td>'
													+ '<td  ></td>' + '</tr>';
													$('#printtable2' + ' tbody').append(
															tr_data);
											//alert(data[i].empName);
										}

									
									document.getElementById("selAll").checked = false;
								});
			

		}


	
	</script>

	<script>
		
		function deleteEmp(empId) {
			$("#loader").show();
			$
					.getJSON(
							'${deleteEmp}',
							{

								empId : empId,
								ajax : 'true',

							},
							function(data) {
								$("#loader").hide();
								$("#printtable1 tbody").empty();

								for (var i = 0; i < data.freeList.length; i++) {

									if (data.freeList[i].exInt1 == 1) {
										partialFull = "Partial";
									} else {
										partialFull = "Full";
									}

									var tr_data = '<tr>'
											+ '<td  >'
											+ (i + 1)
											+ ' '
											+ '<input type="checkbox" class="chk" name="empIds" id="empIds'+i+'" value="'+i+'" data-empFname="'+data.freeList[i].empFname+'" data-empSname="'+data.freeList[i].empSname+'"   />'
											+ '</td>'
											+ '<td  >'
											+ data.freeList[i].empFname
											+ ' '
											+ data.freeList[i].empSname
											+ '</td>'
											+ '<td  >'
											+ partialFull
											+ '</td>'
											+ '<td  >   <a onclick="getEmpHistory('
											+ data.freeList[i].empId
											+ ');"><i class="fas fa-list"></i></a></td>'
											+ '</tr>';
									$('#printtable1' + ' tbody')
											.append(tr_data);
								}

								$("#printtable2 tbody").empty();

								for (var i = 0; i < data.bsyList.length; i++) {

									var atn;
									var partialFull;
									if (data.bsyList[i].pallotId == 0) {
										atn = '<td  >  <a  onclick="deleteEmp('
												+ i
												+ ')"><i class="icon-trash"></i></a></td>';
									} else {
										atn = '<td  >  </td>';
									}

									if (data.bsyList[i].exInt1 == 1) {
										partialFull = 'Partial';
									} else {
										partialFull = 'Full';
									}

									var tr_data = '<tr>' + '<td  >' + (i + 1)
											+ '</td>' + '<td  >'
											+ data.bsyList[i].empFname + ' '
											+ data.bsyList[i].empSname
											+ '</td>' + '<td  >'
											+ data.bsyList[i].pallotFromdt
											+ '</td>' + '<td  >'
											+ data.bsyList[i].pallotTodt
											+ '</td>' + '<td  >' + partialFull
											+ '</td>' + '<td  >'
											+ data.bsyList[i].pallotDailyHrs
											+ '</td>' + atn + '</tr>';
									$('#printtable2' + ' tbody')
											.append(tr_data);
								}

							});

		}
		
		
		
		$(document).ready(function($) {

			$("#submitInsertEmpType").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if (!isError) {

					var x = confirm("Do you really want to submit the form?");
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
		function myFunction() {
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("myInput");
			filter = input.value.toUpperCase();
			table = document.getElementById("printtable1");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[1];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script>
	<script>
		function myFunction1() {
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("myInput1");
			filter = input.value.toUpperCase();
			table = document.getElementById("printtable2");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[1];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script>
	<!-- Scrollable modal -->
	<!-- <div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Fill Info</h5>
					<br>
					<div class="col-md-10">

						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="selectWorkType"
								id="fulltimeWorkType" checked value="2"
								onclick="opneCloseHoursDiv(2)"> Full Time
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="form-check-input" name="selectWorkType"
								id="parttimeWorkType" value="1" onclick="opneCloseHoursDiv(1)">
								Partial Time
							</label>
						</div>
						<span class="validation-invalid-label" id="error_fullTimeError"
							style="display: none;">You Can't Select Full Time</span>
					</div>

					<div class="col-lg-10" style="display: none;" id="hoursDiv">
						<label class="col-form-label col-lg-5" for="hours"> Enter
							Hours :<span style="color: red">* </span>
						</label>
						<div class="col-md-10">
							<input type="text" class="form-control" name="hours"
								data-placeholder="Enter Hours" id="hours" autocomplete="off">
							<span class="validation-invalid-label" id="error_hours"
								style="display: none;">Enter Valid Hours </span>
						</div>

					</div>
				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="moveEmp()">Add</button>
					<input id="tempEmpId" name="tempEmpId" type="hidden">
				</div>
			</div>
		</div>
	</div> -->

	<!-- Full width modal -->
	<div id="modal_full" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-full">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Fill Info</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body">

					<div class="form-group row">
						<label class="col-form-label col-lg-2" for="fulltimeWorkType">
							Select : <span style="color: red">* </span>
						</label>
						<div class="col-lg-10">
							<div class="form-check form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="selectWorkType"
									id="fulltimeWorkType" checked value="2"
									onclick="opneCloseHoursDiv(2)"> Full Time
								</label>
							</div>
							<div class="form-check form-check-inline">
								<label class="form-check-label"> <input type="radio"
									class="form-check-input" name="selectWorkType"
									id="parttimeWorkType" value="1" onclick="opneCloseHoursDiv(1)">
									Partial Time
								</label>
							</div>
							<span class="validation-invalid-label" id="error_fullTimeError"
								style="display: none;">You Can't Select Full Time</span>
						</div>
					</div>

					<div class="form-group row" style="display: none;" id="hoursDiv">
						<label class="col-form-label col-lg-2" for="hours">Enter
							Hours :<span style="color: red">* </span>
						</label>
						<div class="col-lg-10">
							<input type="text" class="form-control" name="hours"
								data-placeholder="Enter Hours" id="hours" autocomplete="off">
							<span class="validation-invalid-label" id="error_hours"
								style="display: none;">Enter Valid Hours </span>
						</div>
					</div>


					<table
						class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
						id="tempallocatedTable">
						<thead>
							<tr class="bg-blue">
								<th width="10%">Sr. No.</th>
								<th>Employee Name</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					<br>

					<div class="modal-footer" style="text-align: center;">
						<button type="button" class="btn bg-primary" data-dismiss="modal">Cancel</button>
						<!-- <button type="button" class="btn bg-primary"
							onclick="getEmpHistory()">History</button> -->
						<button type="button" class="btn bg-primary" onclick="moveEmp()">Add</button>
						<input id="tempEmpId" name="tempEmpId" type="hidden"> <input
							id="tempEmployeeId" name="tempEmployeeId" type="hidden">
					</div>

				</div>


			</div>
		</div>
	</div>
	<!-- /full width modal -->

	<div class="modal fade" data-backdrop="false" id="historyTableDiv">
		<div class="modal-dialog modal-full">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Employee History</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body">

					<table
						class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
						id="historyTable">
						<thead>
							<tr class="bg-blue">
								<th width="10%">Sr. No.</th>
								<th>Project Name</th>
								<th width="10%">Half/Full</th>
								<th width="10%">From Date</th>
								<th width="10%">To Date</th>
								<th width="10%">Hours</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>

				</div>


			</div>
		</div>
	</div>
	<!-- /scrollable modal -->

</body>
</html>