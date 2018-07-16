package com.sunshine.Service.Impl;

import java.sql.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;

import com.sunshine.Dao.YudingDaoMapper;
import com.sunshine.Model.Bookinfo;
import com.sunshine.Model.User;
import com.sunshine.Service.YudingServiceI;

@Service
public class YudingServiceImpl implements YudingServiceI{
	
	@Resource
	private YudingDaoMapper yudingDaoMapper;

	@Override
	public List<Bookinfo> getALLCustomerBookinfos(Bookinfo bookinfo) {
		
		return yudingDaoMapper.getALLCustomerBookinfos(bookinfo);
	}

	@Override
	public int CountALlCustomerBookInfos(Bookinfo bookinfo) {
		
		return yudingDaoMapper.CountALlCustomerBookInfos(bookinfo);
	}

	@Override
	public int SaveOrUpdateCustomerBookInfos(Bookinfo bookinfo) {
		Subject subject=SecurityUtils.getSubject();
		User user=(User) subject.getPrincipal();
		if(bookinfo.getBook_id()!=null && !bookinfo.getBook_id().equals("")){
			bookinfo.setCreate_time(new Date(System.currentTimeMillis()));
			 return yudingDaoMapper.updateCustomerBookInfos(bookinfo);
		}else{
			 bookinfo.setDeal_state("0");
			 bookinfo.setUser_id(user.getUser_id());
			 bookinfo.setCreate_time(new Date(System.currentTimeMillis()));
			 return yudingDaoMapper.saveCustomerBookInfos(bookinfo);
		}
	}

	@Override
	public int deleteCustomerBookInfos(String book_id) {
		
		return yudingDaoMapper.deleteCustomerBookInfos(book_id);
	}
}
