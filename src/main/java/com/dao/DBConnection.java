package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	public static Connection conn;
	
	public static Connection getConn() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db" ,"root","anant2004");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
