<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="setDate()">
	<c:url value="/getCountofPartner" var="getCountofPartner"></c:url>

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
<%-- 			<jsp:include page="/WEB-INF/views/include/breadcrum.jsp"></jsp:include>
 --%>

			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Send Work Log Email</h5>
						<div class="header-elements">
						</div>
					</div>
					
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
									<span class="font-weight-semibold">Well Done!</span>
									<%
										out.println(session.getAttribute("successMsg"));
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%> 


					<form action="${pageContext.request.contextPath}/assignTask"
						id="submitInsertEmpType1">
						<div class="card-body">

							


						</div>
					</form>

					<form
						action="${pageContext.request.contextPath}/sendEmailWorkLog"
						id="submitInsertAssignTask" method="post">
						<div class="card-body">
							<div class="form-group row">

								<label class="col-form-label col-lg-2" for="workDate">Work
									Date: </label>
								<div class="col-lg-4">
									<input type="text" required class="form-control datepickerclass1"
										name="workDate" id="workDate" placeholder="Task Work Date"
										autocomplete="off">
								</div>
<label class="col-form-label col-lg-3" for="service">
									Log of 3 Days before selected date will be sent !!<span style="color: red">* </span> :
								</label>

								<label class="col-form-label col-lg-2" for="locId2">
									<input type="button" class="btn btn-primary" value="Send Work Log Email "
									id="deleteId"
									style="align-content: left; width: 225px; margin-left: 20px;">
								</label>
								<span class="validation-invalid-label" id="error_worDate"
										style="display: none;">Please select work date</span>
							</div>
<br>
							<div style="text-align: center;">
								
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
	
							$("#deleteId")
									.click(function(){
												var isError = false;
												
												if (!$("#workDate").val()) {
													isError = true;

												$("#error_worDate")
														.show()

											} else {
												$("#error_worDate")
														.hide()
											}
												if(isError==false)
													$("#submitInsertAssignTask").submit();
												
						});
	</script>

	<script type="text/javascript">
	/* var rows_selected = [];
	var countChecked = function($table, checkboxClass) {
		  if ($table) {
		    // Find all elements with given class
		    var chkAll = $table.find(checkboxClass);
		    // Count checked checkboxes
		    var checked = chkAll.filter(':checked').length;
		    // Count total
		    var total = chkAll.length;    
		    // Return an object with total and checked values
		    return {
		      total: total,
		      checked: checked
		    }
		  }
		}
		$(document).on('click', '.select_all', function() {
		  var result = countChecked($('#printtable1'), '.select_all');
		   alert(result.checked+":"+result.total);
		  
		});
		$(document).on('click', '#selAll', function() {
			  var result = countChecked($('#printtable1'), '.select_all');
			   alert(result.checked+":"+result.total);
			  
			}); */
			
			
		$(document).ready(
		
				function() {
					
					//
					$('#printtable_assignTask').dataTable({
					    "bPaginate": false,
					  	dom: 'Bfrtip',
					    buttons: [
				            'copyHtml5',
				            'excelHtml5',
				            'csvHtml5',
				            'pdfHtml5'
				        ]
					});
					//
					
					//	$('#printtable').DataTable();
			
					$("#selAll").click(
							function() {
								$('#printtable_assignTask tbody input[type="checkbox"]')
										.prop('checked', this.checked);
								 
							});
					 
				});
	</script>
	<script type="text/javascript">
		function setDate() {

			document.getElementById("workDate").value = "";
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

		$('.datepickerclass1').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			autoUpdateInput : false,
			//autoApply:false,
			//startDate :NULL,
			locale : {
				format : 'DD-MM-YYYY'

			}
		});

		$('input[name="workDate"]').on('apply.daterangepicker',
				function(ev, picker) {
					$(this).val(picker.startDate.format('DD-MM-YYYY'));
				});

		$('input[name="workDate"]').on('cancel.daterangepicker',
				function(ev, picker) {
					$(this).val('');
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