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
	
		<c:url value="/getCustLoginDetailByCustDetailId" var="getCustLoginDetailByCustDetailId"></c:url>
	
	
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
								<h6 class="card-title">Customer Detail</h6>
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
									<span class="font-weight-semibold"></span>
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
								
								<form method="post"
									action="${pageContext.request.contextPath}/addCustLoginDetail"
									id="submitInsertActivity">

									<input type="hidden" id="custId" name="custId"
										value="${custId}"> <input type="hidden"
										id="custDetailId" name="custDetailId" value="0">

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="customer">
											Customer : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Customer Name" id="customer"
												value="${custName}" name="customer" autocomplete="off"
												onchange="trim(this)" readonly="readonly">
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="service">
											Service : </label>
										<div class="col-lg-4">
											<select name="service" data-placeholder="Select Service"
												id="service"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true"
												onchange="getActivities(this.value)">

												<c:forEach items="${serviceList}" var="serv">
													<option value="${serv.servId}">${serv.servName}</option>
												</c:forEach>

											</select>
										</div>

										<label class="col-form-label col-lg-2" for="activity">
											Activity : </label>
										<div class="col-lg-4">
											<select name="activity" data-placeholder="Select Activity"
												id="activity"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
											</select>
										</div>


									</div>



									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="username">Login
											Username <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Login Username" id="username"
												name="username" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_username"
												style="display: none;">Please enter login username.</span>
										</div>


										<label class="col-form-label col-lg-2" for="password">Login
											Password <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Login Password" id="password"
												name="password" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_password"
												style="display: none;">Please enter login password.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="que1">Security
											Question 1 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Security Question 1" id="que1"
												name="que1" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_que1"
												style="display: none;">Please enter security question 1.</span>
										</div>


										<label class="col-form-label col-lg-2" for="ans1">Answer
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Answer" id="ans1" name="ans1"
												autocomplete="off" onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_ans1"
												style="display: none;">Please enter answer.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="que1">Security
											Question 2 <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Security Question 2" id="que2"
												name="que2" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_que2"
												style="display: none;">Please enter security question 2.</span>
										</div>


										<label class="col-form-label col-lg-2" for="ans2">Answer
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Answer" id="ans2" name="ans2"
												autocomplete="off" onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_ans2"
												style="display: none;">Please enter answer.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="remark">Remark
											: </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Enter Remark" id="remark" name="remark"
												autocomplete="off" onchange="trim(this)">
										</div>
									</div>

									<div class="form-group row mb-0">
										<div class="col-lg-12" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											&nbsp; <a
												href="${pageContext.request.contextPath}/customerDetailList"><button
													type="button" class="btn btn-primary">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div>


								</form>


							</div>
						</div>

					</div>

					<div class="col-md-12">

						<div class="card">

							<div class="card-body">

								<form action="${pageContext.request.contextPath}/"
									id="submitInsertActivity" method="post">

									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th>Activity</th>
												<th>Login</th>
												<th>Security Questions</th>
												<th class="text-center" width="10%">Actions</th>
											</tr>
										</thead>
										<tbody>

											<c:forEach items="${custDetailList}" var="custDetail">

												<tr>
													<td>${custDetail.actiName}</td>
													<td>Username : ${custDetail.loginId}<br>Password
														: ${custDetail.loginPass}
													</td>
													<td>Que 1 : ${custDetail.loginQue1}<br>Ans 1 :
														${custDetail.loginAns1} <br>Que 2 :
														${custDetail.loginQue2}<br>Ans 2 :
														${custDetail.loginAns2}
													</td>

													<td class="text-center"><a href="#"  onclick="showEdit(${custDetail.custDetailId})" title="Edit"><i
															class="icon-pencil7" style="color: black;"></i></a> <a
														href=""
														onClick="return confirm('Are you sure want to delete this record');"
														title="Delete"><i class="icon-trash"
															style="color: black;"></i> </a></td>


												</tr>
											</c:forEach>

										</tbody>

									</table>

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
		$(document).ready(function($) {

			$("#submitInsertActivity").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if (!$("#activity").val()) {

					isError = true;

					$("#error_activityName")
							.show()
					//return false;
				} else {
					$("#error_activityName")
							.hide()
				}
 
				if (!$("#username").val()) {

					isError = true;

					$("#error_username").show()

				} else {
					$("#error_username").hide()
				}

				if (!$("#password").val()) {

					isError = true;

					$("#error_password").show()

				} else {
					$("#error_password").hide()
				}

				if (!$("#que1").val()) {

					isError = true;

					$("#error_que1").show()

				} else {
					$("#error_que1").hide()
				}

				if (!$("#ans1").val()) {

					isError = true;

					$("#error_ans1").show()

				} else {
					$("#error_ans1").hide()
				}

				if (!$("#que2").val()) {

					isError = true;

					$("#error_que2").show()

				} else {
					$("#error_que2").hide()
				}

				if (!$("#ans2").val()) {

					isError = true;

					$("#error_ans2").show()

				} else {
					$("#error_ans2").hide()
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

		function getActivities(servId) {
			//alert("servId " +servId)
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
									var p = -1;
									var q = "Select Activity";
									html += '<option disabled value="'+p+'">'
											+ q + '</option>';
									html += '</option>';

									var temp = 0;
									//temp=document.getElementById("temp").value;
									//alert("temp");
									var len = data.length;
									for (var i = 0; i < len; i++) {

										/* 	if(temp==data[i].infraAreaId){
												 html += '<option selected value="' + data[i].infraAreaId + '">'
										         + data[i].infraAreaName + '</option>';
											}
												
												else{ */

										html += '<option value="' + data[i].actiId + '">'
												+ data[i].actiName
												+ '</option>';
										//}

									}

									/*        if(temp==0){
									       	//alert("If temp==0");
									       	  var x=0;
									             var y="Any Other";
									             html += '<option selected value="'+x+'">'
									             +y+'</option>';
									             html += '</option>';
									             //document.getElementById("other_area").show();
												$("#area_name_div").show();

									            
									       }else{
									       	  /* var x=0;
									             var y="Any Other";
									             html += '<option value="'+x+'">'
									             +y+'</option>';
									             html += '</option>'; */

									// } 
									$('#activity').html(html);
									$("#activity").trigger("chosen:updated");

								});

			}//end of if
		}
		
		function showEdit(custDetailId){
			 document.getElementById("custDetailId").value="0";
			$
			.getJSON(
					'${getCustLoginDetailByCustDetailId}',
					{
						custDetailId : custDetailId,
						ajax : 'true',
					},

					function(data) {
						
						//alert(JSON.stringify(data));
						 document.getElementById("custDetailId").value=data.custDetailId;
						// document.getElementById("service").value=data.servId;
						// document.getElementById("activity").value=data.actiId;
						 document.getElementById("username").value=data.loginId;
						 document.getElementById("password").value=data.loginPass;
						 document.getElementById("que1").value=data.loginQue1;
						 document.getElementById("que2").value=data.loginQue2;
						 document.getElementById("ans1").value=data.loginAns1;
						 document.getElementById("ans2").value=data.loginAns2;
						 document.getElementById("remark").value=data.loginRemark;
						 var x=data.servId;
						$("#service").val(x).change();

					}
					)
		}
	 

	</script>

</body>
</html>