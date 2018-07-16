package com.sunshine.Service;

import java.util.List;

import com.sunshine.Model.Contact;

public interface ContactServiceI {

	public List<Contact> getALLCustomerContacts(Contact contact);
	
	public int CountALLCustomerContactsRecords(Contact contact);
	
	public int SaveOrUpdateCustomerContactInfo(Contact contact);
	
	public int deletCustomerContactInfo(String cont_id);
}
