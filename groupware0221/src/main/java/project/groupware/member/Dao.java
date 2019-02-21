package project.groupware.member;

import java.util.ArrayList;
import java.util.HashMap;

public interface Dao {
	
	int makeIdNum();
	
	void insert(Member m);
	
	ArrayList<Member> selectAll();
	
	ArrayList<Member> selectCondition(HashMap<String, Object> map);
	
	Member selectMember(int member_id);
	
	String selectName(int member_id);
	
	String[] selectName(String member_email);
	
	ArrayList<Integer> selectId(Member m);
	
	String selectPw(Member m);
	
	String selectEmail(Member m);
	
	void update(Member m);
	
	void updatePw(Member m);
	
	void delete(int member_id);
	
		
	ArrayList<Member> selectAllMemJoin();
	
	ArrayList<Member> selectByDeptId(int member_id);
	
	ArrayList<Member> selectByName(String searchName);
	
	Member selectById(int member_id);
}
