package com.sunshine.Service.Impl;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sunshine.Dao.DocumentDaoMapper;
import com.sunshine.Model.Document;
import com.sunshine.Model.User;
import com.sunshine.Service.DocumentServiceI;

@Service
public class DocumentServiceImpl implements DocumentServiceI {

	@Resource
	private DocumentDaoMapper documentDaoMapper;
	
	@Override
	public List<Document> findALLDocumentList(Document document) {
		
		return documentDaoMapper.findALLDocumentList(document);
	}

	@Override
	public int CountALLDocumentRecord(Document document) {
		
		return documentDaoMapper.CountALLDocumentRecord(document);
	}
   
	@Override
	public int SaveOrUpdateDocument(Document document) {
		if(document.getDoc_id()!=null && !document.getDoc_id().equals("")){
			document.setCreate_time(new Date(System.currentTimeMillis()));
			return documentDaoMapper.Updatedocument(document);
		}else{
			Subject subject=SecurityUtils.getSubject();
			User user=(User) subject.getPrincipal();
			document.setUser_id(user.getUser_id());
			document.setCreate_time(new Date(System.currentTimeMillis()));
			return documentDaoMapper.Savedocument(document);
		}
	}
	
	@Override
	public boolean uploadDocument(HttpServletRequest request, MultipartFile file,String doc_id) {
		if(file.isEmpty()){
			return false;
		}
		Document document=documentDaoMapper.GetCustomerDocumentById(doc_id);
		String Rel_path=request.getSession().getServletContext().getRealPath("/");
		String fileName=file.getOriginalFilename();
		String filesuffix=fileName.substring(fileName.lastIndexOf("."), fileName.length());
		String doc_name=UUID.randomUUID().toString()+filesuffix;
		String store_path="temp"+"/"+doc_name;
		File localFile=new File(Rel_path+store_path);
		if(!localFile.getParentFile().exists()){
			localFile.getParentFile().mkdirs();
		}
		try {
			file.transferTo(localFile);
			document.setDoc_path(store_path);
			document.setDoc_name(doc_name);
			documentDaoMapper.Updatedocument(document);
			return true;
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Document GetCustomerDocumentById(String doc_id) {
		
		return documentDaoMapper.GetCustomerDocumentById(doc_id);
	}

	@Override
	public int deleteDocument(HttpServletRequest request, String doc_id) {
		Document document=documentDaoMapper.GetCustomerDocumentById(doc_id);
		String store_path=request.getSession().getServletContext().getRealPath("/")+document.getDoc_path();
		File file=new File(store_path);
		if(file.exists()){
			file.delete();
		}
		return documentDaoMapper.deleteDocument(doc_id);
	}

}
