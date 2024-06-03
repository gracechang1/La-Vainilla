package uuu.lav.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

import uuu.lav.exception.LAVException;

public class MySQLConnection_lav {
	private static final String driver;
	private static final String url ;
	private static final String userid ;
	private static final String password ;
	
	static {		
//	jdbc屬性可以宣告為final
//		ResourceBundle 的靜態 getBundle() 方法會取得一個 ResourceBundle 的實例，所給定的引數名稱是訊息檔案的主檔名，getBundle() 會自動找到對應的 .properties檔案，
//		取得 ResourceBundle 實例後，可以使用 getString() 指定鍵來取得檔案中對應的值，如果日後想要改變顯示的訊息，只要改變 .properties 檔案的內容就可以了。
		ResourceBundle bundle = ResourceBundle.getBundle("mysql_jdbc");
		driver=bundle.getString("driver");
		url=bundle.getString("url");
		userid=bundle.getString("userid");
		password=bundle.getString("password");

		
//	測試訊息
//		System.out.printf("driver:%s\n"
//				           + "url:%s\n"
//				           + "userid:%s\n"
//				           + "pwd:%s\n", driver, url, userid, password);
	}
	
	public static Connection getConnection() throws LAVException{
		try {
//	1.載入JDBC Driver	 	
			Class.forName(driver);
//	2.建立連線			
			try {
				Connection c=DriverManager.getConnection(url,userid,password);
				return c;
			} catch (SQLException e) {
				throw new LAVException("建立連線失敗:" + driver, e);
			}
			
		} catch (ClassNotFoundException e) {
			throw new LAVException("載入JDBC Driver失敗:" + driver, e);
		}
		
	}
}
