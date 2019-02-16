package it.kit.gware.calendar;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import dto.Calendar_Cate;
import dto.Calendar_Dto;

@Component("Cal_Service")
public class Cal_ServiceImpl implements Calendar_Service {

	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private Calendar_Dao cal_Dao;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Calendar_Dto addCal(Calendar_Dto calDto) {
		cal_Dao=sqlSession.getMapper(Calendar_Dao.class);
		cal_Dao.insertCal(calDto);
		return cal_Dao.selectLatestCal();
	}

	@Override
	public int removeCal(int calendar_id) {
		cal_Dao=sqlSession.getMapper(Calendar_Dao.class);
		return cal_Dao.deleteCal(calendar_id);
	}

	@Override
	public Calendar_Dto modifyCal(Calendar_Dto calDto) {
		cal_Dao=sqlSession.getMapper(Calendar_Dao.class);
		cal_Dao.updateCal(calDto);
		return cal_Dao.selectById(calDto.getCalendar_id());
	}

	@Override
	public ArrayList<Calendar_Dto> getAllCal() {
		cal_Dao=sqlSession.getMapper(Calendar_Dao.class);
		return cal_Dao.selectAllCal();
	}

	@Override
	public ArrayList<Calendar_Cate> getCalCate() {
		cal_Dao=sqlSession.getMapper(Calendar_Dao.class);
		return cal_Dao.selectAllCate();
	}


}
