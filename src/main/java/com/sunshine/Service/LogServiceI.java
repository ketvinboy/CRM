package com.sunshine.Service;

import java.util.List;

import com.sunshine.Model.Logs;

public interface LogServiceI {

	public List<Logs> getALLLogRecordInfoList(Logs log);
	
	public int CountALLLogRecordInfos(Logs logs);
	
	public int SaveOrUpdateLogRecordInfo(Logs logs);
	
	public int deleteLogRecordInfo(String log_id);
}
