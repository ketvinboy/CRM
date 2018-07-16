package com.sunshine.Service;

import java.util.List;
import java.util.Map;

import com.sunshine.Model.Customer;

public interface CustomerServiceI {

	public List<Customer> GetCustomerName();
	
	public List<Customer> findALLCustomerInfoRecord(Customer customer);
	
	public int CountALLCustomerInfoRecord(Customer customer);
	
	public int SaveOrUpdateCustomerInfo(Customer customer);
	
	public int deleteCustomerInfoRecord(String customer_id);

	public int UpdateCustomerAssign(Customer customer);

	public List<Map<String, Object>> GetSaleUserListMap();
}
