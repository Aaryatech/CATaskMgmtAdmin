<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>


</head>

<body>
<c:url value="/deleteActMapByDate" var="deleteActMapByDate"></c:url>

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


				<%-- <div
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
					<div class="breadcrumb justify-content-center">
						<c:if test="${addAccess == 0}"> 
							<a href="${pageContext.request.contextPath}/service"
								class="breadcrumb-elements-item"> Add Service </a>
						</c:if>

					</div>

				</div> --%>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Customer And
										Activity Mapping</h5></td>
								<%-- <td width="40%" align="right"><a
									href="${pageContext.request.contextPath}/customerAdd"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Add
											Customer</button>
								</a></td> --%>
								
								<td width="40%" align="right">
								<a href="#" title="Delete Task by Date"><i class="icon-calendar52 mr-3 icon-2x" style="color: black;" data-toggle="modal" data-target="#modal_small"></i></a>
								<!-- Small modal -->
				<div id="modal_small" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content">
						
							<div class="modal-header">
								<h5 class="modal-title" align="center">Select Date</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							
							<div class="modal-body">
							<input type="hidden" value="${custId}" id="cust_id" name="cust_id"> 
								<div class="form-group form-group-float col-md-12">
									<!-- 	<label class="form-group-float-label">Work Date</label> --> <input
											type="text" class="form-control datepickerclass"
											name="sel_date" id="sel_date"
											placeholder="Work Date">
												
									</div>
							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-link" data-dismiss="modal" id="btn1">Close</button>
								<button type="button" class="btn bg-primary" onclick="getData()" id="btn2">Delete Tasks</button>
							</div>
							<p class="desc text-danger fontsize11" align="left">Notice : All tasks will be deleted, generated after selected date.</p>
						</div>
					</div>
				</div>
								
								
								<a
									href="${pageContext.request.contextPath}/customerList"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Back
											</button>
								</a></td>
							</tr>
						</table>
					</div>

					<div class="card-body">

						<div style="display: none;" id="failmsg">						
							<div
								class="alert bg-danger text-white alert-styled-left alert-dismissible">
								<button type="button" class="close" data-dismiss="alert">
									<span>×</span>
								</button>
								<span class="font-weight-semibold">Oh snap! Fail to deleted successfully</span>
								
							</div>
						</div>

						
						<div style="display: none;" id="sucssmsg">
							<div
								class="alert bg-success text-white alert-styled-left alert-dismissible" >
								<button type="button" class="close" data-dismiss="alert">
									<span>×</span>
								</button>
								<span class="font-weight-semibold">Well done! Task deleted successfully</span>
								
							</div>
						</div>
						
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
							
								<tr class="bg-blue">
									<th width="10%">Sr.no</th>
									<th>Customer Group</th>
									<th>Service</th>
									<th>Activity</th>
									<th>Periodicity</th>
									<th>Start Date</th>
									<th>End Date</th>
									<th>Statutory End Days</th>
									<th>Manager Budget Hours</th>
									<th>Employee Budget Hours</th>
									<th>Billing Amount</th>									
									<!-- <th class="text-center" width="10%">Actions</th> -->
								</tr>
							</thead>
							<c:forEach items="${custActMapList}" var="actMap" varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td>${actMap.custGroupName}</td>
								<td>${actMap.servName}</td>
								<td>${actMap.actiName}</td>
								<td>${actMap.periodicityName}</td>
								<td>${actMap.actvStartDate}</td>
								<td>${actMap.actvEndDate}</td>
								<td>${actMap.actvStatutoryDays}</td>
								<td>${actMap.actvManBudgHr}</td>
								<td>${actMap.actvEmpBudgHr}</td>
								<td>${actMap.actvBillingAmt}</td>

								<%-- <td><a
									href="${pageContext.request.contextPath}/customerActivityAddMap?custId=${custHeadList.custId}"
									title="Map Activity"><i class="icon-add"
										style="color: black;"></i></a> 
										
										<a
									href="${pageContext.request.contextPath}/showCustomerActivityMap?custId=${custHeadList.custId}"
									title="Mapped Activity List"><i class="icon-three-bars""
										style="color: black;"></i></a>
										
										<a href="${pageContext.request.contextPath}/editCust?custId=${custHeadList.custId}" title="Edit"><i
										class="icon-pencil7" style="color: black;"></i></a> <a href="${pageContext.request.contextPath}/deletCust?custId=${custHeadList.custId}"
									onClick="return confirm('Are you sure want to delete this record');"
									title="Delete"><i class="icon-trash" style="color: black;"></i>
								</a></td> --%>

							</tr>
							</c:forEach>
						

							<%-- <tbody>


								<c:forEach items="${compList}" var="compList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${compList.companyName}</td>
										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editCompany?compId=${compList.exVar1}"
													title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
												<a
													href="${pageContext.request.contextPath}/editCompany?compId=${compList.exVar1}"
													title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/deleteCompany?compId=${compList.exVar1}"
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
													style="color: black;"></i> </a>
											</c:if></td>
									</tr>
								</c:forEach>

							</tbody> --%>
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
<script type="text/javascript">
function getData() {
	document.getElementById("btn2").disabled = true;
	var date = $("#sel_date").val();
	var custId = $("#cust_id").val();
	
	if(date!=null && custId!=0){
		confirm("Are you sure want to delete record");
	}
	$
			.getJSON(
					'${deleteActMapByDate}',
					{

						date : date,
						custId : custId,
						ajax : 'true',

					},
					function(data) {
						//alert("LogList:"+JSON.stringify(data));
						
						if(!data.isError){
							$('#modal_small').modal('hide')							
							showMsg();							
						}else{
							$('#modal_small').modal('hide')							
							showFailMsg();							
						}
					});
	document.getElementById("btn2").disabled = false;
}

/* function showDate(){
	$('#modal_small').modal('show')	
} */

function showMsg(){
	setTimeout(function(){
		$('#sucssmsg').fadeOut('fast');
		}, 3000);
	 $("#sucssmsg").show();
}

function showFailMsg(){
	setTimeout(function(){
		$('#failmsg').fadeOut('fast');
		}, 3000);
	 $("#failmsg").show();
}



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
	 drops:'up', //up
	cancelClass : 'btn-light',
	locale : {
		format : 'DD-MM-YYYY',
		separator : ' to '
	}
});
</script>
</body>
</html>