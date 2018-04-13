package com.oa.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class sqltset {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String sql =  "select username,password from user where username = 'sysadmin' and password = 'admin007'";
		Connection conn = DBHelper.getCon();
		try {
			PreparedStatement pstat = conn.prepareStatement(sql);
			ResultSet set = pstat.executeQuery();
			if(set.next()){
				String username1 = set.getString(1);
				String password1 = set.getString(2);
				System.out.println("Êä³ö£º"+username1+password1);
			
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
