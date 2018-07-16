<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script>
	var user_id=${admin.user_id};
	var role_id=${admin.role_id};
	$(function(){
		$('#search_doc_user_id').combobox({    
			          url:'${pageContext.request.contextPath}/CustomerManager/GetUserListMap',    
			   valueField:'id',    
			    textField:'text',
			  panelHeight:200  
			}); 
	});
	function caozuo5(value,row,index){
		var url="${pageContext.request.contextPath}/documentManager/downloaddocument/"+row.doc_id;
		if(user_id==row.user_id || role_id=="1"){
			return "<a href='javascript:void(0)' onclick='editdocRecord("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
					       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					   "<a href='javascript:void(0)' onclick='deletedocRecord("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>"+
					  	 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					   "<a href='javascript:void(0)' onclick='fileupload("+index+")'><img alt='文件上传' src='${pageContext.request.contextPath}/images/file_upload.png'></a>"+
					  	 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					   "<a href="+url+"><img alt='文件下载' src='${pageContext.request.contextPath}/images/down.png'></a>";
		}else{
			return "<a href="+url+"><img alt='文件下载' src='${pageContext.request.contextPath}/images/down.png'></a>";
		};	
	}
	function searchdoc(){
		var queryParam={};
		if($("#search_doc_start_date").val()!='' && $("#search_doc_end_date").val()!=''){
			queryParam={
						  user_id:$("#search_doc_user_id").val(), 
						cust_name:$("#search_doc_cust_name").val(),
						doc_title:$("#search_doc_title").val(),
				   doc_start_date:$("#search_doc_start_date").val(),
					 doc_end_date:$("#search_doc_end_date").val(),
						 doc_type:$("#search_doc_type").val(),
				};
		}else{
			queryParam={
						  user_id:$("#search_doc_user_id").val(),
						cust_name:$("#search_doc_cust_name").val(),
						doc_title:$("#search_doc_title").val(),
						 doc_type:$("#search_doc_type").val(),
				};
		}
		$('#documentManager_datagrid').datagrid({
					 url:'${pageContext.request.contextPath}/documentManager/GetALlDocumentListRecord',
			 queryParams: queryParam,			
		});	
	}
	function Newsdoc(){
		$('#doc_customer_id').combobox({    
			           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
			    valueField:'customer_id',    
			     textField: 'cust_name' ,
			   panelHeight:150,
		}); 
		$('#NewdocumentForm').form('clear');
		$('#Updatedocument_dialog').dialog('open').dialog('setTitle','新增文档');
	}
	function SaveOrUpdateDocReord(){
		$.messager.progress(); 
		$('#NewdocumentForm').form('submit', {    
			        url:'${pageContext.request.contextPath}/documentManager/SaveOrUpdateDocumentReord',       
			    success:function(data){    
			   		$.messager.progress('close'); 			
			        var obj=$.parseJSON(data);
			        if(obj.success){
			        	$('#Updatedocument_dialog').dialog('close');
			        	$('#documentManager_datagrid').datagrid('reload');
			        	$.messager.show({
								title:'系统提示',
								  msg:obj.msg,
							 showType:'show',
								style:{
									right:'',
									top:document.body.scrollTop+document.documentElement.scrollTop,
									bottom:''
								}
							});        	
			        }else{
			        	$('#Updatedocument_dialog').dialog('close');
			        	$.messager.show({
								title:'系统提示',
								  msg:obj.msg,
							 showType:'show',
								style:{
									right:'',
									top:document.body.scrollTop+document.documentElement.scrollTop,
									bottom:''
								}
							});        	
			        }  
			    }    
			});  
	}
	function editdocRecord(rowindex){
				$('#documentManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#documentManager_datagrid').datagrid('getSelected');
		if(row){
			$('#doc_customer_id').combobox({    
				           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
				    valueField:'customer_id',    
				     textField: 'cust_name' ,
				   panelHeight:150,
			}); 
			$('#NewdocumentForm').form('clear');
			$('#NewdocumentForm').form('load',row);
			$('#Updatedocument_dialog').dialog('open').dialog('setTitle','编辑文档资料');
		}
	} 
	function deletedocRecord(rowindex){
				$('#documentManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#documentManager_datagrid').datagrid('getSelected');
		if(row){
			$.messager.confirm('系统提示','您确认要删除'+row.create_time+'和'+row.cust_name+'签订的'+row.doc_title+'记录吗？',function(r){    
			    if (r){    
			        $.ajax({
			        	 url:'${pageContext.request.contextPath}/documentManager/deleteDocumentRecord',
			        	type:"post",
			        dataType:'json',
			        	data:{
			        		doc_id:row.doc_id
			        	},
			      beforeSend:function(){
			        	$.messager.progress(); 
			        	},
			        	success:function(data){
			        	$.messager.progress('close'); 
			        		if(data.success){
			        			$('#documentManager_datagrid').datagrid('reload');
					        	$.messager.show({
										title:'系统提示',
										  msg:data.msg,
									 showType:'show',
										style:{
											right:'',
											top:document.body.scrollTop+document.documentElement.scrollTop,
											bottom:''
										}
									});     
			        		}else{
					        	$.messager.show({
										title:'系统提示',
										  msg:data.msg,
									 showType:'show',
										style:{
											right:'',
											top:document.body.scrollTop+document.documentElement.scrollTop,
											bottom:''
										}
									});     
			        		}
			        	},
			        	error:function(){
			        		alert("出错了，请联系管理员！");
			        	}		        
			        });   
			    }    
			}); 
		}
	}
	function fileupload(rowindex){
		$('#documentManager_datagrid').datagrid('selectRow',rowindex);
		$('#Upload_documentForm').form('clear');
		$('#uploaddocument_dialog').dialog('open');
	}
	function UploadDocument(){
	   var row=$('#documentManager_datagrid').datagrid('getSelected');
	   $("#doc_id").val(row.doc_id);
	   $('#uploaddocument_dialog').dialog('close');
	   $('#uploadprogress_dialog').dialog('open');
	   $('#file_progress').progressbar('setValue', 0); 
	   var time=setInterval("progressListener()",1000);
	   $('#Upload_documentForm').form('submit', {    
			            url:'${pageContext.request.contextPath}/documentManager/uploadDocument',		        			
			        success:function(data){    
			           clearInterval(time);
			           var obj=$.parseJSON(data);
			           $('#uploadprogress_dialog').dialog('close');
			           if(obj.success){
				           	$.messager.show({
											title:'系统提示',
											  msg:obj.msg,
										 showType:'show',
											style:{
												right:'',
												top:document.body.scrollTop+document.documentElement.scrollTop,
												bottom:''
											}
										});     
			           }else{
			           		$.messager.show({
										title:'系统提示',
										  msg:obj.msg,
									 showType:'show',
										style:{
											right:'',
											top:document.body.scrollTop+document.documentElement.scrollTop,
											bottom:''
										}
									});     
			           }
			    }    
			}); 
			
	}
	function progressListener(){
		 $.ajax({
		 	    url:'${pageContext.request.contextPath}/documentManager/GetFileUploadProgress',
		 	   type:"post",
		 	success:function(data){
		 		var obj=$.parseJSON(data);
		 		var value = $('#file_progress').progressbar('getValue'); 
		 		if(value<100){
		 			$('#file_progress').progressbar('setValue', obj.value); 
		 		}
		 	}
		 });
	}
</script>
<div style="margin: 10px">
<table id="documentManager_datagrid" title="文档管理" class="easyui-datagrid" style="width:960px;height:500px"   
      			  data-options="url:'${pageContext.request.contextPath}/documentManager/GetALlDocumentListRecord',
      			  		 fitColumns:true,
      			  	   singleSelect:true,
      			  	       striped:true,
      			  	    pagination:true,     			  
      			  	      pageList:['10','20','30','40','50'],      			  	      
      			  	       toolbar:'#documentManager_tools'    			  	   
      			  	   ">   
    <thead>   
        <tr>   
            <th data-options="field:'doc_id',width:80,align:'center'">文档编号</th>   
            <th data-options="field:'doc_title',width:100,align:'center'">标题</th>   
            <th data-options="field:'cust_name',width:180,align:'center'">客户名称</th>   
            <th data-options="field:'doc_type',width:100,align:'center',formatter:function(value,row,index){
            	if(row.doc_type=='1'){return '合同'};
            	if(row.doc_type=='2'){return '订单'};
            }">文档类型</th>  
            <th data-options="field:'create_time',width:100,align:'center'">创建日期</th>            
            <th data-options="field:'caozuo5',width:180,align:'center',formatter:function(value,row,index){
            	 return caozuo5(value,row,index);
            }">相关操作</th>  
        </tr>   
    </thead>   
</table>
<div id="documentManager_tools" style="padding: 5px;" >
		<div class="fitem" >
			指&nbsp;派&nbsp;&nbsp;人：&nbsp; <input id="search_doc_user_id"  style="width:250px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   客户名称：&nbsp;<input id="search_doc_cust_name"  name="cust_name" class="easyui-textbox" style="width:250px">(支持模糊查询)
		</div>
		<div class="fitem">
		 	标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：&nbsp;
		 	<input id="search_doc_title"  name="doc_title" class="easyui-textbox" style="width:250px">
		 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			创建日期：<input id="search_doc_start_date" name="doc_start_date" class= "easyui-datebox" ></input>
						-
					 <input id="search_doc_end_date"  name="doc_end_date"   class="easyui-datebox" ></input>
		</div>
		<div class="fitem">
			类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：&nbsp;
			<select  id="search_doc_type" data-options="panelHeight:100" title="全部" class="easyui-combobox" name="doc_type" style="width:250px;">   
				    <option value="">选择类型</option> 
				    <option value="1">合同</option>   
				    <option value="2">订单</option> 		
				</select> 
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdoc()">查询文档</a>  
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="Newsdoc()">新增文档</a>    
		</div>
</div>
<!-- 新增文档对话框 -->
<div id="Updatedocument_dialog" class="easyui-dialog"  style="width:500px;height:380px;padding: 10px;"   
         data-options="iconCls:'icon-admin',resizable:true,modal:true,buttons:'#Updatedocument_buttons',closed:true,closable:false">   
   <div class="ftitle">新增/编辑客户文档界面 </div>
   <form id="NewdocumentForm" method="post">
	   <div class="fitem" style="text-align: center;">
	   		<input type="hidden" name="doc_id">
	   		客&nbsp;户&nbsp;名&nbsp;称：<input id="doc_customer_id" name="customer_id" style="width:250px;">    
	   </div>
	   <div class="fitem" style="text-align: center;">
	   	          标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题： <input  name="doc_title" class="easyui-textbox" style="width:250px"></input>
	   </div>
	   <div class="fitem" style="text-align: center;">
	   	          描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述： <input  name="doc_describe" class="easyui-textbox" style="width:250px;height: 120px;" data-options="multiline:true"></input>
	   </div>
	   <div class="fitem" style="text-align: center;">
	   		文&nbsp;档&nbsp;类&nbsp;型:&nbsp;&nbsp;
	   		<select class="easyui-combobox" name="doc_type" style="width:250px;" data-options="panelHeight:100">   
					   <option value="1">合同</option>   
					   <option value="2">订单</option>      			
			</select>  
	   </div>
   </form>
</div> 
<div id="Updatedocument_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SaveOrUpdateDocReord()">保存文档</a>
	<a href="javascript:$('#Updatedocument_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div>
<!-- 上传相关文档对话框 -->
<div id="uploaddocument_dialog" title="客户文档上传界面" class="easyui-dialog" style="width:500px;height:220px;padding: 15px;"   
          data-options="iconCls:'icon-upload',resizable:true,modal:true,buttons:'#uploaddocument',closed:true,closable:false">   
      <div class="ftitle">客户文档记录上传界面 </div>
      <form id="Upload_documentForm" method="post" enctype="multipart/form-data">
	      <div class="fitem" style="padding-top: 15px" >
	      		<font style="font-weight: bolder;font-family: '宋体';font-size: 18px;">选择上传文件:</font>
	      		<input type="hidden" name="doc_id" id="doc_id">
		   		<input class="easyui-filebox" id="file"  name="file" style="width:300px" data-options="buttonText:'选择文件',buttonIcon:'icon-upload'">
		   </div>
	   </form>
</div>
<div id="uploaddocument">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="UploadDocument()">上传</a>
	<a href="javascript:$('#uploaddocument_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div> 
<!-- 文件上传进度条显示 -->
<div id="uploadprogress_dialog" title="文件上传进度界面" class="easyui-dialog" style="width:400px;height:150px;padding: 15px;"   
          data-options="iconCls:'icon-upload',resizable:true,modal:true,closed:true,closable:false">   
      <div class="ftitle">文档上传进度监控界面</div>
      <div class="fitem">
      		<div id="file_progress" class="easyui-progressbar" data-options="value:0" style="width:350px;"></div>
      </div>
</div>
</div>