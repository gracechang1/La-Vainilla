package uuu.lav.entity;

public class Flavor_lav implements Comparable<Flavor_lav>{
	
	private String flavorName;	//Pkey
	private int stock;			//必要
	private String photoUrl;	//非必要
	private String iconUrl;		//非必要
	private int ordinal;		//非必要
	
	
	public String getFlavorName() {
		return flavorName;
	}
	public void setFlavorName(String flavorName) {
		this.flavorName = flavorName;
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
	public String getIconUrl() {
		return iconUrl;
	}
	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}
	public int getOrdinal() {
		return ordinal;
	}
	public void setOrdinal(int ordinal) {
		this.ordinal = ordinal;
	}
	
	@Override
	public String toString() {
		return this.getClass().getName()+
				"[flavor名稱=" + flavorName + ", flavor庫存=" + stock + ",\n flavor圖片網址=" + photoUrl + ",\n flavor圖示網址="
				+ iconUrl + ", flavor排序=" + ordinal + "]";
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((flavorName == null) ? 0 : flavorName.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Flavor_lav))
			return false;
		Flavor_lav other = (Flavor_lav) obj;
		if (flavorName == null) {
			if (other.flavorName != null)
				return false;
		} else if (!flavorName.equals(other.flavorName))
			return false;
		return true;
	}
	@Override
	public int compareTo(Flavor_lav o) {
		if(this.ordinal>o.ordinal) {
			return 1;
		}else if(this.ordinal<o.ordinal) {
			return -1;
		}else {
			return flavorName.compareTo(o.flavorName);	
		}
			//return this.ordinal - o.ordinal;		
	}
	
}
