package com.oa.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class ULservlet
 */
public class ULservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ULservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = (String)request.getParameter("username");
		String password = (String)request.getParameter("password");
		System.out.println(username);
		String sql =  "select username,password from user where username = '"+username+"' and password = '"+password+"'";
		Connection conn = DBHelper.getCon();
		try {
			PreparedStatement pstat = conn.prepareStatement(sql);
			ResultSet set = pstat.executeQuery();
			if(set.next()){
				String username1 = set.getString(1);
				String password1 = set.getString(2);
				HttpSession session = request.getSession();
				session.setAttribute("username", username1);
				session.setAttribute("password", password1);
				Cookie[] cookies = request.getCookies();
				for(Cookie cookie:cookies){
					String name = cookie.getName();
					if(name.equals("oAuser")){
						cookie.setMaxAge(0);
					}
				}
				Cookie cookie = new Cookie("OAuser", username1+"#"+password1);
				cookie.setMaxAge(-1);
				response.setCharacterEncoding("UTF-8");
			    response.setContentType("text/html;charset=UTF-8");
			    response.addCookie(cookie);
			    response.sendRedirect("index.jsp");
			}else{
				response.setCharacterEncoding("UTF-8");
			    response.setContentType("text/html;charset=UTF-8");
			    response.getWriter().write("µÇÂ½Ê§°Ü");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
