<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>


</head>

<body>
	<c:url value="/getActivityByService" var="getActivityByService"></c:url>

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
							<a href="#" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active"></span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>

					</div>
					<div class="breadcrumb justify-content-center">
						<%-- <c:if test="${addAccess == 0}"> 
							<a href="${pageContext.request.contextPath}/service"
								class="breadcrumb-elements-item"> Add Service </a>
						</c:if> --%>

					</div>

				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Inactive Task
										List</h5></td>
								<td width="40%" align="right"></td>
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
							<span class="font-weight-semibold">Oh snap!</span>
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
							<span class="font-weight-semibold">Well done!</span>
							<%
								session.removeAttribute("successMsg");
							%>
						</div>
						<%
							session.removeAttribute("successMsg");
							}
						%>

						<form action="${pageContext.request.contextPath}/inactiveTaskList"
							id="submitInsertActivity">



							<div class="form-group row">
								<label class="col-form-label col-lg-1" for="service">
									Service<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="service" data-placeholder="Select Service"
										id="service"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true"
										onchange="getActivities(this.value)">
										<option value="0">Select Service</option>
										<c:forEach items="${serviceList}" var="serviceList">
											<c:choose>
												<c:when test="${serviceList.servId==servId}">
													<option selected value="${serviceList.servId}">${serviceList.servName}</option>
												</c:when>
												<c:otherwise>
													<option value="${serviceList.servId}">${serviceList.servName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>

									</select>
								</div>
								<div class="col-lg-2">
									<span class="validation-invalid-label" id="error_periodicity"
										style="display: none;"> Select Service</span>
								</div>
								
									<label class="col-form-label col-lg-1" for="activity">
									Activity <span style="color: red">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="activity" data-placeholder="Select Activity"
										id="activity" multiple
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">


									</select>
								</div>

								<div class="col-lg-2">
									<span class="validation-invalid-label" id="error_activity"
										style="display: none;"> Select Activity </span>

								</div>
								
							</div>

							<div class="form-group row">
								<label class="col-form-label col-lg-1" for="service">
									Customer<span style="color: red">* </span> :
								</label>
								<div class="col-lg-3">
									<select name="customer" data-placeholder="Select Customer"
										id="customer" multiple
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<c:set var="isAll" value="0"></c:set>
										<c:if test="${custIdList[0]==-1}">
											<option selected value="-1">All</option>
										  <c:set var="isAll" value="1"></c:set>
										</c:if>
											<c:if test="${isAll==0}">
											<option  value="-1">All</option>
											</c:if>
									 
										<c:forEach items="${custList}" var="custList">
											<c:set var="flag" value="0"></c:set>
											<c:forEach items="${custIdList}" var="custList1"
												varStatus="count2">
												<c:choose>
													<c:when test="${custList1==custList.custId}">
														<option selected value="${custList.custId}"><c:out
																value="${custList.custFirmName}" /></option>
														<c:set var="flag" value="1"></c:set>
													</c:when>
													<c:otherwise>

													</c:otherwise>
												</c:choose>
											</c:forEach>
											<c:choose>
												<c:when test="${flag==0}">
													<option value="${custList.custId}"><c:out
															value="${custList.custFirmName}" /></option>
												</c:when>
											</c:choose>
										</c:forEach>



									</select>
								</div>
								<div class="col-lg-2">
									<span class="validation-invalid-label" id="error_cust"
										style="display: none;"> Select customer </span>
								</div>
							</div>


							<div class="form-group row">


							

							</div>




							<input type="hidden" id="activity_id" name="activity_id"
								value="${activity.actiId}">


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


						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>

								<tr class="bg-blue">
									<th width="10%">Sr.no</th>
									<th>Customer Name</th>
									<th>Service Name</th>
									<th>Task Text</th>
									<th>Start Date</th>
									<th>End Date</th>
									<th>Periodicity</th>

									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>
							<c:forEach items="${taskList}" var="taskList" varStatus="count">
								<tr>
									<td>${count.index+1}</td>
									<td>${taskList.custFirmName}</td>
									<td>${taskList.servName}</td>
									<td>${taskList.taskText}</td>
									<td>${taskList.taskStartDate}</td>
									<td>${taskList.taskEndDate}</td>
									<td>${taskList.periodicity_name}</td>

									<td><a
										href="${pageContext.request.contextPath}/updateManualTaskStatus?taskId=${taskList.exVar1}&stat=2"
										title="Activate Task"><i class="icon-checkmark4 "
											style="color: black;"></i></a></td>

								</tr>
							</c:forEach>



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
	<script type="text/javascript">
		function getActivities(servId) {
			
		
			
			if (servId > 0) {
				
			
				$.getJSON('${getActivityByService}', {
					servId : servId,
					ajax : 'true',
				},

				function(data) {
					var html;
					var p = -1;
					var q = "All";
					html += '<option  value="'+p+'" >' + q + '</option>';
					html += '</option>';

					var temp = 0;
					var list =${actIntList};
					//alert("list " +list);
					var len = data.length;
					var len1 = list.length;
					//alert("len1 " +len1);
					 for (var i = 0; i < len; i++) {
						var flag=0;
						 for(var j = 0; j < len1; j++){
													
							 if(data[i].actiId==list[j]){
								 		flag=1;							 
							 }	

					}
						 if(flag==1){

								html += '<option selected value="' + data[i].actiId + '">'
										+ data[i].actiName + '</option>';

		                     }else{

									html += '<option value="' + data[i].actiId + '">'
											+ data[i].actiName + '</option>';

		                     }
						 
						 
					} 

					$('#activity').html(html);
					$("#activity").trigger("chosen:updated");
                    
						
					});


				}

			//}//end of if
		}
	</script>
	<!-- /page content -->

</body>
</html>