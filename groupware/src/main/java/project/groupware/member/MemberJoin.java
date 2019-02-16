package project.groupware.member;

import java.sql.Date;

public class MemberJoin {

	   private int member_id;
	   private String member_pw;
	   private String member_name;
	   private String member_birth;
	   private String member_email;
	   private String member_address1;
	   private String member_address2;
	   private String member_address3;
	   private String member_phone;
	   private int member_department;
	   private int member_rank;
	   private Date member_indate;
	   private Date member_modidate;
	   private String member_gender;
	   private String member_img;
	   private String rank_name;
	   private String department_name;
	   
	   
	   
	@Override
	public String toString() {
		return "MemberJoin [member_id=" + member_id + ", member_pw=" + member_pw + ", member_name=" + member_name
				+ ", member_birth=" + member_birth + ", member_email=" + member_email + ", member_address1="
				+ member_address1 + ", member_address2=" + member_address2 + ", member_address3=" + member_address3
				+ ", member_phone=" + member_phone + ", member_department=" + member_department + ", member_rank="
				+ member_rank + ", member_indate=" + member_indate + ", member_modidate=" + member_modidate
				+ ", member_gender=" + member_gender + ", member_img=" + member_img + ", rank_name=" + rank_name
				+ ", department_name=" + department_name + "]";
	}
	public MemberJoin() {
		super();
	}
	public MemberJoin(int member_id, String member_pw, String member_name, String member_birth, String member_email,
			String member_address1, String member_address2, String member_address3, String member_phone,
			int member_department, int member_rank, Date member_indate, Date member_modidate, String member_gender,
			String member_img, String rank_name, String department_name) {
		super();
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_name = member_name;
		this.member_birth = member_birth;
		this.member_email = member_email;
		this.member_address1 = member_address1;
		this.member_address2 = member_address2;
		this.member_address3 = member_address3;
		this.member_phone = member_phone;
		this.member_department = member_department;
		this.member_rank = member_rank;
		this.member_indate = member_indate;
		this.member_modidate = member_modidate;
		this.member_gender = member_gender;
		this.member_img = member_img;
		this.rank_name = rank_name;
		this.department_name = department_name;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_birth() {
		return member_birth;
	}
	public void setMember_birth(String member_birth) {
		this.member_birth = member_birth;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_address1() {
		return member_address1;
	}
	public void setMember_address1(String member_address1) {
		this.member_address1 = member_address1;
	}
	public String getMember_address2() {
		return member_address2;
	}
	public void setMember_address2(String member_address2) {
		this.member_address2 = member_address2;
	}
	public String getMember_address3() {
		return member_address3;
	}
	public void setMember_address3(String member_address3) {
		this.member_address3 = member_address3;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public int getMember_department() {
		return member_department;
	}
	public void setMember_department(int member_department) {
		this.member_department = member_department;
	}
	public int getMember_rank() {
		return member_rank;
	}
	public void setMember_rank(int member_rank) {
		this.member_rank = member_rank;
	}
	public Date getMember_indate() {
		return member_indate;
	}
	public void setMember_indate(Date member_indate) {
		this.member_indate = member_indate;
	}
	public Date getMember_modidate() {
		return member_modidate;
	}
	public void setMember_modidate(Date member_modidate) {
		this.member_modidate = member_modidate;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_img() {
		return member_img;
	}
	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}
	public String getRank_name() {
		return rank_name;
	}
	public void setRank_name(String rank_name) {
		this.rank_name = rank_name;
	}
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	
}
