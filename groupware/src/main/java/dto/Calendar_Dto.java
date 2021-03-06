package dto;

import java.sql.Date;

public class Calendar_Dto {

	private int calendar_id;
	private int calendar_cate;
	private String calendar_cateSelf;
	private int calendar_member_id;
	private String calendar_start;
	private String calendar_end;
	private String calendar_title;
	private String calendar_content;
	private String calendar_color;
	private int calendar_allDay;
	
	

	@Override
	public String toString() {
		return "Calendar_Dto [calendar_id=" + calendar_id + ", calendar_cate=" + calendar_cate + ", calendar_cateSelf="
				+ calendar_cateSelf + ", calendar_member_id=" + calendar_member_id + ", calendar_start="
				+ calendar_start + ", calendar_end=" + calendar_end + ", calendar_title=" + calendar_title
				+ ", calendar_content=" + calendar_content + ", calendar_color=" + calendar_color + ", calendar_allDay="
				+ calendar_allDay + "]";
	}
	public Calendar_Dto() {
		super();
	}
	public Calendar_Dto(int calendar_id, int calendar_cate, String calendar_cateSelf, int calendar_member_id,
			String calendar_start, String calendar_end, String calendar_title, String calendar_content,
			String calendar_color, int calendar_allDay) {
		super();
		this.calendar_id = calendar_id;
		this.calendar_cate = calendar_cate;
		this.calendar_cateSelf = calendar_cateSelf;
		this.calendar_member_id = calendar_member_id;
		this.calendar_start = calendar_start;
		this.calendar_end = calendar_end;
		this.calendar_title = calendar_title;
		this.calendar_content = calendar_content;
		this.calendar_color = calendar_color;
		this.calendar_allDay = calendar_allDay;
	}
	public int getCalendar_id() {
		return calendar_id;
	}
	public void setCalendar_id(int calendar_id) {
		this.calendar_id = calendar_id;
	}
	public int getCalendar_cate() {
		return calendar_cate;
	}
	public void setCalendar_cate(int calendar_cate) {
		this.calendar_cate = calendar_cate;
	}
	public String getCalendar_cateSelf() {
		return calendar_cateSelf;
	}
	public void setCalendar_cateSelf(String calendar_cateSelf) {
		this.calendar_cateSelf = calendar_cateSelf;
	}
	public int getCalendar_member_id() {
		return calendar_member_id;
	}
	public void setCalendar_member_id(int calendar_member_id) {
		this.calendar_member_id = calendar_member_id;
	}
	public String getCalendar_start() {
		return calendar_start;
	}
	public void setCalendar_start(String calendar_start) {
		this.calendar_start = calendar_start;
	}
	public String getCalendar_end() {
		return calendar_end;
	}
	public void setCalendar_end(String calendar_end) {
		this.calendar_end = calendar_end;
	}
	public String getCalendar_title() {
		return calendar_title;
	}
	public void setCalendar_title(String calendar_title) {
		this.calendar_title = calendar_title;
	}
	public String getCalendar_content() {
		return calendar_content;
	}
	public void setCalendar_content(String calendar_content) {
		this.calendar_content = calendar_content;
	}
	public String getCalendar_color() {
		return calendar_color;
	}
	public void setCalendar_color(String calendar_color) {
		this.calendar_color = calendar_color;
	}
	public int getCalendar_allDay() {
		return calendar_allDay;
	}
	public void setCalendar_allDay(int calendar_allDay) {
		this.calendar_allDay = calendar_allDay;
	}
	

	
	
}
