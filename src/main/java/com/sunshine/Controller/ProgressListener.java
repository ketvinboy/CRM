package com.sunshine.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.sunshine.Utils.Progress;

@Component
public class ProgressListener implements org.apache.commons.fileupload.ProgressListener{

	private HttpSession session;
	
	public void setSession(HttpSession session) {
		this.session = session;
		Progress status=new Progress();
		session.setAttribute("status", status);
	}

	@Override
	public void update(long PByteRead, long PContextLength, int PItems) {
		Progress status=(Progress) session.getAttribute("status");
		try {
			Thread.sleep(5);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		status.setPByteRead(PByteRead);
		status.setPContextLength(PContextLength);
		status.setPItems(PItems);
	}

}
