<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="showDiv(${setType})">


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
								class="breadcrumb-item active">Activity</span>
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
								<h6 class="card-title">Statutory Date Setting for Assign Task</h6>
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
									<span class="font-weight-semibold"> </span>
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
									<span class="font-weight-semibold"> </span>
									<%
										session.removeAttribute("successMsg");
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>

								<form
									action="${pageContext.request.contextPath}/submitStatResponse"
									id="submitStatResponse" method="post">
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="settingType">
											Type <span style="color: red">*</span>:
										</label>
										<div class="form-check form-check-inline">
											<label class="form-check-label"> <input type="radio"
												class="form-check-input" name="settingType" id="settingType"
												checked="checked" ${setType == 1 ? 'checked' : ''}
												onclick="showDiv(this.value)" value="1"> Days
											</label>
										</div>
										<div class="form-check form-check-inline">
											<label class="form-check-label"> <input type="radio"
												class="form-check-input" name="settingType" id="settingType"
												${setType == 2 ? 'checked' : ''}
												onclick="showDiv(this.value)" value="2">Date
											</label>
										</div>
									</div>


									<div class="form-group row" id="divDays">

										<label class="col-form-label col-lg-3" for="noDays">No.
											of Days <span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control"
												placeholder="Enter No. of Days" id="noDays" name="noDays"
												value="${noDays}" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_noDays"
												style="display: none;">Please enter no. of days.</span>
										</div>

									</div>


									<div class="form-group row" id="divDate">
										<label class="col-form-label col-lg-3" for="dob">Date
											<span style="color: red">* </span>:
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control datepickerclass"
												placeholder="Enter Date " id="limitDate" name="limitDate"
												value="${statDate}" autocomplete="off" onchange="trim(this)">
										</div>
										<div class="col-lg-3">
											<span class="validation-invalid-label" id="error_limitDate"
												style="display: none;">Please Enter Date Properly.</span>
										</div>
									</div>


									<div class="form-group row mb-0">
										<div class="col-lg-12" align="center">
											<!-- 	<button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>

										</div>
									</div>

								</form>
								<p class="desc text-danger fontsize11">Notice : * Fields are
									mandatory.</p>
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
	<script type="text/javascript">
function showDiv(typdId){
	//alert("Id="+typdId);
		if (typdId == 2) {
			
			document.getElementById("divDate").style = "visible"
			document.getElementById("divDays").style = "display:none"
 				
		} else if (typdId == 1) {
			document.getElementById("divDate").style = "display:none"
			document.getElementById("divDays").style = "visible"
	}
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

	<script>
		$(document).ready(function($) {

			$("#submitStatResponse").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if (!$("#settingType").val()) {

					isError = true;

					$("#error_settingType").show()
					//return false;
				} else {
					$("#error_settingType").hide()
				}

				
				if($("#settingType").val()==1){
					
					

					if (!$("#noDays").val()) {

						isError = true;

						$("#error_noDays").show()
						//return false;
					} else {
						$("#error_noDays").hide()
					}

					
				}
				
				
				if($("#settingType").val()==2){
					
					

					if (!$("#limitDate").val()) {

						isError = true;

						$("#error_limitDate").show()
						//return false;
					} else {
						$("#error_limitDate").hide()
					}

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

</body>
</html>