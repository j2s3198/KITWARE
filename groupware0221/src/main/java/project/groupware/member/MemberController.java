package project.groupware.member;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.groupware.department.Department;
import project.groupware.email.Email;
import project.groupware.email.SendEmail;
import project.groupware.rank.Rank;

@Controller
public class MemberController {
	
	private String img_path = "D:\\Java\\workspace\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\webapps\\img\\";
	
	@Resource(name="memberService")
	private Service service;
	
	@Resource(name="departmentService")
	private project.groupware.department.Service dept_service;
	
	@Resource(name="rankService")
	private project.groupware.rank.Service rank_service;
	
	@Resource(name="emailService")
	private project.groupware.email.Service email_service;	

	// Mapping
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Locale locale, Model model) { // 메인			
		return "redirect:/member/login";
	}
	
	@RequestMapping(value="/member/login", method = RequestMethod.GET)
	public void login() {} // 로그인 페이지 이동	
	
	@RequestMapping(value="/member/login" , method=RequestMethod.POST)
	public String login(HttpServletRequest req, Member member) { // 로그인하면 가능 여부 확인 후 맞는 페이지로 이동
		// 이동할 주소 초기화
		String result = "";
		// 로그인 여부 확인
		boolean flag = service.checkLogin(member.getMember_id(), member.getMember_pw());
		if (flag) { // 로그인 성공			
			HttpSession session = req.getSession();
			Member m = service.getMember(member.getMember_id());
			int status = m.getMember_status();
			if (status == 0) { // 미승인 회원		
				
				result = "redirect:/member/login";
			} else if (status == 1) { // 비밀번호 찾기 한 회원
				// 임시비밀번호인 회원 아이디를 session에 저장
				session.setAttribute("member", member);			
				result = "redirect:/member/editPw?type=1";
			} else { // 승인 완료 회원
				// 로그인 회원정보를 session에 저장  		
				session.setAttribute("member", m);				
				result = "redirect:/member/main";
			}			
		} else { // 로그인 실패시 이동할 주소
			result = "redirect:/member/login";
		}
		return result;
	}
	
	@RequestMapping(value="/member/checkLogin", method=RequestMethod.POST)
	public ModelAndView login(Member m) { // 로그인 페이지에서 ajax를 이용해 로그인 가능 여부 확인
		ModelAndView mav = new ModelAndView("json/singleValue");
		boolean flag = service.checkLogin(m.getMember_id(), m.getMember_pw());
		mav.addObject("value", flag);
		return mav;
	}
	
	@RequestMapping("/member/join")
	public ModelAndView memberJoin() { // 로그인 페이지에서 회원가입 버튼 눌렀을 때 실행
		ModelAndView mav = new ModelAndView("member/join");
		// dept_service에서 부서명 읽음
		ArrayList<Department> dept_list = dept_service.getAll();
		// rank_service에서 직급 읽음
		ArrayList<Rank> rank_list = rank_service.getAll();
		mav.addObject("dept", dept_list);
		mav.addObject("rank", rank_list);
		return mav;
	}
	
	@RequestMapping(value="/member/join", method=RequestMethod.POST)
	public String join(Member m) { // 회원가입
		// member_id sequence 값 생성
		int id = service.getIdNum();		
		// Calendar로 년도 생성
		Calendar cal = Calendar.getInstance();
		int yy = cal.get(Calendar.YEAR);		
		// 생성된 년도와 sequence 값으로 사번 조합( (년도 % 100) * 1000000 + sequence 값) 
		int make_id = (yy % 100) * 1000000 + id;		
		// 생성한 사번을 member 객체에 set
		m.setMember_id(make_id);
		// 회원가입
		service.joinMember(m);		
		return "redirect:/member/login";
	}
	
	@RequestMapping("/member/search")
	public void memberSearch() {} // 로그인 페이지에서 찾기 버튼 눌렀을 때 실행
	
	@RequestMapping(value="/member/searchId", method=RequestMethod.POST)
	public ModelAndView memberSearchId(Member m) { // 찾기 페이지에서 ajax를 이용해 member_id 검색
		// 단일 값 json 리스트로 변환
		ModelAndView mav = new ModelAndView("json/multyValue");
		// 찾기한 회원정보에 맞는 리스트 읽음
		ArrayList<Integer> list = service.getId(m);
		mav.addObject("list", list);
		return mav;		
	}
	
	@RequestMapping(value="/member/searchPw", method=RequestMethod.POST)
	public ModelAndView memberSearchPw(Member m) { // 찾기 페이지에서 ajax를 이용해 임시 비밀번호 등록한 메일로 발송		
		// 단일 값 json으로 변환
		ModelAndView mav = new ModelAndView("json/singleValue");		
		
		String receiver_id = service.getEmail(m); // 받는 이메일 주소
		if (receiver_id != null) { // 일치하는 정보가 있을 때
			// 관리자 계정으로 임시 비밀번호 발송
			String email_account = "hongkd12341234@gmail.com"; // 이메일 계정
			String email_pw = "hong1234$"; // 이메일 계정 비밀번호
			String sender_id = "hongkd12341234@gmail.com"; // 보내는 이메일 주소
			String sender = "KIT ware"; // 보내는 사람
			String receiver = m.getMember_name(); // 받는 사람
			String title = "임시 비밀번호 발급"; // 메일 제목
			String pw = createPw(); // 임시 비밀번호 생성
			StringBuilder content = new StringBuilder(); // 메일 내용
			content.append("안녕하세요. KIT 그룹웨어 입니다.");
			content.append("<br><br>임시 비밀번호는 <Strong>" + pw + "</Strong> 입니다.");
			content.append("<br><br>로그인 후 비밀번호 변경이 가능하며, 비밀번호를 변경해야 서비스를 정상적으로 이용가능합니다.");
			content.append("<br><br>감사합니다.");

			// 메일 생성 및 발송
			Email mail = new Email();
			mail.setEmail_account(email_account);
			mail.setEmail_pw(email_pw);
			mail.setSender_id(sender_id);
			mail.setSender(sender);
			mail.setReceiver_id(receiver_id);
			mail.setReceiver(receiver);
			mail.setTitle(title);
			mail.setContent(content.toString());			
			new SendEmail().send(mail);

			// 임시 비밀번호 저장
			m.setMember_pw(pw);
			m.setMember_status(1);
			service.editPw(m);
			
			// 메일 발송 성공
			mav.addObject("value", true);
			System.out.println("인증메일 발송");
		}
		else { // 일치하는 정보가 없을 때
			// 메일 발송 실패
			mav.addObject("value", false);
		}		
		return mav;
	}
	
	@RequestMapping("/member/logout")
	public String memberJoin(HttpServletRequest req) { // 로그아웃
		// session에서 member를 삭제
		HttpSession session = req.getSession(false);
		session.removeAttribute("member");
		session.invalidate();
		return "redirect:/member/login";
	}
	
	@RequestMapping("/member/myinfo")
	public ModelAndView memberView(HttpServletRequest req) { // 회원정보 상세보기
		ModelAndView mav = new ModelAndView("/member/viewInfo");
		// 내 정보에서 필요한 업무 이메일 계정정보 읽음
		HttpSession session = req.getSession(false);
		Member m = (Member)session.getAttribute("member");
		Email email = email_service.getAccount(m.getMember_id());
		mav.addObject("account", email);
		return mav;
	}
	
	@RequestMapping(value="/member/edit", method=RequestMethod.POST)
	public String memberEdit(HttpServletRequest req, Member member, Email email) { // 회원정보 수정
		if(member.getImg_file() != null) { // 회원 이미지 파일 생성
			String name = fileUpload(member, "_img");
			member.setMember_img("/img/member/"+name);
		}		
		if(member.getSign_file() != null) { // 회원 싸인 파일 생성
			String name = fileUpload(member, "_sign");
			member.setMember_sign("/img/member/"+name);
		}		
		// 회원정보 수정
		service.editMember(member);
		// 업무메일 등록(수정)
		email_service.addAccount(email);
		// 수정된 회원정보를 세션에 저장
		Member m = service.getMember(member.getMember_id());
		HttpSession session = req.getSession(false);
		session.setAttribute("member", m);		
		
		return "redirect:/member/myinfo";
	}
	
	@RequestMapping("/member/editPw")
	public ModelAndView memberEditPw(@RequestParam(value="type") int type) { // 회원 비밀번호 변경
		ModelAndView mav = new ModelAndView();
		mav.addObject("type", type);
		if (type == 0) {
			mav.setViewName("/member/editPw");
		} else {
			mav.setViewName("member/editPw");
		}
		return mav;
	}
	
	@RequestMapping(value="/member/editPw" , method=RequestMethod.POST)
	public ModelAndView memberEditPw(HttpServletRequest req, Member member, @RequestParam(value="type") int type) { // 회원 비밀번호 변경
		ModelAndView mav = new ModelAndView();
		// 비밀번호 수정		
		member.setMember_status(2);
		service.editPw(member);
		if (type == 0) {
			// 수정한 비밀번호 값을 세션 맴버에 저장
			HttpSession session = req.getSession(false);
			Member m = (Member)session.getAttribute("member");
			m.setMember_pw(member.getMember_pw());
			mav.addObject("type", type);
			mav.setViewName("redirect:/member/editPw");
		} else {
			mav.setViewName("redirect:/member/login");
		}
		return mav;
	}
	
	@RequestMapping("/member/main")
	public String groupwareMain() { // 그룹웨어 메인페이지 이동	
		return "/member/main";
	} 
	
	// 임시 비밀번호 생성
	public String createPw() {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 8; i++) { // 8자리 숫자+영문 조합
			if ((byte)(Math.random() * 5) == 0) { // 20% 확률로 숫자
				sb.append((char)((Math.random() * 10) + 48));				
			}
			else { // 80% 확률로 영문자
				sb.append((char)((Math.random() * 26) + 97));				
			}			
		}
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	// 파일 업로드(추가한 그림파일 서버에 생성)
	public String fileUpload(Member member, String type) {
		// 첨부파일의 이름 변수에 저장
		String fileName = member.getImg_file().getOriginalFilename();
		// StringBuilder에 저장한 파일이름의 '.' 위치를 구함
		StringBuilder sb = new StringBuilder(fileName);		
		int idx = sb.indexOf(".");
		
		// 생성할 파일 명을 만들고 원래 파일명과 교체
		String str = member.getMember_id() + type;   
		sb.replace(0, idx, str);
		
		// StringBuilder를 String으로 바꾸고 저장할 경로 지정
		String name = sb.toString();
		String path = img_path + name;
		File f = new File(path);
		try { // 파일 복사
			member.getImg_file().transferTo(f);			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return name;
	}
	
}
