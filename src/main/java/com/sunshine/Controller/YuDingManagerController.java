package com.sunshine.Controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.sunshine.Model.Bookinfo;
import com.sunshine.Model.User;
import com.sunshine.Service.YudingServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MessageNotify;

@Controller
@RequestMapping("/YuDingManager")
public class YuDingManagerController {

	@Autowired
	private YudingServiceI yudingServiceI;
	
	
	private DataGrid dataGrid=DataGrid.getDataGrid();
	private MessageNotify notify=MessageNotify.getMessageNotify();
	
	/**
	 * 返回预订管理首页面页面
	 * @return
	 */
	@RequestMapping(value="/YuDingManager_index",method=RequestMethod.GET)
	public String YuDingManager_index(){
		
		return "client/YudingManager";
	}
	/**
	 * 获取所有的客户预约记录信息
	 * @param page
	 * @param rows
	 * @param bookinfo
	 * @return
	 */
	@RequestMapping(value="/GetALLCustomerBookfosRecord",method=RequestMethod.POST)
	@ResponseBody
	public DataGrid GetALLCustomerBookfosRecord(int page,int rows,Bookinfo bookinfo){
		Subject subject=SecurityUtils.getSubject();
		User user=(User) subject.getPrincipal();
		if(user.getRole_id().equals("3")){
			bookinfo.setUser_id(user.getUser_id());
		}
		PageHelper.startPage(page, rows);
		List<Bookinfo> bookinfos=yudingServiceI.getALLCustomerBookinfos(bookinfo);
		int total=yudingServiceI.CountALlCustomerBookInfos(bookinfo);
		dataGrid.setRows(bookinfos);
		dataGrid.setTotal(total);
		return dataGrid;
	}
	/**
	 * 保存或更新客户预约记录信息
	 * @param bookinfo
	 * @return
	 */
	@RequestMapping(value="/SaveorUpdateCustomerBookfos",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify SaveorUpdateCustomerBookfos(Bookinfo bookinfo){
		int total=yudingServiceI.SaveOrUpdateCustomerBookInfos(bookinfo);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户预约记录处理成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户预约记录处理失败！请稍后重试！");
		}
		return notify;
	}
	/**
	 * 删除客户预约记录信息
	 * @param book_id
	 * @return
	 */
	@RequestMapping(value="/deleteCustomerBookfosRecord",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify deleteCustomerBookfosRecord(String book_id){
		int total=yudingServiceI.deleteCustomerBookInfos(book_id);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户预约记录信息删除成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户预约记录信息删除失败，请稍后重试！");
		}
		return notify;
	}
}
