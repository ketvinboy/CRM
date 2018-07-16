package com.sunshine.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.sunshine.Model.Document;

public interface DocumentServiceI {

	public List<Document> findALLDocumentList(Document document);
	
	public int CountALLDocumentRecord(Document document);
	
	public int SaveOrUpdateDocument(Document document);
	
	public int deleteDocument(HttpServletRequest request,String doc_id);

	public boolean uploadDocument(HttpServletRequest request, MultipartFile file,String doc_id);

	public Document GetCustomerDocumentById(String doc_id);
}
