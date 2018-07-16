package com.sunshine.Service.Impl;

import java.sql.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sunshine.Dao.LogDaoMapper;
import com.sunshine.Model.Logs;
import com.sunshine.Model.User;
import com.sunshine.Service.LogServiceI;

@Service
public class LogServiceImpl implements LogServiceI{
	
	@Autowired
	private LogDaoMapper logDaoMapper;

	@Override
	public List<Logs> getALLLogRecordInfoList(Logs log) {
		
		return logDaoMapper.getALLLogRecordInfoList(log);
	}

	@Override
	public int CountALLLogRecordInfos(Logs logs) {
		
		return logDaoMapper.CountALLLogRecordInfos(logs);
	}

	@Override
	public int SaveOrUpdateLogRecordInfo(Logs logs) {
		if(logs.getLog_id()!=null && !logs.getLog_id().equals("")){	
			logs.setCreate_time(new Date(System.currentTimeMillis()));
			return logDaoMapper.updateLogsRecord(logs);
		}else{
			Subject subject=SecurityUtils.getSubject();
			User user=(User) subject.getPrincipal();
			logs.setUser_id(user.getUser_id());
			logs.setCreate_time(new Date(System.currentTimeMillis()));
			return logDaoMapper.saveLogsRecord(logs);
		}
	}

	@Override
	public int deleteLogRecordInfo(String log_id) {
		
		return logDaoMapper.deleteLogRecordInfo(log_id);
	}

}
