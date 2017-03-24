package cmd.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmd.service.AdminService;
import helper.dao.CommonDAO;

@Service("cmd.AdminService")
public class AdminServiceImpl implements AdminService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public void insert_notice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(new java.util.Date());
		map.put("insertDate", currentDate);
		
		try {
			this.commonDao.insertData("admin.insert_notice", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void update_img(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			if(map.get("category").equals("02")){
				this.commonDao.updateData("admin.update_img_schedual", map);
			} else {
				this.commonDao.updateData("admin.update_img", map);
			}
			
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
			list = this.commonDao.getListData("admin.select_noticeList", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void delete_notice(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("admin.delete_notice", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void modify_notice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("admin.modify_notice", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Object> scheduleImgList() {
		// TODO Auto-generated method stub
		List<Object> result = null;
				
		try {
			result = this.commonDao.getListData("admin.selectScheduleImgList");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void schedule_img_delete(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("admin.schedule_img_delete", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
