<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
var role_id=${admin.role_id};
var user_id=${admin.user_id};
	$(function(){	
		$('#search_customer_user_id').combobox({    
			          url:'${pageContext.request.contextPath}/CustomerManager/GetUserListMap',    
			   valueField:'id',    
			    textField:'text',
			  panelHeight:200  
			}); 
	});
	function NewsCustomer(){
	    var user_id=${admin.user_id};
		$('#NewCustomerForm').form('clear');
		$('#user_id').textbox('setValue',user_id);
		$('#Newcustomer_dialog').dialog('open').dialog('setTitle','新增客户资料');
	}
	function caozuo3(value,row,index){
		if(role_id=="1"){
			return "<a href='#' onclick='editCustomerInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
					        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					        "<a href='#' onclick='deleteCustomerInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>"+
					  	    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					       "<a href='#' onclick='tszp("+index+")'><img alt='约定指派' src='${pageContext.request.contextPath}/images/zhipei.png'></a>";
		}
		else if(role_id=="2"){
				if(user_id==row.user_id && role_id==row.role_id){
					return "<a href='#' onclick='editCustomerInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
					        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					       "<a href='#' onclick='deleteCustomerInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>"+
					  	   "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					      "<a href='#' onclick='tszp("+index+")'><img alt='约定指派' src='${pageContext.request.contextPath}/images/zhipei.png'></a>";	
					    }
				else if(row.role_id=="3"){
						return "<a href='#' onclick='editCustomerInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
					        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					         "<a href='#' onclick='deleteCustomerInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>"+
					  	     "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
					        "<a href='#' onclick='tszp("+index+")'><img alt='约定指派' src='${pageContext.request.contextPath}/images/zhipei.png'></a>";	
				  }
				  else{
				    	return "";
				    }    
		 }
		 else{
			return "<a href='#' onclick='editCustomerInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
			       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
			      "<a href='#' onclick='deleteCustomerInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>";
		}
	}
	function editCustomerInfo(rowindex){
				$('#CustomerManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#CustomerManager_datagrid').datagrid('getSelected');
		if(row){
			$('#NewCustomerForm').form('clear');
			$('#NewCustomerForm').form('load',row);
			$('#Newcustomer_dialog').dialog('open').dialog('setTitle','编辑客户资料');
		};
	}
	function deleteCustomerInfo(rowindex){
				$('#CustomerManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#CustomerManager_datagrid').datagrid('getSelected');
		if(row){
			$.messager.confirm('温馨提示','您确认想要删除'+row.cust_name+'该条记录信息吗？',function(r){    
			    if (r){    
			       	$.ajax({
			       		url:'${pageContext.request.contextPath}/CustomerManager/deleteCustomerInfo',
			       		type:"post",
			       		dataType:'json',
			       		data:{
			       			customer_id:row.customer_id
			       		},
			       		success:function(data){
			       			if(data.success){
			       				$('#CustomerManager_datagrid').datagrid('reload');
					       		$.messager.show({
										title:'系统提示',
										  msg:data.msg,
									 showType:'show',
									  timeout:3000,									 
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
									 timeout:5000,									 
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
			    };   
			});
		};
	}
	function SaveOrUpdateCustomerInfo(){ 
		$.messager.progress();	// 显示进度条
		$('#NewCustomerForm').form('submit', {    
		   		url:'${pageContext.request.contextPath}/CustomerManager/SaveOrUpdateCustomerInfo',    
		    success:function(data){   
		    $.messager.progress('close');	// 显示进度条 
		       var obj=$.parseJSON(data);
		       if(obj.success){
		       		$('#Newcustomer_dialog').dialog('close');
		       		$('#CustomerManager_datagrid').datagrid('reload');
		       		$.messager.show({
							title:'系统提示',
							  msg:obj.msg,
						  timeout:3000,
						 showType:'show',
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							}
						}); 		
		       }else{
		       		$('#Newcustomer_dialog').dialog('close');
		       		$.messager.show({
							title:'系统提示',
							  msg:obj.msg,
						 showType:'show',
						  timeout:5000,						 
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							}
						}); 		
		       };
		    }
		}); 
	}
	function searchCustomer(){
		$('#CustomerManager_datagrid').datagrid({
				url:'${pageContext.request.contextPath}/CustomerManager/GetALLCustomerInfoRecord',
		queryParams: {
				cust_name:$("#search_customer_cust_name").val(),
				  user_id:$("#search_customer_user_id").val(),
		  cust_background:$("#search_customer_cust_background").val(),
				   listed:$("#search_customer_listed").val(),
				cust_type:$("#search_customer_cust_type").val(),
				   status:$("#search_customer_status").val()
				}		
		});
	}
	function tszp(rowindex){
				$('#CustomerManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#CustomerManager_datagrid').datagrid('getSelected');
		if(row){
				$('#zp_user_id').combobox({    
					    url:'${pageContext.request.contextPath}/CustomerManager/GetSaleUserListMap',    
					   valueField:'id',    
					    textField:'text',
					  panelHeight:200,  
				});  
				$('#AssginCustomerForm').form('clear');
				$('#AssginCustomerForm').form('load',row);
				if(row.role_id=="2" || row.role_id=="1"){
					$('#zp_user_id').combobox('setValue',"请选择指派人");
				}else{
					$('#zp_user_id').combobox('setValue',row.user_id);
				}
				$('#Assign_dialog').dialog('open');
		};
	}
	function CustomerAssign(){
		$.messager.progress();	// 显示进度条
		$('#AssginCustomerForm').form('submit', {    
		   		url:'${pageContext.request.contextPath}/CustomerManager/UpdateCustomerAssign',    
		    success:function(data){ 
		       $.messager.progress('close');//隐藏进度条	   
		       var obj=$.parseJSON(data);
		       if(obj.success){
		       		$('#Assign_dialog').dialog('close');
		       		$('#CustomerManager_datagrid').datagrid('reload');
		       		$.messager.show({
							title:'系统提示',
							  msg:obj.msg,
						 showType:'show',
						  timeout:3000,						
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:'',
							}
						}); 		
		       }else{
		       		$('#Assign_dialog').dialog('close');
		       		$.messager.show({
							title:'系统提示',
							  msg:obj.msg,
						 showType:'show',
						  timeout:5000,						
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:'',
							}
						}); 		
		       }
		    }    
		}); 
	}
</script>
<div style="margin: 10px">
<table id="CustomerManager_datagrid" title="客户管理" class="easyui-datagrid" style="width:960px;height:500px"   
      			  data-options="url:'${pageContext.request.contextPath}/CustomerManager/GetALLCustomerInfoRecord',
      			  		 fitColumns:true,
      			  	   singleSelect:true,
      			  	       striped:true,
      			  	    pagination:true,    			  	    
      			  	      pageList:['10','20','30','40','50'],
      			  	      checkbox:true,
      			  	      toolbar: '#CustomerManager_tools'    			  	   
      			  	   ">   
    <thead>   
        <tr>   
            <th data-options="field:'customer_id',width:80,align:'center'">客户编号</th>   
            <th data-options="field:'cust_name',width:180,align:'center'">客户名称</th>   
            <th data-options="field:'user_name',width:100,align:'center'">指派人</th>   
            <th data-options="field:'create_time',width:150,align:'center'">创建时间</th>  
            <th data-options="field:'status',width:100,align:'center',formatter: function(value,row,index){
			 	if(row.status=='1'){return '潜在客户'};
			 	if(row.status=='2'){return '正式客户'};
			 	if(row.status=='3'){return '放弃客户'};
			 	if(row.status=='4'){return '签约客户'};
			 }">客户状态</th>   
            <th data-options="field:'caozuo3',width:150,align:'center',formatter: function(value,row,index){
            	return caozuo3(value,row,index);
            }">相关操作</th>  
        </tr>   
    </thead>   
</table>
<div id="CustomerManager_tools" style="padding: 5px;" >
		<div class="fitem" >
			客&nbsp;户&nbsp;名&nbsp;称：&nbsp;<input id="search_customer_cust_name"  name="cust_name" class="easyui-textbox" style="width:200px">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<c:choose>
				<c:when test="${admin.role_id==3}"></c:when>
				<c:otherwise>
				      指&nbsp;&nbsp;派&nbsp;&nbsp;人&nbsp;&nbsp;：&nbsp;<input  id="search_customer_user_id" name="user_id"  style="width:200px;"> 
				</c:otherwise>
			</c:choose>					  				        
		</div>
		<div class="fitem">
		       背&nbsp;户&nbsp;背&nbsp;景：
		   <select  class="easyui-combobox" id="search_customer_cust_background" data-options="panelHeight:250" name="cust_background" style="width:200px;">   
				    <option value="">全部</option> 
				    <option value="1">民营</option>   
				    <option value="2">国营</option>      
				    <option value="3">合资</option>  
			</select>  
			&nbsp;&nbsp;&nbsp;&nbsp;
			是&nbsp;否&nbsp;上&nbsp;市：
			<select  class="easyui-combobox" id="search_customer_listed" data-options="panelHeight:200" name="listed" style="width:200px;">   
				    <option value="">全部</option> 
				    <option value="1">是</option>   
				    <option value="0">否</option>      
				</select>  
		</div>
		<div class="fitem">
			客&nbsp;户&nbsp;类&nbsp;型：
			<select  id="search_customer_cust_type" data-options="panelHeight:200"  class="easyui-combobox" name="cust_type" style="width:200px;">   
				    <option value="">全部</option> 
				    <option value="1">企业</option>   
				    <option value="2">院校</option> 
				    <option value="3">代理</option>      		
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;
			客&nbsp;户&nbsp;状&nbsp;态：
			<select  class="easyui-combobox" id="search_customer_status" data-options="panelHeight:250" name="status" style="width:200px;">   
				    <option value="">全部</option> 
				    <option value="1">潜在客户</option>   
				    <option value="2">正式客户</option>      
				    <option value="3">放弃客户</option> 
				    <option value="4">签约客户</option>   
				</select>   
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchCustomer()">查询客户</a>  
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="NewsCustomer()">新增客户</a>    
		</div>
</div>
<!-- 新增客户对话框 -->
<div id="Newcustomer_dialog" class="easyui-dialog"  style="width:850px;height:650px;padding: 10px;"   
         data-options="iconCls:'icon-admin',resizable:true,modal:true,buttons:'#NewCustomer_buttons',closed:true,closable:false">   
   <div class="ftitle">新增/编辑客户信息界面 </div>
   <form id="NewCustomerForm" method="post">
		<table class="bordered" border=""  width="700px" height="450px" style="border-collapse:collapse;" cellspacing="0" cellpadding="10px" align="center">
           <tr bgcolor="#0000EE">
                <td colspan="4" align="left" style="font-weight: bolder;color: white;">基本信息</td>
           </tr>
		    <tr>
		        <td align="right">公司名称</td>
		        <td><input class="easyui-textbox" style="width:200px" name="cust_name">
		        	<input type="hidden" name="customer_id">
		        </td>
		        <td align="right">申请类型</td>
		        <td><select  class="easyui-combobox" name="cust_type" style="width:200px;" data-options="panelHeight:150" >   
					    <option value="">==请选择==</option>
		 				<option value="1">企业</option>
		 				<option value="2">院校</option>
		 				<option value="3">代理</option>
					</select>  
				</td>		       		   
		    </tr>
		    <tr>
		        <td align="right">公司背景</td>
		        <td><select  class="easyui-combobox" name="cust_background" style="width:200px;" data-options="panelHeight:150">   
					   <option value="">==请选择==</option>
		 				<option value="1">民营</option>
		 				<option value="2">国营</option>
		 				<option value="3">合资</option>
					</select>		     
		        </td>
		        <td align="right">是否上市</td>
		        <td><select  class="easyui-combobox" name="listed" style="width:200px;" data-options="panelHeight:150">   
					   <option value="">==请选择==</option>
		 				<option value="1">是</option>
		 				<option value="0">否</option>
					</select>
		        </td>
		    </tr>
		    <tr>
		        <td align="right">注册资本</td>
		        <td><input class="easyui-textbox" style="width:200px" name="reg_capital"></td>
		        <td align="right">年销售额</td>
		        <td><input class="easyui-textbox" style="width:200px" name="year_sales"></td>
		    </tr>
		    <tr>
		        <td align="right">企业规模</td>
		        <td><input class="easyui-textbox" style="width:200px" name="entp_scale"></td>
		        <td align="right">测试人员</td>
		        <td><input class="easyui-textbox" style="width:200px" name="tester_no"></td>
		    </tr>
		    <tr>
		       <td align="right">公司网址</td>
		        <td><input class="easyui-textbox" style="width:200px" name="url"></td>
		        <td align="right">邮政编码</td>
		        <td><input class="easyui-textbox" style="width:200px" name="zip_code"></td>
		    </tr>
		    <tr>
		        <td align="right">公司地址</td>
		        <td colspan="3"><input class="easyui-textbox" style="width:200px" name="address"></td>
		    </tr>
		    <tr>
		        <td align="right">主营产品</td>
		        <td>
		        	<input class="easyui-textbox" style="width:200px;height: 80px" name="main_products" data-options="multiline:true">  
		        </td>
		        <td align="right">主要服务</td>
		        <td>
		        	<input class="easyui-textbox" style="width:200px;height: 80px" name="major_services" data-options="multiline:true"> 
		        </td>
		    </tr>
		     <tr bgcolor="#0000EE">
                <td colspan="4" align="left" style="font-weight: bolder;color: white;">其他信息</td>
           </tr>
		    <tr>
		        <td align="right">客户状态</td>
		       <td><select  class="easyui-combobox" name="status" style="width:200px;" data-options="panelHeight:150">   
					   <option value="">==请选择==</option>
		 				<option value="1">潜在客户</option>
		 				<option value="2">正式客户</option>
		 				<option value="3">放弃客户</option>
		 				<option value="4">签约客户</option>
					</select>	     
		       </td>
		        <td align="right">指派人编号</td>
		        <td><input class="easyui-textbox" style="width:200px" id="user_id" name="user_id"  data-options="readonly:true"></td>
		    </tr>
		</table>
   </form>
</div> 
<div id="NewCustomer_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SaveOrUpdateCustomerInfo()">保存客户</a>
	<a href="javascript:$('#Newcustomer_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div> 
<!-- 特殊指派对话框 -->
<div id="Assign_dialog" title="特殊指派界面" class="easyui-dialog" style="width:400px;height:250px;padding: 10px;"   
          data-options="iconCls:'icon-zhipei',resizable:true,modal:true,buttons:'#Assgin_buttons',closed:true,closable:false">   
      <div class="ftitle">客户指派界面</div>
      <form id="AssginCustomerForm" method="post">
	      <div class="fitem" style="text-align: center;">
	     	   客户姓名：<input class="easyui-textbox" name="cust_name" style="width:250px" data-options="readonly:true">
	      </div>
	      <div class="fitem" style="text-align: center;">
		   	  指派安排：<input id="zp_user_id" name="user_id"  style="width:250px;">  		   	 
		   </div>
	   </form>
</div>
<div id="Assgin_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton"   data-options="iconCls:'icon-assign'" onclick="CustomerAssign()">特殊指派</a>
	<a href="javascript:$('#Assign_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-no'">关闭窗口</a>
</div> 
</div>