package com.sunshine.Utils;

import java.sql.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

import com.sunshine.Dao.YudingDaoMapper;
import com.sunshine.Model.Bookinfo;

public class BespokeUpdateJob implements Job {

	
	 YudingDaoMapper yudingDaoMapper=ApplicationContextHelper.getBean(YudingDaoMapper.class);
	 
	 JmsTemplate jmsTemplate=ApplicationContextHelper.getBean(JmsTemplate.class);
	
	 Destination destination=(Destination) ApplicationContextHelper.getBean("activeMQTopic");

	public BespokeUpdateJob(){
		
	}
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		List<Bookinfo> bookinfos=yudingDaoMapper.findCurrentYudingInfo(new Date(System.currentTimeMillis()));
		if(bookinfos!=null && bookinfos.size()>0){
			for(int i=0;i<bookinfos.size();i++){
				final Bookinfo bookinfo=bookinfos.get(i);
				bookinfo.setDeal_state("1");
				yudingDaoMapper.updateCustomerBookInfos(bookinfo);
				jmsTemplate.send(destination, new MessageCreator() {				
					@Override
					public Message createMessage(Session session) throws JMSException {
						TextMessage textMessage=session.createTextMessage(bookinfo.getBook_id());
						return textMessage;
					}
				});
			}
		}
	}

}
