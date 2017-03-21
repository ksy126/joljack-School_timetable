package cmd.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cmd.service.TimeTableService;



@Controller
@RequestMapping("/timeTable")
public class TimeTableController {
	
	@Resource(name="timetable.TimeTableService")
	private TimeTableService timetableSerivce;
	
	private final static Log logger = LogFactory.getLog(TimeTableController.class);

	//시간표 메인 페이지 이동
	@RequestMapping("/main.do")
	public ModelAndView main(@RequestParam Map<String, Object> map){
		Map<String, Object> rMap = (Map<String, Object>) timetableSerivce.select_timetable(map);

		ModelAndView mav = new ModelAndView("timetable/timetable_main");
		mav.addObject("timetable", rMap);
		return mav;
	}
	
	//시간표 안드로이드 메인 페이지 이동
	@RequestMapping("/and_main.do")
	public ModelAndView and_main(HttpServletRequest req, HttpServletResponse res){
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession(true);
		String session_member_no = (String) session.getAttribute("member_no");
		
		
		if(session_member_no == null || session_member_no == ""){
			
		} else {
			
			map.put("member_no", session_member_no);
			
		}
		ModelAndView mav = new ModelAndView("timetable/timetable_main");
		Map<String, Object> rMap = (Map<String, Object>) timetableSerivce.select_timetable(map);			
		mav.addObject("timetable", rMap);
		return mav;
	}
	
	//시간표 입력 페이지 이동 
	@RequestMapping("/addTimeTable.do")
	public ModelAndView add_timeTable(){
		ModelAndView mav = new ModelAndView("timetable/add_timetable");
		return mav;
	}
	
	//시간표 입력 페이지 이동 
		@RequestMapping("/modifyTimeTable.do")
		public ModelAndView modifyTimeTable(@RequestParam Map<String, Object> map){
			Map<String, Object> rMap = (Map<String, Object>) timetableSerivce.select_timetable(map);
			ModelAndView mav = new ModelAndView("timetable/timetable_modify");
			mav.addObject("timetable", rMap);
			return mav;
		}
	
	//시간표 DB등록
	@RequestMapping("/insert_timeTable.do")
	public ModelAndView insert_timeTable(@RequestParam Map<String, Object> map){
		timetableSerivce.insertTimeTable(map);
		ModelAndView mav = new ModelAndView("redirect:/timeTable/main.do?member_no="+map.get("member_no"));
		return mav;
	}
	
	//시간표 DB 수정
	@RequestMapping("/modify_timeTable.do")
	public ModelAndView modify_timeTable(@RequestParam Map<String, Object> map){
		timetableSerivce.update_timetable(map);
		ModelAndView mav = new ModelAndView("redirect:/timeTable/main.do?member_no="+map.get("member_no"));
		return mav;
	}
	
	//시간표 DB 삭제
	@RequestMapping("/deleteTimeTable.do")
	public ModelAndView deleteTimeTable(@RequestParam Map<String, Object> map){
		timetableSerivce.delete_timetable(map);
		ModelAndView mav = new ModelAndView("redirect:/timeTable/main.do?member_no="+map.get("member_no"));
		return mav;
	}
	
}
