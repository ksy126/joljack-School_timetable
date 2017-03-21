package cmd.service;

import java.util.List;
import java.util.Map;

public interface CmdService {
	
	public Object check_login(Map<String, Object> map);
	
	public void insert_member(Map<String, Object> map);
	
	public void update_member(Map<String, Object> map);
	
	public Object select_member(Map<String, Object> map);
	
	public void insert_boardList(Map<String, Object> map);
	
	public void insert_board_qa(Map<String, Object> map);
	
	public List<Object> select_board(Map<String, Object> pMap);
	
	public List<Object> select_boardList_qa(Map<String, Object> pMap);
	
	public List<Object> select_board_replay(Map<String, Object> pMap);
	
	public List<Object> select_board_qa_replay(Map<String, Object> pMap);
	
	public void insert_board_replay(Map<String, Object> map);	
	
	public void insert_board_qa_replay(Map<String, Object> map);
	
	public List<Object> select_noticeList(Map<String, Object> pMap);
	
	public List<Object> select_notice_department_List(Map<String, Object> pMap);
	
	public Object select_notice_no(Map<String, Object> pMap);
	
	public Object notice_department_details(Map<String, Object> pMap);
	
	public Object select_img(Map<String, Object> pMap);
	
	public void insert_notice(Map<String, Object> map);
	
	public void delete_notice_department(Map<String, Object> map);
	
	public void update_board(Map<String, Object> map);
	
	public void update_replay(Map<String, Object> map);
	
	public void delete_board(Map<String, Object> map);
	
	public void delete_replay(Map<String, Object> map);
	
	public void update_qa_board(Map<String, Object> map);
	
	public void update_qa_replay(Map<String, Object> map);
	
	public void delete_qa_board(Map<String, Object> map);
	
	public void delete_qa_replay(Map<String, Object> map);
}
