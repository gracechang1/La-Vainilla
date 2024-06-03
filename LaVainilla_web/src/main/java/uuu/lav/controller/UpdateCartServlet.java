package uuu.lav.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.lav.entity.CartItem_lav;
import uuu.lav.entity.ShoppingCart_lav;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart_lav cart = (ShoppingCart_lav)session.getAttribute("cart");
		
		if(cart!=null && cart.size()>0) {
			for(CartItem_lav cartItem:cart.getCartItemSet()) {
				//1.讀取request中的form data
				String quantity=request.getParameter("quantity" + cartItem.hashCode());
				String delete=request.getParameter("delete" + cartItem.hashCode());
				String checkout=request.getParameter("checkout" + cartItem.hashCode());
				
				if(delete==null) {//要修改數量、checkout	
					cartItem.setCheckOut(checkout!=null);
					if(quantity!=null && quantity.matches("\\d+")) {
						int qty = Integer.parseInt(quantity);
						if(qty>0) {
							cart.update(cartItem, qty);
						}else {
							cart.remove(cartItem);
						}						
					}
				}else{ //要刪除明細
					cart.remove(cartItem);
				}			
			}
		}
		
		//3. 外部轉址給cart.jsp(timeout情況下，若尚未結帳，會直接跳轉至cart.jsp)
		if("checkOut".equals(request.getParameter("submit"))) {
			response.sendRedirect("check_out.jsp");
		}else {
			response.sendRedirect("cart.jsp");
		}
	}



}
