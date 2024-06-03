package uuu.lav.entity;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import uuu.lav.exception.LAVDataInvalidException;

public class Customer_lav {

//	宣告屬性
		private String name; 		//必要,2~20個字
		private LocalDate birthday;	//必要, 年滿12歲
		private char gender ;		//必要, M-男,F-女,O-其他
		private String email;		//必要,PKey,unique, 要符合email格式,60個字
		private String password;	//必要,6~20個字
		private String phone;		//必要,unique, 符合台灣手機格式
		private String address="";	//非必要, 100個字
		private boolean subscribed; //非必要
		
//	建構子		
		public Customer_lav() {
			super();
		}
		

//	封裝、設條件、拋出錯誤
		public String getName() {
			return name;
		}

		public static final int NAME_MIN_LENGTH=2;
		public static final int NAME_MAX_LENGTH=20;
		public void setName(String name) {
			if(name!=null && (name=name.trim()).length()>=NAME_MIN_LENGTH && name.length()<=NAME_MAX_LENGTH) {
				this.name = name;
			}else {	
//				System.err.println("姓名格式不符");
				String errMsg= String.format("姓名格式不符，必須輸入%s~%s個字",NAME_MIN_LENGTH,NAME_MAX_LENGTH);
				throw new LAVDataInvalidException(errMsg);
			}
		}


		public LocalDate getBirthday() {
			return birthday;
		}

		private static final int MIN_AGE=12;
/**
* 傳入LocalDate型態的生日物件，統一檢查年齡限制，符合者指派給birthday屬性(符合encapsulation)
* @param date LocalDate型態的生日物件
*/
		public void setBirthday(LocalDate birthday) {
			if(birthday!=null && LocalDate.now().getYear()-birthday.getYear()>=MIN_AGE) {
				this.birthday = birthday;
			}else {
//				System.err.println("年齡未超過12歲");
				String errMsg=String.format("年齡未超過%s歲", MIN_AGE);
				throw new LAVDataInvalidException(errMsg);
			}
		}

/**
* 傳入生日字串轉換為LocalDate物件，呼叫setBirthday(LocalDate)方法來檢查與指派
* @param dateStr 須符合iso-8601或yyyy/MM/dd
*/
		public void setBirthday(String dateStr) {
			if(dateStr!=null) {
				dateStr=dateStr.replace("/", "-");
			}
			try {
				LocalDate date= LocalDate.parse(dateStr);
				this.setBirthday(date);
				
			} catch (DateTimeParseException | NullPointerException e) {
//				System.out.println("必須輸入客戶生日資料且應符合iso8601格式");
				String errMsg=String.format("必須輸入客戶生日資料且應符合iso8601格式");
				throw new LAVDataInvalidException(errMsg);
			}
		}
		
/**
* 傳入生日 year, month, day(int型態), 轉換為LocalDate物件，呼叫setBirthday(LocalDate)方法來檢查與指派
* @param dateStr 須符合iso-8601
*/
		
		public void setBirthday(int year, int month, int day) {
			LocalDate date= LocalDate.of(year, month, day);
			this.setBirthday(date);
		}
		
		public char getGender() {
			return gender;
		}

		private static final char MALE='M';
		private static final char FEMALE='F';
		private static final char OTHER='O';
		public void setGender(char gender) {
			if(gender==MALE || gender==FEMALE || gender==OTHER ) {
				this.gender = gender;
			}else {
//				System.err.println("性別填寫有誤，請重新填寫");
				String errMsg=String.format("性別填寫有誤，請重新填寫%s、%s或%s",MALE, FEMALE,OTHER);
				throw new LAVDataInvalidException(errMsg);
			}
		}


		public String getEmail() {
			return email;
		}
		
//	regular expression來檢查
		public static final String EMAIL_PATTERN="^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
		public void setEmail(String email) {
			if(email!=null && email.matches(EMAIL_PATTERN)) {
				this.email = email;
			}else {
//				System.err.println("email格式不正確");
				String errMsg=String.format("email格式不正確，請依照格式填寫");
				throw new LAVDataInvalidException(errMsg);
			}
		}


		public String getPassword() {
			return password;
		}

		public static final int PWD_MIN_LENGTH=6;
		public static final int PWD_MAX_LENGTH=20;
		public void setPassword(String password) {
			if(password!=null && password.length()>=PWD_MIN_LENGTH && password.length()<=PWD_MAX_LENGTH) {
				this.password = password;
			}else {
//				System.err.println("密碼長度不正確");
				String errMsg=String.format("密碼長度不正確，請填寫%s~%s個字",PWD_MIN_LENGTH,PWD_MAX_LENGTH );
				throw new LAVDataInvalidException(errMsg);
			}
		}


		public String getPhone() {
			return phone;
		}
		
//	regular expression來檢查
		public static final String PHONE_PATTERN="\\d{10,}";
		public void setPhone(String phone) {
			if(phone!=null && phone.matches(PHONE_PATTERN)) {
				this.phone = phone;
			}else {
//				System.err.println("手機號碼格式錯誤");
				String errMsg=String.format("手機號碼格式錯誤，請依照格式填寫");
				throw new LAVDataInvalidException(errMsg);
			}
		}


		public String getAddress() {
			return address;
		}

//地址:不填(商店取貨) 填(宅配/商店取貨)		
		public void setAddress(String address) {
			if(address==null) 	address="";
			this.address = address.trim();
		}


		public boolean isSubscribed() {
			return subscribed;
		}


		public void setSubscribed(boolean subscribed) {
			this.subscribed = subscribed;
		}

		
//	toString:將物件所有屬性值串成一個字串回傳
		@Override
		public String toString() {
//	單純取得類別名稱(Customer_lav)方法	
			return this.getClass().getSimpleName()
					+"[姓名=" + name + ", 生日=" + birthday + ", 性別=" + gender + ", 電子信箱=" + email
					+ ", 密碼=" + password + ", 手機號碼=" + phone + ", 地址=" + address + ", 訂閱="
					+ subscribed + "]";
		}

		
//		equals and hashCode (PKey)
//		hashCode:回傳物件記憶體位址			
@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((email == null) ? 0 : email.hashCode());
			return result;
		}


//	equals:比較this與傳入的物件obj是否相同(勾選instanceof比較)
@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (!(obj instanceof Customer_lav))
				return false;
			Customer_lav other = (Customer_lav) obj;
			if (email == null) {
				if (other.email != null)
					return false;
			} else if (!email.equals(other.email))
				return false;
			return true;
		}



}

	