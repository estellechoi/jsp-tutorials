package mall.Dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

public class Product {

	// 상품 리스트 출력시 필드값 가져올 변수 정의
	// 상품 상세 페이지 이동시 필요한 값
	private int id;
	private String product_list;
	private String name;
	private String price; // 콤마 추가된 가격은 문자열
	
	// getter 와 setter 를 사용하여 private 변수를 사용하자 !
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProduct_list() {
		return product_list;
	}
	public void setProduct_list(String product_list) {
		this.product_list = product_list;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	// 생성자
	public Product(ResultSet rs) throws SQLException {
		super();
		DecimalFormat df = new DecimalFormat("#,###"); // 금액 콤마
		
		this.id = rs.getInt("id");
		this.product_list = rs.getString("product_list");
		this.name = rs.getString("name");
		this.price = df.format(rs.getInt("price"));
	}
	
	
	
	
}
