<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Home</title>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" href="assets/materialize/css/materialize.min.css"
	media="screen,projection" />
<!-- Bootstrap Styles-->
<link href="assets/css/bootstrap.css" rel="stylesheet" />
<!-- FontAwesome Styles-->
<link href="assets/css/font-awesome.css" rel="stylesheet" />
<!-- Morris Chart Styles-->
<link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
<!-- Custom Styles-->
<link href="assets/css/custom-styles.css" rel="stylesheet" />
<!-- Google Fonts-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="assets/js/Lightweight-Chart/cssCharts.css">
</head>
<%
Cookie[] cookies = request.getCookies();
String oAuser = null;
for(Cookie cookie:cookies){
	String name = cookie.getName();
	if(name.equals("oAuser")){
		oAuser = cookie.getValue();
	}
}
String id ="0097c36a5cceb496015ce2680f870a2e";
String username = (String)session.getAttribute("username");
String password = (String)session.getAttribute("password");
%>
<body>
	<div id="wrapper">
		<nav class="navbar navbar-default top-navbar" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle waves-effect waves-dark"
				data-toggle="collapse" data-target=".sidebar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand waves-effect waves-dark" href="javascript:login2()"><i
				class="large material-icons">insert_chart</i> <strong>TRACK</strong></a>

			<div id="sideNav" href="">
				<i class="material-icons dp48">toc</i>
			</div>
		</div>

		<ul class="nav navbar-top-links navbar-right">
			<li><a class="dropdown-button waves-effect waves-dark" href="#!"
				data-activates="dropdown4"><i class="fa fa-envelope fa-fw"></i>
					<i class="material-icons right">arrow_drop_down</i></a></li>
			<li><a class="dropdown-button waves-effect waves-dark" href="#!"
				data-activates="dropdown3"><i class="fa fa-tasks fa-fw"></i> <i
					class="material-icons right">arrow_drop_down</i></a></li>
			<li><a class="dropdown-button waves-effect waves-dark" href="#!"
				data-activates="dropdown2"><i class="fa fa-bell fa-fw"></i> <i
					class="material-icons right">arrow_drop_down</i></a></li>
			<li><a class="dropdown-button waves-effect waves-dark" href="#!"
				data-activates="dropdown1"><i class="fa fa-user fa-fw"></i> <b><%=username %></b>
					<i class="material-icons right">arrow_drop_down</i></a></li>
		</ul>
		</nav>
		<!-- Dropdown Structure -->
		<ul id="dropdown1" class="dropdown-content">
			<li><a href="#"><i class="fa fa-user fa-fw"></i> My Profile</a>
			</li>
			<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a></li>
			<li><a href="#"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
			</li>
		</ul>


		<!--/. NAV TOP  -->
		<nav class="navbar-default navbar-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav" id="main-menu">
				
				
			</ul>

		</div>

		</nav>
		<!-- /. NAV SIDE  -->

		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">Dashboard</h1>
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li><a href="#">Dashboard</a></li>
					<li class="active">Data</li>
				</ol>

			</div>
			<div id="page-inner">

				<iframe name="sss" id="sss" src="http://www.baidu.com" style="height: 900px; width: 100%"></iframe>


			</div>

			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<script type="text/javascript">
	//请求SwitchSysAdminAction2调用菜单xml
	function login2(){
	
    	$.ajax({url:"http://localhost:8080/ServiceAction/com.seaz.base.security.servlet.SwitchUserAction2?username=<%=username %>",
    		dataType: "text",
    		contentType: "text/plain;charset=utf-8", 
    		success:function(result){
    			$('#sss').attr("src","success.jsp");
    			var xmltxt = result;
				var xmlDoc = null;
				var chose = 1; //当为1时以视为ie9以下内核处理xml
    			//alert('结果集'+xmltxt);
    			try //Internet Explorer
    			  {
					xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
    			  	xmlDoc.loadXML(xmltxt);    

					
    			  }
    			catch(e)
    			  {
    			  	try //Firefox, Mozilla, Opera, etc.
	    			  {	

						//alert(e.message);
	    			  	var parser=new DOMParser();
	    			  	xmlDoc=parser.parseFromString(xmltxt,"text/xml");
						chose = 0;

	    			  }
	    			  catch(e)
	    			  {
	    			  	alert(e.message);	    			  
	    			  }
					  
    			}
				//xmlDoc.async=false;
				if(chose==1){
					
						  var nodes = xmlDoc.getElementsByTagName("portlet-menu-tool")[0].childNodes;//ie
							$("#main-menu").empty();//刷新后清空列表									
							for(var a = 0;a<=nodes.length;a++){						
								var node = nodes[a];						
								$("#main-menu").append("<li><a href='#' class='waves-effect waves-dark'><i class='fa fa-sitemap'></i>"+node.getAttribute("name")+"<span class='fa arrow'></span></a><ul id="+node.getAttribute("id")+" class='nav nav-second-level'>   </ul></li>");
								var items = node.childNodes;
								for(var b = 0;b<items.length;b++){
									var item = items[b];
									//ie9以下不支持在a标签里用JavaScript：方法
									$("#_"+(a+1)).append("<li><a target='sss' onclick='changePage(&#39;http://localhost:8080"+item.getAttribute("id")+"&#39;)' >"+item.getAttribute("name")+"</a></li>");							
								}
							}
					  }else if(chose==0){
						  
						//xmlDoc.async=false;
				
						//开始解析
						//var nodet = xmlDoc.getElementsByTagName("portlet-menu-tool")[0].childNodes[0].nodeValue;
						//alert('节点信息1'+xmlDoc.getElementsByTagName("portlet-menu-tool")[0].childNodes[1].childNodes[1].attributes["name"].value);   //子节点必须从1开始
						var nodes = xmlDoc.getElementsByTagName("portlet-menu-tool")[0].children;
						//var nodes = xmlDoc.getElementsByTagName("portlet-menu-tool")[0].childNodes;
						//alert(nodes.length);
						//alert(nodes[1].attributes["name"].value)
						$("#main-menu").empty();
						
						
						for(var a = 0;a<nodes.length;a++){
							
							var node = nodes[a];
							$("#main-menu").append("<li><a href='#' class='waves-effect waves-dark'><i class='fa fa-sitemap'></i>"+node.attributes["name"].value+"<span class='fa arrow'></span></a><ul id="+node.attributes["id"].value+" class='nav nav-second-level'>   </ul></li>");
							//$("#main-menu").append("<li><a href='#' class='waves-effect waves-dark'><i class='fa fa-sitemap'></i>"+node.getAttribute("name")+"<span class='fa arrow'></span></a><ul id="+node.getAttribute("id")+" class='nav nav-second-level'>   </ul></li>");
							//alert(node.attributes["name"].value);
							var items = node.children;
							//var items = node.childNodes;
							//alert(items.length);
							for(var b = 0;b<items.length;b++){
								var item = items[b];
								//alert(item.attributes["id"].value);   &#39;代替‘'’单引号
								//$("#_"+a).append("<li><a target='sss' href='javascript:changePage(&#39;http://localhost:8080"+item.getAttribute("id")+"&#39;)'>"+item.getAttribute("id")+"</a></li>");
								$("#_"+(a+1)).append("<li><a target='sss' href='javascript:changePage(&#39;http://localhost:8080"+item.attributes["id"].value+"&#39;)'>"+item.attributes["name"].value+"</a></li>");
								//alert(item.attributes["name"].value);
							}
						}
					  }
    			
     	},
    	error:function(result){
    	}
    });
}
	
	</script>
	<!-- /. WRAPPER  -->
	<!-- JS Scripts-->
	<!-- jQuery Js -->
	<script src="assets/js/jquery-1.10.2.js"></script>

	<!-- Bootstrap Js -->
	<script src="assets/js/bootstrap.min.js"></script>

	<script src="assets/materialize/js/materialize.min.js"></script>

	<!-- Metis Menu Js -->
	<script src="assets/js/jquery.metisMenu.js"></script>
	<!-- Morris Chart Js -->
	<script src="assets/js/morris/raphael-2.1.0.min.js"></script>
	<script src="assets/js/morris/morris.js"></script>


	<script src="assets/js/easypiechart.js"></script>
	<script src="assets/js/easypiechart-data.js"></script>

	<script src="assets/js/Lightweight-Chart/jquery.chart.js"></script>

	<!-- Custom Js -->
	<script src="assets/js/custom-scripts.js"></script>
	


	<script type="text/javascript">
	
//转发型调用xml
function login(){
	
    $.ajax({url:"http://localhost:8092/j_acegi_security_check?j_username=sysadmin&j_password=123456",
    		success:function(result){
    			$('#sss').attr("src","success.jsp");
    			//回调函数再做请求
    			alert("登陆成功");
    	    	$.ajax({url:"http://localhost:8092/ssoMenuXml/ssoMenuXml.jsp",
    	    		dataType: "text",
    	    		contentType: "text/plain; charset=utf-8", 
    	    		success:function(result){
    	    			 alert(result);
    	     	},
    	    	error:function(result){
    	    		
    	    	}
    	    });
    },
   });
} 
function xml(){
	
	alert("ss");
    	$.ajax({url:"http://localhost:8092/ssoMenuXml/ssoMenuXml.jsp",
    		dataType: "text",
    		contentType: "text/plain; charset=utf-8", 
    		success:function(result){
    			 alert(result);
    
     	},
    	error:function(result){
    	}
    });
}

//转发
/* function login(){
	
    $.ajax({url:"redirect.jsp?j_username=sysadmin&j_password=123456",success:function(result){
    	alert(result);
    	$('#sss').attr("src","success.jsp");
    }});
} */
</script>

	<script type="text/javascript">
            	function changePage(aa){
            		$('#sss').attr("src",aa) ;
            		
            	}
            	/* $("#sss").contents().find("#uname").value= 'sysadmin';
            	$("#sss").contents().find("#j_password").value = 'admin007';
            	alert($("#sss").contents().find("#uname").value);
            	$("#sss").contents().find("#form1").submit(); */
            	
            	
            	/* var doc = document.getElementById("#sss").contentDocument; 
            	alert(doc.body.innerHTML);
            	document.getElementById('#sss').contentWindow.document.getElementByTagName('uname').value = 'sysadmin';
            	document.getElementById('#sss').contentWindow.document.getElementByTagName('j_password').value = 'admin007';
            	document.getElementById('#sss').contentWindow.document.getElementByTagName('form1').submit(); */
            	//$('#sss').attr("src",'http://localhost:8092/workflow/request/formbase.jsp?categoryid=297e899261111161016111e77562001a') ;
				
            	
</script>
	<script type="text/javascript">
		
	
	
</script>
</body>

</html>