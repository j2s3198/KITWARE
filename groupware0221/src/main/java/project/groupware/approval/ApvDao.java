package project.groupware.approval;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import dto.Approval_Auth;
import dto.Approval_Cate;
import dto.Approval_Dto;

public interface ApvDao {

	public ArrayList<Approval_Cate> selectAllCate();
	
	public int selectSeqNum();
	
	public int insertApv(Approval_Dto dto);
	
	public ArrayList<Approval_Dto> selectMyAllApv(int member_id);
	
	public ArrayList<Approval_Auth> selectAllApvAuth();
	
	public Approval_Dto selectApvDetail(int approval_id);
	
	public ArrayList<Approval_Dto> selectNotAuthApv1(int member_id);
	public ArrayList<Approval_Dto> selectNotAuthApv2(int member_id);
	public ArrayList<Approval_Dto> selectNotAuthApv3(int member_id);
	
	public int updateApv1(Map<String, Object> map);
	public int updateApv2(Map<String, Object> map);
	public int updateApv3(Map<String, Object> map);
	
	public ArrayList<Approval_Dto> selectYesAuthApv1(int member_id);
	public ArrayList<Approval_Dto> selectYesAuthApv2(int member_id);
	public ArrayList<Approval_Dto> selectYesAuthApv3(int member_id);
	
	public ArrayList<Approval_Dto> selectTempApvList(int member_id);
	
	public int updateReWrite(Approval_Dto dto);
	
	public int deleteApv(int approval_id);
	
	public int updateDecreVacat(HashMap<String, Object> map);
	public int updateRecoverVacat(HashMap<String, Object> map);

}
