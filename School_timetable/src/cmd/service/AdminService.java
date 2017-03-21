package cmd.service;

import java.util.List;
import java.util.Map;

public interface AdminService {

	public void insert_notice(Map<String, Object> map);
	
	public void modify_notice(Map<String, Object> map);
	
	public void update_img(Map<String, Object> map);
	
	public List<Object> select_noticeList(Map<String, Object> pMap);
	
	public void delete_notice(Map<String, Object> pMap);
}
