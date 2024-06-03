<%@page import="uuu.lav.entity.Spec_lav"%>
<%@page import="java.util.List"%>
<%@page import="uuu.lav.service.ProductService_lav"%>
<%@ page pageEncoding="UTF-8"%>

	<%
		String productId= request.getParameter("productId");
		String flavorName= request.getParameter("flavorName");

		ProductService_lav pService= new ProductService_lav();
		List<Spec_lav> specList= null;
		if(productId!=null){
			specList= pService.getSpecList(productId, flavorName);
		}
	%>
	
	<% if(specList!=null && specList.size()>0){ %>
		
		<div class='specDiv specDivShow' data-flavor='<%= flavorName%>'>
			<% for(Spec_lav spec:specList){ %>
				<input type='radio' name='spec' value='<%= spec.getSpecName() %>' required data-listPrice='<%= spec.getListPrice() %>'
					   data-photo='<%=spec.getPhotoUrl()==null? "":spec.getPhotoUrl() %>' 
					   data-price='<%= spec.getUnitPrice() %>' data-stock='<%= spec.getStock()%>'><label><%= spec.getSpecName() %></label>
			<% } %> 
		</div>		
	<% }else{ %> 
			<div class='specDiv specDivShow'>
				目前查無此產品規格
			</div>
		<% } %> 