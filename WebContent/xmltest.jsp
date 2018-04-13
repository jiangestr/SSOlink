<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">

</script>
<script type="text/javascript">
	//请求SwitchSysAdminAction2调用菜单xml
	function login2(){
	
    	$.ajax({url:"http://localhost:8092/ServiceAction/com.seaz.base.security.servlet.SwitchSysAdminAction2?username=zhangli",
    		dataType: "text",
    		contentType: "text/plain;charset=utf-8", 
    		success:function(result){
    			parseXML(result);
     	},
	    	error:function(result){
	    	}
    	});
	}
	
	function parseXML(result)
	{
	text=result;

	try //Internet Explorer
	  {
	  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
	  xmlDoc.async="false";
	  xmlDoc.loadXML(text);
	  }
	catch(e)
	  {
	  try //Firefox, Mozilla, Opera, etc.
	  {
	  parser=new DOMParser();
	  xmlDoc=parser.parseFromString(text,"text/xml");
	  }
	  catch(e)
	  {
	  alert(e.message);
	  return;
	  }
	}
	document.getElementById("to").innerHTML=xmlDoc.getElementsByTagName("node")[0].childNodes[0].nodeValue;
	document.getElementById("from").innerHTML=xmlDoc.getElementsByTagName("from")[0].childNodes[0].nodeValue;
	document.getElementById("message").innerHTML=xmlDoc.getElementsByTagName("body")[0].childNodes[0].nodeValue;
	}
	
</script>


</head>

<body onload="parseXML()">
<h1>W3Schools Internal Note</h1>
<p><b>To:</b> <span id="to"></span><br />
<b>From:</b> <span id="from"></span><br />
<b>Message:</b> <span id="message"></span>
</p>
</body>
</html>