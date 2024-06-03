package uuu.lav.test;

import uuu.lav.entity.Product_lav;

public class TestProduct_lav {

	public static void main(String[] args) {

		Product_lav p= new Product_lav();
		p.setId(1);
		p.setName("馬達加斯加香草莢");
		p.setUnitPrice(80);
		p.setStock(50);
		p.setExpirationDate("2024-08-15");
		p.setCategory("香草莢");
		p.setPhotoUrl("https://down-tw.img.susercontent.com/file/sg-11134201-22100-0urqfz1omaiv3c");
		p.setOrigin("巴布亞新幾內亞");
		p.setDescription("風味特色: 蘭姆酒、焦糖、奶油、莓果、葡萄乾、木質、煙燻，交織出濃郁無比的迷人奶香。");
		
		System.out.printf("p: %s\n", p);
		
		
	}

}
