package board.Dto;

public class Board_dto {
	private int id;
	private int readnum;
	private String writeday;
	private String name;
	private String title;
	private String content;
	private int open;

	
	// getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	// 생성자 -? 이거 왜쓰는디
	public Board_dto() {
		super();
	}
	
	// 생성자 오버로딩 변수에 값 줄 때
	public Board_dto(int readnum, int id, int open, String writeday, String name, String title, String content) {
		super();
		this.id = id;
		this.readnum = readnum;
		this.open = open;
		this.writeday = writeday;
		this.name = name;
		this.title = title;
		this.content = content;
	}




	
	
}
