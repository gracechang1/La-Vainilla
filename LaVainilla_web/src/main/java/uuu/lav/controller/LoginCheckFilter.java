package uuu.lav.controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.lav.entity.Customer_lav;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter("/member/*")
public class LoginCheckFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginCheckFilter() {
        super();
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//	載入session		
		HttpSession session= ((HttpServletRequest) request).getSession();
//	外部轉址		
		Customer_lav member= (Customer_lav) session.getAttribute("member");
		if(member!=null) {
//	交給下一棒			
			chain.doFilter(request, response);
		}else {
//	跳轉至login.jsp		
//			((HttpServletResponse)response).sendRedirect("../login.jsp");
			
			String uri = ((HttpServletRequest)request).getRequestURI();
			//System.out.printf("uri: %s\n", uri);
			session.setAttribute("prevURI", uri);
			((HttpServletResponse)response).sendRedirect("../login.jsp");			

		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
