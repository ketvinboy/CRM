package com.sunshine.Dao;

import java.sql.Date;
import java.util.List;

import com.sunshine.Model.Bookinfo;

public interface YudingDaoMapper {

	List<Bookinfo> getALLCustomerBookinfos(Bookinfo bookinfo);

	int CountALlCustomerBookInfos(Bookinfo bookinfo);

	int updateCustomerBookInfos(Bookinfo bookinfo);

	int saveCustomerBookInfos(Bookinfo bookinfo);

	int deleteCustomerBookInfos(String book_id);

	List<Bookinfo> findCurrentYudingInfo(Date book_time);

	Bookinfo getBookcustomerInfo(String book_id);

}
