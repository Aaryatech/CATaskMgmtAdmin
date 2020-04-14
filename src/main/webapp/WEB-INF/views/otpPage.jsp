<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<%@ page import="java.util.UUID"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.math.BigInteger"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Task Management</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/global_assets/images/kppm.png"
	type="image/x-icon" />
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
register-show input[type="submit"] {
    max-width: 150px;
    width: 100%;
    background: #444444;
    color: #f9f9f9;
    border: none;
    padding: 10px;
    text-transform: uppercase;
    border-radius: 5px;
    float:right;
    cursor:pointer;
}

.register-show1{
    max-width: 150px;
    width: 100%;
    background: #444444;
    color: #f9f9f9;
    border: none;
    padding: 10px;
    text-transform: uppercase;
    border-radius: 2px;
    float:right;
    cursor:pointer;
}

</style>

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
<div class="content">
				<form method="post"
					action="${pageContext.request.contextPath}/validateOTP">

				<%
											UUID uuid = UUID.randomUUID();
											MessageDigest md = MessageDigest.getInstance("MD5");
											byte[] messageDigest = md.digest(String.valueOf(uuid).getBytes());
											BigInteger number = new BigInteger(1, messageDigest);
											String hashtext = number.toString(16);
											session = request.getSession();
											session.setAttribute("generatedKey", hashtext);
										%>
										<input type="hidden" value="<%out.println(hashtext);%>"
											name="token" id="token">
												<div class="row">
					<h2>Enter OTP</h2>
					
						<div class="col-md-8">
					<input type="text" placeholder="Enter OTP" name="otp"
						id="otp" style="border-radius: 5px">
						<c:if test="${errorPassMsg!=null}">
						<span style="color: red;">${errorPassMsg}</span>
						<%
									session.removeAttribute("errorPassMsg");
								%>
						 
					</c:if>
					
					</div>
					</div>
					
								<div class="row" style="display: inline-block;width: 100%;">
								<div class="col-md-3" style="float: left;margin: 9px 0 0 0;">
							<input type="hidden" value="${sessionScope.userEmail}" name="userEmail">
								
						 <input type="submit"   value="Submit">
						 </div>
						 <div class="col-md-3" style="float: left;">
						 <a href="${pageContext.request.contextPath}/"><button
									class="register-show1" style="float: left;"	type="button">Cancel</button></a>
						</div>
								</div>
						
					 

				</form>
				</div>
			</div>
					<span id="countdown" style="color: red; font-size: 12px;"></span>	

		</div>
	</div>


	<script>
		function myFunction() {
			var x = document.getElementById("password");
			if (x.type === "password") {
				x.type = "text";
			} else {
				x.type = "password";
			}
		}
	</script>
<script type="text/javascript">
	
	var timeleft = 114;
	var downloadTimer = setInterval(function(){
	  document.getElementById("countdown").innerHTML = timeleft + " seconds remaining to expire sent OTP";
	  timeleft -= 1;
	  if(timeleft <= 0){
	    clearInterval(downloadTimer);
	    document.getElementById("countdown").innerHTML = "OTP Expired"
	    	document.getElementById("wp-submit").disabled=true;	
	  }
	}, 1000);
	
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/js/login.js"></script>

</body>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/global_assets/css/login.css">



</html>