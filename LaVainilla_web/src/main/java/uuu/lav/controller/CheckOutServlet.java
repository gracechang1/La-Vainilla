package uuu.lav.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.lav.entity.Order_lav;
import uuu.lav.entity.PaymentType_lav;
import uuu.lav.entity.ShippingType_lav;
import uuu.lav.entity.ShoppingCart_lav;
import uuu.lav.exception.LAVException;
import uuu.lav.exception.StockShortageException_lav;
import uuu.lav.service.OrderService_lav;

/**
 * Servlet implementation class checkOutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOutServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		ShoppingCart_lav cart = (ShoppingCart_lav)session.getAttribute("cart");
		if(cart==null || cart.size()==0) {
			response.sendRedirect("cart.jsp");
			return;
		}		
	
		// 1.取得request中的form data
		String shippingType = request.getParameter("shippingType"); 
		String paymentType = request.getParameter("paymentType");
		String recipientName = request.getParameter("recipientName"); 
		String recipientEmail = request.getParameter("recipientEmail");
		String recipientPhone = request.getParameter("recipientPhone"); 
		String shippingAddress = request.getParameter("shippingAddress");
	
		//檢查form data參數條件
		ShippingType_lav shType = null;
		PaymentType_lav pType = null;
		
		if(shippingType==null || shippingType.length()==0) {
			errors.add("必須選擇貨運方式");
		}else {
			shType = ShippingType_lav.valueOf(shippingType);
		}
		
		if(paymentType==null || paymentType.length()==0) {
			errors.add("必須選擇付款方式");
		}else {
			pType = PaymentType_lav.valueOf(paymentType);
		}
		
		if(recipientName==null || 
				(recipientName=recipientName.trim()).length()==0) {
			errors.add("必須輸入收件人姓名");
		}
		
		if(recipientEmail==null || 
				(recipientEmail=recipientEmail.trim()).length()==0) {
			errors.add("必須輸入收件人Email");
		}
		
		if(recipientPhone==null || 
				(recipientPhone=recipientPhone.trim()).length()==0) {
			errors.add("必須輸入收件人手機");
		}
		
		if(shippingAddress==null || 
				(shippingAddress=shippingAddress.trim()).length()==0) {
			errors.add("必須輸入收件地址");
		}
	
		//2.若無誤，則呼叫商業邏輯
		if(errors.isEmpty()) {
			
			Order_lav order = new Order_lav();
			
			order.setOrderDate(LocalDate.now());
			order.setOrderTime(LocalTime.now());
			
			order.setShippingType(shType);
			order.setShippingFee(shType.getFee());
			
			order.setPaymentType(pType);
			order.setPaymentFee(pType.getFee());
			
			order.setRecipientName(recipientName);
			order.setRecipientEmail(recipientEmail);
			order.setRecipientPhone(recipientPhone);
			order.setShippingAddress(shippingAddress);
			
			order.add(cart);
			
			OrderService_lav oService = new OrderService_lav();
			try {
				oService.checkOut(order);
				
				cart.removeCheckOutItem();
				
		        //信用卡(若paymentType.equals("CARD"))則轉交/WEB-INF/credit_card.jsp來送出對於第三方支付的請求
	            if(order.getPaymentType()==PaymentType_lav.CARD){               
	                    request.setAttribute("order", order);
	                    request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);
	                  return;
	            }
				
			//3.1 成功則forward給check_out_ok.jsp	
				request.setAttribute("order", order);
				request.getRequestDispatcher("check_out_ok.jsp").forward(request, response);
				return;
			} catch(StockShortageException_lav e) {
				this.log(e.toString(), e);
				response.sendRedirect("cart.jsp");
				return;	
			} catch (LAVException e) {
				this.log(e.getMessage(), e);
				errors.add(e.getMessage()+",請聯絡Admin");
			}catch (Exception e) {
				this.log("系統發生非預期錯誤", e);
				errors.add("系統發生錯誤:" + e.getMessage()+",請聯絡Admin");
			}
		}

		//3.2 失敗則forward給check_out.jsp
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("check_out.jsp").forward(request, response);
		return;

		
	}

}
