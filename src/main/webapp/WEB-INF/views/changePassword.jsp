<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Task Management</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


</head>
<body>


	<div class="login-reg-panel">


		<div class="register-info-box">

			<img
				src="${pageContext.request.contextPath}/resources/global_assets/images/kppm.png"
				alt="" style="height: 50px; width: 150px;">

		</div>

		<p
			style="color: #00669B; font-size: 15px; width: 40%; padding: 0 20px; top: 30%; right: 0; position: absolute; text-align: center;">
			<br> <br>Delivering with Professional Excellence To be
			preferred Chartered Accountant, Advisor or Consultant to Business
			across India; and provide utility oriented legal compliance.
		</p>

		<div class="white-panel">
			<div class="login-show">

				<form method="post"
					action="${pageContext.request.contextPath}/chngNewPassword"
					onsubmit="return confirm('Do you really want to Change the Password?');">

				
					<h2>Change Password</h2>
					<input type="password" placeholder="New Passsword" name="newPasssword"
						id="newPasssword" style="border-radius: 5px">
						
						 <input onblur="validatePassword()"
						type="password" placeholder="confrmNewPasssword" id="confrmNewPasssword"
						name="confrmNewPasssword" style="border-radius: 5px">
						
						 <input
						type="checkbox" onclick="myFunction()"><font color="white">Show
						Password</font> <br> <br> 
						
						<input type="submit" value="Change Password" >
							<c:if test="${errorPassMsg!=null}">
						<span style="color: red;">${errorPassMsg}</span>
						 
					</c:if>
						
					<!-- <a
						href="">Forgot password?</a>
						
 -->
				</form>
			</div>

		</div>
	</div>


	<script>
		function myFunction() {
			var x = document.getElementById("newPasssword");
			var y = document.getElementById("confrmNewPasssword");
			
			if (x.type == "password" && y.type == "password") {
				x.type = "text";
				y.type = "text";
			} else {
				x.type = "password";
				y.type = "password";
			}
		}
		
		 function validatePassword() {
			 //alert("Hi");
				var pass = document.getElementById("newPasssword").value;
				var conpass = document.getElementById("confrmNewPasssword").value;
				// alert(pass+" "+conpass);

				if (pass != conpass) {

					document.getElementById("confrmNewPasssword").value = "";
					alert("Confirm password not matched!");
					return false;
				}
			}
	</script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/js/login.js"></script>

</body>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/global_assets/css/login.css">



</html>