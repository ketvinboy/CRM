package com.sunshine.Utils;

public class Progress {

	private long PByteRead;      //到目前为止读取的文件比特数
	private long PContextLength;//文件的总长度
	private long PItems;        //目前正在读取第几个文件
	
	public long getPByteRead() {
		return PByteRead;
	}
	public void setPByteRead(long pByteRead) {
		PByteRead = pByteRead;
	}
	public long getPContextLength() {
		return PContextLength;
	}
	public void setPContextLength(long pContextLength) {
		PContextLength = pContextLength;
	}
	public long getPItems() {
		return PItems;
	}
	public void setPItems(long pItems) {
		PItems = pItems;
	}
	
	
}
