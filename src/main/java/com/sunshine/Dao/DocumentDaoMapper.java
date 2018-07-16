package com.sunshine.Dao;

import java.util.List;

import com.sunshine.Model.Document;

public interface DocumentDaoMapper {

	List<Document> findALLDocumentList(Document document);

	int CountALLDocumentRecord(Document document);

	int Updatedocument(Document document);

	int Savedocument(Document document);

	int deleteDocument(String doc_id);

	Document GetCustomerDocumentById(String doc_id);

}
