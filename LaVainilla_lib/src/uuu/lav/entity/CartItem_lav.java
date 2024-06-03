package uuu.lav.entity;

public class CartItem_lav {
	private Product_lav product; //Pkey, 多型的屬性(Product, SpecialOffer,...)
	private Flavor_lav flavor; 	 //Pkey
	private Spec_lav spec;		 //Pkey
	
	private boolean checkOut=true;

//	為紀錄即時庫存加入的方法
	public void setStock(int stock) { 
		if(spec!=null ) {
			spec.setStock(stock); return;
		}
	
		if(flavor!=null ) {
			flavor.setStock(stock); return;
		}	
		
		product.setStock(stock);
	}
	
	
	public boolean isCheckOut() {
		return checkOut;
	}
	public void setCheckOut(boolean checkOut) {
		this.checkOut = checkOut;
	}
	public Product_lav getProduct() {
		return product;
	}
	public void setProduct(Product_lav product) {
		this.product = product;
	}
	public Flavor_lav getFlavor() {
		return flavor;
	}
	public void setFlavor(Flavor_lav flavor) {
		this.flavor = flavor;
	}
	public Spec_lav getSpec() {
		return spec;
	}
	public void setSpec(Spec_lav spec) {
		this.spec = spec;
	}
	
//	依據畫面定義getters	(代理程式)
	public int getProductId() {
		return product.getId();
	}

	public String getProductName() {
		return product.getName();
	}
	
	public String getPhotoUrl() {
		if(spec!=null && spec.getPhotoUrl()!=null && spec.getPhotoUrl().length()>0) {
			return spec.getPhotoUrl();
		}else if(flavor!=null && flavor.getPhotoUrl()!=null && flavor.getPhotoUrl().length()>0) {
			return flavor.getPhotoUrl();
		} else {
			return product.getPhotoUrl();
		}
	}
	
	public String getFlavorName() {
		if(flavor!=null){
		 return flavor.getFlavorName();	
		}
		
		return "";
	}	

	public String getSpecName() {
		if(spec!=null){
		 return spec.getSpecName();	
		}		
		return "";
	}
	
	public String getFlavorSpecName() {
		if (getFlavorName().length()>0 && getSpecName().length()>0) {
			return String.format("%s/%s", getFlavorName(), getSpecName());		
		}else {
			return String.format("%s%s", getFlavorName(), getSpecName());
		}
	}

	public int getStock() {
		if(spec!=null)return spec.getStock();		
		if(flavor!=null)return flavor.getStock();		
		return product.getStock();
	}
	
	public double getListPrice() {
		if(spec!=null){
			return spec.getListPrice();	
		}else if(product instanceof SpecialOffer_lav) {
			return ((SpecialOffer_lav)product).getListPrice();	
		}
		return product.getUnitPrice();		
	}

	public String getDiscountString() {
		if(product instanceof SpecialOffer_lav) {
			return ((SpecialOffer_lav)product).getDiscountString();	
		}
		return "";
	}
	
	public double getUnitPrice(){
		if(spec!=null){
			return spec.getUnitPrice();
		}
		return product.getUnitPrice();
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((flavor == null) ? 0 : flavor.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((spec == null) ? 0 : spec.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof CartItem_lav))
			return false;
		CartItem_lav other = (CartItem_lav) obj;
		if (flavor == null) {
			if (other.flavor != null)
				return false;
		} else if (!flavor.equals(other.flavor))
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (spec == null) {
			if (other.spec != null)
				return false;
		} else if (!spec.equals(other.spec))
			return false;
		return true;
	}
	
	
	@Override
	public String toString() {
		return "\n明細 [產品編號=" + getProductId() + ", 產品名稱=" + getProductName()
				+ ", 味道=" + getFlavorName() + ", 規格=" + getSpecName()
				+ ",\n 定價=" + getListPrice() + ", 台灣折扣=" + getDiscountString() + ", 售價=" + getUnitPrice()
				+ "]";
	}

	
	
	
}
