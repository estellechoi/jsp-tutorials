package mall.Dto;

// 수정/삭제시 무조건 id 필요
// 자료형과 변수명은 DB 필드명과 동일해야함
// 
public class Member {
	
	// 자바빈 객체 property="*" 통해 같은 이름을 갖는 파라미터 값을 부여하였음 
	private int id;
	private int usertype;
	private String email;
	private String username;
	private String pwd;
	private String cell;
	private int zip;
	private String address1;
	private String address2;
	private int sex;
	private String birth;
	private String agree_SMS;
	private String agree_email;
	
	// getters and setters
	
	
	public int getUsertype() {
		return usertype;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setUsertype(int usertype) {
		this.usertype = usertype;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getCell() {
		return cell;
	}
	public void setCell(String cell) {
		this.cell = cell;
	}
	public int getZip() {
		return zip;
	}
	public void setZip(int zip) {
		this.zip = zip;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAgree_SMS() {
		return agree_SMS;
	}
	public void setAgree_SMS(String agree_SMS) {
		this.agree_SMS = agree_SMS;
	}
	public String getAgree_email() {
		return agree_email;
	}
	public void setAgree_email(String agree_email) {
		this.agree_email = agree_email;
	}
	
	// 모든 값을 출력하고싶을 때 ..? 
	@Override
	public String toString() {
		return "Member [usertype=" + usertype + ", email=" + email
				+ ", username=" + username + ", pwd=" + pwd + ", cell=" + cell
				+ ", zip=" + zip + ", address1=" + address1 + ", address2="
				+ address2 + ", sex=" + sex + ", birth=" + birth
				+ ", agree_SMS=" + agree_SMS + ", agree_email=" + agree_email
				+ "]";
	}
}
