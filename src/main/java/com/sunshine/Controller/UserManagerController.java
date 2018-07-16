package com.sunshine.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.sunshine.Model.User;
import com.sunshine.Service.UserServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MessageNotify;

@Controller
@RequestMapping("/UserManager")
public class UserManagerController {

	@Autowired
	private UserServiceI userServiceI;
	
	private MessageNotify notify=MessageNotify.getMessageNotify();

	private DataGrid dataGrid=DataGrid.getDataGrid();
	/**
	 * 返回用户管理页面
	 * @return
	 */
	@RequestMapping("/UserManager_index")
	public String UserManager_index(){
		return "client/UserManager";
	}
	/**
	 * 获取用户管理信息数据列表
	 * @param page
	 * @param rows
	 * @param user
	 * @return datagrid
	 */
	
	@RequestMapping(value="/findALLUserInfoRecord",method=RequestMethod.POST)
	@ResponseBody
	public DataGrid findALLUserInfoRecord(int page,int rows,User user){
		PageHelper.startPage(page, rows);
		List<User> users=userServiceI.findALLUserList(user);
		int total=userServiceI.CountAllUserListRecords(user);
		dataGrid.setRows(users);
		dataGrid.setTotal(total);
		return dataGrid;
	}
	/**
	 *保存或更新用户信息
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/SaveOrUpdateUserInfo",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify SaveOrUpdateUserInfo(User user){
		int total=userServiceI.SaveOrUpdateUserRecord(user);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("用户信息更新成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("用户信息更新失败！");
		}
		return notify;
	}
	
	@RequestMapping(value="/deleteUSerInfo",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify deleteUSerInfo(String user_id){
		int total=userServiceI.deleteUSerInfo(user_id);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("用户信息删除成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("用户信息删除失败！");
		}
		return notify;
	}
	
	@RequestMapping(value="/UpdateUserPwd",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify UpdateUserPwd(User user){
		int total=userServiceI.UpdateUserPwd(user);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("用户密码更新成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("用户密码更新失败！");
		}
		return notify;
	} 
  
	@RequestMapping(value="/ajaxUsernick",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify ajaxUsernick(String user_name){
		boolean flag=userServiceI.ajaxUsernick(user_name);
		if(flag){
			notify.setSuccess(true);
		}else{
			notify.setSuccess(false);
		}
		return notify;
	}
}
