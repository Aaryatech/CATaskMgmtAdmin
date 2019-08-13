<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>


<div class="sidebar sidebar-dark sidebar-main sidebar-expand-md">
	<c:url var="setSubModId" value="/setSubModId" />
	<!-- Sidebar mobile toggler -->
	<div class="sidebar-mobile-toggler text-center">
		<a href="#" class="sidebar-mobile-main-toggle"> <i
			class="icon-arrow-left8"></i>
		</a> <span class="font-weight-semibold">Navigation</span> <a href="#"
			class="sidebar-mobile-expand"> <i class="icon-screen-full"></i> <i
			class="icon-screen-normal"></i>
		</a>
	</div>
	<!-- /sidebar mobile toggler -->


	<!-- Sidebar content -->
	<div class="sidebar-content">
  
		<!-- Main navigation -->
		<div class="card card-sidebar-mobile">





			<ul class="nav nav-sidebar" data-nav-type="accordion">

				<!-- Main -->
				<!-- <li class="nav-item-header"><div class="text-uppercase font-size-xs line-height-xs">Main</div> <i class="icon-menu" title="Main"></i></li> -->
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/dashboard"
					class="nav-link active"> <i class="icon-home4"></i> <span>
							Dashboard </span>
				</a></li>
				<li class="nav-item nav-item-submenu"><a href="#"
					class="nav-link"><i class="icon-list-unordered"></i><span>Master</span></a>

					<ul class="nav nav-group-sub" data-submenu-title="Master">

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/serviceList"
							class="nav-link">Service Master</a></li>

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/activity"
							class="nav-link">Activity Master</a></li>

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/employeeList"
							class="nav-link">Employee Master</a></li>

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/customerGroupList"
							class="nav-link">Customer Group Master</a></li>

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/customerList"
							class="nav-link">Customer - Activity Mapping</a></li>

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/customerDetailList"
							class="nav-link">Customer Login & Signatory</a></li>


					</ul></li>
					
					
					<li class="nav-item"><a
							href="${pageContext.request.contextPath}/manualTaskAdd"
							class="nav-link"><i class="icon-folder-plus"></i><span>Add Task</span></a></li>

				<li class="nav-item nav-item-submenu"><a href="#"
					class="nav-link"><i class="icon-list-unordered"></i><span>Task
							Allotment</span></a>

					<ul class="nav nav-group-sub" data-submenu-title="Task
							Allotment">


						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/assignTask"
							class="nav-link">Assign Task</a></li>
					</ul></li>

				<li class="nav-item nav-item-submenu"><a href="#"
					class="nav-link"><i class="icon-list-unordered"></i><span>
							Leave Management </span></a>

					<ul class="nav nav-group-sub" data-submenu-title="Master">

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/showEmpListForLeave"
							class="nav-link">Apply Leave</a></li>

						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/showLeaveHistListBetweenDate"
							class="nav-link">Leave History</a></li>

					</ul></li>
 


				<c:forEach items="${sessionScope.moduleJsonList}"
					var="moduleJsonList" varStatus="count">
					<c:choose>
						<c:when test="${moduleJsonList.moduleId==sessionModuleId}">
							<li class="nav-item nav-item-submenu nav-item-open">
						</c:when>
						<c:otherwise>
							<li class="nav-item nav-item-submenu">
						</c:otherwise>
					</c:choose>

					<a href="#" class="nav-link">${moduleJsonList.iconDiv}<span>${moduleJsonList.moduleName}</span></a>

					<c:choose>
						<c:when test="${moduleJsonList.moduleId==sessionModuleId}">
							<ul class="nav nav-group-sub"
								data-submenu-title="${moduleJsonList.moduleName}"
								style="display: block;">
						</c:when>
						<c:otherwise>
							<ul class="nav nav-group-sub"
								data-submenu-title="${moduleJsonList.moduleName}">
						</c:otherwise>
					</c:choose>

					<c:forEach items="${moduleJsonList.accessRightSubModuleList}"
						var="accessRightSubModuleList">
						<li class="nav-item"><c:choose>
								<c:when
									test="${accessRightSubModuleList.subModuleId==sessionSubModuleId}">
									<a
										href="${pageContext.request.contextPath}/${accessRightSubModuleList.subModuleMapping}"
										class="nav-link active legitRipple"
										onclick="selectSubMod(${accessRightSubModuleList.subModuleId},${accessRightSubModuleList.moduleId})">${accessRightSubModuleList.subModulName}</a></li>
						</c:when>
						<c:otherwise>
							<a
								href="${pageContext.request.contextPath}/${accessRightSubModuleList.subModuleMapping}"
								class="nav-link"
								onclick="selectSubMod(${accessRightSubModuleList.subModuleId},${accessRightSubModuleList.moduleId})">${accessRightSubModuleList.subModulName}</a>
							</li>
						</c:otherwise>
						</c:choose>
					</c:forEach>
			</ul>
			</li>

			</c:forEach>

			<%-- <li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/logout"><i
					class="icon-width"></i> <span>Logout</span></a></li> --%>
			<!-- /main -->


			</ul>
		</div>
		<!-- /main navigation -->

	</div>
	<!-- /sidebar content -->

</div>

<script>
			function selectSubMod(subModId, modId) {

				$.getJSON('${setSubModId}', {
					subModId : subModId,
					modId : modId,
					ajax : 'true'
				});

			}
		</script>
		
		</html>
