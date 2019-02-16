package it.kit.gware.calendar;

import java.util.ArrayList;

import dto.Calendar_Cate;
import dto.Calendar_Dto;

public interface Calendar_Dao {

	public int insertCal(Calendar_Dto calDto);
	public int deleteCal(int calendar_id);
	public int updateCal(Calendar_Dto calDto);
	public ArrayList<Calendar_Dto> selectAllCal();
	public ArrayList<Calendar_Cate> selectAllCate();
	public Calendar_Dto selectById(int  calendar_idd);
	public Calendar_Dto selectLatestCal();
	
}
