package com.sunshine.Dao;

import java.util.List;

import com.sunshine.Model.Logs;

public interface LogDaoMapper {

	List<Logs> getALLLogRecordInfoList(Logs log);

	int CountALLLogRecordInfos(Logs logs);

	int updateLogsRecord(Logs logs);

	int saveLogsRecord(Logs logs);

	int deleteLogRecordInfo(String log_id);

}
