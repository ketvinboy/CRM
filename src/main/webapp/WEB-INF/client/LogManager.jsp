<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script>
var user_id=${admin.user_id};
var role_id=${admin.role_id};
	function caozuo6(value,row,index){
		if(user_id==row.user_id || role_id=="1"){
			return "<a href='javascript:void(0)' onclick='editLogRecord("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
				       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
			    	"<a href='javascript:void(0)' onclick='deleteLogRecord("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>"+
				  	 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
				   "<a href='javascript:void(0)' onclick='viewLogRecord("+index+")'><img alt='查看' src='${pageContext.request.contextPath}/images/view.png'></a>";
		}else{
			return  "<a href='javascript:void(0)' onclick='viewLogRecord("+index+")'><img alt='查看' src='${pageContext.request.contextPath}/images/view.png'></a>";
		}
	}
	function searchLog(){
		var queryParam={};
		if($("#search_log_start_date").val()!='' && $("#search_log_end_date").val()!=''){
			queryParam={				 
						cust_name:$("#search_log_cust_name").val(),					
				   log_start_date:$("#search_log_start_date").val(),
					 log_end_date:$("#search_log_end_date").val(),					
				};
		}else{
			queryParam={			
						cust_name:$("#search_log_cust_name").val(),					
				};
		}
		$('#LogManager_datagrid').datagrid({
					 url:'${pageContext.request.contextPath}/LogManager/GetALlLogListRecord',
			 queryParams: queryParam,			
		});	
	}
	function NewsLog(){
		$('#log_customer_id').combobox({    
			           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
			    valueField:'customer_id',    
			     textField: 'cust_name' ,
			   panelHeight:150,
		}); 
		$('#NewLogForm').form('clear');
		$('#log_save').css('display','');
		document.getElementById("tip").innerHTML='新增/编辑日志界面';
		$('#UpdateLog_dialog').dialog('open').dialog('setTitle','新增日志');
	}
	function SaveOrUpdateLogReord(){
		$.messager.progress(); 
		$('#NewLogForm').form('submit', {    
			        url:'${pageContext.request.contextPath}/LogManager/SaveOrUpdateLogReord',       
			    success:function(data){    
			   		$.messager.progress('close'); 			
			        var obj=$.parseJSON(data);
			        if(obj.success){
			        	$('#UpdateLog_dialog').dialog('close');
			        	$('#LogManager_datagrid').datagrid('reload');
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
			        	$('#UpdateLog_dialog').dialog('close');
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
	function editLogRecord(rowindex){
				$('#LogManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#LogManager_datagrid').datagrid('getSelected');
		if(row){
			$('#log_customer_id').combobox({    
				           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
				    valueField:'customer_id',    
				     textField: 'cust_name' ,
				   panelHeight:150,
			}); 
			$('#NewLogForm').form('clear');
			$('#NewLogForm').form('load',row);
			$('#log_save').css('display','');
			document.getElementById("tip").innerHTML='新增/编辑日志界面';
			$('#UpdateLog_dialog').dialog('open').dialog('setTitle','编辑日志');
		}
	} 
	function viewLogRecord(rowindex){
				$('#LogManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#LogManager_datagrid').datagrid('getSelected');
		if(row){
			$('#log_customer_id').combobox({    
				           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
				    valueField:'customer_id',    
				     textField: 'cust_name' ,
				   panelHeight:150,
			}); 
			$('#NewLogForm').form('clear');
			$('#NewLogForm').form('load',row);
			document.getElementById("tip").innerHTML='查看和'+row.cust_name+'相关的日志记录信息';
			$('#UpdateLog_dialog').dialog('open').dialog('setTitle','查看日志记录信息');
			$('#log_save').css('display','none');
		}
	}
	function deleteLogRecord(rowindex){
				$('#LogManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#LogManager_datagrid').datagrid('getSelected');
		if(row){
			$.messager.confirm('系统提示','您确认要删除'+row.create_time+'记录的和'+row.cust_name+'关于'+row.log_title+'的日志记录吗？',function(r){    
			    if (r){    
			        $.ajax({
			        	 url:'${pageContext.request.contextPath}/LogManager/deleteLogRecord',
			        	type:"post",
			        dataType:'json',
			        	data:{
			        		log_id:row.log_id
			        	},
			      beforeSend:function(){
			        	$.messager.progress(); 
			        	},
			        	success:function(data){
			        	$.messager.progress('close'); 
			        		if(data.success){
			        			$('#LogManager_datagrid').datagrid('reload');
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
</script>
<div style="margin: 10px">
<table id="LogManager_datagrid" title="日志管理" class="easyui-datagrid" style="width:960px;height:500px"   
      			  data-options="url:'${pageContext.request.contextPath}/LogManager/GetALlLogListRecord',
      			  		 fitColumns:true,
      			  	   singleSelect:true,
      			  	       striped:true,
      			  	    pagination:true,     			  
      			  	      pageList:['10','20','30','40','50'],      			  	      
      			  	       toolbar:'#logManager_tools'    			  	   
      			  	   ">   
    <thead>   
        <tr>   
            <th data-options="field:'log_id',width:80,align:'center'">日志编号</th>   
            <th data-options="field:'log_title',width:100,align:'center'">标题</th>   
            <th data-options="field:'cust_name',width:180,align:'center'">客户名称</th>   
            <th data-options="field:'user_name',width:100,align:'center'">指派人</th>  
            <th data-options="field:'create_time',width:100,align:'center'">创建日期</th>            
            <th data-options="field:'caozuo6',width:150,align:'center',formatter:function(value,row,index){
            	 return caozuo6(value,row,index);
            }">相关操作</th>  
        </tr>   
    </thead>   
</table>
<div id="logManager_tools" style="padding: 5px;" >
		<div class="fitem" >
			客户名称：<input id="search_log_cust_name"  class="easyui-textbox" style="width:250px">(支持模糊查询)
		</div>
		<div class="fitem">
			创建日期：<input id="search_log_start_date"  class= "easyui-datebox" ></input>
						-
					 <input id="search_log_end_date"    class="easyui-datebox" ></input>
		    <a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchLog()">查询日志</a>  
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="NewsLog()">新增日志</a>   
		</div>			 
</div>
<!-- 新增日志对话框 -->
<div id="UpdateLog_dialog" class="easyui-dialog"  style="width:500px;height:380px;padding: 10px;"   
         data-options="iconCls:'icon-rz',resizable:true,modal:true,buttons:'#UpdateLog_buttons',closed:true,closable:false">   
   <div class="ftitle" id="tip">新增/编辑日志界面 </div>
   <form id="NewLogForm" method="post">
	   <div class="fitem" style="text-align: center;">
	   		<input type="hidden" name="log_id">
	   		客&nbsp;户&nbsp;名&nbsp;称：<input id="log_customer_id" name="cust_id" style="width:250px;">    
	   </div>
	   <div class="fitem" style="text-align: center;">
	   	          标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题： 
	   	     <input  name="log_title" class="easyui-textbox" style="width:250px"></input>
	   </div>
	   <div class="fitem" style="text-align: center;">
	   	          描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述： 
	   	     <input id="log_desc"  name="log_desc" class="easyui-textbox" style="width:250px;height: 120px;" data-options="multiline:true"></input>
	   </div>
   </form>
</div> 
<div id="UpdateLog_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-rz'" id="log_save" onclick="SaveOrUpdateLogReord()">保存</a>
	<a href="javascript:$('#UpdateLog_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div>
</div>