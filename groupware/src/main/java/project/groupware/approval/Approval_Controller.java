package project.groupware.approval;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Approval_Controller {

	@RequestMapping(value="/approval")
	public String approval() {
		
		return "/approval/writeForm1";
	}
	
}
