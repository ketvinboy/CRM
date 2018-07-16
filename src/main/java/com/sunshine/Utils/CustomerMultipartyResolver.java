package com.sunshine.Utils;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.sunshine.Controller.ProgressListener;

public class CustomerMultipartyResolver  extends CommonsMultipartResolver{
	
	@Autowired
	private ProgressListener progressListener;

	public void setProgressListener(ProgressListener progressListener) {
		this.progressListener = progressListener;
	}
	
	@Override
	protected MultipartParsingResult parseRequest(HttpServletRequest request)
			throws MultipartException {
		String encoding=determineEncoding(request);
		FileUpload fileUpload=prepareFileUpload(encoding);
		progressListener.setSession(request.getSession());
		fileUpload.setProgressListener(progressListener);
		List<FileItem> fileItems;
		try {
			fileItems = ((ServletFileUpload)fileUpload).parseRequest(request);
			return parseFileItems(fileItems, encoding);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		   return null;
	}

}
