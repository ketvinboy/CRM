package com.sunshine.Service.Impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sunshine.Dao.ContactDaoMapper;
import com.sunshine.Model.Contact;
import com.sunshine.Service.ContactServiceI;

@Service
public class ContactServiceImpl implements ContactServiceI{

	@Resource
	private ContactDaoMapper contactDaoMapper;
	
	@Override
	public List<Contact> getALLCustomerContacts(Contact contact) {
		
		return contactDaoMapper.getALLCustomerContacts(contact);
	}

	@Override
	public int CountALLCustomerContactsRecords(Contact contact) {
		
		return contactDaoMapper.CountALLCustomerContactsRecords(contact);
	}

	@Override
	public int SaveOrUpdateCustomerContactInfo(Contact contact) {
		if(contact.getCont_id()!=null && !contact.getCont_id().equals("")){
			contact.setCreate_time(new java.sql.Date(System.currentTimeMillis()));
			return contactDaoMapper.updateCustomerContactInfo(contact);
		}else{
			contact.setCreate_time(new java.sql.Date(System.currentTimeMillis()));
			return contactDaoMapper.saveCustomerContactInfo(contact);
		}
	}

	@Override
	public int deletCustomerContactInfo(String cont_id) {
		
		return contactDaoMapper.deletCustomerContactInfo(cont_id);
	}

}
