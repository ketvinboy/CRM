package com.sunshine.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.sunshine.Model.Contact;
import com.sunshine.Model.Customer;
import com.sunshine.Service.ContactServiceI;
import com.sunshine.Service.CustomerServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MessageNotify;

@Controller
@RequestMapping("/ContactManager")
public class ContactManagerController {
	
	@Autowired
	private CustomerServiceI customerServiceI; //客户管理服务类
	
	@Autowired
    private ContactServiceI contactServiceI;
	
	private MessageNotify notify=MessageNotify.getMessageNotify();
	private DataGrid dataGrid=DataGrid.getDataGrid();
	
	@RequestMapping(value="/ContactManager_index",method=RequestMethod.GET)
	public String ContactManager_index(){
		
		return "client/ContactsManager";
	}
	
	/**
	 * 获取客户列表，组装combox下拉列表
	 * @return
	 */
	
	@RequestMapping(value="/getCustomerName",method=RequestMethod.POST)
	@ResponseBody
	public List<Customer> getCustomerName(){
		
		return customerServiceI.GetCustomerName();
	}
	/**
	 * 返回所有的客户联系资料信息表
	 * @param page
	 * @param rows
	 * @param contact
	 * @return
	 */
	@RequestMapping(value="/GetALLCustomerContactINfoRecord",method=RequestMethod.POST)
	@ResponseBody
    public DataGrid GetALLCustomerContactINfoRecord(int page,int rows,Contact contact){
    	PageHelper.startPage(page, rows);
    	List<Contact> contacts=contactServiceI.getALLCustomerContacts(contact);
    	int total=contactServiceI.CountALLCustomerContactsRecords(contact);
    	dataGrid.setRows(contacts);
    	dataGrid.setTotal(total);
    	return dataGrid;
    }
	/**
	 * 保存或更新客户资料信息
	 * @param contact
	 * @return
	 */
	@RequestMapping(value="/SaveOrUpdateCustomerInfo",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify SaveOrUpdateCustomerInfo(Contact contact){
		int total=contactServiceI.SaveOrUpdateCustomerContactInfo(contact);
		if(total>0){
			notify.setMsg("客户资料信息更新成功！");
			notify.setSuccess(true);
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户资料信息更新失败，请稍后重试！");
		}
		return notify;
	}
	
	/**
	 * 删除客户联系人信息
	 * @param cont_id
	 * @return
	 */
	@RequestMapping(value="/deleteCustomerContactInfo",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify deleteCustomerContactInfo(String cont_id){
		int total=contactServiceI.deletCustomerContactInfo(cont_id);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("删除客户联系人信息成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("删除客户联系人信息失败，请稍后重试！");
		}
		return notify;
	}
}
