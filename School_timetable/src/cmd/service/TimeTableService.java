package cmd.service;

import java.util.Map;

public interface TimeTableService {
	
	public void insertTimeTable(Map<String, Object> map);
	
	public Object select_timetable(Map<String, Object> map);
	
	public void update_timetable(Map<String, Object> map);
	
	public void delete_timetable(Map<String, Object> map);

}
