package com.sunshine.Service;

import java.util.List;
import java.util.Map;

import com.sunshine.Model.User;

public interface UserServiceI {

	public List<User> findALLUserList(User user);
	
	public int CountAllUserListRecords(User user);
	
	public int SaveOrUpdateUserRecord(User user);

	public int deleteUSerInfo(String user_id);

	public int UpdateUserPwd(User user);

	public boolean ajaxUsernick(String user_name);

	public List<Map<String, Object>> GetUserListMap();

	public User LoginSystem(String user_name, String password);
	
}
