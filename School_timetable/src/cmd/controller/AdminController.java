package cmd.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cmd.service.AdminService;



@Controller("admin")
@RequestMapping("/admin")
public class AdminController{
	
	@Resource(name="cmd.AdminService")
	private AdminService adminService;
	
    private final static Log logger = LogFactory.getLog(AdminController.class);   
    
    @RequestMapping("/login.do")
    public String login(){
    	return "admin/login";
    }
    
    @RequestMapping("/main.do")
    public String main(){
    	return "admin/main";
    }
    
    @RequestMapping("/notice.do")
    public String notice(){
    	return "admin/notice";
    }
    
    @RequestMapping("/notice_list.do")
    public String notice_list(){
    	return "admin/notice_list";
    }
    
    @RequestMapping("/member.do")
    public String member(){
    	return "admin/member";
    }
    
    @RequestMapping("/img_orgaization.do")
    public String img_orgaization(){
    	return "admin/img_orgaization";
    }
    
    @RequestMapping("/img_schedule.do")
    public String img_schedule(){
    	return "admin/img_schedule";
    }
    
    //
    @RequestMapping("/insert_notice.do")
    public ModelAndView insert_notice(@RequestParam Map<String, Object> map){
    	adminService.insert_notice(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    @RequestMapping("/modify_notice.do")
    public ModelAndView modify_notice(@RequestParam Map<String, Object> map){
    	adminService.modify_notice(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }

	
	//
    @RequestMapping("/save_img.do")
    public ModelAndView save_organization_chart(@RequestParam Map<String, Object> map){
    	adminService.update_img(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
    
    @RequestMapping("/select_noticeList.do")
    public ModelAndView select_noticeList(@RequestParam Map<String, Object> map){
    	List<Object> list = null;
    	
    	list = adminService.select_noticeList(map);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	mav.addObject("list", list);
    	return mav;
    }
    
    //
    @RequestMapping("/delete_notice.do")
    public ModelAndView delete_notice(@RequestParam Map<String, Object> map){
    	adminService.delete_notice(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
}

