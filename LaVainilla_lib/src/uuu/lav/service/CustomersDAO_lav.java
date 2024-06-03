package uuu.lav.service;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.lav.entity.Customer_lav;
import uuu.lav.entity.VIP_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;

class CustomersDAO_lav {
//	MySQL指令
	private static final String SELECT_CUSTOMER_BYEMAIL=
			"SELECT name, birthday, gender, email, password, phone, address, subscribed, discount"
			+ "	FROM customers WHERE email=?";
//	前端傳來帳號	
	Customer_lav selectCustomerByEmail(String email) throws LAVException{
		
//	查詢客戶
		Customer_lav c=null;
		try(
//	1,2取得連線					
			Connection connection=MySQLConnection_lav.getConnection();
//	3.準備指令物件				
			PreparedStatement pstmt=connection.prepareStatement(SELECT_CUSTOMER_BYEMAIL);				
			){
//	3.1傳入?的值		
			pstmt.setString(1, email);
			
//	4.執行指令			
			try(
					ResultSet rs=pstmt.executeQuery();
				) {
//	5.處理rs	
			while (rs.next()) {
//	VIP條件				
				int discount=rs.getInt("discount");
				if(discount>0) {
					c= new VIP_lav();
					((VIP_lav)c).setDiscount(discount);
				}else {
					c=new Customer_lav();
				}
				
				c.setName(rs.getString("name"));
				c.setBirthday(rs.getString("birthday"));
				c.setGender(rs.getString("gender").charAt(0));
				c.setEmail(rs.getString("email"));
				c.setPassword(rs.getString("password"));
				c.setPhone(rs.getString("phone"));
				c.setAddress(rs.getString("address"));
				c.setSubscribed(rs.getBoolean("subscribed"));
				System.out.println(c);
				}
			}
			return c;
			
		} catch (SQLException e) {
			Logger.getLogger("").log(Level.SEVERE, "執行會員登入SQL失敗", e);
			throw new LAVException("查詢客戶失敗",e);
		}
	}
	
	
//	註冊會員
	private static final String INSERT_CUSTOMERS="INSERT INTO customers (name, birthday, gender, email, password, phone, address, subscribed)"
			+ "	VALUES (?,?,?, ?,?,?, ?,?)";
	public void insert(Customer_lav c) throws LAVException{
		
		try(
			Connection connection=MySQLConnection_lav.getConnection();
			PreparedStatement pstmt=connection.prepareStatement(INSERT_CUSTOMERS);	
				){
			pstmt.setString(1, c.getName());
			pstmt.setString(2, String.valueOf(c.getBirthday()));
			pstmt.setString(3, String.valueOf(c.getGender()));
			pstmt.setString(4, c.getEmail());
			pstmt.setString(5, c.getPassword());
			pstmt.setString(6, c.getPhone());
			pstmt.setString(7, c.getAddress());
			pstmt.setBoolean(8, c.isSubscribed());
		
			pstmt.executeUpdate();
			
//	拋出Pkey、UNIQUE_INDEX重複錯誤
//	違反資料庫唯一約束條件			
		}catch (SQLIntegrityConstraintViolationException e) {
//	查詢字串位置(找不到回傳-1)			
			if(e.getMessage().indexOf("PRIMARY")>=0) {
				throw new LAVDataInvalidException("會員註冊失敗，帳號重複",e);
			}else if(e.getMessage().indexOf("phone_UNIQUE")>=0) {
				throw new LAVDataInvalidException("會員註冊失敗，手機號碼重複",e);
			}else{
//	Not Null				
				throw new LAVException("會員註冊失敗",e);
			}
		
		} catch (SQLException e) {
			throw new LAVException("新增會員失敗",e);
		}
		
	}

//	修改會員	
	private static final String UPDATE_CUSTOMERS ="UPDATE customers SET"
			+ "	name=?, birthday=?, gender=?, email=?, password=?, phone=?, address=?, subscribed=?"
			+ "	WHERE(email=?)";
	public void update(Customer_lav c) throws LAVException{
		try (
			Connection connection= MySQLConnection_lav.getConnection();
			PreparedStatement pstmt= connection.prepareStatement(UPDATE_CUSTOMERS);
				){
			
			pstmt.setString(1, c.getName());
			pstmt.setString(2, String.valueOf(c.getBirthday()));
			pstmt.setString(3, String.valueOf(c.getGender()));
			pstmt.setString(4, c.getEmail());
			pstmt.setString(5, c.getPassword());
			pstmt.setString(6, c.getPhone());
			pstmt.setString(7, c.getAddress());
			pstmt.setBoolean(8, c.isSubscribed());
			pstmt.setString(9, c.getEmail());
			
			pstmt.executeUpdate();
			
//	拋出UNIQUE_INDEX重複錯誤(PKEY不可修改)
//	違反資料庫唯一約束條件	
		}catch(SQLIntegrityConstraintViolationException e) {
//	查詢字串位置(找不到回傳-1)			
			if(e.getMessage().indexOf("phone_UNIQUE")>=0) {
				throw new LAVDataInvalidException("會員修改失敗，手機號碼重複",e);
			}else{
//	Not Null				
				throw new LAVException("會員修改失敗",e);
			}

		} catch (SQLException e) {
			throw new LAVException("修改會員失敗", e);
		}
	}


}
