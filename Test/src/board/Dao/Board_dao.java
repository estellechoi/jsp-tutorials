package board.Dao;
import board.Jdbc.Connect;
import board.Dto.Board_dto;
import java.sql.*;
import java.util.ArrayList;

public class Board_dao {
	
	// 1) Write 값을 입력하는 메소드 (리턴 X)
	// JSP 페이지에서 jsp:useBean 액션태그를 사용하여 DTO 클래스에 값을 전달
	// 전달된 값을 가진 DTO 객체를 매개변수로 사용하여 값을 불러오자 (getter 사용)
	public void write(Connection conn, Board_dto dto) throws SQLException {
		
		// 쿼리
		String sql = "insert into board(name, title, content, writeday, open)";
		sql = sql + " values(?,?,?,now(),?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getName());
		pstmt.setString(2, dto.getTitle());
		pstmt.setString(3, dto.getContent());
		pstmt.setInt(4, dto.getOpen());
		pstmt.execute();
		pstmt.close();
		conn.close();
	}
	
	// 2) List 값을 불러오는 리턴 메소드
	public ArrayList<Board_dto> select(Connection conn) throws SQLException {
		
		// 값을 담을 ArrayList 객체 생성
		ArrayList<Board_dto> Ali = new ArrayList<Board_dto>();
		
		// 쿼리
		String sql = "select*from board order by id desc";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			int id = rs.getInt("id");
			int readnum = rs.getInt("readnum");
			int open = rs.getInt("open");
			String name = rs.getString("name");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writeday = rs.getString("writeday");
			
			// 레코드마다 DTO 클래스에 값 전달
			// DTO 생성자 실행 (DTO 클래스의 모든 private 변수(DB 필드와 동일)에 값 저장)
			// 레코드마다 값을 담은 dto 객체 생성
			Board_dto dto = new Board_dto(readnum, id, open, writeday, name, title, content);
			
			// 레코드 마다 값을 담은 dto 객체를 ArrayList의 요소로 추가
			Ali.add(dto);
		}
		
		// 모든 레코드의 dto 객체를 요소로 하는 ArrayList 객체를 리턴 
		return Ali;
	}
	
	// 3) Content 값을 불러오는 리턴 메소드
	public ArrayList<Board_dto> content(Connection conn, int id) throws SQLException {
		
		// 값을 담을 ArrayList 객체 생성
		ArrayList<Board_dto> Ali = new ArrayList<Board_dto>();
		
		// 쿼리
		String sql = "select*from board where id="+id;
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		
		String name = rs.getString("name");
		String title = rs.getString("title");
		String content = rs.getString("content");
		String writeday = rs.getString("content");
		int readnum = rs.getInt("readnum");
		int open =rs.getInt("open");
		
		// DTO 클래스 생성자의 매개변수를 통해 값 전달
		// 레코드 값을 담은 dto 객체 생성
		Board_dto dto = new Board_dto(readnum, id, open, writeday, name, title, content);
		
		// 레코드 값을 담은 dto 객체를 ArrayList의 요소로 추가
		// content() 메소드에서는 1개의 요소를 가진 ArrayList 객체 생성 !
		Ali.add(dto);
		
		stmt.close();
		conn.close();
		rs.close();
		
		// 레코드 값을 담은 dto 객체를 요소로 하는 ArrayList 객체를 리턴
		return Ali;
	}
	
	// 4) Delete id 값을 받아 특정 레코드를 삭제하는 메소드 (리턴X)
	public void delete(Connection conn, String id) throws SQLException {
		
		// 쿼리
		String sql = "delete from board where id="+id;
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		stmt.close();
		conn.close();
	}
	
	// 5) Update id 값을 받아 수정페이지에서 기존 값들을 불러오는 리턴 메소드
	public ArrayList<Board_dto> update(Connection conn, String id) throws SQLException {
		
		// 값을 담을 ArrayList 객체 생성
		ArrayList<Board_dto> Ali = new ArrayList<Board_dto>();
		
		// 쿼리
		String sql = "select*from board where id="+id;
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		
		String name = rs.getString("name");
		String title = rs.getString("title");
		String content = rs.getString("content");
		String writeday = rs.getString("writeday");
		int readnum = rs.getInt("readnum");
		int open =rs.getInt("open");
		int id_int = Integer.parseInt(id);
		
		// DTO 클래스 생성자 실행
		Board_dto dto = new Board_dto(readnum, id_int, open, writeday, name, title, content);
		
		// DTO 클래스 생성자 실행의 결과를 담은 dto 객체를 ArrayList의 요소로 추가
		Ali.add(dto);
		
		stmt.close();
		conn.close();
		rs.close();
		
		// 최종 리턴
		return Ali;
	}
	
	// 6) UpdateOk id 값을 받아 특정 레코드의 내용을 수정하는 메소드 (리턴X)
	// * jsp:useBean 액션태그로 DTO에 값을 전달
	// * id 등의 파라미터 값을 담는 매개변수 필요없다, 대신 매개변수로 값을 담은 dto 객체 필요
	public void updateok(Connection conn, Board_dto dto) throws SQLException {
		
		// 쿼리
		String sql = "update board set title=?, content=?, open=? where id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getTitle());
		pstmt.setString(2, dto.getContent());
		pstmt.setInt(3, dto.getOpen());
		pstmt.setInt(4, dto.getId());
		pstmt.execute();
		pstmt.close();
		conn.close();
	}
}
