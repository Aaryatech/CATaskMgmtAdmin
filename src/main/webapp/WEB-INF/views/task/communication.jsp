<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<c:url var="saveNewMessage" value="/saveNewMessage" />
<c:url var="getAllCommunicationByTaskId"
	value="/getAllCommunicationByTaskId" />
	<c:url var="insertDeliverableLink" value="/insertDeliverableLink" />
	
 
<style type="text/css">
.media-chat-scrollable {
	max-height: 209px;
	overflow: auto;
}
</style>
 

	<!-- Page content -->
	<div class="page-content">

		 

		<!-- Main content -->
		<div class="content-wrapper">



			<!-- Content area -->
			<div class="content">

				 

				<div class="row">
					<div class="col">

						<div class="card">
							<div class="card-header header-elements-inline">
								<h5 class="card-title">Communication & Logs</h5>
							</div>

							<!-- Basic layout -->

							<div class="card-body">

								<ul class="media-list media-chat media-chat-scrollable mb-3"
									id="ulComm">

									<c:forEach items="${communicationList}" var="communicationList">

										<c:choose>
											<c:when test="${communicationList.typeId==1}">
												<c:choose>
													<c:when test="${communicationList.empId==loginUser}">
														<li class="media media-chat-item-reverse old">
															<div class="media-body">
																<div class="media-chat-item">${communicationList.communText}</div>
																<div class="font-size-sm text-muted mt-2">
																	${communicationList.empName}&nbsp;${communicationList.updateDatetime}
																</div>
															</div>

															<div class="ml-3">
																<%-- <a
															href="${pageContext.request.contextPath}/resources/global_assets/images/demo/images/3.png"> --%>

																<c:choose>
																	<c:when test="${not empty communicationList.empPic}">
																		<img src="${imgViewUrl}${communicationList.empPic}"
																			class="rounded-circle" width="40" height="40" alt="">
																	</c:when>
																	<c:otherwise>
																		<img
																			src="${pageContext.request.contextPath}/resources/global_assets/images/noimageteam.png"
																			class="rounded-circle" width="40" height="40" alt="">
																	</c:otherwise>
																</c:choose>

																<!-- </a> -->
															</div>
														</li>



													</c:when>

													<c:otherwise>

														<li class="media old">
															<div class="mr-3">
																<%-- <a
															href="${pageContext.request.contextPath}/resources/global_assets/images/demo/images/3.png"> --%>
																<c:choose>
																	<c:when test="${not empty communicationList.empPic}">
																		<img src="${imgViewUrl}${communicationList.empPic}"
																			class="rounded-circle" width="40" height="40" alt="">
																	</c:when>
																	<c:otherwise>
																		<img
																			src="${pageContext.request.contextPath}/resources/global_assets/images/noimageteam.png"
																			class="rounded-circle" width="40" height="40" alt="">
																	</c:otherwise>
																</c:choose>
																<!-- </a> -->
															</div>

															<div class="media-body">
																<div class="media-chat-item">
																	${communicationList.communText}</div>
																<div class="font-size-sm text-muted mt-2">
																	${communicationList.empName}&nbsp;${communicationList.updateDatetime}
																</div>
															</div>
														</li>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<li
													class="media content-divider justify-content-center text-muted mx-0 old">${communicationList.communText}&nbsp;${communicationList.updateDatetime}</li>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</ul>

								<!-- <textarea name="enter-message" class="form-control mb-3"
									rows="3" cols="1" placeholder="Enter your message..."></textarea>

								<div class="d-flex align-items-center">
							

									<button type="button"
										class="btn bg-teal-400 btn-labeled btn-labeled-right ml-auto">
										<b><i class="icon-paperplane"></i></b> Send
									</button>
								</div> -->

								<%-- <form
									action="${pageContext.request.contextPath}/insertNewMessage"
									id="submitInsertClient" method="post"> --%>

								<table width="100%">
									<tr>
										<td width="89%">
											<!-- <textarea name="msg" id="msg"
													class="form-control mb-3" rows="1" cols="1"
													placeholder="Enter your message..."></textarea> --> <input
											name="msg" id="msg" class="form-control mb-3"
											placeholder="Enter your message...">
										</td>
										<td width="1%"></td>
										<td width="10%" align="right">
											<button type="button" id="submtbtn" class="btn bg-teal-400"
												onclick="chat()">
												<b><i class="icon-paperplane"></i></b>
											</button></b>
											
											<b><i class="icon-bubbles10
" title="Email This Line"></i></b><input type="checkbox" id="check_email" name="check_email">
												
											

										</td>
									</tr>
								<%-- 	<tr>
									
									<td>
									<lable><h5 class="card-title">Deliverable Link</h5></lable>
										<input type="hidden" name="taskId" id="task_id" value="${taskId}">
										<input
												name="link" id="link" class="form-control mb-3"
												placeholder="Deliverable Link" value="${task.exVar1}">
										<div class="col-lg-6">
												<span class="validation-invalid-label"
													id="error_link" style="display: none;">Please
													enter delivery link.</span>
											</div>
									</td>
									<td width="1%"></td>
									<td width="10%" align="right">
											<button type="button" id="delvrybtn" class="btn bg-teal-400"
												onclick="addDeliverAbleLink()">
												<b><i class="icon-paperplane"></i></b>
											</button>


										</td>
									
									</tr> --%>
								</table>


								<input type="hidden" name="taskId_chat" id="taskId_chat" value="${taskId}"> <input
									type="hidden" name="empId" id="empId" value="${empId}"> <input
									type="hidden" name="loginUser" id="loginUser"
									value="${loginUser}"> <input type="hidden"
									name="comLength" id="comLength"
									value="${communicationList.size()}"> <input
									type="hidden" name="imgPath" id="imgPath" value="${imgViewUrl}">
								<!-- </form> -->
								
							<%-- <form
									action="${pageContext.request.contextPath}/insertDeliverableLink"
									id="submitInsertDelivrableLink" method="post"> --%>
										
									
											
										
									<!-- </form>  -->
									
									

							</div>
							<!-- /basic layout -->





						</div>

					</div>


					<%-- <div class="col-md-4">
						<div class="card">
							<div class="card-header header-elements-inline">
								<h5 class="card-title">Task Status Update</h5>
							</div>

							<div class="card-body">
								<form
									action="${pageContext.request.contextPath}/updateTaskStatus"
									method="post" id="changeTask">
									<input type="hidden" value="${task.taskId}" id="taskId"
										name="taskId">

									<div class="form-group row">
										<label class="col-form-label col-lg-12" for="status">
											Select Status <span style="color: red">* </span>:
										</label>
										<div class="col-lg-12">
											<select name="status" data-placeholder="Select Status"
												id="status"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">

												<option value="">Select Status</option>
												<c:forEach items="${statusList}" var="statusList"
													varStatus="count">
													<option value="${statusList.statusValue}">${statusList.statusText}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-lg-12">
											<span class="validation-invalid-label" id="error_serviceName"
												style="display: none;">Please select status.</span>
										</div>
									</div>
 
									<div class="form-group row">
										<button type="submit" class="btn btn-primary" id="submtbtn">Update</button>
										<div class="form-group row"></div>

									</div>
									<br> <br>
								</form>
							</div>

						</div>




					</div> --%>
				</div>
				<!-- /content area -->


				<!-- Footer -->
				<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include> --%>
				<!-- /footer -->


			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/global_assets/js/common_js/validation.js"></script>





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

		function chat() {
			var msg = $("#msg").val();//document.getElementById("msg").value;
			var taskId = $("#taskId_chat").val();//document.getElementById("taskId").value;

			if (msg != "") {

				document.getElementById("msg").value = "";

				$.post('${saveNewMessage}', {
					msg : msg,
					taskId : taskId,
					ajax : 'true',
				},

				function(data) {

					if (data.error == false) {

						chatList(1);

					} else {
						alert("Message Not dilivered");
					}

				});
			}

		}

		function chatList(index) {
			//alert(index);
			var taskId = document.getElementById("taskId_chat").value;
			var loginUser = document.getElementById("loginUser").value;
			
			$
					.getJSON(
							'${getAllCommunicationByTaskId}',
							{
								taskId : taskId,
								ajax : 'true',
							},

							function(data) {

								var comLength = document
										.getElementById("comLength").value;
								var imgPath = document
										.getElementById("imgPath").value;
								//alert(imgPath)
								if (data.length > comLength) {
									$(".old").remove();

									for (var i = 0; i < data.length; i++) {

										if (data[i].typeId == 1) {
											if (data[i].empId == loginUser) {

												var timeDiv = ''
														+ '<div class="media-body">'
														+ '<div class="media-chat-item">'
														+ data[i].communText
														+ '</div>'
														+ '<div class="font-size-sm text-muted mt-2">'
														+ data[i].empName
														+ '&nbsp;'
														+ data[i].updateDatetime
														+ '</div>'
														+ '</div>'
														+ '<div class="ml-3">'
														+ '<img src="'+imgPath+data[i].empPic+'"'+
			'class="rounded-circle" width="40" height="40" alt="${pageContext.request.contextPath}/resources/global_assets/images/noimageteam.png"> </div>'
														+ '';

												/* var ul = document
														.getElementById("ulComm");
												var $last =  */
												$("#ulComm")
														.append(
																$(
																		'<li class="media media-chat-item-reverse old"></li>')
																		.html(
																				timeDiv));
											} else {

												var timeDiv = '<div class="mr-3">'
														+ ' <img src="'+imgPath+data[i].empPic+'"'+
												'class="rounded-circle" width="40" height="40" alt="${pageContext.request.contextPath}/resources/global_assets/images/noimageteam.png"">'
														+ '</div> '
														+ '<div class="media-body">'
														+ '<div class="media-chat-item">'
														+ data[i].communText
														+ '</div>'
														+ '<div class="font-size-sm text-muted mt-2">'
														+ data[i].empName
														+ '&nbsp;'
														+ data[i].updateDatetime
														+ '</div>' + '</div>';

												/* var ul = document
														.getElementById("ulComm");
												var $last =  */
												$("#ulComm")
														.append(
																$(
																		'<li class="media old"></li>')
																		.html(
																				timeDiv));
											}
										} else {

											$("#ulComm")
													.append(
															$(
																	'<li class="media content-divider justify-content-center text-muted mx-0 old"></li>')
																	.html(
																			data[i].communText
																					+ '&nbsp;'
																					+ data[i].updateDatetime));
										}

									}
									if (index == 0) {
										var audio = new Audio(
												'https://notificationsounds.com/notification-sounds/for-sure-576/download/mp3');
										audio.play();
									}
								}

								document.getElementById("comLength").value = data.length;
								if (data.length > comLength) {
									container = $('#ulComm').get(0);
									container.scrollTop = (container.scrollHeight + container.offsetHeight);
								}
								display_c();
							});

		}
		function onloadActive() {
			
			container = $('#ulComm').get(0);
			container.scrollTop = (container.scrollHeight + container.offsetHeight);
			display_c();
			
		}
		function display_c() {
			
			var refresh = 15000; // Refresh rate in milli seconds
			mytime = setTimeout('chatList(0)', refresh)
		}

		$(document).keypress(function(event) {
			if (event.keyCode == 13) {
				chat();
				//$('#submtbtn').click();
				//  validate(); doesn't need to be called from here
			}
		});
	</script>
	<script>
		$(document).ready(function($) {
			
			onloadActive(); 
			$("#changeTask").submit(function(e) {
				var isError = false;
				var errMsg = "";

				if (!$("#status").val() || $("#status").val() == "") {

					isError = true;

					$("#error_serviceName").show()
					//return false;
				} else {
					$("#error_serviceName").hide()
				}

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
		
		//deliverLink
		function addDeliverAbleLink() {
			var link = $("#link").val() 
			var taskId = $("#task_id").val();//document.getElementById("taskId").value;
			//alert(link+" "+taskId)
			if (link != "") {
				$("#error_link").hide()
				//document.getElementById("link").value = "";
				document.getElementById("delvrybtn").disabled = true;
				$.post('${insertDeliverableLink}', {
					link : link,
					taskId : taskId,
					ajax : 'true',
				},

				function(data) {

					if (data.error == false) {

						///chatList(1);
						alert("Link delivered");
						$("#myModal").modal("hide");
						//window.open = "taskListForEmp";

					} else {
						alert("Link not delivered");
						$("#myModal").modal("hide");
						//window.open = "taskListForEmp";
					}

				});
			}else{
				if (!$("#link").val()) {

					isError = true;

					$("#error_link").show()
					//return false;
				} else {
					$("#error_link").hide()
				}
			}

		}
			
	</script>
 