package uuu.lav.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.filters.ExpiresFilter.XPrintWriter;

import uuu.lav.entity.Customer_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.exception.LoginFailedException_lav;
import uuu.lav.service.CustomerService_lav;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name="uuu.lav.controller.LoginServlet", urlPatterns = {"/login.do"}, loadOnStartup = 1)
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   	
    	List<String> errors= new ArrayList<>();
//	載入session     	
    	HttpSession session= request.getSession();
    	
//	1.取得請求的form data...(email、password、captcha)
    	String email= request.getParameter("email");
    	String password= request.getParameter("password");
    	String captcha= request.getParameter("captcha");
    	
//    	System.out.printf("email:%s, password:%s, captcha:%s", email, password, captcha);
//	檢查前端請求
    	if(email==null || (email=email.trim()).length()==0) {
    		errors.add("請務必輸入帳號");
    	}
    	if(password==null || password.length()==0) {
    		errors.add("請務必輸入密碼");
    	}
    	if(captcha==null || (captcha=captcha.trim()).length()==0) {
    		errors.add("請務必輸入驗證碼");
    	}else {
//	完成驗證碼檢查
    		String genedCaptcha= (String)session.getAttribute("LoginCaptchaServlet");
    		if(!captcha.equalsIgnoreCase(genedCaptcha)) {
    			errors.add("驗證碼不正確，請重新輸入");
    		}
		}
    	session.removeAttribute("LoginCaptchaServlet");
    	
    	
//	2.若檢查無誤，呼叫商業邏輯
    	if(errors.isEmpty()) {
    		CustomerService_lav cService= new CustomerService_lav();
    		try {
    			Customer_lav c= cService.login(email, password);
    			
    		    			
//	3.1 內部轉交(forward)成功(login_ok.jsp)
//    		request.setAttribute("member",c);
//    		RequestDispatcher dispatcher= request.getRequestDispatcher("login_ok.jsp");
//    		dispatcher.forward(request, response);	
//	3.1 外部轉址(index.jsp)
//    		session.setAttribute("member",c);	
//    		response.sendRedirect("./");
//	3.1 外部轉址(login_ok.jsp)
    		session.setAttribute("member",c);
    		response.sendRedirect("login_ok.jsp");
    		
//	TODO: 寄送email來通知登入成功    			
    			return;
    			
    		}catch(LoginFailedException_lav e) {
    			errors.add(e.getMessage());
    			
    		} catch (LAVException e) {
    			this.log("Login Failed"+ e.getMessage(), e);
    			errors.add(e.getMessage()+",請聯絡管理員");
    		}
    	}
    	
//	3.2 內部轉交(forward)給失敗jsp(login.jsp)
    	request.setAttribute("errors",errors);
    	RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
    	dispatcher.forward(request, response);
    	
//	TODO: 寄送email來通知登入失敗   	
    	
	}

}
