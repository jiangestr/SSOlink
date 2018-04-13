<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println("转发成功");
	%>
	
</body>
<!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script type="text/javascript">

    $.ajax({url:"http://localhost:8092/j_acegi_security_check?j_username=sysadmin&j_password=123456",success:function(result){
    	$.ajax({url:"http://localhost:8092/ssoMenuXml/ssoMenuXml.jsp",success:function(result){
        	alert(result);
        }});
    }});

</script>
</html>