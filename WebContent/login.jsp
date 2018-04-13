<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="bg-dark">
<head>
<meta charset="utf-8" />
<title>Notebook | Web Application</title>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="css/app.v2.css" type="text/css" />
<link rel="stylesheet" href="css/font.css" type="text/css" cache="false" /> 
<!--[if lt IE 9]> <script src="js/ie/html5shiv.js" cache="false"></script> <script src="js/ie/respond.min.js" cache="false"></script> <script src="js/ie/excanvas.js" cache="false"></script> <![endif]-->
</head>
<body>
<section id="content" class="m-t-lg wrapper-md animated fadeInUp">
  <div class="container aside-xxl"> <a class="navbar-brand block" href="">Notebook</a>
    <section class="panel panel-default bg-white m-t-lg">
      <header class="panel-heading text-center"> <strong>Sign in</strong> </header>
      <form action="${pageContext.request.contextPath}/ULservlet" class="panel-body wrapper-lg">
        <div class="form-group">
          <label class="control-label">Email</label>
          <input type="text" placeholder="test@example.com" name="username" class="form-control input-lg">
        </div>
        <div class="form-group">
          <label class="control-label">Password</label>
          <input type="password" id="inputPassword" name="password" placeholder="Password" class="form-control input-lg">
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox">
            Keep me logged in </label>
        </div>
        <a href="#" class="pull-right m-t-xs"><small>Forgot password?</small></a>
        <button type="submit" class="btn btn-primary">Sign in</button>
        
      </form>
    </section>
  </div>
</section>
<!-- footer -->
<footer id="footer">
  <div class="text-center padder">
    <p> <small>Web app framework base on Bootstrap<br>
      &copy; 2013</small> </p>
  </div>
</footer>
</body>
</html>