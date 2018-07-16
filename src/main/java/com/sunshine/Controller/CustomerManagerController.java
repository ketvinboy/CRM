package com.sunshine.Controller;

import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.sunshine.Model.Customer;
import com.sunshine.Model.User;
import com.sunshine.Service.CustomerServiceI;
import com.sunshine.Service.UserServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MessageNotify;

@Controller
@RequestMapping("/CustomerManager")
public class CustomerManagerController {
	
	@Autowired
	private UserServiceI userServiceI;
	
	@Autowired
	private CustomerServiceI customerServiceI;
	
	private DataGrid dataGrid=DataGrid.getDataGrid();
	private MessageNotify notify=MessageNotify.getMessageNotify();
	
	/**
	 * 返回客户首页面
	 * @return
	 */
	@RequestMapping(value="/CustomerManager_index",method=RequestMethod.GET)
	public String CustomerManager_index(){
		
		return "client/CustomerManager";
	}
	/**
	 * 获取用户列表，用来组装Combox，进行特殊指派
	 * @return
	 */
	@RequestMapping(value="/GetUserListMap",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> GetUserListMap(){
		
		return userServiceI.GetUserListMap();
	}
	
	/**
	 * 获取所有的客户信息记录
	 * @return
	 */
	@RequestMapping(value="/GetALLCustomerInfoRecord",method=RequestMethod.POST)
	@ResponseBody
	public DataGrid GetALLCustomerInfoRecord(int page,int rows,Customer customer){
		Subject subject=SecurityUtils.getSubject();
		User user=(User) subject.getPrincipal();
		if(user.getRole_id().equals("3")){
			customer.setUser_id(user.getUser_id());
		}
		PageHelper.startPage(page, rows);
		List<Customer> customers=customerServiceI.findALLCustomerInfoRecord(customer);
		int total=customerServiceI.CountALLCustomerInfoRecord(customer);
		dataGrid.setRows(customers);
		dataGrid.setTotal(total);
		return dataGrid;
	}
	/**
	 * 保存或更新客户资料信息
	 * @param customer
	 * @return
	 */
	@RequestMapping(value="/SaveOrUpdateCustomerInfo",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify SaveOrUpdateCustomerInfo(Customer customer){
		int total=customerServiceI.SaveOrUpdateCustomerInfo(customer);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户资料信息更新成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户资料信息更新失败！请稍后重试！");
		}
		return notify;
	}
	/**
	 * 删除客户信息资料
	 * @param customer_id
	 * @return
	 */
	@RequestMapping(value="/deleteCustomerInfo",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify deleteCustomerInfo(String customer_id){
		int total=customerServiceI.deleteCustomerInfoRecord(customer_id);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户资料信息删除成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户资料信息删除失败！请联系管理员！");
		}
		return notify;
	}
	/**
	 * 特殊指派
	 * @return
	 */
	@RequestMapping(value="/UpdateCustomerAssign",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify UpdateCustomerAssign(Customer customer){
		int total=customerServiceI.UpdateCustomerAssign(customer);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户销售指派处理成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户销售指派处理失败！");
		}
		return notify;
	}
	/**
	 * 获取角色为销售人员的列表进行特殊指派操作
	 * @return
	 */
	@RequestMapping(value="/GetSaleUserListMap",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> GetSaleUserListMap(){
		return customerServiceI.GetSaleUserListMap();
	}
}
