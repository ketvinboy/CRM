package com.sunshine.Dao;

import java.util.List;

import com.sunshine.Model.Contact;

public interface ContactDaoMapper {

	int deletCustomerContactInfo(String cont_id);

	int saveCustomerContactInfo(Contact contact);

	int updateCustomerContactInfo(Contact contact);

	int CountALLCustomerContactsRecords(Contact contact);

	List<Contact> getALLCustomerContacts(Contact contact);

}
