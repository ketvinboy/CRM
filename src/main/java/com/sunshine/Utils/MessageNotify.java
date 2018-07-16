package com.sunshine.Utils;

public class MessageNotify {
	
	private boolean success=false;
	private String  msg;
	
	private static class MessageNotifyClass{
		private static final MessageNotify notify=new MessageNotify();
	}

	public static MessageNotify getMessageNotify(){
		return MessageNotifyClass.notify;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
