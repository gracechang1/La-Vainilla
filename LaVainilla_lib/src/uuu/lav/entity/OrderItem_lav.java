package uuu.lav.entity;

public class OrderItem_lav {
	
	private int orderId;  //Pkey
	private Product_lav product;  //Pkey
	private Flavor_lav flavor; //Pkey, ""
	private Spec_lav spec;	 //Pkey
	private double price;
	private int quantity;
	
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
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
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

//	依據畫面設計getter
	public String getProductName() {
		return product.getName();
	}

	public String getPhotoUrl() {
		if(spec!=null && spec.getPhotoUrl()!=null && spec.getPhotoUrl().length()>0) {
			return spec.getPhotoUrl();
		}else if(flavor!=null && flavor.getPhotoUrl()!=null && flavor.getPhotoUrl().length()>0) {
			return flavor.getPhotoUrl();
		}else {
			return product.getPhotoUrl();
		}
	}
	
	public String getFlavorName() {
		if(flavor!=null) {
			return flavor.getFlavorName();
		}
		return "";
	}

	public String getSpecName() {
		if(spec!=null) {
			return spec.getSpecName();
		}
		return "";
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((flavor == null) ? 0 : flavor.hashCode());
		result = prime * result + orderId;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((spec == null) ? 0 : spec.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof OrderItem_lav))
			return false;
		OrderItem_lav other = (OrderItem_lav) obj;
		if (flavor == null) {
			if (other.flavor != null)
				return false;
		} else if (!flavor.equals(other.flavor))
			return false;
		if (orderId != other.orderId)
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
		return 	this.getClass().getSimpleName()
				+ "[訂單編號=" + orderId 
					+ ", 訂購產品=" + getProductName() 
					+ ", 訂購味道=" + getFlavorName() 
					+ ", 訂購規格=" + getSpecName()
					+ ",\n photo=" + getPhotoUrl()
				+ ",\n 交易價=" + price 
				+ ", 數量=" + quantity + "]";
	}
	
	
}
