package com.sunshine.Utils;

import javax.annotation.Resource;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.sunshine.Dao.YudingDaoMapper;
import com.sunshine.Model.Bookinfo;

public class EmailSendServer implements MessageListener {

	@Resource
	private YudingDaoMapper yudingDaoMapper;
	
	@Autowired
	private SimpleMailMessage simpleMailMessage;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Override
	public void onMessage(Message message) {
		TextMessage textMessage=(TextMessage) message;
		try {
			String book_id=textMessage.getText();
			Bookinfo bookinfo=yudingDaoMapper.getBookcustomerInfo(book_id);
			simpleMailMessage.setSubject("客户预约到期通知");
			simpleMailMessage.setTo(bookinfo.getUser_qq());
			String text="预约时间："+bookinfo.getBook_time()+"||预约客户："+bookinfo.getCust_name()+"||预约内容："+bookinfo.getTitle();
			simpleMailMessage.setText(text);
			javaMailSender.send(simpleMailMessage);		
		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
