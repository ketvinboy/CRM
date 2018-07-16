package com.sunshine.Service;

import java.util.List;

import com.sunshine.Model.Bookinfo;

public interface YudingServiceI {

	public List<Bookinfo> getALLCustomerBookinfos(Bookinfo bookinfo);
	
	public int CountALlCustomerBookInfos(Bookinfo bookinfo);
	
	public int SaveOrUpdateCustomerBookInfos(Bookinfo bookinfo);
	
	public int deleteCustomerBookInfos(String book_id);

}
