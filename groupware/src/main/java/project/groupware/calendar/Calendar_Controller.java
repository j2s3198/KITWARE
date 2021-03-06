package project.groupware.calendar;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.Calendar_Cate;
import dto.Calendar_Dto;
import project.groupware.member.Member;

@Controller
public class Calendar_Controller {
	
	@Resource(name="Cal_Service")
	private Calendar_Service cal_Service;
	
	@RequestMapping(value = "/calendar",method=RequestMethod.GET)
	public ModelAndView calmain(HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView("/calendar/calendar");
		
		  ArrayList<Calendar_Cate> cateList = cal_Service.getCalCate();
		  
		  JSONArray arr = new JSONArray();
		  for(Calendar_Cate cate : cateList) {
			  JSONObject jobj = new JSONObject();
			  
			  jobj.put("cal_cate_id", cate.getCal_cate_id());
			  jobj.put("cal_cate_name", cate.getCal_cate_name());
			  jobj.put("cal_cate_color", cate.getCal_cate_color());
			  arr.add(jobj);
		  }
		  mav.addObject("cateList", arr);
		  
		  HttpSession session = req.getSession();
		  
		  int id = ((Member)session.getAttribute("member")).getMember_id();
		  
		  mav.addObject("who", id);
		
		  //=======================================================================
		  
		  ArrayList<Calendar_Dto> calList = cal_Service.getAllCal(id);
		  
		  JSONArray jArr = new JSONArray();
		  for(Calendar_Dto dto : calList) {
			  JSONObject jobj = new JSONObject();
			  
			  jobj.put("id", dto.getCalendar_id());
			  jobj.put("calendar_cate", dto.getCalendar_cate());
			  jobj.put("calendar_cateSelf", dto.getCalendar_cateSelf());
			  jobj.put("member_id", dto.getCalendar_member_id());
			  jobj.put("start", dto.getCalendar_start());
			  jobj.put("end", dto.getCalendar_end());
			  jobj.put("title", dto.getCalendar_title());
			  jobj.put("content", dto.getCalendar_content());
			  jobj.put("color", dto.getCalendar_color());
			  jobj.put("textColor", "#FFF");
			  boolean ad = false;
			  if(dto.getCalendar_allDay() == 1) {
				  ad = true;
			  }else {
				  ad = false;
			  }
			  jobj.put("allDay", ad);
			  
			  jArr.add(jobj);
		  }
		
		mav.addObject("list",jArr.toJSONString());
		  
		  
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/calendar/addEvent", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String addCalendar(ServletRequest req, Calendar_Dto dto) {
		
		System.out.println(dto);
		
		Calendar_Dto result = cal_Service.addCal(dto);
		
		System.out.println("result : "+result);
		
		  
		JSONObject jobj = new JSONObject();
			  
		jobj.put("id", result.getCalendar_id());
		jobj.put("calendar_cate", result.getCalendar_cate());
		jobj.put("calendar_cateSelf", result.getCalendar_cateSelf());
		jobj.put("calendar_member_id", result.getCalendar_member_id());
		jobj.put("start", result.getCalendar_start());
		jobj.put("end", result.getCalendar_end());
		jobj.put("title", result.getCalendar_title());
		jobj.put("content", result.getCalendar_content());
		jobj.put("color", result.getCalendar_color());
		jobj.put("allDay", result.getCalendar_allDay());
		
		return jobj.toJSONString();
		
	}
	
	@ResponseBody
	@RequestMapping(value="/calendar/getCalList", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getCalList(@RequestParam(value="member_id") String member_id) {

		JSONArray arr = new JSONArray();
		
		try {
			ArrayList<Calendar_Dto> calList = cal_Service.getAllCal(Integer.parseInt(member_id));
		
		  for(Calendar_Dto dto : calList) {
			  JSONObject jobj = new JSONObject();
			  
			  jobj.put("id", dto.getCalendar_id());
			  jobj.put("calendar_cate", dto.getCalendar_cate());
			  jobj.put("calendar_cateSelf", dto.getCalendar_cateSelf());
			  jobj.put("member_id", dto.getCalendar_member_id());
			  jobj.put("start", dto.getCalendar_start());
			  jobj.put("end", dto.getCalendar_end());
			  jobj.put("title", dto.getCalendar_title());
			  jobj.put("content", dto.getCalendar_content());
			  jobj.put("color", dto.getCalendar_color());
			  boolean ad = false;
			  if(dto.getCalendar_allDay() == 1) {
				  ad = true;
			  }else {
				  ad = false;
			  }
			  jobj.put("allDay", ad);
			  
			  arr.add(jobj);
		  }
		}catch(Exception e) {
			
		}
		return arr.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/calendar/removeCal", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String removeCal(@RequestParam(value="pId") String id) {
	
		int result = cal_Service.removeCal(Integer.parseInt(id));
		System.out.println("removeCal result : "+result);
		
		return id;
	}
	
	@ResponseBody
	@RequestMapping(value="/calendar/modiEvent", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String modiEvent(ServletRequest req, Calendar_Dto dto) {
		
		System.out.println(dto);
		
		Calendar_Dto result = cal_Service.modifyCal(dto);
		
		System.out.println("modi result : "+result);
		  
		JSONObject jobj = new JSONObject();
			  
		jobj.put("id", result.getCalendar_id());
		jobj.put("calendar_cate", result.getCalendar_cate());
		jobj.put("calendar_cateSelf", result.getCalendar_cateSelf());
		jobj.put("calendar_member_id", result.getCalendar_member_id());
		jobj.put("start", result.getCalendar_start());
		jobj.put("end", result.getCalendar_end());
		jobj.put("title", result.getCalendar_title());
		jobj.put("content", result.getCalendar_content());
		jobj.put("color", result.getCalendar_color());
		jobj.put("allDay", result.getCalendar_allDay());
		
		return jobj.toJSONString();
		
		
	}
	
	   @ResponseBody
	   @RequestMapping(value="/calendar/calCount", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	   public String getCalCount(HttpServletRequest req) {
	   
	      HttpSession session = req.getSession();
	      Member m = (Member) session.getAttribute("member");
	      
	      int count = cal_Service.getCalCount(m.getMember_id());
	      
	      System.out.println("getCalCount : "+count);
	      
	      return count+"";
	   }

}
