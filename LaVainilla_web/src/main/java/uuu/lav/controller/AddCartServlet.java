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

import uuu.lav.entity.Product_lav;
import uuu.lav.entity.ShoppingCart_lav;
import uuu.lav.entity.Spec_lav;
import uuu.lav.exception.LAVDataInvalidException;
import uuu.lav.exception.LAVException;
import uuu.lav.service.ProductService_lav;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/add_cart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		// 1.取得請求中的form data
		String productId=request.getParameter("productId");
		String flavor = request.getParameter("flavor"); 	//可能NULL
		String spec = request.getParameter("spec"); 		//可能NULL
		String quantity=request.getParameter("quantity");
		
		//2. 呼叫商業邏輯
		if(productId!=null) {
			ProductService_lav pService = new ProductService_lav();						
			try {
				Product_lav p = pService.getProductById(productId);
				if(p!=null) {
					Spec_lav theSpec = null;
					if(p.getSpecCount()>0) {
						theSpec = pService.getSpecById(productId, flavor, spec);
						if(theSpec==null) {
							errors.add("加入購物車失敗，產品規格不正確: " + productId + "-" + flavor + "-" + spec);
						}
					}
					if(errors.isEmpty()) {
						ShoppingCart_lav cart = (ShoppingCart_lav)session.getAttribute("cart");
						if(cart==null) {
							cart = new ShoppingCart_lav();
							session.setAttribute("cart", cart);
						}
						if(quantity!=null && quantity.matches("\\d+")) {
							int qty = Integer.parseInt(quantity);
							cart.add(p, flavor, theSpec, qty);
						}else{
							errors.add("加入購物車失敗，產品數量不正確: " + productId + "-" + flavor + "-" + spec+ ", qty:" + quantity);
						}
					}
					
				}else {
					errors.add("加入購物車失敗，找不到產品:" + productId);
				}
			} catch (LAVDataInvalidException e) {	
				errors.add(e.getMessage());
			} catch (LAVException e) {
				errors.add(e.getMessage() + ", 請聯絡admin");
			}
			
			if(errors.size()>0)this.log(errors.toString());		//for admin, developer, test
			
			//3.外部轉址給cart.jsp			
			if(request.getParameter("ajax")!=null) {
				response.sendRedirect(request.getContextPath() + "/small_cart.jsp");
			}else {
				response.sendRedirect("member/cart.jsp");
			}
			
		}
		
	}



}
