package uuu.lav.entity;

public class Spec_lav {

	private int productId;		//Pkey
	private String flavorName;	//Pkey
	private String specName;	//Pkey
	private double listPrice;
	private double unitPrice;
	private int stock;
	private String photoUrl;
	
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getFlavorName() {
		return flavorName;
	}
	public void setFlavorName(String flavorName) {
		this.flavorName = flavorName;
	}
	public String getSpecName() {
		return specName;
	}
	public void setSpecName(String specName) {
		this.specName = specName;
	}
	public double getListPrice() {
		return listPrice;
	}
	public void setListPrice(double listPrice) {
		this.listPrice = listPrice;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
	
	@Override
	public String toString() {
		return this.getClass().getName()+
				" [規格代號=" + productId + "-" + flavorName + "-" + specName
				+ ",\n 規格定價=" + listPrice + ", 售價=" + unitPrice + ", 規格庫存=" + stock 
				+ ",\n 規格圖片="+ photoUrl + "]";
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((flavorName == null) ? 0 : flavorName.hashCode());
		result = prime * result + productId;
		result = prime * result + ((specName == null) ? 0 : specName.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Spec_lav other = (Spec_lav) obj;
		if (flavorName == null) {
			if (other.flavorName != null)
				return false;
		} else if (!flavorName.equals(other.flavorName))
			return false;
		if (productId != other.productId)
			return false;
		if (specName == null) {
			if (other.specName != null)
				return false;
		} else if (!specName.equals(other.specName))
			return false;
		return true;
	}
	
	
	
}
