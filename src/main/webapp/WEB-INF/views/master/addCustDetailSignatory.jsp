<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="hideAddForm()">
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>

	<c:url value="/getCustLoginDetailByCustDetailId"
		var="getCustLoginDetailByCustDetailId"></c:url>
	<c:url value="/getCustSignatoryBySignId" var="getCustSignatoryBySignId"></c:url>

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

<!-- 
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


				</div> -->
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->

				<div class="row">


					<div class="col-md-12" id="abc">


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
							<span class="font-weight-semibold"></span>
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
												onchange="getActivities(this.value,0)">

												<c:forEach items="${serviceList}" var="serv">
													<option value="${serv.servId}">${serv.servName}</option>
												</c:forEach>

											</select>
										</div>
										<label class="col-form-label col-lg-2" for="activity">
											Activity <span style="color: red">* </span>:
										</label>
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
											Username <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Login Username" id="username"
												name="username" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_username"
												style="display: none;">Please enter login username.</span>
										</div>


										<label class="col-form-label col-lg-2" for="password">Login
											Password <span style="color: red"></span>:
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
											Question 1 <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Security Question 1" id="que1"
												name="que1" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_que1"
												style="display: none;">Please enter security question
												1.</span>
										</div>


										<label class="col-form-label col-lg-2" for="ans1">Answer
											<span style="color: red"> </span>:
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
											Question 2 <span style="color: red"> </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Security Question 2" id="que2"
												name="que2" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_que2"
												style="display: none;">Please enter security question
												2.</span>
										</div>


										<label class="col-form-label col-lg-2" for="ans2">Answer
											<span style="color: red"> </span>:
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
									<!-- Customer Detail End -->

									<!-- Customer Signatory Start -->

									<!-- <div class="card-header header-elements-inline">
										<h6 class="card-title">Customer Signatory</h6>
								</div> -->

									<%-- <div class="form-group row">
										<label class="col-form-label col-lg-2" for="customer">
											Customer : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Customer Name" id="customer" name="customer"
												autocomplete="off" value="${custName}" onchange="trim(this)" readonly="readonly">
										</div>
									</div> --%>

									<legend
										class="font-weight-semibold text-uppercase font-size-sm">Signatory
										Information</legend>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="signFName">
											First Name <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter First Name" id="signFName"
												name="signFName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_signFName"
												style="display: none;">Please enter first name.</span>
										</div>


										<label class="col-form-label col-lg-2" for="signLName">
											Last Name <span style="color: red"> </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Last Name" id="signLName"
												name="signLName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_signLName"
												style="display: none;">Please enter last name.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="regNo">Register
											Number <span style="color: red"> </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Registration Number" id="regNo"
												name="regNo" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_regNo"
												style="display: none;">Please enter register No.</span>
										</div>


										<label class="col-form-label col-lg-2" for="desg">Designation
											<span style="color: red"> </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Designation" id="desg" name="desg"
												autocomplete="off" onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_desg"
												style="display: none;">Please enter designation.</span>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="signMobile">
											Contact Number <span style="color: red"> </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Signatory Contact Number" id="signMobile"
												name="signMobile" autocomplete="off" onchange="trim(this)"
												maxlength="10"> <span
												class="validation-invalid-label" id="error_signMobile"
												style="display: none;">Please enter contact No.</span>
										</div>

									</div>

									<legend
										class="font-weight-semibold text-uppercase font-size-sm">Contact
										Person Information</legend>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="contPerName">
											Name <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Contact Person Name" id="contPerName"
												name="contPerName" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label" id="error_contPerName"
												style="display: none;">Please enter name.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="contPerEmail">
											Email <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Email Address" id="contPerEmail"
												name="contPerEmail" autocomplete="off" onchange="trim(this)">
											<span class="validation-invalid-label"
												id="error_contPerEmail" style="display: none;">Please
												enter email.</span>
										</div>


										<label class="col-form-label col-lg-2" for="contPerNo">Contact
											Number <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												placeholder="Enter Contact Number" id="contPerNo"
												maxlength="10" name="contPerNo" autocomplete="off"
												onchange="trim(this)"> <span
												class="validation-invalid-label" id="error_contPerNo"
												style="display: none;">Please enter contact No.</span>
										</div>

									</div>


									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="remark">Remark
											: </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Enter Remark" id="sigremark" name="sigremark"
												autocomplete="off" onchange="trim(this)">
										</div>
									</div>



									<!-- Customer Signatory End -->

									<div class="form-group row mb-0">
										<div class="col-lg-12" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											&nbsp; <a
												href="${pageContext.request.contextPath}/customerDetailList"><button
													type="button" class="btn btn-primary" id="cancelbtn">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Cancel
												</button></a>
										</div>
									</div>


								</form>


							</div>
						</div>

					</div>

					<div class="col-md-12" id="custsiglist">

						<div class="card">

							<div class="card-header header-elements-inline">

								<table width="100%">
									<tr width="100%">
										<td width="60%"><h5 class="card-title"></h5></td>
										<td width="40%" align="right">
											<button type="button" onclick="showAddForm()"
												class="btn btn-primary">Add Customer Detail</button>
										</td>
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
									<span class="font-weight-semibold"></span>
									<%
										out.println(session.getAttribute("successMsg"));
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%> 

								<form id="submitInsertActivity1" method="post">

									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th>Sr. No.</th>
												<th>Activity</th>
												<th>Customer Name</th>
												<th>Login</th>
												<th>Security Questions</th>
												<th>Signatory</th>
												<th>Designation</th>
												<th>Contact Person Name</th>
												<th>Contact Person Mobile</th>
												<th class="text-center" width="10%">Actions</th>
											</tr>
										</thead>
										<tbody>

											<c:forEach items="${custDetailList}" var="custDetail"
												varStatus="count">

												<tr>
													<td>${count.index+1}</td>
													<td>${custDetail.actiName}</td>
													<td>${custDetail.custFirmName}</td>
													<td>Username : ${custDetail.loginId}<br>Password
														: ${custDetail.loginPass}
													</td>
													<td>Que 1 : ${custDetail.loginQue1}<br>Ans 1 :
														${custDetail.loginAns1} <br>Que 2 :
														${custDetail.loginQue2}<br>Ans 2 :
														${custDetail.loginAns2}
													</td>
													<td>${custDetail.signfName}&nbsp;${custDetail.signlName}</td>
													<td>${custDetail.signDesign}</td>
													<td>${custDetail.contactName}</td>
													<td>${custDetail.contactPhno}</td>
													<td class="text-center"><a href="#"
														onclick="showEdit(${custDetail.custDetailId})"
														title="Edit"><i class="icon-pencil7"
															style="color: black;"></i></a> <%-- <a
														href="${pageContext.request.contextPath}/deletCustDetail?custDetId=${custDetail.custDetailId}"
														onClick="return confirm('Are you sure want to delete this record');"
														title="Delete"><i class="icon-trash"
															style="color: black;"></i> </a> --%>
															
															
															  <a href="javascript:void(0)"
class="list-icons-item text-danger-600 bootbox_custom"
data-uuid="${custDetail.custDetailId}" data-popup="tooltip"
title="" data-original-title="Delete"><i class="icon-trash" style="color: black;"></i></a>
															
															
															</td>


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

			<div class="content"></div>

			<!-- /content area -->

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	<script type="text/javascript">
function showAddForm(){
	 var x = document.getElementById("abc");
	  if (window.getComputedStyle(x).display == "none") {
		  document.getElementById("abc").style.display="block";
		  document.getElementById("custsiglist").style.display="none";
		  
	  }else {
		  document.getElementById("abc").style.display="none";
	  }
	 
}
function hideAddForm(){
	  document.getElementById("abc").style.display="none";
}



</script>
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
location.href = "${pageContext.request.contextPath}/deletCustDetail?custDetId="
+ uuid;

}
}
});
});
</Script>


	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>

	<script>
	$('#signMobile').on('input', function() {
		  this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		});
	
	$('#contPerNo').on('input', function() {
		  this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		});
	
		 $(document).ready(function($) {

			$("#submitInsertActivity").submit(function(e) {
				var isError = false;
				var errMsg = "";

				/* if (!$("#activity").val()) {

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
				}  */

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
 
		function getActivities(servId,valid) {
	
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
									//
									if(valid>0){
										$("#activity").val(valid);
									}

								});

			}//end of if
		}
		
	function showEdit(custDetailId){
	//alert("call--------"+custDetailId)
		document.getElementById("custDetailId").value="0";
		var x = document.getElementById("abc");
		
		if (window.getComputedStyle(x).display == "none") {
		  document.getElementById("abc").style.display="block";
		  document.getElementById("custsiglist").style.display="none";
	
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
						 
						 document.getElementById("signFName").value=data.signfName;
						 document.getElementById("signLName").value=data.signlName;
						 document.getElementById("regNo").value=data.signRegNo;
						 document.getElementById("desg").value=data.signDesign;
						 document.getElementById("signMobile").value=data.signPhno;
						 document.getElementById("contPerName").value=data.contactName;
						 document.getElementById("contPerEmail").value=data.contactEmail;
						 document.getElementById("contPerNo").value=data.contactPhno;
						 document.getElementById("sigremark").value=data.custRemark;
		
						 var x=data.servId;
						$("#service").val(x).change();
						getActivities(x,data.actvId);
						//$("#service").val(x);
						//var html = '<option selected value="' + data.actvId + '">'+ data.actiName+'</option>';
						//$('#activity').html(html);
						//$("#activity").trigger("chosen:updated");
						 
						 
						
						//$("#activity").val(data.actvId);
						//alert($("#activity").val());
					}
					);
	  }else{
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
						 
						 document.getElementById("signFName").value=data.signfName;
						 document.getElementById("signLName").value=data.signlName;
						 document.getElementById("regNo").value=data.signRegNo;
						 document.getElementById("desg").value=data.signDesign;
						 document.getElementById("signMobile").value=data.signPhno;
						 document.getElementById("contPerName").value=data.contactName;
						 document.getElementById("contPerEmail").value=data.contactEmail;
						 document.getElementById("contPerNo").value=data.contactPhno;
						 document.getElementById("sigremark").value=data.custRemark;
		
						 var x=data.servId;
						$("#service").val(x).change();
						getActivities(x,data.actvId);
						//$("#service").val(x);
						//var html = '<option selected value="' + data.actvId + '">'+ data.actiName+'</option>';
						//$('#activity').html(html);
						//$("#activity").trigger("chosen:updated");
						 
						 
						
						//$("#activity").val(data.actvId);
						//alert($("#activity").val());
					}
					);
	 		 }
		
		}
	 
	</script>


</body>
</html>