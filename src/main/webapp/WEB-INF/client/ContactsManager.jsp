<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script>
	$(function(){
		
	});
	function NewContact(){
		$('#cust_id').combobox({    
			           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
			    valueField:'customer_id',    
			     textField: 'cust_name' ,
			   panelHeight:150,
		}); 
		$('#NewCustomerContactForm').form('clear');
		$('#Updatecustomer_dialog').dialog('open').dialog('setTitle','新增客户联络信息');
	}
	function SaveOrUpdateCustomerInfo(){
		$.messager.progress(); 
		$('#NewCustomerContactForm').form('submit', {    
   				 url:'${pageContext.request.contextPath}/ContactManager/SaveOrUpdateCustomerInfo',     
   		     success:function(data){  
   		     $.messager.progress('close');  
              var obj=$.parseJSON(data);
              if(obj.success){
              	 $('#Updatecustomer_dialog').dialog('close');
              	 $('#ContactManager_datagrid').datagrid('reload');
              	 $.messager.show({
						title:'系统提示',
						  msg:obj.msg,
					 showType:'slide'
					});  	 
              }else{
                $('#Updatecustomer_dialog').dialog('close');
                $.messager.show({
						title:'系统提示',
						  msg:obj.msg,
					 showType:'slide'
					});  	 
              }    
          }    
       }); 
	}
	function caozuo2(value,row,index){
	  return "<a href='#' onclick='editCustomerContactInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
			       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
			   "<a href='#' onclick='deleteCustomerContactInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>";
			}	
	function editCustomerContactInfo(rowindex){
		        $('#ContactManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#ContactManager_datagrid').datagrid('getSelected');
		if(row){
			$('#cust_id').combobox({    
				           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
				    valueField:'customer_id',    
				     textField: 'cust_name' ,
				   panelHeight:150,
			}); 
			$('#NewCustomerContactForm').form('clear');
			$('#NewCustomerContactForm').form('load',row);
		    $('#Updatecustomer_dialog').dialog('open').dialog('setTitle','编辑客户联络信息');
		}
	}
	function deleteCustomerContactInfo(rowindex){
	 			$('#ContactManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#ContactManager_datagrid').datagrid('getSelected');
		if(row){
			$.messager.confirm('温馨提示','您确认想要删除'+row.cont_name+'该客户的所有记录吗？',function(r){    
			    if (r){    
			        $.ajax({
			        	 url:'${pageContext.request.contextPath}/ContactManager/deleteCustomerContactInfo',
			        	type:"post",
			        dataType:'json',
			        	data:{
			        	   cont_id:row.cont_id
			        	},
			        success:function(data){
			        	  if(data.success){		        
			              	 $('#ContactManager_datagrid').datagrid('reload');
			              	 $.messager.show({
									title:'系统提示',
									  msg:data.msg,
								 showType:'slide'
								});  	 
			        	  }else{		        	
              	 			 $.messager.alert('系统提示',data.msg,'error');     
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
	function searchcustomer(){
		var queryParams;
		if($("#search_contact_startdate").val()!=''&& $("#search_contact_end_startdate").val()!=''){
			queryParams={
				 cust_name:$("#search_contact_cust_name").val(),
				start_date:$("#search_contact_startdate").val(),
				  end_date:$("#search_contact_end_startdate").val()
			};
		}else{
		 queryParams={
				 cust_name:$("#search_contact_cust_name").val()
			};
		}
		$('#ContactManager_datagrid').datagrid({
				    url:'${pageContext.request.contextPath}/ContactManager/GetALLCustomerContactINfoRecord',
			queryParams: queryParams
		});
	}  	
</script>
<div style="margin: 10px">
<table id="ContactManager_datagrid" title="客户联络管理" class="easyui-datagrid" style="width:1150px;height:500px"   
      			  data-options="url:'${pageContext.request.contextPath}/ContactManager/GetALLCustomerContactINfoRecord',
      			  		 fitColumns:true,
      			  	   singleSelect:true,
      			  	       striped:true,
      			  	    pagination:true,    			  	  
      			  	      pageList:['10','20','30','40','50'],
      			  	      checkbox:true,
      			  	      toolbar: '#contactManager_tools'    			  	   
      			  	   ">   
    <thead>   
        <tr>   
            <th data-options="field:'cont_id',width:60,align:'center'">联络编号</th>   
            <th data-options="field:'cust_name',width:180,align:'center'">客户名称</th>   
            <th data-options="field:'cont_name',width:100,align:'center'">客户姓名</th>   
            <th data-options="field:'cont_dept',width:100,align:'center'">部门名称</th>  
            <th data-options="field:'cont_position',width:80,align:'center'">客户职位</th>  
            <th data-options="field:'cont_mobile',width:120,align:'center'">客户手机</th>   
            <th data-options="field:'cont_email',width:180,align:'center'">客户邮箱</th>   
            <th data-options="field:'cont_qq',width:120,align:'center'">客户QQ</th>   
            <th data-options="field:'tech_degree',width:100,align:'center',formatter: function(value,row,index){
            	if(row.tech_degree=='1'){return '一般'};
            	if(row.tech_degree=='2'){return '熟练'};
            	if(row.tech_degree=='3'){return '业务精干'};
            }">技术程度</th>   
            <th data-options="field:'create_time',width:120,align:'center'">创建日期</th> 
            <th data-options="field:'caozuo2',width:150,align:'center',formatter: function(value,row,index){
            	return caozuo2(value,row,index);
            }">相关操作</th>  
        </tr>   
    </thead>   
</table>
<div id="contactManager_tools" style="padding: 5px;" >
		<div class="fitem">
			客户名称：<input id="search_contact_cust_name"  name="cust_name" class="easyui-textbox" style="width:250px">(支持模糊查询)
		</div>
		<div class="fitem">
			创建日期：<input id="search_contact_startdate" name="start_date" class= "easyui-datebox" ></input>
			              -
				    <input id="search_contact_end_startdate" name="end_date" class= "easyui-datebox" ></input>
				    <a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchcustomer()">查询客户</a>
				    <a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="NewContact()">新增联络</a>
		</div>
</div>
<!-- 新增客户联络对话框 -->
<div id="Updatecustomer_dialog" class="easyui-dialog"  style="width:700px;height:450px;padding: 15px;"   
         data-options="iconCls:'icon-admin',resizable:true,modal:true,buttons:'#Updatecustomer_buttons',closed:true,closable:false">   
   <div class="ftitle">新增/编辑客户联络信息界面 </div>
   <form id="NewCustomerContactForm" method="post">
		<table class="bordered" border=""  width="650px" height="280px" style="border-collapse:collapse;" cellspacing="0" cellpadding="10px" align="center">		   
		    <tr>
		        <td>客户名称</td>        
		        <td><input id="cust_id" name="cust_id" style="width: 200px;">
		            <input type="hidden" name="cont_id">
		         </td>
		 		<td>客户姓名</td>        
		        <td><input class="easyui-textbox" name="cont_name" style="width:200px"> </td>
		    </tr> 
		     <tr>
		        <td>客户部门</td>        
		        <td><input class="easyui-textbox" style="width:200px" name="cont_dept"></td>
		 		<td>客户职位</td>        
		        <td><select class="easyui-combobox" name="cont_position" style="width:200px;" data-options="panelHeight:150">   
					    <option value="总裁">总裁</option>   
					    <option value="经理">经理</option>   
					    <option value="主任">主任</option> 
					    <option value="组长">组长</option> 
					    <option value="普通职员">普通职员</option>       
					 </select> 
			 </td>
		    </tr>      
		     <tr>
		        <td>客户电话</td>        
		        <td><input class="easyui-textbox" style="width:200px" name="cont_telephone"> </td>
		 		<td>客户手机</td>        
		        <td><input class="easyui-textbox" style="width:200px" name="cont_mobile"></td>
		    </tr>      
		     <tr>
		        <td>客户QQ</td>        
		        <td><input class="easyui-textbox" style="width:200px" name="cont_qq"></td>
		 		<td>客户邮箱</td>        
		        <td><input class="easyui-textbox" style="width:200px" name="cont_email"> </td>
		    </tr>      
		     <tr>
		        <td>技术程度</td>        
		        <td><select class="easyui-combobox" name="tech_degree" style="width:200px;" data-options="panelHeight:150">   
					    <option value="1">一般</option>   
					    <option value="2">熟练</option>   
					    <option value="3">业务精干</option>   
					</select> 
				</td>
		 		<td>其他信息</td>        
		        <td><input class="easyui-textbox" style="width:200px" name="more_info"> </td>
		    </tr>               
		</table>
   </form>
</div> 
<div id="Updatecustomer_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SaveOrUpdateCustomerInfo()">保存</a>
	<a href="javascript:$('#Updatecustomer_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div> 
</div>