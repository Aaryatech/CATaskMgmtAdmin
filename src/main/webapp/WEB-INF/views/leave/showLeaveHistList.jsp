<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
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
			<%-- <div class="page-header page-header-light">


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
						<a href="${pageContext.request.contextPath}/showEmpListForLeave"
							class="breadcrumb-elements-item">Employee List</a>

					</div>


				</div>
			</div> --%>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">

					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">${employee.empName}&nbsp;Leave&nbsp;History</h5></td>

								<td width="40%" align="right"><a
									href="${pageContext.request.contextPath}/showEmpListForLeave"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Employee
											List</button>
								</a></td>

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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="10%">Sr. No.</th>
									<th>From Date</th>
									<th>To Date</th>
									<th>No. of Days</th>
									<th>Type</th>
									<th>Reason</th>
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${list}" var="list" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${list.leaveFromdt}</td>
										<td>${list.leaveTodt}</td>
										<td>${list.leaveNumDays}</td>
										<c:choose>
											<c:when test="${list.leaveDuration==0}">
												<td>Half Day</td>
											</c:when>
											<c:otherwise>
												<td>Full Day</td>
											</c:otherwise>
										</c:choose>
										<td>${list.leaveEmpReason}</td>
										<td class="text-center"> 
											<a href="#"
												onclick="showEditLeave('${list.leaveId}','${list.leaveFromdt}','${list.leaveTodt}','${list.leaveNumDays}','${list.empName}','${list.empId}')"
												title="Edit"><i class="icon-pencil7"
													style="color: black;" data-toggle="modal"
													data-target="#modal_edit"></i></a>
											 <a href="javascript:void(0)"
											class="list-icons-item text-danger-600 bootbox_custom"
											data-uuid="${empId1}" data-leaveid="${list.leaveId}"
											data-popup="tooltip" title="" data-original-title="Delete"><i
												class="icon-trash" style="color: black;"></i></a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

					</div>

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
	
	
	
	
	<!-- Leave Edit Modal -->
	
	<div id="modal_edit" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">

							<div class="modal-header bg-success">
								<h5 class="modal-title">Edit Leave</h5>
								<p id="ed_task_name" style="color: white;"></p>
								&nbsp;&nbsp;
								<p id="ed_task_cust" style="color: white;"></p>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">

									<form action="${pageContext.request.contextPath}/editLeave"
									id="editLeave" method="post">
								<input type="hidden" id="leaveId" name="leaveId" value=0>
 																<input type="hidden" id="empId" name="empId" value=0>
								
								 
							 <div class="form-group row">
									<label class="col-form-label col-lg-3">Employee Name : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											 id="empName" name="empName" readonly="readonly"
											autocomplete="off">
									</div>
								</div>
							 
							 
								<div class="form-group row">
									<label class="col-form-label col-lg-3">From Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											 id="fromDate" name="fromDate" readonly="readonly"
											autocomplete="off">
									</div>
								</div>
								
								
	<div class="form-group row">
									<label class="col-form-label col-lg-3">To Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control datepickerclass"
											 id="toDate" name="toDate"  onchange="calculateDiff()"
											autocomplete="off"><span style="display: none;"
													class="validation-invalid-label" id="error_toDate">Please
													Select To Date.</span>
									</div>
								</div>
							 
								
								
									<div class="form-group row">
										<label class="col-form-label col-lg-3" for="noOfDays">
											No. of Days<span style="color: red"></span> :
										</label>
										<div class="col-lg-6">
											<input type="text" class="form-control numbersOnly"
												placeholder="No. of Days " id="noOfDays" name="noOfDays"
												autocomplete="off" readonly>  
												
												<span style="display: none;"
													class="validation-invalid-label" id="error_noOfDays">Please
													Enter To Date Greater than From Date.</span>
										</div>
									</div>
							 
 
								<div class="modal-footer">
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">
											Submit <i class="icon-paperplane ml-2"></i>
										</button>
									<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>

								</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				
					<!-- Leave Edit Modal Ends-->
				

</body>
	<script type="text/javascript">

$(document)
				.ready(
						function($) {

							$("#editLeave")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";
 
												if (!$("#toDate").val()) {

													isError = true;

													$("#error_toDate")
															.show()
													//return false;
												} else {
													$("#error_toDate")
															.hide()
												}
												
												
												if ($("#noOfDays").val() < 0) {

													isError = true;

													$("#error_noOfDays")
															.show()
													//return false;
												} else {
													$("#error_noOfDays")
															.hide()
												}

												if (!isError) {
													submitForm();
												 
												}
												return false;
											});
						});
		//
	</script>
	<script>
		function submitForm() {
			$('#modal_edit').modal('hide');
			document.getElementById("submtbtn").disabled = true;
			document.getElementById("editLeave").submit();

		}
	</script>


	<script type="text/javascript">
	function showEditLeave(lvId,frmDate,toDate,days,empName,empId) {
		
		
		document.getElementById("noOfDays").value =days ;
		document.getElementById("fromDate").value =frmDate ;

		document.getElementById("toDate").value =toDate ;
		document.getElementById("empName").value =empName ;
		
		document.getElementById("empId").value =empId ;
		document.getElementById("leaveId").value =lvId ;


 
		
	}
	</script>
	
	
	<script type="text/javascript">
		function calculateDiff() {

			var toDate = document.getElementById("toDate").value;
			var fromDate = document.getElementById("fromDate").value;
			
			
			  var admission = moment(fromDate, 'DD-MM-YYYY'); 
				 var discharge = moment(toDate, 'DD-MM-YYYY');
				 var diffDays=discharge.diff(admission, 'days');
				// console.log(diffDays + " days");  
				 
				 if(diffDays < 0){
						document.getElementById("noOfDays").value = diffDays-1;

				 }else{
						document.getElementById("noOfDays").value = diffDays+1;

				 }
 
		/*  	var date1res = fromDate.split("-");
			var date2res = toDate.split("-");

			var date1 = new Date(date1res[2], date1res[1] - 1, date1res[0])//converts string to date object

			var date2 = new Date(date2res[2], date2res[1] - 1, date2res[0])

			const diffTime = Math.abs(date2.getTime() - date1.getTime());
			const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); */
			
			
			 

 
			
			/* const diffTime = Math.abs(toDate - fromDate);
			 
			 
			const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
			console.log(diffTime + " milliseconds");
			console.log(diffDays + " days");
			 */
			 
			 
		

		
		}
	</script>


	<script type="text/javascript">
	
	//For Work Log
	//var start = moment().subtract(3, 'days');
    //var end = moment();
    
    var start= moment();
    
$('.datepickerclass1').daterangepicker({
	singleDatePicker : true,
	selectMonths : true,
	selectYears : true,
	minDate: start,
	maxDate: '31-08-2020',
	drops:'down',
	locale : {
		format : 'DD-MM-YYYY'
	}
});


		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			drops:'down',
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		//daterange-basic_new
		// Basic initialization
		$('.daterange-basic_new').daterangepicker({
			//applyClass : 'bg-slate-600',
			 autoApply:true,
			 opens:'left',
			 drops:'down', //up
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>
<script>
	// Custom bootbox dialog
	$('.bootbox_custom')
			.on(
					'click',
					function() {
						var uuid = $(this).data("uuid") // will return the number 123
						var leaveId = $(this).data("leaveid")
						//alert(leaveId)
						bootbox
								.confirm({
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
											location.href = "${pageContext.request.contextPath}/deleteLeave?emp="
													+ uuid
													+ "&leaveId="
													+ leaveId;

										}
									}
								});
					});
</Script>
</html>