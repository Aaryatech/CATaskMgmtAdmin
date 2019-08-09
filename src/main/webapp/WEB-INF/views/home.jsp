<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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


				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">
				<div class="row">
					<div class="col-md-12">

						<div class="card">
							<div class="card-body">

								<div class="form-group row">

									

								</div>
							</div>
						</div>

					</div>
				</div>



				<div class="row">
					<div class="col-md-12">

						<div class="card">
							<div class="card-body">

								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th width="10%">Sr.no</th>
											<th>Task</th>
											<th class="text-center" width="10%">Actions</th>
										</tr>
									</thead>

									<tr>
										<td>1</td>
										<td>Income Tax</td>
										<td><a href="" title="Edit"><i class="icon-pencil7"
												style="color: black;"></i></a> <a href=""
											onClick="return confirm('Are you sure want to delete this record');"
											title="Delete"><i class="icon-trash"
												style="color: black;"></i> </a></td>
									</tr>

									<tr>
										<td>2</td>
										<td>TDS</td>
										<td><a href="" title="Edit"><i class="icon-pencil7"
												style="color: black;"></i></a> <a href=""
											onClick="return confirm('Are you sure want to delete this record');"
											title="Delete"><i class="icon-trash"
												style="color: black;"></i> </a></td>
									</tr>

									<tr>
										<td>3</td>
										<td>GST</td>
										<td><a href="" title="Edit"><i class="icon-pencil7"
												style="color: black;"></i></a> <a href=""
											onClick="return confirm('Are you sure want to delete this record');"
											title="Delete"><i class="icon-trash"
												style="color: black;"></i> </a></td>
									</tr>


								</table>

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









</body>



</html>