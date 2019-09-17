package Test;

public class test {
	
	public String print() {
		return "안녕하세요";
	}
	
	public void insert(String name, String pwd) {
		String sql = "insert into member(name, pwd) values('"+name+"', '"+pwd+"')";
	}

}
