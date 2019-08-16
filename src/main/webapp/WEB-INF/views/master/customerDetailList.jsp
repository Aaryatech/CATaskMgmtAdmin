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
				<form id="custHeaderForm" >
				<input type="hidden"  id="custId" name="custId" value="0">
				
								<div class="card">
					<div class="card-header header-elements-inline">

						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Customer Detail
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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">
									<th width="10%">Sr.no</th>
									<th>Firm Name</th>
									<th>Customer Group</th>
									<th>Assesse Name</th>
									<th>PAN No.</th>
									<th>Email</th>
									<th>Contact</th>
									<th>Owner Partner</th>
									<th class="text-center" width="10%">Actions</th>
								</tr>
							</thead>

							<tbody>
						<c:forEach items="${custHeadList}" var="custHeadList" varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td>${custHeadList.custFirmName}</td>
								<td>${custHeadList.custGroupName}</td>
								<td>${custHeadList.custAssesseeName}</td>
								<td>${custHeadList.custPanNo}</td>
								<td>${custHeadList.custEmailId}</td>
								<td>${custHeadList.custPhoneNo}</td>
								<td>${custHeadList.empName}</td>


								<td class="text-center"><a
										href="#" onclick="addDetail(1)"
										class="dropdown-item"><i class="icon-add"></i> Add Detail</a>
										<a href="#" onclick="addSignatory(1)"
										class="dropdown-item"><i class="icon-add"></i> Add
											Signatory</a></td>

								</tr>
							</c:forEach>

									
							


							
							</tbody>

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
				</form>
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



	<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>   
    <script type="text/javascript">  
        $(document).ready(function () {  
                $('tr.parent')  
                    /* .css("cursor", "pointer") */  
                    /* .attr("title", "Click to expand/collapse")   */
                    .click(function () {  
                         $(this).siblings('.child-' + this.id).toggle(); 
                    });  
                 $('tr[@class^=child-]').hide().children('td');   
        });  
        </script>   -->
<script type="text/javascript">

function addDetail(custId) {
	
	//alert("Hi");
	document.getElementById("custId").value=custId;//create this 
	var form=document.getElementById("custHeaderForm");
    form.setAttribute("method", "post");

	form.action=("customerDetailAdd");
	form.submit();
	
}

function addSignatory(custId) {
	
	//alert("Hi");
	document.getElementById("custId").value=custId;//create this 
	var form=document.getElementById("custHeaderForm");
    form.setAttribute("method", "post");

	form.action=("customerSignAdd");
	form.submit();
	
}

</script>

</body>
</html>