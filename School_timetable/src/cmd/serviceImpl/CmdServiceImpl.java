package cmd.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmd.VO.MemberVO;
import cmd.VO.NoticeVO;
import cmd.service.CmdService;
import helper.dao.CommonDAO;

@Service("cmd.CmdService")
public class CmdServiceImpl implements CmdService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;
	
	@Override
	public Object check_login(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO memberVo = new MemberVO();
		MemberVO memberVo2 = new MemberVO();
		
		try {
			memberVo = (MemberVO) this.commonDao.getReadData("login.login_check", map);
			System.out.println("memberVo="+memberVo);
			
			if(memberVo == null){
				memberVo2.setCheck("no");
				memberVo = memberVo2;
			} else {				
				memberVo.setCheck("yes");
				
			}
						
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return memberVo;
	}

	@Override
	public void insert_member(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.insertData("login.insert_member", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public void update_member(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.insertData("login.update_member", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Object select_member(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO memberVo = new MemberVO();
		
		try {
			memberVo = (MemberVO) this.commonDao.getReadData("login.select_member", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return memberVo;
	}

	@Override
	public void insert_boardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(new java.util.Date());
		map.put("insertDate", currentDate);
		try {
			this.commonDao.insertData("cmd.insert_board", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	@Override
	public void insert_board_qa(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(new java.util.Date());
		map.put("insertDate", currentDate);
		
		try {
			this.commonDao.insertData("cmd.insert_board_qa", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


	@Override
	public List<Object> select_board(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> list = null;
				
		try {
			list = this.commonDao.getListData("cmd.select_board", pMap);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	

	@Override
	public List<Object> select_boardList_qa(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.select_board_qa", pMap);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}


	@Override
	public List<Object> select_board_replay(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.select_board_reply", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	

	@Override
	public List<Object> select_board_qa_replay(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.select_board_qa_reply", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void insert_board_replay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(new java.util.Date());
		map.put("insertDate", currentDate);
		try {
			this.commonDao.insertData("cmd.insert_board_replay", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	@Override
	public void insert_board_qa_replay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(new java.util.Date());
		map.put("insertDate", currentDate);	
		try {
			this.commonDao.insertData("cmd.insert_board_qa_replay", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	@Override
	public List<Object> select_noticeList(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.select_noticeList", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Object> select_notice_department_List(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		
		try {
			list = this.commonDao.getListData("cmd.select_notice_department_List", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Object select_notice_no(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		NoticeVO noticeVo = null;
		
		try {
			noticeVo = (NoticeVO) this.commonDao.getReadData("cmd.select_notice_no", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return noticeVo;
	}
	
	@Override
	public Object notice_department_details(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
NoticeVO noticeVo = null;
		
		try {
			noticeVo = (NoticeVO) this.commonDao.getReadData("cmd.select_notice_notice_department_details_no", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return noticeVo;
	}

	@Override
	public Object select_img(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		Map<String, Object> img = new HashMap<>();
		
		try {
			img = (Map<String, Object>) this.commonDao.getReadData("cmd.select_img", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return img;
	}

	@Override
	public void insert_notice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(new java.util.Date());
		map.put("insertDate", currentDate);
		
		try {
			this.commonDao.insertData("cmd.insert_notice", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_notice_department(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("cmd.delete_notice_department", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void update_board(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("cmd.update_board", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_board(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("cmd.delete_board", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_replay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("cmd.delete_replay", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void update_replay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("cmd.update_replay", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	public void update_qa_board(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("cmd.update_qa_board", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_qa_board(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("cmd.delete_qa_board", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_qa_replay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("cmd.delete_qa_replay", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void update_qa_replay(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("cmd.update_qa_replay", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


}
