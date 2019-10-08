package mall.Dto;

public class Qna {
	
	private int readnum;
	private int id;
	private String writeday;
	private String username;
	private String email;
	private String title;
	private String content;
	
	// 생성자
	public Qna(int readnum, int id, String writeday, String username, String email, String title, String content) {
		super();
		this.readnum =readnum;
		this.id = id;
		this.writeday = writeday;
		this.username = username;
		this.email = email;
		this.title = title;
		this.content = content;
	}
	
	// getters and setters
	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}

// * DTO : Date Transfer Object
// DAO 클래스를 활용하여 데이터 관리할 때 사용하는 변수를 담은 클래스
