<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="setDate()">

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
			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>


			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Generated Task List</h5>
						<div class="header-elements">
						<%-- 	<div class="list-icons">

								<a href="#" title="Chat/Update" data-toggle="modal"
									data-target="#modal_remote"><img
									src="${pageContext.request.contextPath}/resources/global_assets/images/filter.png"
									alt="" style="height: 26px; width: 26px;"></a> &nbsp;<a
									class="list-icons-item" data-action="collapse"></a>
							</div> --%>
						</div>
					</div>

					<form
						action="${pageContext.request.contextPath}/submitTaskResponse"
						id="submitInsertEmpType" method="post">
						<div class="card-body">
							<div class="form-group row">
										<label class="col-form-label col-lg-2" for="serviceDesc">Service
											  : </label>
										<div class="col-lg-3">
											<input type="text" class="form-control" value="${service.servName}"
											 
												readonly>
										</div>
										
										<label class="col-form-label col-lg-2" for="serviceDesc">Activity
											  : </label>
										<div class="col-lg-3">
											<input type="text" class="form-control" value="${activity.actiName}"
											readonly	>
										</div>
									</div>
									
									
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="serviceDesc">Customer
											  : </label>
										<div class="col-lg-3">
											<input type="text" class="form-control" value="${custHead.custFirmName}"
												readonly>
										</div>
										
										<label class="col-form-label col-lg-2" for="serviceDesc">Periodicity
											  : </label>
										<div class="col-lg-3">
											<input type="text" class="form-control" value="${per.periodicityName}"
												readonly>
										</div>
									 
									</div>


							<div class="table-responsive">

								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th width="10%">Sr.no</th>
											<th>Task</th>
											<th>Start Date</th>
											<th>Statutory Due  Date</th>
 											<th>Manager Budget Hrs.</th>
											<th>Emp Budget Hrs.</th>


										</tr>
									</thead>

									<c:forEach items="${taskList}" var="taskList" varStatus="count">
										<tr>
											<td>${count.index+1}&nbsp;&nbsp;<input type="checkbox"
												id="TaskId${taskList.taskId}" value="${taskList.taskId}"
												name="TaskId" class="select_all" checked></td>

											<td>${taskList.taskText}</td>
											<td>${taskList.taskStartDate}</td>
											<td>${taskList.taskStatutoryDueDate}</td>
											<td>${mHr}</td>
											<td>${eHr}</td>
											 



										</tr>
									</c:forEach>
									</tbody>

								</table>

							</div>
							<br>
							<div style="text-align: center;">
								<input type="submit" class="btn btn-primary" value="Submit"
									id="deleteId"
									onClick="var checkedVals = $('.select_all:checkbox:checked').map(function() { return this.value;}).get();checkedVals=checkedVals.join(',');if(checkedVals==''){alert('No Rows Selected');return false;	}else{   return confirm('Are you sure want to Assign These Task');}"
									style="align-content: center; width: 113px; margin-left: 40px;">
							</div>



						</div>
					</form>
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
					//	$('#printtable').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});
	</script>
<script type="text/javascript">

function setDate(){
	
	
	document
	.getElementById("workDate").value="";
}

</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>
	<!-- /page content -->
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
</body>
</html>