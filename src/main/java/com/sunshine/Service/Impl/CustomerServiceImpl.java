package com.sunshine.Service.Impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sunshine.Dao.CustomerDaoMapper;
import com.sunshine.Dao.UserDaoMapper;
import com.sunshine.Model.Customer;
import com.sunshine.Model.User;
import com.sunshine.Service.CustomerServiceI;

@Service
public class CustomerServiceImpl implements CustomerServiceI {

	@Resource
	private CustomerDaoMapper customerDaoMapper;
	
	@Resource
	private UserDaoMapper userDaoMapper;
	
	@Override
	public List<Customer> GetCustomerName() {
		
		return customerDaoMapper.GetCustomerName();
	}

	@Override
	public List<Customer> findALLCustomerInfoRecord(Customer customer) {
		
		return customerDaoMapper.findALLCustomerInfoRecord(customer);
	}

	@Override
	public int CountALLCustomerInfoRecord(Customer customer) {
		
		return customerDaoMapper.CountALLCustomerInfoRecord(customer);
	}

	@Override
	public int SaveOrUpdateCustomerInfo(Customer customer) {
		if(customer.getCustomer_id()!=null && !customer.getCustomer_id().equals("")){
			customer.setCreate_time(new Date(System.currentTimeMillis()));
			return customerDaoMapper.updateCustomerInfo(customer);
		}else{
			customer.setCreate_time(new Date(System.currentTimeMillis()));
			return customerDaoMapper.saveCustomerInfo(customer);
		}
	}

	@Override
	public int deleteCustomerInfoRecord(String customer_id) {
		
		return customerDaoMapper.deleteCustomerInfoRecord(customer_id);
	}

	@Override
	public int UpdateCustomerAssign(Customer customer) {
		
		return customerDaoMapper.UpdateCustomerAssign(customer);
	}

	@Override
	public List<Map<String, Object>> GetSaleUserListMap() {
		List<Map<String, Object>> lMaps=new ArrayList<Map<String,Object>>();
		List<User> salelistUsers=userDaoMapper.findAllSaleUserList();
		if(salelistUsers!=null&& salelistUsers.size()>0){
			for(int i=0;i<salelistUsers.size();i++){
				User user=salelistUsers.get(i);
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("id", user.getUser_id());
				map.put("text", user.getUser_name());
				lMaps.add(map);
			}
		}
		return lMaps;
	}

}
