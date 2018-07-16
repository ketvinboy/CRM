package com.sunshine.Dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sunshine.Model.User;

public interface UserDaoMapper {

	List<User> findALLUserList(User user);

	int CountAllUserListRecords(User user);

	int updateUserRecord(User user);

	int saveUserRecord(User user);
	
	int deleteUSerRecord(String user_id);
	
	User getUserInfoRecordById(String user_id);

	int UpdateUserPwd(@Param("user_name")String user_name, @Param("password")String password);

	User getUserInfoRecordByName(String user_name);

	List<User> findALLUserListMap();

	User GetUserInfoRecordByNameAndPwd(@Param("user_name") String user_name, @Param("password") String password);

	List<User> findAllSaleUserList();

}
