package uuu.lav.controller;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

/**
 * Servlet Filter implementation class CharSetFilter
 */
//dispatcher:設定Filter執行時機(使內部轉交可觸發Filter)
@WebFilter(urlPatterns = { "*.jsp", "*.do" }, dispatcherTypes = {DispatcherType.REQUEST,DispatcherType.ERROR})
public class CharSetFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public CharSetFilter() {
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
//	前置處理		
		request.setCharacterEncoding("UTF-8");
//	鎖住request的編碼		
		request.getParameterNames();
		
		response.setCharacterEncoding("UTF-8");
//	鎖住response的編碼		
		response.getWriter();
//	交給下一棒		
		chain.doFilter(request, response);
//	後續處理
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
