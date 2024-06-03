package uuu.lav.test;

import uuu.lav.entity.SpecialOffer_lav;

public class TestSpecialOffer_lav {

	public static void main(String[] args) {

		SpecialOffer_lav specialOffer= new SpecialOffer_lav();
		specialOffer.setId(1);
		specialOffer.setName("馬達加斯加香草莢");
		specialOffer.setUnitPrice(80);
		specialOffer.setStock(50);
		specialOffer.setExpirationDate("2024-08-15");
		specialOffer.setCategory("香草莢");
		specialOffer.setPhotoUrl("https://down-tw.img.susercontent.com/file/sg-11134201-22100-0urqfz1omaiv3c");
		specialOffer.setOrigin("巴布亞新幾內亞");
		specialOffer.setDescription("風味特色: 蘭姆酒、焦糖、奶油、莓果、葡萄乾、木質、煙燻，交織出濃郁無比的迷人奶香。");
		specialOffer.setDiscount(20);
		
		System.out.printf("specialOffer: %s\n", specialOffer);
	}

}
