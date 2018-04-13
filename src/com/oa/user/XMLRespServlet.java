package com.oa.user;

import com.seaz.base.AbstractAction;
import com.seaz.base.BaseContext;
import com.seaz.base.security.model.Sysuser;
import com.seaz.base.security.service.acegi.SeazUser;
import com.seaz.base.security.service.logic.SysuserService;
import com.seaz.base.util.NumberHelper;
import com.seaz.base.util.StringHelper;
import com.seaz.homepage.dao.WebSkinDao;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.acegisecurity.Authentication;
import org.acegisecurity.GrantedAuthority;
import org.acegisecurity.context.SecurityContextHolder;
import org.acegisecurity.providers.ProviderManager;
import org.acegisecurity.providers.UsernamePasswordAuthenticationToken;
import org.acegisecurity.userdetails.UserDetails;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class XMLRespServlet implements AbstractAction {
	protected final Log logger = LogFactory.getLog(this.getClass());
	private HttpServletRequest request;
	private HttpServletResponse response;
	private SysuserService sysuserService;
	private ProviderManager providerManager;

	public XMLRespServlet(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.sysuserService = (SysuserService) BaseContext.getBean("sysuserService");
		this.providerManager = (ProviderManager) BaseContext.getBean("switchAuthenticationManager");
	}
	
	public  Connection getConnection(){
    	String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=seaztt";
        String USER="sa";
        String PASSWORD="root";
        Connection conn=null;
        
    	 try {
             //1.加载驱动程序
             Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
             //2.获得数据库的连接
             conn=(Connection)DriverManager.getConnection(URL,USER,PASSWORD);
         } catch (ClassNotFoundException e) {
             e.printStackTrace();
         } catch (SQLException e) {
             e.printStackTrace();
         }
        return conn;
    }

	public void execute() throws IOException, ServletException {
		//SeazUser user=BaseContext.getRemoteUser();
		WebSkinDao webSkinDao=(WebSkinDao)BaseContext.getBean("webSkinDao");
		String longonname = request.getParameter("username");
		String hql="from Sysuser where longonname='"+longonname+"'";
		List<Sysuser> list1=webSkinDao.getList(hql);
		if(list1.get(0)==null) {
			response.setContentType("text/xml");
	        response.setHeader("Cache-Control", "no-cache");
	        response.getWriter().write("帐号不存�?");
	        return;
		}
		SwitchUserAction.switchUser(request,list1.get(0));
		
		//返回菜单xml
	     // TODO Auto-generated method stub 2c90808c41c40c540141c439179400dd   4028b8815ad4978c015ad66ef20d01bc(seaztt行政办公)
	    	String sql = "select menuname from menu where pid ='4028b8815ad4978c015ad66ef20d01bc' and URL is null and ISDELETE = 0";
	    	List<String> menuNodes = new LinkedList<String>();

	    	Connection conn = getConnection();
	    	PreparedStatement pstat;

	    	try {
	    		pstat = conn.prepareStatement(sql);
	    		ResultSet set = pstat.executeQuery();
	    		while (set.next()) {
	    			menuNodes.add(set.getString(1));
	    			//System.out.println(set.getString(1));
	    		}
	    		//System.out.println(menuNodes.toString());
	    		//创建docbuilerfactory
	    		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    		DocumentBuilder builder;
	    		try {
	    			builder = factory.newDocumentBuilder();
	    			Document document = builder.newDocument();
	    			document.setXmlStandalone(true);

	    			Element tool = document.createElement("portlet-menu-tool");
	    			int i = 0;
	    			//遍历memuNodes
	    			for (String menu : menuNodes) {
	    				/* System.out.println("////////////////////////");
	    				System.out.println(menu); */
	    				i++;
	    				//创建�?个子节点
	    				Element node = document.createElement("node");
	    				//设置属�??
	    				node.setAttribute("ident", String.valueOf(i));
	    				node.setAttribute("id", "_" + i);
	    				node.setAttribute("name", menu);
	    				node.setAttribute("portlet", "portlet");
	    				String sql2 = "select menuname,url from menu where pid"
	    						+ " in (select id from menu where menuname = '" + menu + "')"
	    						+ " and isdelete = 0 and URL is not null";
	    				PreparedStatement pstat1 = conn.prepareStatement(sql2);
	    				ResultSet set1 = pstat1.executeQuery();
	    				int j = 0;
	    				while (set1.next()) {
	    					//System.out.println(set1.getString(1));
	    					j++;
	    					Element item = document.createElement("item");
	    					//设置属�??
	    					item.setAttribute("ident", i + "." + j);
	    					item.setAttribute("id", set1.getString(2));
	    					item.setAttribute("name", set1.getString(1));
	    					node.appendChild(item);
	    				}
	    				// 为根节点添加子节�?
	    				tool.appendChild(node);
	    			}
	    			// 将根节点添加到Document�?
	    			document.appendChild(tool);

	    			/*
	    			 * 下面�?始实现： 生成XML文件
	    			 */

	    			// 创建TransformerFactory对象
	    			TransformerFactory tff = TransformerFactory.newInstance();

	    			// 创建Transformer对象
	    			Transformer tf = tff.newTransformer();

	    			// 设置输出数据时换�?
	    			tf.setOutputProperty(OutputKeys.INDENT, "yes");

	    			// 使用Transformer的transform()方法将DOM树转换成XML
	    			File file = new File("e://menu.xml");
	    			//保存成文�?
	    			tf.transform(new DOMSource(document), new StreamResult(file));

	    			//将dom转换成字符串
	    			//ByteArrayOutputStream bos = new ByteArrayOutputStream();

	    			//返回menuXml
	    			response.setCharacterEncoding("UTF-8");
	    			/*response.setHeader("Charset","UTF-8");
	    			response.setContentType("text/plain;charset=UTF-8");*/
	    			response.setContentType("text/xml");
	                response.setHeader("Cache-Control", "no-cache");
	    			//把response的流直接放到xml转换器中
	    			PrintWriter reout = response.getWriter();
	    			tf.transform(new DOMSource(document), new StreamResult(reout));
	    			String menuXmls = reout.toString();
	    			System.out.println(menuXmls);
	    			reout.flush();
	    			reout.close();
	    			return;

	    		} catch (ParserConfigurationException e) {
	    			// TODO Auto-generated catch block
	    			e.printStackTrace();
	    		} catch (TransformerConfigurationException e) {
	    			// TODO Auto-generated catch block
	    			e.printStackTrace();
	    		} catch (TransformerException e) {
	    			// TODO Auto-generated catch block
	    			e.printStackTrace();
	    		}
	    	} catch (SQLException e) {
	    		// TODO Auto-generated catch block
	    		e.printStackTrace();
	    	} finally {
	    		try {
	    			conn.close();
	    		} catch (SQLException e) {
	    			// TODO Auto-generated catch block
	    			e.printStackTrace();
	    		}
	    	}
	}

	public static int switchUser(HttpServletRequest request, Sysuser sysuser) {
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(sysuser.getLongonname(),
				sysuser.getLogonpass());
		ProviderManager _providerManager = (ProviderManager) BaseContext.getBean("switchAuthenticationManager");
		Authentication at = _providerManager.doAuthentication(token);
		if (at != null) {
			Object principal = at.getPrincipal();
			if (principal != null && UserDetails.class.isInstance(principal)) {
				SeazUser vu = (SeazUser) principal;
				GrantedAuthority[] gas = vu.getAuthorities();
				GrantedAuthority[] arg10 = gas;
				int arg9 = gas.length;

				for (int arg8 = 0; arg8 < arg9; ++arg8) {
					GrantedAuthority ga = arg10[arg8];
					System.out.println(ga.getAuthority());
				}

				vu.setSessionid(request.getSession(true).getId());
				vu.setRemoteIpAddress(request.getRemoteAddr());
				request.getSession(true).setAttribute("seaz_user@bean", sysuser);
				SecurityContextHolder.getContext().setAuthentication(at);
			}
		}

		return 0;
	}
}