package com.sunshine.Dao;

import java.util.List;

import com.sunshine.Model.Customer;

public interface CustomerDaoMapper {

	public List<Customer> GetCustomerName();

	public int updateCustomerInfo(Customer customer);

	public int saveCustomerInfo(Customer customer);

	public int CountALLCustomerInfoRecord(Customer customer);

	public List<Customer> findALLCustomerInfoRecord(Customer customer);

	public int deleteCustomerInfoRecord(String customer_id);

	public int UpdateCustomerAssign(Customer customer);

}
