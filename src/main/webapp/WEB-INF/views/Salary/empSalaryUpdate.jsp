<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>
	<c:url value="/getPrevSalList" var="getPrevSalList"></c:url>

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
								class="breadcrumb-item active"></span>
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

						<div class="card">

							<div class="card-header header-elements-inline">
								<h6 class="card-title" id="headTitle">Employee Salary Update</h6>
								
							</div>
							
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


							<div class="card-body">
								<form
									action="${pageContext.request.contextPath}/updateEmpsalary"
									id="submitInsertActivity1">


									<div class="form-group row">

										<label class="col-form-label col-lg-1" for="month"
											align="left"> Month <span style="color: red">*
										</span>:
										</label>
										<div class="col-lg-2">
											<select name="month" data-placeholder="Select Month"
												id="month"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="1" ${month == 1 ? 'selected' : ''}>JAN</option>
												<option value="2" ${month == 2 ? 'selected' : ''}>FEB</option>
												<option value="3" ${month == 3 ? 'selected' : ''}>MAR</option>
												<option value="4" ${month == 4 ? 'selected' : ''}>APR</option>
												<option value="5" ${month == 5 ? 'selected' : ''}>MAY</option>
												<option value="6" ${month == 6 ? 'selected' : ''}>JUN</option>
												<option value="7" ${month == 7 ? 'selected' : ''}>JUL</option>
												<option value="8" ${month == 8 ? 'selected' : ''}>AUG</option>
												<option value="9" ${month == 9 ? 'selected' : ''}>SEP</option>
												<option value="10" ${month == 10 ? 'selected' : ''}>OCT</option>
												<option value="11" ${month == 11 ? 'selected' : ''}>NOV</option>
												<option value="12" ${month == 12 ? 'selected' : ''}>DEC</option>

											</select>
										</div>

										<label class="col-form-label col-lg-2" for="empService"
											align="right">Financial Year<span style="color: red">*
										</span>:
										</label>
										<div class="col-lg-2">
											<select name="finYear"
												data-placeholder="Select Financial Year" id="finYear"
												 
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<c:forEach items="${fyList}" var="fyList">
													<c:choose>
														<c:when test="${fyList.finYearId==finYear}">
															<option selected value="${fyList.finYearId}">${fyList.finYearName}</option>
														</c:when>

														<c:otherwise>
															<option value="${fyList.finYearId}">${fyList.finYearName}</option>
														</c:otherwise>

													</c:choose>

												</c:forEach>


											</select>
										</div>
										
<div class="col-lg-1">
											<input type="button" onclick="getPrevMonthSalaryData()" class="btn bg-blue ml-3 legitRipple" value="Search">
										</div>
										<div class="col-lg-1"> &nbsp;
											<span class="validation-invalid-label" id="error_fyList"
												style="display: none;">Please Select Financial Year .</span>
										</div>
<div id="loader1" style="display: none;">
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
									</div>

									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th width="10%">Sr.no</th>

												<th>Employee Name</th>
												<th>Employee Type</th>
												<th>Date of Birth</th>
												<th>Official Email Id</th>
												<th>Contact No.</th>
												<th>Prev Salary</th>
												<th>Salary</th>

											</tr>
										</thead>

										<c:forEach items="${epmList}" var="epmList" varStatus="count">
											<tr>
												<td>${count.index+1}</td>

												<td>${epmList.empName}</td>
												<td>${epmList.empType==1 ? 'Admin': epmList.empType==2 ? 'Partner' : epmList.empType==3 ? 'Manager' : epmList.empType==4 ? 'Team Leader' : epmList.empType==5 ? 'Employee' : ''}</td>
												<td>${epmList.empDob}</td>
												<td>${epmList.empEmail}</td>
												<td>${epmList.empMob}</td>
												<td><input type="text" name="prevSal${epmList.empId}"
													value="0" id="prevSal${epmList.empId}" class="form-control"
													readonly></td>
												<td><input type="text" name="currSal${epmList.empId}"
													maxlength="7" value="0" id="currSal${epmList.empId}"
													class="form-control"></td>

											</tr>
										</c:forEach>

									</table>

									<div class="form-group row mb-0">
										<div class="col-lg-12 ml-lg-auto" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
										<%-- 	<a href="#"><button type="button" class="btn btn-primary">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a> --%>
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
	<script type="text/javascript">
		function changeMonth() {
			//alert("hii")

			var el = document.getElementById('month');
			var text = el.options[el.selectedIndex].innerHTML;
			//alert(text);

		}

		function getPrevMonthSalaryData() {
			$("#loader1").show();
			var month = document.getElementById("month").value;
			var finYear = document.getElementById("finYear").value;
			var el = document.getElementById('month');
			var text = el.options[el.selectedIndex].innerHTML;
			
			var el1 = document.getElementById('finYear');
			var text1 = el1.options[el1.selectedIndex].innerHTML;
			 document.getElementById("headTitle").innerHTML="Employee Salary Update " +text+" - " +text1
			//alert(selectedValues);
			$
					.getJSON(
							'${getPrevSalList}',
							{
								finYear : finYear,
								ajax : 'true',

							},
							function(data) {
								if (data.empSalList == "") {
									$("input:text").val("0");
								}

								//alert("data"+JSON.stringify(data));
								for (var i = 0; i < data.empSalList.length; i++) {

									for (var j = 0; j < data.empList.length; j++) {

										if (data.empSalList[i].empId == data.empList[j].empId) {

											if (month == 1) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].jan;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].dece;

											} else if (month == 2) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].feb;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].jan;

											} else if (month == 3) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].mar;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].feb;

											} else if (month == 4) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].apr;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].mar;

											} else if (month == 5) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].may;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].apr;

											} else if (month == 6) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].jun;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].may;

											} else if (month == 7) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].jul;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].jun;

											} else if (month == 8) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].aug;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].jul;

											} else if (month == 9) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].sep;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].aug;

											} else if (month == 10) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].oct;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].sep;

											} else if (month == 11) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].nov;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].oct;

											} else if (month == 12) {
												document
														.getElementById("currSal"
																+ data.empList[j].empId).value = data.empSalList[i].dece;
												document
														.getElementById("prevSal"
																+ data.empList[j].empId).value = data.empSalList[i].nov;

											}

										}

									}

								}
								$("#loader1").hide();
							});

		}

		$('.form-control').on(
				'input',
				function() {
					this.value = this.value.replace(/[^0-9.]/g, '').replace(
							/(\..*)\./g, '$1');
				});
	</script>
	<script>
		$(document).ready(function($) {

			$("#submitInsertClient").submit(function(e) {
				var isError = false;
				var errMsg = "";
				form

				if ($("#finYear").val() == "") {

					isError = true;

					$("#error_fyList").show()
					//return false;
				} else {
					$("#error_fyList").hide()
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

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>




</body>
</html>