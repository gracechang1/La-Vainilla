package uuu.lav.test;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.service.MySQLConnection_lav;

public class TestMySQLConnection_lav {
	private static final String driver="com.mysql.cj.jdbc.Driver";
	private static final String url="jdbc:mysql://localhost:3306/lav" ;
	private static final String userid="root" ;
	private static final String password="Mysql@8035" ;

	public static void main(String[] args) {
//	1.載入JDBC Driver		
		try {
			Class.forName(driver);
//	2.建立連線			
			try {
				Connection c=DriverManager.getConnection(url,userid,password);
				System.out.println(c.getClass().getName()+"連線成功");
				c.close();
				
			} catch (SQLException e) {
				Logger.getLogger("").log(Level.SEVERE, "連線不成功", e);
			}
			
		} catch (ClassNotFoundException e) {
//	for admin			
			Logger.getLogger("").log(Level.SEVERE, "載入Driver失敗", e);
		}
		
	}

}
