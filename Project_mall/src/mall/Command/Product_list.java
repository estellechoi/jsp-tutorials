package mall.Command;

import java.sql.*;
import java.util.ArrayList;
import mall.Dto.Product;
import mall.Jdbc.Connect;

public class Product_list {

	public ArrayList<Product> product(int c) throws SQLException {
		
		// 1) DB 연결
		Connection conn = Connect.connection_static();
		
		// 2) 쿼리 작성
		String sql = "select*from product where product_code like 'p0" + c + "%' limit 0, 24";
		
		// 3) 쿼리 실행
		PreparedStatement pstmt = conn.prepareStatement(sql);	
		ResultSet rs = pstmt.executeQuery();
		
		// 4) ResultSet 레코드 → ArrayList<E> 요소로 저장
		// 자료형 : mall.Dto 패키지 Product 클래스
		ArrayList<Product> list = new ArrayList<Product>();
		
		// Product 클래스의 객체 생성 후 해당 객체를 ArrayList list 요소로 저장
		while(rs.next()) {
			// rs 레코드마다 Product 클래스의 객체를 생성하여 ArrayList의 요소로 저장
			// Product 객체 생성시 마다 생성자 실행
			list.add(new Product(rs));
		}
		
		// * 아래 방법 대신 new Product(rs); 객체 생성하여 바로 ArrayList에 추가
		//		Product pro = new Product();
		//		pro.setId(rs.getInt("id"));
		//		pro.setProduct_list(rs.getString("product_list"));
		//		pro.setName(rs.getString("name"));
		//		pro.setPrice(rs.getString("price"));
		//		list.add(pro);
		
		// 레코드를 모두 리스트에 추가하고 list 객체 리턴
		return list;
	}
}
