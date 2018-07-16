package com.sunshine.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.sunshine.Model.Logs;
import com.sunshine.Service.LogServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MessageNotify;

@Controller
@RequestMapping("/LogManager")
public class LogManagerController {

	@Autowired
	private LogServiceI logServiceI;
	
	private DataGrid dataGrid=DataGrid.getDataGrid();
	private MessageNotify notify=MessageNotify.getMessageNotify();
	
	/**
	 * 返回日志管理首页面
	 * @return
	 */
	@RequestMapping(value="/LogManager_index",method=RequestMethod.GET)
	public String LogManager_index(){
		
		return "client/LogManager";
	}
	/**
	 * 获取所有的日志列表信息（可根据查询条件进行过滤）
	 * @param page
	 * @param rows
	 * @param log
	 * @return
	 */
	@RequestMapping(value="/GetALlLogListRecord",method=RequestMethod.POST)
	@ResponseBody
	public DataGrid GetALlLogListRecord(int page,int rows,Logs log){
		PageHelper.startPage(page, rows);
		List<Logs> logRecordList=logServiceI.getALLLogRecordInfoList(log);
		int total=logServiceI.CountALLLogRecordInfos(log);
		dataGrid.setRows(logRecordList);
		dataGrid.setTotal(total);
		return dataGrid;
	}
	
	/**
	 * 保存或更新日志记录信息
	 * @param log
	 * @return
	 */
	@RequestMapping(value="/SaveOrUpdateLogReord",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify SaveOrUpdateLogReord(Logs log){
		int total=logServiceI.SaveOrUpdateLogRecordInfo(log);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("日志记录更新成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("日志记录更新失败，请稍后重试！");
		}
		return notify;
	}
	/**
	 * 删除日志记录信息操作
	 * @param log_id
	 * @return
	 */
	@RequestMapping(value="/deleteLogRecord",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify deleteLogRecord(String log_id){
		int total=logServiceI.deleteLogRecordInfo(log_id);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("日志记录删除成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("日志记录删除失败，请稍后重试！");
		}
		return notify;
	}
}
