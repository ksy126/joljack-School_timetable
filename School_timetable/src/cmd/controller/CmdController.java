package cmd.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.servlet.view.xml.MarshallingView;

import cmd.VO.MemberVO;
import cmd.VO.NoticeVO;
import cmd.service.AdminService;
import cmd.service.CmdService;
import helper.util.FileUtil;


@Controller("cmd")
@RequestMapping("/cmd")
public class CmdController{
	
	@Resource(name="cmd.CmdService")
	private CmdService cmdService;
	@Resource(name="cmd.AdminService")
	private AdminService adminService;
	
    private final static Log logger = LogFactory.getLog(CmdController.class);   
    
    
    //�α��� ������ �̵�
    @RequestMapping("/login.do")
    public ModelAndView login(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/login");
    	return mav;
    }
    
    //�а� �Ұ� ������ �̵�
    @RequestMapping("/move_school_introduce.do")
    public ModelAndView move_school_introduce(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/school_department_introduction");
    	return mav;
    }
    
    //������ �Ұ� ������ �̵�
    @RequestMapping("/school_professor_info.do")
    public ModelAndView school_professor_info(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/school_professor_info");
    	return mav;
    }
    
    //�л�ȸ ������ �̵�
    @RequestMapping("/organization_chart.do")
    public ModelAndView organization_chart(@RequestParam Map<String, Object> map){
    	map.put("category", "01");
    	Map<String, Object> img = new HashMap<>();
    	img = (Map<String, Object>) cmdService.select_img(map);	
    	ModelAndView mav = new ModelAndView("main/organization_chart");
    	mav.addObject("img", img);
    	return mav;
    }
    
    //�л� ���� �̵�
    @RequestMapping("/department_schedule.do")
    public ModelAndView department_schedule(@RequestParam Map<String, Object> map){
    	List<Object> imgList = null;
    	imgList = adminService.scheduleImgList();
    	System.out.println(imgList);
    	ModelAndView mav = new ModelAndView("main/school_schedule");
    	mav.addObject("imgList", imgList);
    	return mav;
    }
    
    //�а� ���� �̵�
    @RequestMapping("/school_notice.do")
    public ModelAndView school_notice(@RequestParam Map<String, Object> map){  
    	ModelAndView mav = new ModelAndView("main/school_notice");
    	return mav;
    }
    
    //�Խ��� �̵� 
    @RequestMapping("/school_board.do")
    public ModelAndView school_board(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/school_board");
    	return mav;
    }
    
    //�Խ��� �̵� 
    @RequestMapping("/school_board_qa.do")
    public ModelAndView school_board_qa(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/school_board_qa");
    	return mav;
    }
    
    //���� ������ �̵�
    @RequestMapping("/main.do")
    public String main(){      	    
    	return "main/main";
    }
    
    //�������� �̵�
    @RequestMapping("/school_personal_information.do")
    public ModelAndView school_personal_information(@RequestParam Map<String, Object> map){
    	MemberVO memberVo = null;
    	memberVo = (MemberVO) cmdService.select_member(map);
    	ModelAndView mav = new ModelAndView("main/school_personal_information");
    	mav.addObject("memberVo", memberVo);
    	return mav;
    }
    
    //
    @RequestMapping("/move_department_notice.do")
    public ModelAndView move_department_notice(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/school_department_notice");
    	return mav;
    }
    
    @RequestMapping("/member_join.do")
    public String member_join_move(){
    	return "main/member_join";
    }
    
    @RequestMapping("/update_member.do")
    public String update_member(@RequestParam Map<String, Object> map){
    	cmdService.update_member(map);
    	return "main/main";
    }
    
    @RequestMapping("/insert_member.do")
    public ModelAndView insert_member(@RequestParam Map<String, Object> map){
    	cmdService.insert_member(map);
    	ModelAndView mav = new ModelAndView("admin/member");
    	mav.addObject("check", "yes");
    	return mav;
    }
    
    @RequestMapping("/user_login.do")
    public ModelAndView user_login(HttpServletRequest req, HttpServletResponse res,@RequestParam Map<String, Object> map){
    	MemberVO memberVo = null;
    	memberVo = (MemberVO) cmdService.check_login(map);
    	Map<String, Object> rMap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView();
    	
    	if(memberVo.getCheck() != "no"){
    		HttpSession session = req.getSession(true);
    		
    		//���ǵ��
    		rMap.put("memberInfo", memberVo);
    		session.setAttribute("sessionData", rMap);
    		session.setAttribute("member_no", memberVo.getMember_no());
    		mav.addObject("member_no", memberVo.getMember_no());
    	}
    	
    	
		mav.setViewName("jsonView");
		mav.addObject("check", memberVo.getCheck());
    	
    	return mav;
    }
    
    @RequestMapping("/user_logout.do")
    public String user_logout(HttpServletRequest req, HttpServletResponse res){
    	HttpSession session = req.getSession(true);
    	session.removeAttribute("sessionData");
    	session.removeAttribute("member_no");
    	session = req.getSession(true);
    	return "main/main";
    }
    
    @RequestMapping("/member_manage.do")
    public ModelAndView and_main(HttpServletRequest req, HttpServletResponse res){
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession(true);
		String session_member_no = (String) session.getAttribute("member_no");		
		
		if(session_member_no == null || session_member_no == ""){
			
		} else {			
			map.put("member_no", session_member_no);			
		}
		MemberVO memberVo = (MemberVO) cmdService.select_member(map);
		ModelAndView mav = new ModelAndView("main/member_manage");
		mav.addObject("memberVo", memberVo);
		return mav;
	}
   
    //�Խ��� �� ��� 
    @RequestMapping("/insert_boardList.do")
    public ModelAndView insert_boardList(@RequestParam Map<String, Object> map){
    	cmdService.insert_boardList(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
    
    //�Խ��� �� ��� 
    @RequestMapping("/insert_board_qa.do")
    public ModelAndView insert_board_qa(@RequestParam Map<String, Object> map){
    	cmdService.insert_board_qa(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
    
    //�Խ��� �� �������� 
    @RequestMapping("/select_boardList.do")
    public ModelAndView select_boardList(@RequestParam Map<String, Object> map){
    	List<Object> list = null;
    	List<Object> replay_list = null;
    	list = cmdService.select_board(map);
    	replay_list = cmdService.select_board_replay(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("list", list);
		mav.addObject("replay_list", replay_list);
		return mav;
	}
    
    //
    @RequestMapping("/select_boardList_qa.do")
    public ModelAndView select_boardList_qa(@RequestParam Map<String, Object> map){
    	List<Object> list = null;
    	List<Object> replay_list = null;
    	list = cmdService.select_boardList_qa(map);
    	replay_list = cmdService.select_board_qa_replay(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("list", list);
		mav.addObject("replay_list", replay_list);
		return mav;
	}
    
    //��� ��� 
    @RequestMapping("/insert_board_replay.do")
    public ModelAndView insert_board_replay(@RequestParam Map<String, Object> map){
    	cmdService.insert_board_replay(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
    
    //
    @RequestMapping("/insert_board_qa_replay.do")
    public ModelAndView insert_board_qa_replay(@RequestParam Map<String, Object> map){
    	cmdService.insert_board_qa_replay(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
    //
    @RequestMapping("/select_noticeList.do")
    public ModelAndView select_noticeList(@RequestParam Map<String, Object> map){
    	List<Object> list = null;
    	
    	list = cmdService.select_noticeList(map);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	mav.addObject("list", list);
    	return mav;
    }
    
    //
    @RequestMapping("/select_notice_department_List.do")
    public ModelAndView select_notice_department_List(@RequestParam Map<String, Object> map){
    	List<Object> list = null;
    	
    	list = cmdService.select_notice_department_List(map);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	mav.addObject("list", list);
    	return mav;
    }
    
    //
    @RequestMapping("/notice_details.do")
    public ModelAndView notice_details(@RequestParam Map<String, Object> map){
    	NoticeVO noticeVo = null;
    	noticeVo = (NoticeVO) cmdService.select_notice_no(map);    	
		ModelAndView mav = new ModelAndView("main/school_notice_details");
		mav.addObject("noticeVo", noticeVo);
		return mav;
	}
    
    @RequestMapping("/notice_department_details.do")
    public ModelAndView notice_department_details(@RequestParam Map<String, Object> map){
    	NoticeVO noticeVo = null;
    	noticeVo = (NoticeVO) cmdService.notice_department_details(map);    	
		ModelAndView mav = new ModelAndView("main/school_notice_details_details");
		mav.addObject("noticeVo", noticeVo);
		return mav;
	}
    
    // ��й�ȣ ����
    @RequestMapping("/update_member_pwd.do")
    public ModelAndView update_member_pwd(@RequestParam Map<String, Object> map){
    	cmdService.update_member(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
    
    //
    @RequestMapping("/insert_notice.do")
    public ModelAndView insert_notice(@RequestParam Map<String, Object> map){
    	cmdService.insert_notice(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //���� 
    @RequestMapping("/delete_notice_department.do")
    public ModelAndView delete_notice_department(@RequestParam Map<String, Object> map){
    	cmdService.delete_notice_department(map);
    	ModelAndView mav = new ModelAndView("main/school_department_notice");
    	return mav;
    }
    
    //�̹��� Ȯ�� ������ �̵�
    @RequestMapping("/img_expand.do")
    public ModelAndView img_expand(@RequestParam Map<String, Object> map){
    	ModelAndView mav = new ModelAndView("main/img_expand");
    	mav.addObject("img_src", map.get("img_src"));
    	return mav;
    }
    
    //update_board
    @RequestMapping("/update_board.do")
    public ModelAndView update_board(@RequestParam Map<String, Object> map){
    	cmdService.update_board(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //update_replay
    @RequestMapping("/update_replay.do")
    public ModelAndView update_replay(@RequestParam Map<String, Object> map){
    	cmdService.update_replay(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //delete_board
    @RequestMapping("/delete_board.do")
    public ModelAndView delete_board(@RequestParam Map<String, Object> map){
    	cmdService.delete_board(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //delete_replay
    @RequestMapping("/delete_replay.do")
    public ModelAndView delete_replay(@RequestParam Map<String, Object> map){
    	cmdService.delete_replay(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //update_qa_board
    @RequestMapping("/update_qa_board.do")
    public ModelAndView update_qa_board(@RequestParam Map<String, Object> map){
    	cmdService.update_qa_board(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //update_qa_replay
    @RequestMapping("/update_qa_replay.do")
    public ModelAndView update_qa_replay(@RequestParam Map<String, Object> map){
    	cmdService.update_qa_replay(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //delete_qa_board
    @RequestMapping("/delete_qa_board.do")
    public ModelAndView delete_qa_board(@RequestParam Map<String, Object> map){
    	cmdService.delete_qa_board(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //delete_qa_replay
    @RequestMapping("/delete_qa_replay.do")
    public ModelAndView delete_qa_replay(@RequestParam Map<String, Object> map){
    	cmdService.delete_qa_replay(map);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
	/**
	 * ��ü���Ͼ��ε�
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/saveCompanyFile.do")
	public ModelAndView saveCompanyFile(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws Exception {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		int result = 0;

		try {

			HttpSession sesson = req.getSession();
			String doc_root = sesson.getServletContext().getRealPath("/upload");

			String fileDestPath = "";
			String member_no = pMap.get("member_no").toString();
			fileDestPath = doc_root + File.separator + "img" + File.separator + member_no;

			String fileUploadPath = (String) pMap.get("fileUploadPath");
			String orgName = (String) pMap.get("fileNewName");
			String destination = (String) pMap.get("destination");

			System.out.println(" * �ӽ� ���� ��� : " + destination);

			if (!orgName.equals("") && !fileUploadPath.equals("")) {
				String temp_file_ext = orgName.substring(orgName.lastIndexOf(".") + 1);
				String temp_total_path = destination;
				Calendar calendar = Calendar.getInstance();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
				String today = dateFormat.format(calendar.getTime());
				String newName = member_no + today + "." + temp_file_ext;
				// System.gc();
				FileUtil.moveFile(temp_total_path, fileDestPath, newName);

				System.out.println(" * ���� ����� ���� ��� : " + fileDestPath);
				System.out.println(" * ���� ����� ���� �̸� : " + newName);

				rMap.put("fileUploadPath", fileDestPath);
				rMap.put("fileNewName", newName);
			}
		

		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		rMap.put("resultCode", result);

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;
	}
}

