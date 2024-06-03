package uuu.lav.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.lav.entity.Customer_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
       
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors= new ArrayList<>();
		request.setCharacterEncoding("UTF-8");
		
//	載入session
		HttpSession session= request.getSession();
		
//	1.取得request中的Form Data(name, birthday, gender, email, pwd1, pwd2,
//								phone, address, captcha, subscribedAgree, subscribedMsg)		
		String name= request.getParameter("name");	
		String birthday= request.getParameter("birthday");
		String gender= request.getParameter("gender");
		String email= request.getParameter("email");
		String pwd1= request.getParameter("pwd1");
		String pwd2= request.getParameter("pwd2");
		String phone= request.getParameter("phone");
		String address= request.getParameter("address");
		String captcha= request.getParameter("captcha");
		String subscribedAgree= request.getParameter("subscribedAgree");
		String subscribedMsg= request.getParameter("subscribedMsg");
		
//	檢查必要欄位(name, birthday, gender, email, pwd1, pwd2, phone,
//				captcha)	
		if(name==null || (name=name.trim()).length()==0) errors.add("請務必輸入姓名");
		if(birthday==null || birthday.length()==0) errors.add("請務必輸入生日");
		if(gender==null || gender.length()!=1) errors.add("請務必輸入性別");
		if(email==null || (email=email.trim()).length()==0) errors.add("請務必輸入帳號(email)");
//		if(pwd1==null || pwd1.length()==0) errors.add("請務必輸入密碼");
//		if(pwd2==null || pwd2.length()==0 || !pwd2.equals(pwd1)) errors.add("請務必再次確認密碼");
		if(pwd1==null || pwd1.length()==0 || !pwd1.equals(pwd2)) errors.add("請務必輸入密碼且再次確認密碼一致性"); 
		if(phone==null || (phone=phone.trim()).length()==0) errors.add("請務必輸入手機號碼");
		if(captcha==null || (captcha=captcha.trim()).length()==0) {
			errors.add("請務必輸入驗證碼");
		} else {
//	完成驗證碼檢查	
			String genedCaptcha= (String)session.getAttribute("RegisterCaptchaServlet");
			if(!captcha.equalsIgnoreCase(genedCaptcha)) {
				errors.add("驗證碼不正確，請重新輸入");
			}
		}
		session.removeAttribute("RegisterCaptchaServlet");
		
//	2. 若檢查無誤，呼叫商業邏輯	
		if(errors.isEmpty()) {
			Customer_lav c= new Customer_lav();
			try {
				c.setName(name);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				c.setEmail(email);
//	pw1跟pw2物件內容相同,故只須設定pwd1				
				c.setPassword(pwd1);
				c.setPhone(phone);
				c.setAddress(address);
				c.setSubscribed(subscribedAgree!=null);
				c.setSubscribed(subscribedMsg!=null);
				
				CustomerService_lav cService= new CustomerService_lav();
				cService.register(c);
				
				
//	3.1 內部轉交(forward)成功(register_ok.jsp)	
				request.setAttribute("member",c);
				request.getRequestDispatcher("register_ok.jsp").forward(request, response);	
				
//	TODO:寄送email來通知登入成功				
				return;
				
			} catch(LAVDataInvalidException e) {
				errors.add(e.getMessage());
				
			} catch (LAVException e) {
				this.log(e.getMessage(), e);	
				errors.add(e.getMessage()+ ",請聯絡管理員");
				
			} catch (Exception e) {
				this.log("系統錯誤(Register Failed)"+ e.getMessage(), e);
				errors.add("系統無法註冊,請聯絡管理員");
			}
		}
		
//	3.2 失敗內部轉交(register.jsp), 重新註冊
				request.setAttribute("errors", errors);
				request.getRequestDispatcher("register.jsp").forward(request, response);
		
//	TODO: 寄送email來通知登入失敗		
		
	}

}
