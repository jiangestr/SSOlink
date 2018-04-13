<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
<title>Insert title here</title>
</head>
<body>
<form name="form1" id="form1" method="post" action="${pageContext.request.contextPath}/ULservlet" >
        <div class="">
          <label >Email</label>
          <input type="text" name="username" id="username">
        </div>
        <div class="form-group">
          <label class="control-label">Password</label>
          <input type="password" id="password" name="password" >
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox">
            Keep me logged in </label>
        </div>
        <a href="#" ><small>Forgot password?</small></a>
        <button type="submit" >Sign in</button>
        
      </form>
</body>
<script type="text/javascript">

window.onload=function(){
	document.getElementById("username").value = "sysadmin";
	document.getElementById("password").value = "lyadmin007"; 
	alert(document.getElementById("username").value);
	alert(document.getElementById("password").value);
	$("#form1").submit();
}

</script>
</html>