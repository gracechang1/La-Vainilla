package uuu.lav.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.lav.entity.Customer_lav;
import uuu.lav.entity.VIP_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;
import uuu.lav.service.CustomerService_lav;

/**
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet("/member/update_member.do")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<String> errors= new ArrayList<>();
//	載入session(檢查已存在session:有,載入 沒有,回傳null) 		
		HttpSession session= request.getSession(false);
		Customer_lav member= null;
		if(session!=null) {
			member= (Customer_lav) session.getAttribute("member");
		}
		if(member==null) {
			errors.add("請重新登入會員");
		}
		
//	1.讀取請求中的form data，並檢查必要欄位	
//		(name, birthday, gender, email, pwd, changePwdBox, pwd1, pwd2,
//		 phone, address, captcha, subscribedAgree, subscribedMsg)
		String name= request.getParameter("name");	
		String birthday= request.getParameter("birthday");
		String gender= request.getParameter("gender");
		String email= request.getParameter("email");
		String pwd= request.getParameter("pwd");
//	TODO:修改密碼		
//		String changPwdBox= request.getParameter("changePwdBox");
//		String pwd1= request.getParameter("pwd1");
//		String pwd2= request.getParameter("pwd2");
		
		String phone= request.getParameter("phone");
		String address= request.getParameter("address");
		String captcha= request.getParameter("captcha");
		String subscribedAgree= request.getParameter("subscribedAgree");
		String subscribedMsg= request.getParameter("subscribedMsg");		
//	檢查必要欄位(name, birthday, gender, email, pwd, changePwdBox, 
//		      pwd1, pwd2, phone,captcha)
		if(name==null || (name=name.trim()).length()==0) errors.add("請務必輸入姓名");
		if(birthday==null || birthday.length()==0) errors.add("請務必輸入生日");
		if(gender==null || gender.length()!=1) errors.add("請務必輸入性別");
//	帳號不得修改且與註冊帳號相同		
		if(email!=null && !email.equals(member.getEmail())) errors.add("無法更改註冊帳號(email)");
//	與註冊密碼相同		
		if(pwd==null || !pwd.equals(member.getPassword())) errors.add("與註冊密碼不相符");
//	TODO: 要修改密碼	
//		if(changePwdBox!=null) {
//			if(pwd1==null || pwd1.length()==0 || !pwd1.equals(pwd2)) errors.add("請務必輸入密碼且再次確認密碼一致性"); 
//		}
		
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
				Customer_lav c;
//	加入VIP條件				
				if(member instanceof VIP_lav) {
					c= new VIP_lav();
					((VIP_lav)c).setDiscount(((VIP_lav)c).getDiscount());
				}else {
					c= new Customer_lav();
				}
				
				try {
					c.setName(name);
					c.setBirthday(birthday);
					c.setGender(gender.charAt(0));
//	帳號不可設定,與註冊相同					
					c.setEmail(member.getEmail());
//	TODO:修改密碼					
//					if(changePwdBox!=null) {
//						c.setPassword(pwd1);
//					}else {
						c.setPassword(member.getPassword());
//					}
					
					c.setPhone(phone);
					c.setAddress(address);
					c.setSubscribed(subscribedAgree!=null);
					c.setSubscribed(subscribedMsg!=null);
					
					CustomerService_lav cService= new CustomerService_lav();
//	修改table中的會員					
					cService.update(c);
					
//	3.1 外部轉址(index.jsp)
					session.setAttribute("member",c);
					response.sendRedirect(request.getContextPath());	
					
//	TODO:寄送email來通知登入成功				
					return;
					
				} catch(LAVDataInvalidException e) {
					errors.add(e.getMessage());
					
				} catch (LAVException e) {
					this.log(e.getMessage(), e);	
					errors.add(e.getMessage()+ ",請聯絡管理員");
					
				} catch (Exception e) {
					this.log("系統錯誤(Update Member Failed)"+ e.getMessage(), e);
					errors.add("系統無法修改會員,請聯絡管理員");
				}
			}
			
//	3.2 內部轉交(forward)給失敗jsp(update_member.jsp)
					request.setAttribute("errors", errors);
					request.getRequestDispatcher("update_member.jsp").forward(request, response);
			
//		TODO: 寄送email來通知登入失敗		
			
		}

	
}
