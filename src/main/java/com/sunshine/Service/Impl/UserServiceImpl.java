package com.sunshine.Service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sunshine.Dao.UserDaoMapper;
import com.sunshine.Model.User;
import com.sunshine.Service.UserServiceI;
import com.sunshine.Utils.MD5keyBean;

@Service
public class UserServiceImpl implements UserServiceI{
	
	@Resource
	private UserDaoMapper userDaoMapper;
	
	private MD5keyBean md5keyBean=new MD5keyBean();

	@Override
	public List<User> findALLUserList(User user) {
		
		return userDaoMapper.findALLUserList(user);
	}

	@Override
	public int CountAllUserListRecords(User user) {
		
		return userDaoMapper.CountAllUserListRecords(user);
	}

	@Override
	public int SaveOrUpdateUserRecord(User user) {
		if(user.getStatus()!=null){
			user.setStatus("1");
		}else{
			user.setStatus("0");
		}
		if(user.getUser_id()!=null && !user.getUser_id().equals("")){
			return userDaoMapper.updateUserRecord(user);
		}else{
			 user.setPassword(md5keyBean.getkeyBeanofStr("123456"));
			if(user.getStatus()!=null || !user.getStatus().equals("")){
				user.setStatus("1");
			}else{
				user.setStatus("0");
			}
			return userDaoMapper.saveUserRecord(user);
		}
}

	@Override
	public int deleteUSerInfo(String user_id) {
		
		return userDaoMapper.deleteUSerRecord(user_id);
	}

	@Override
	public int UpdateUserPwd(User user) {
		
		return userDaoMapper.UpdateUserPwd(user.getUser_name(),md5keyBean.getkeyBeanofStr(user.getPassword()));
	}

	@Override
	public boolean ajaxUsernick(String user_name) {
		User user=userDaoMapper.getUserInfoRecordByName(user_name);
		if(user!=null){
			return true;
		}
		 return false;
	}

	@Override
	public List<Map<String, Object>> GetUserListMap() {
		List<Map<String, Object>> lMaps=new ArrayList<Map<String,Object>>();
		Map<String, Object> tiMap=new HashMap<String, Object>();
		tiMap.put("id", "");
		tiMap.put("text", "==请选择指派人==");
		lMaps.add(tiMap);
		List<User> uList=userDaoMapper.findALLUserListMap();
		if(uList!=null && uList.size()>0){
			for(int i=0;i<uList.size();i++){
				Map<String, Object> map=new HashMap<String, Object>();
				User user=uList.get(i);
				map.put("id", user.getUser_id());
				map.put("text", user.getUser_name());
				lMaps.add(map);
			}
		}
		return lMaps;
	}

	@Override
	public User LoginSystem(String user_name, String password) {
		
		return userDaoMapper.GetUserInfoRecordByNameAndPwd(user_name,md5keyBean.getkeyBeanofStr(password));
	}
}
