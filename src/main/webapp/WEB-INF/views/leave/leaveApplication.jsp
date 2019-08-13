<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>

<c:url var="addStrDetail" value="/addStrDetail" />
<c:url var="chkNumber" value="/chkNumber" />
<c:url var="getLeaveStructureForEdit" value="/getLeaveStructureForEdit" />
<c:url var="getHolidayAndWeeklyOffList"
	value="/getHolidayAndWeeklyOffList" />
<c:url var="calholidayWebservice" value="/calholidayWebservice" />
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
						<a href="${pageContext.request.contextPath}/showApplyForLeave"
							class="breadcrumb-elements-item">Employee List</a>

					</div>


				</div>
			</div>
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
								<h6 class="card-title">Add Leave</h6>
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
									<span class="font-weight-semibold">Well done!</span>
									<%
										out.println(session.getAttribute("successMsg"));
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>

								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="lvsName">
										Employee Code : </label>
									<div class="col-lg-10">
										<input type="text" class="form-control"
											placeholder="Enter Leave Structure Name" id="empCode"
											value="0001" name="lvsName" autocomplete="off"
											onchange="trim(this)" readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="lvsName">
										Employee Name : </label>
									<div class="col-lg-10">
										<input type="text" class="form-control"
											placeholder="Enter Leave Structure Name" id="empName"
											value="Akshay Kasar" name="lvsName" autocomplete="off"
											onchange="trim(this)" readonly>

									</div>
								</div>
								<hr>

								<br>
								<form action="${pageContext.request.contextPath}/insertLeave"
									id="submitInsertLeave" method="post">



									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="leaveTypeId">
											Select <span style="color: red">* </span>:
										</label>

										<div class="col-lg-2">
											<select data-placeholder="Select a Day Type" id="dayTypeName"
												name="dayTypeName"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<option></option>
												<option selected value="1">Full Day</option>
												<option value="2">Half Day</option>
											</select><span class="validation-invalid-label" id="error_dayType"
												style="display: none;">This field is required.</span>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-lg-2">Date Range<span
											style="color: red">* </span>:
										</label>
										<div class="col-lg-10">
											<input type="text" class="form-control daterange-basic_new "
												name="leaveDateRange" data-placeholder="Select Date"
												id="leaveDateRange"> <span
												class="validation-invalid-label" id="error_Range"
												style="display: none;">This field is required.</span> <span
												class="validation-invalid-label" id="error_insuf"
												style="display: none;">Insufficient Leaves.</span>

										</div>
									</div>




									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="noOfDays">
											No. of Days<span style="color: red">* </span> :
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly"
												placeholder="No. of Days " id="noOfDays" name="noOfDays"
												autocomplete="off" readonly> <span
												class="validation-invalid-label" id="error_noOfDays"
												style="display: none;">This field is required.</span>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="lvngReson">Remark<span
											style="color: red">* </span> :
										</label>
										<div class="col-lg-10">
											<textarea rows="3" cols="3" class="form-control"
												placeholder="Remark" onchange="trim(this)" id="leaveRemark"
												name="leaveRemark"> </textarea>
											<span class="validation-invalid-label" id="error_leaveRemark"
												style="display: none;">This field is required.</span>
										</div>
									</div>
									<input type="hidden" class="form-control numbersOnly"
										id="empId" value="${empId}" name="empId"> <input
										type="hidden" class="form-control numbersOnly" id="tempNoDays"
										name="tempNoDays"> <input type="hidden"
										class="form-control numbersOnly" id="lvsId" value="${lvsId}"
										name="lvsId"> <input type="hidden"
										class="form-control numbersOnly" id="auth" value="${authId}"
										name="auth"> <input type="hidden" id="leaveLimit"
										value="${setlimit.value}"> <input type="hidden"
										id="yearFinalDate" value="${currYr.calYrToDate}">



									<div class="col-md-12" style="text-align: center;">


										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">
											Submit <i class="icon-paperplane ml-2"></i>
										</button>

										<a
											href="${pageContext.request.contextPath}/showEmpListForLeave"><button
												type="button" class="btn btn-primary">
												<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
												Cancel
											</button></a>

									</div>
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






	<script type="text/javascript">
		function calholiday() {

			var daterange = document.getElementById("leaveDateRange").value;
			var dayTypeName = document.getElementById("dayTypeName").value;
			var res = daterange.split(" to ");
			var empId = document.getElementById("empId").value;

			/* if(dayTypeName!=""){ */

			$
					.getJSON(
							'${getHolidayAndWeeklyOffList}',
							{

								fromDate : res[0],
								toDate : res[1],
								empId : empId,
								ajax : 'true',

							},
							function(data) {

								// alert("Data  " +JSON.stringify(data));
								var diff = calculateDiff();
								if (dayTypeName == 2) {
									diff = diff / 2;
								}
								var totalSundays = 0;
								var comndate = [];

								for (var i = 0; i < data.weeklyList.length; i++) {

									if (data.weeklyList[i].woType == 0) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");

										var date1 = new Date(date1res[2],
												date1res[1] - 1, date1res[0])//converts string to date object 
										var date2 = new Date(date2res[2],
												date2res[1] - 1, date2res[0])

										for (var j = date1; j <= date2;) {

											if (j.getDay() == data.weeklyList[i].woDay) {

												formatDate(date1);
												comndate
														.push(formatDate(date1));
												totalSundays++;
											}
											j.setTime(j.getTime() + 1000 * 60
													* 60 * 24);

										}

									} else if (data.weeklyList[i].woType == 3) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");
										var year = date1res[2];

										for (k = (date1res[1] - 1); k <= (date2res[1] - 1); k++) {

											var date1 = new Date(year, k, 1);
											var date2 = new Date(year, k, 7);
											/*  
											alert(date1);
											alert(date2); */
											//alert(year);
											var holfrstdt = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											for (var m = holfrstdt; m <= holseconddt;) {

												if (m >= date1 && m <= date2) {

													for (var j = m; j <= date2;) {

														if (j.getDay() == data.weeklyList[i].woDay
																&& m >= holfrstdt
																&& m <= holseconddt) {

															//alert(j+"matched 1st");

															formatDate(m);
															comndate
																	.push(formatDate(m));
															/* if ( 'FULL DAY' == data.weeklyList[i].woPresently){
															  totalSundays=totalSundays+1;
															}else{
															  totalSundays=totalSundays+0.5;
															} */
															totalSundays++;
														}
														j.setTime(j.getTime()
																+ 1000 * 60
																* 60 * 24);

													}

												}
												m.setTime(m.getTime() + 1000
														* 60 * 60 * 24);
											}

											var lastDay = new Date(year, k + 1,
													0);
											var nextDay = new Date();
											nextDay.setDate(lastDay.getDate());
											var spltdt = formatDate(lastDay)
													.split("-");
											year = spltdt[0];

										}

									} else if (data.weeklyList[i].woType == 4) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");
										var year = date1res[2];
										//alert("year " + year);

										for (k = (date1res[1] - 1); k <= (date2res[1] - 1); k++) {

											var date1 = new Date(year, k, 8);
											var date2 = new Date(year, k, 14);

											var holfrstdt = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											for (var m = holfrstdt; m <= holseconddt;) {

												if (m >= date1 && m <= date2) {

													for (var j = m; j <= date2;) {

														if (j.getDay() == data.weeklyList[i].woDay
																&& m >= holfrstdt
																&& m <= holseconddt) {

															//alert(j+"matched 2nd");

															formatDate(m);
															comndate
																	.push(formatDate(m));
															totalSundays++;
														}
														j.setTime(j.getTime()
																+ 1000 * 60
																* 60 * 24);

													}

												}
												m.setTime(m.getTime() + 1000
														* 60 * 60 * 24);
											}

											var lastDay = new Date(year, k + 1,
													0);
											var nextDay = new Date();
											nextDay.setDate(lastDay.getDate());
											var spltdt = formatDate(lastDay)
													.split("-");
											year = spltdt[0];

										}

									} else if (data.weeklyList[i].woType == 5) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");
										var year = date1res[2];
										//alert("year " + year);

										for (k = (date1res[1] - 1); k <= (date2res[1] - 1); k++) {

											var date1 = new Date(year, k, 15);
											var date2 = new Date(year, k, 21);

											var holfrstdt = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											for (var m = holfrstdt; m <= holseconddt;) {

												if (m >= date1 && m <= date2) {

													for (var j = m; j <= date2;) {

														if (j.getDay() == data.weeklyList[i].woDay
																&& m >= holfrstdt
																&& m <= holseconddt) {

															//alert(j+"matched 3rd");

															formatDate(m);
															comndate
																	.push(formatDate(m));
															totalSundays++;
														}
														j.setTime(j.getTime()
																+ 1000 * 60
																* 60 * 24);

													}

												}
												m.setTime(m.getTime() + 1000
														* 60 * 60 * 24);
											}

											var lastDay = new Date(year, k + 1,
													0);

											var nextDay = new Date();
											nextDay.setDate(lastDay.getDate());
											var spltdt = formatDate(lastDay)
													.split("-");
											year = spltdt[0];

										}

									} else if (data.weeklyList[i].woType == 6) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");
										var year = date1res[2];
										//alert("year " + year);

										for (k = (date1res[1] - 1); k <= (date2res[1] - 1); k++) {

											var date1 = new Date(year, k, 22);
											var date2 = new Date(year, k, 28);

											var holfrstdt = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											for (var m = holfrstdt; m <= holseconddt;) {

												if (m >= date1 && m <= date2) {

													for (var j = m; j <= date2;) {

														if (j.getDay() == data.weeklyList[i].woDay
																&& m >= holfrstdt
																&& m <= holseconddt) {

															//alert(j+"matched 4th");

															formatDate(m);
															comndate
																	.push(formatDate(m));
															totalSundays++;
														}
														j.setTime(j.getTime()
																+ 1000 * 60
																* 60 * 24);

													}

												}
												m.setTime(m.getTime() + 1000
														* 60 * 60 * 24);
											}

											var lastDay = new Date(year, k + 1,
													0);

											var nextDay = new Date();
											nextDay.setDate(lastDay.getDate());
											var spltdt = formatDate(lastDay)
													.split("-");
											year = spltdt[0];

										}

									} else if (data.weeklyList[i].woType == 1) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");
										var year = date1res[2];

										for (k = (date1res[1] - 1); k <= (date2res[1] - 1); k++) {

											var date1 = new Date(year, k, 8);
											var date2 = new Date(year, k, 14);

											var holfrstdt = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											var fststwk = evenodd(date1, date2,
													holfrstdt, holseconddt,
													data.weeklyList[i].woDay);

											var date3 = new Date(year, k, 22);
											var date4 = new Date(year, k, 28);

											var holfrstdt1 = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt1 = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											var sndwk = evenodd(date3, date4,
													holfrstdt1, holseconddt1,
													data.weeklyList[i].woDay);

											totalSundays = totalSundays
													+ fststwk[fststwk.length - 1]
													+ sndwk[sndwk.length - 1];

											for (var a = 0; a < (fststwk.length - 1); a++) {
												comndate.push(fststwk[a]);
											}
											for (var a = 0; a < (sndwk.length - 1); a++) {
												comndate.push(sndwk[a]);
											}

											var lastDay = new Date(year, k + 1,
													0);
											var nextDay = new Date();
											nextDay.setDate(lastDay.getDate());
											var spltdt = formatDate(lastDay)
													.split("-");
											year = spltdt[0];

										}

									} else if (data.weeklyList[i].woType == 2) {

										var date1res = res[0].split("-");
										var date2res = res[1].split("-");
										var year = date1res[2];

										for (k = (date1res[1] - 1); k <= (date2res[1] - 1); k++) {

											var date1 = new Date(year, k, 1);
											var date2 = new Date(year, k, 7);

											var holfrstdt = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											var fststwk = evenodd(date1, date2,
													holfrstdt, holseconddt,
													data.weeklyList[i].woDay);

											var date3 = new Date(year, k, 15);
											var date4 = new Date(year, k, 22);

											var holfrstdt1 = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt1 = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											var sndwk = evenodd(date3, date4,
													holfrstdt1, holseconddt1,
													data.weeklyList[i].woDay);

											var date5 = new Date(year, k, 29);
											var date6 = new Date(year, k + 1, 0);

											var holfrstdt2 = new Date(
													date1res[2],
													date1res[1] - 1,
													date1res[0])//converts string to date object 
											var holseconddt2 = new Date(
													date2res[2],
													date2res[1] - 1,
													date2res[0])

											var thrdwk = evenodd(date5, date6,
													holfrstdt2, holseconddt2,
													data.weeklyList[i].woDay);

											totalSundays = totalSundays
													+ fststwk[fststwk.length - 1]
													+ sndwk[sndwk.length - 1]
													+ thrdwk[thrdwk.length - 1];

											for (var a = 0; a < (fststwk.length - 1); a++) {
												comndate.push(fststwk[a]);
											}
											for (var a = 0; a < (sndwk.length - 1); a++) {
												comndate.push(sndwk[a]);
											}
											for (var a = 0; a < (thrdwk.length - 1); a++) {
												comndate.push(thrdwk[a]);
											}

											var lastDay = new Date(year, k + 1,
													0);
											var nextDay = new Date();
											nextDay.setDate(lastDay.getDate());
											var spltdt = formatDate(lastDay)
													.split("-");
											year = spltdt[0];

										}

									}

								}

								for (var i = 0; i < data.holidayList.length; i++) {

									//alert("Data  " +JSON.stringify(data.holidayList[i]));

									var frdtres = data.holidayList[i].holidayFromdt
											.split("-");
									var todtres = data.holidayList[i].holidayTodt
											.split("-");
									var frdt = new Date(frdtres[0],
											frdtres[1] - 1, frdtres[2]);
									var todt = new Date(todtres[0],
											todtres[1] - 1, todtres[2]);
									var tempdiff = difffun(frdt, todt);

									for (var j = 0; j < comndate.length; j++) {

										var tempres = comndate[j].split("-");
										var tempdt = new Date(tempres[0],
												tempres[1] - 1, tempres[2]);

										if (tempdt >= frdt && tempdt <= todt) {
											tempdiff--;
										}
									}

									totalSundays = totalSundays + tempdiff;
								}

								document.getElementById("noOfDays").value = diff
										- totalSundays;
								document.getElementById("noOfDaysExclude").value = totalSundays;
								//alert(totalSundays);

							});
			/* }else{
				
				alert("select Day Type ");
			} */
		}

		function formatDate(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
					+ d.getDate(), year = d.getFullYear();

			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;

			return [ year, month, day ].join('-');
		}
		function difffun(date1, date2) {

			const diffTime = Math.abs(date2.getTime() - date1.getTime());
			const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
			//document.getElementById("noOfDays").value = diffDays + 1;

			//document.getElementById("noOfDaysExclude").value = diffDays + 1;

			return (diffDays + 1);
		}

		function evenodd(date1, date2, holfrstdt, holseconddt, day) {

			//alert("date1 " + date1 + "date2 " + date2 + "holfrstdt " + holfrstdt + "holseconddt " + holseconddt + "day" +day)

			var totalcount = 0;
			var tempcomndate = [];

			for (var m = holfrstdt; m <= holseconddt;) {

				if (m >= date1 && m <= date2) {

					for (var j = m; j <= date2;) {

						if (j.getDay() == day && m >= holfrstdt
								&& m <= holseconddt) {

							//alert(j+"matched 1st");

							formatDate(m);
							tempcomndate.push(formatDate(m));
							totalcount++;
						}
						j.setTime(j.getTime() + 1000 * 60 * 60 * 24);

					}

				}
				m.setTime(m.getTime() + 1000 * 60 * 60 * 24);
			}
			tempcomndate.push(totalcount);
			return tempcomndate;
		}
	</script>

	<script type="text/javascript">
		function calculateDiff() {

			var daterange = document.getElementById("leaveDateRange").value;
			var res = daterange.split(" to ");

			var date1res = res[0].split("-");
			var date2res = res[1].split("-");

			var date1 = new Date(date1res[2], date1res[1] - 1, date1res[0])//converts string to date object

			var date2 = new Date(date2res[2], date2res[1] - 1, date2res[0])

			const diffTime = Math.abs(date2.getTime() - date1.getTime());
			const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
			document.getElementById("noOfDays").value = diffDays + 1;

			//document.getElementById("noOfDaysExclude").value = diffDays + 1;

			return (diffDays + 1);
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

		var today = new Date();
		var last = new Date(today.getTime() - (7 * 24 * 60 * 60 * 1000));

		var daterange = document.getElementById("yearFinalDate").value;

		var date1res = daterange.split("-");
		var lastdate = new Date(date1res[0], date1res[1] - 1, date1res[2]);

		//alert(lastdate);
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',
			minDate : last,
			maxDate : lastdate,
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>

	<script>
		function calholidayWebservice() {

			var daterange = document.getElementById("leaveDateRange").value;
			var dayTypeName = document.getElementById("dayTypeName").value;
			var res = daterange.split(" to ");
			var empId = document.getElementById("empId").value;
			document.getElementById("submtbtn").disabled = true;
			$
					.getJSON(
							'${calholidayWebservice}',
							{

								fromDate : res[0],
								toDate : res[1],
								empId : empId,
								ajax : 'true',

							},
							function(data) {

								document.getElementById("noOfDaysExclude").value = data.holidaycount;

								if (dayTypeName == "" || dayTypeName == 1) {
									document.getElementById("noOfDays").value = data.leavecount;
								} else {
									document.getElementById("noOfDays").value = data.leavecount / 2;
								}
								document.getElementById("submtbtn").disabled = false;
								//checkDays(data.leavecount);

							});

		}

		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}

		$(document)
				.ready(
						function($) {

							$("#submitInsertLeave")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if (!$("#dayTypeName").val()) {

													isError = true;

													$("#error_dayType").show()

												} else {
													$("#error_dayType").hide()
												}

												if (!$("#leaveDateRange").val()) {

													isError = true;

													$("#error_Range").show()

												} else {
													$("#error_Range").hide()
												}

												if (!$("#noOfDays").val()) {

													isError = true;

													$("#error_noOfDays").show()

												} else {
													$("#error_noOfDays").hide()
												}

												if (!$("#leaveRemark").val()) {

													isError = true;

													$("#error_leaveRemark")
															.show()
													//return false;
												} else {
													$("#error_leaveRemark")
															.hide()
												}

												if (!isError) {
													var option = $(
															"#leaveTypeId option:selected")
															.attr(
																	"data-leavestrname");

													$('#lvType').html(option);
													$('#noOfDays1')
															.html(
																	document
																			.getElementById("noOfDays").value);
													$('#empCode1')
															.html(
																	document
																			.getElementById("empCode").value);
													$('#empName1')
															.html(
																	document
																			.getElementById("empName").value);
													var daterange = document
															.getElementById("leaveDateRange").value;

													var res = daterange
															.split(" to ");

													$('#fromdate1')
															.html(res[0]);
													$('#todate1').html(res[1]);

													$('#modal_scrollable')
															.modal('show');
													//end ajax send this to php page
												}
												return false;
											});
						});
		//
	</script>
	<script>
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("submtbtn").disabled = true;
			document.getElementById("submitInsertLeave").submit();

		}
	</script>
	<!-- Scrollable modal -->
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Leave Details</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType"> Leave
							Type : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType"> </label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="fromdate1">
							From Date : </label> <label class="col-form-label col-lg-3"
							id="fromdate1" for="noOfDays1"> </label> <label
							class="col-form-label col-lg-3" for="todate1"> To Date :
						</label> <label class="col-form-label col-lg-2" id="todate1"
							for="noOfDays1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noOfDays"> No.
							of Days : </label> <label class="col-form-label col-lg-3" id="noOfDays1"
							for="noOfDays1"> </label>

					</div>
				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->
</body>
</html>