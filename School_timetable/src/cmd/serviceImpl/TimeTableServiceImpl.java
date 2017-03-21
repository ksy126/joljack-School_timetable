package cmd.serviceImpl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmd.service.TimeTableService;
import helper.dao.CommonDAO;

@Service("timetable.TimeTableService")
public class TimeTableServiceImpl implements TimeTableService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public void insertTimeTable(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.insertData("timetable.addTimeTable", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Object select_timetable(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		try {
			rMap = (Map<String, Object>) this.commonDao.getReadData("timetable.select_timetable", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rMap;
	}

	@Override
	public void update_timetable(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("timetable.update_timetable", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_timetable(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.deleteData("timetable.delete_timetable", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
