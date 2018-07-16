package com.sunshine.Controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.sun.jndi.url.dns.dnsURLContext;
import com.sunshine.Model.Document;
import com.sunshine.Service.DocumentServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MessageNotify;
import com.sunshine.Utils.Progress;

@Controller
@RequestMapping("/documentManager")
public class DocumentManagerController {
	
	@Autowired
	private DocumentServiceI documentServiceI;
	
	private DataGrid dataGrid=DataGrid.getDataGrid();
	private MessageNotify notify=MessageNotify.getMessageNotify();
	
	/**
	 * 返回文档管理的首页面
	 * @return
	 */
	@RequestMapping(value="/documentManager_index",method=RequestMethod.GET)
	public String DocumentManager_index(){
		
		return "client/DocumentManager";
	}
	/**
	 * 显示所有的文档列表
	 * @param page
	 * @param rows
	 * @param document
	 * @return
	 */
	@RequestMapping(value="/GetALlDocumentListRecord",method=RequestMethod.POST)
	@ResponseBody
	public DataGrid GetALlDocumentListRecord(int page,int rows,Document document){
		List<Document> documents=documentServiceI.findALLDocumentList(document);
		int total=documentServiceI.CountALLDocumentRecord(document);
		dataGrid.setRows(documents);
		dataGrid.setTotal(total);
		return dataGrid;
	}
    /**
     * 保存或更新客户文档记录信息
     * @param document
     * @return
     */
	@RequestMapping(value="/SaveOrUpdateDocumentReord",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify SaveOrUpdateDocumentReord(Document document){
		int total=documentServiceI.SaveOrUpdateDocument(document);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户文档记录成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户文当记录失败，请稍后重试！");
		}
		return notify;
	}
	/**
	 * 删除客户文档记录信息
	 * @param doc_id
	 * @return
	 */
	@RequestMapping(value="/deleteDocumentRecord",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify deleteDocumentRecord(HttpServletRequest request,String doc_id){
		int total=documentServiceI.deleteDocument(request,doc_id);
		if(total>0){
			notify.setSuccess(true);
			notify.setMsg("客户文档记录删除成功！");
		}else{
			notify.setSuccess(false);
			notify.setMsg("客户文档记录删除失败，请稍后重试！");
		}
		return notify;
	}
	/**
	 * 文档上传操作
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/uploadDocument",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify UploadDocument(@RequestParam("file") MultipartFile file,HttpServletRequest request,String doc_id){
		boolean flag=documentServiceI.uploadDocument(request,file,doc_id);
		if(flag){
			notify.setSuccess(true);
			notify.setMsg("文档上传成功！");
		}else{
			notify.setSuccess(flag);
			notify.setMsg("文档上传失败，请稍后重试！");
		}
		return notify;
	}
	/**
	 * 文件上传进度监听数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/GetFileUploadProgress",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Long> GetFileUploadProgress(HttpServletRequest request){
		Progress progress=(Progress) request.getSession().getAttribute("status");
		double value=((double)progress.getPByteRead()/(double)progress.getPContextLength())*100;
		long progressvalue=Math.round(value);
		Map<String, Long> progressMap=new HashMap<String, Long>();
		progressMap.put("value", progressvalue);
		return progressMap;
	}
	/**
	 * 文件下载操作
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/downloaddocument/{doc_id}",method=RequestMethod.GET)
	public void downloaddocument(@PathVariable String doc_id,HttpServletResponse response,HttpServletRequest request){
		Document document=documentServiceI.GetCustomerDocumentById(doc_id);
		String store_path=request.getSession().getServletContext().getRealPath("/")+document.getDoc_path();
		File file=new File(store_path);
		FileInputStream fis=null;
		BufferedInputStream bis=null;
		byte [] buff=new byte[1024];
		if(file.exists()){
			response.setContentType("application/force-download");
			response.addHeader("Content-Disposition", "attachment;fileName="+document.getDoc_name());
			try {
				fis=new FileInputStream(file);
				bis=new BufferedInputStream(fis);
				OutputStream os=response.getOutputStream();
				int i=bis.read(buff);
				while(i!=-1){
					os.write(buff,0,i);
					i=bis.read(buff);
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}
}
