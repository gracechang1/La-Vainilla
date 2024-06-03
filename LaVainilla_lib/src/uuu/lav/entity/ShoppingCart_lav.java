package uuu.lav.entity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import uuu.lav.exception.LAVDataInvalidException;

public class ShoppingCart_lav {

	private Customer_lav member; 	//必要, 多型的屬性(Customer, VIP,...)
	private Map<CartItem_lav, Integer> cartMap = new HashMap<>();
	
//	代替cartMap的getter: accessers
	public int size() {
		return cartMap.size();
	}

	public int getCheckOutSize() {
		int size = cartMap.size();
		for(CartItem_lav item:cartMap.keySet()) {
			if(!item.isCheckOut()) size--;
		}
		return size;
	}
	
	public boolean isEmpty() {
		return cartMap.isEmpty();
	}
	
	public Integer getQuantity(CartItem_lav key) {
		return cartMap.get(key);
	}

	public Set<CartItem_lav> getCartItemSet() {
		//return cartMap.keySet(); 				//不得回傳正本
		return new HashSet(cartMap.keySet()); 	//應回傳複本
	}	

	public int getTotalQuantity() {
		int sum = 0;
		for(Integer qty:cartMap.values()) {
			sum = sum + qty;
		}		
		return sum;
	}

	public int getCheckOutTotalQuantity() {
		int sum = 0;
		for(CartItem_lav item:cartMap.keySet()) {
			if(item.isCheckOut())sum = sum + cartMap.get(item);
		}		
		return sum;
	}
	
	public double getTotalAmount() {
		double sum = 0;
		for(CartItem_lav item:cartMap.keySet()) {
			sum += item.getUnitPrice() * this.getQuantity(item);
		}
		return Math.round(sum);
	}

	public double getCheckOutTotalAmount() {
		double sum = 0;
		for(CartItem_lav item:cartMap.keySet()) {
			if(item.isCheckOut()) sum += item.getUnitPrice() * this.getQuantity(item);
		}
		return Math.round(sum);
	}
	
//	cartMap的setter: mutators: add, update , remove	
	public void add(Product_lav p, String flavorName, Spec_lav spec, int quantity) {
		if(p==null) throw new IllegalArgumentException("加入購物車時，Product物件p不得為null");
		if(quantity <= 0) throw new IllegalArgumentException("加入購物車時，購買數量必須大於0");
		Flavor_lav flavor = null;
		if(p.getFlavorMapSize()>0) {
			flavor = p.findFlavor(flavorName);
			if(flavor==null) throw new LAVDataInvalidException(
					String.format("%s號產品味道(%s)不正確", p.getId(), flavorName));
		}
	
		if(p.getSpecCount()==0 && spec!=null || 
				p.getSpecCount()>0 && spec==null) 
			throw new LAVDataInvalidException("產品spec不正確");
	
		CartItem_lav item = new CartItem_lav();
		item.setProduct(p);
		item.setFlavor(flavor);
		item.setSpec(spec);

//	找出改cartItem是否已經在購物車中，有:要將原來的數量加上現在購買數量
		Integer oldQty = cartMap.get(item); 
		if(oldQty!=null) {
			quantity = quantity + oldQty;
		}
		
		cartMap.put(item, quantity);		
	}

	
	public void update(CartItem_lav cartItem, int qty) {
		cartMap.put(cartItem, qty);
	}

	public void remove(CartItem_lav cartItem) {
		cartMap.remove(cartItem);
	}
	
	//for 結帳成功
	public void removeCheckOutItem() {
		for(CartItem_lav item:getCartItemSet()) {
			if(item.isCheckOut()) {
				cartMap.remove(item);
			}
		}
	}	
	
	public Customer_lav getMember() {
		return member;
	}
	public void setMember(Customer_lav member) {
		this.member = member;
	}
	
	
	@Override
	public String toString() {
		return this.getClass().getName()+"[訂購人=" + member 
				+ ",\n 購物車內容=\n" + cartMap 
				+ ",\n 共" + size() + "項, " + getTotalQuantity() + "件, 總金額: " + getTotalAmount() + "元]";
	}





	
	
	
}
