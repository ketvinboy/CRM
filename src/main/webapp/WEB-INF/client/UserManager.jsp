<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script>
var flag=true;
$.extend($.fn.validatebox.defaults.rules, {    
	   equals: {    
	        validator: function(value,param){    
	            return value == $(param[0]).val();    
	       },    
	       message: '两次输入的密码不一致！'   
	   }    
}); 
function NewsUser(){
		$('#NewUserForm').form('clear');
		$('#erro_ajax_tip').css('display','none');  
		$('#ok_ajax_tip').css('display','none'); 
		$('#UpdateUser_dialog').dialog('open').dialog('setTitle','新增用户');
	}
function caozuo(value,row,index){
		return "<a href='#' onclick='editUSerInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
			       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
			   "<a href='#' onclick='deleteUSerInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/delete.png'></a>"+
			  	 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
			   "<a href='#' onclick='upadteUSerPwd("+index+")'><img alt='修改密码' src='${pageContext.request.contextPath}/images/password.png'></a>";
	}
function editUSerInfo(rowindex){
				$('#NewUserForm').form('clear');
				$('#erro_ajax_tip').css('display','none');  
				$('#ok_ajax_tip').css('display','none'); 
			    $('#userManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#userManager_datagrid').datagrid('getSelected');
		if(row){
			$('#NewUserForm').form('load',row);
			$('#UpdateUser_dialog').dialog('open').dialog('setTitle','编辑用户信息');
		}
	}
function upadteUSerPwd(rowindex){
				$('#NewUserForm').form('clear');
			    $('#userManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#userManager_datagrid').datagrid('getSelected');
		if(row){
				$('#UpdateUserPwdForm').form('load',row);
				$("#pwd").val('');
				$('#updateUserPwd_dialog').dialog('open');
		}
	}
function UpdateUserPWd(){
			 $.messager.progress();	// 显示进度条
			 $('#UpdateUserPwdForm').form('submit', {    
			    	url:'${pageContext.request.contextPath}/UserManager/UpdateUserPwd',    
			    success:function(data){ 
			       var obj=$.parseJSON(data);   
			       $.messager.progress('close');	// 如果提交成功则隐藏进度条  
			       if(obj.success){
			       		$('#updateUserPwd_dialog').dialog('close');
			       		$('#userManager_datagrid').datagrid('reload');
			       		$.messager.show({
								 title:'系统提示',
								   msg:obj.msg,						
							  showType:'slide'
							});       		
			       }else{
				       $('#updateUserPwd_dialog').dialog('close');
				       $.messager.show({
									 title:'系统提示',
									   msg:obj.msg,						
								  showType:'slide'
								});       
			       }  
			    }    
			}); 
		}
function deleteUSerInfo(rowindex){
		   		 $('#userManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#userManager_datagrid').datagrid('getSelected');
		if(row){
				$.messager.confirm('温馨提示','您确认想要删除姓名为：'+row.user_name+'用户的这条记录吗？',function(r){    
				    if (r){    
				        $.ajax({
				        	 url:'${pageContext.request.contextPath}/UserManager/deleteUSerInfo',
				        	type:"post",
				        dataType:'json',
				        	data:{user_id:row.user_id},
				      beforeSend:function(){
				     			 $.messager.progress();	// 显示进度条
				      		    },
				         success:function(data){
				          $.messager.progress('close');	// 如果提交成功则隐藏进度条  
				        		if(data.success){
				        			$('#userManager_datagrid').datagrid('reload');
						       		$.messager.show({
											 title:'系统提示',
											   msg:data.msg,						
										  showType:'slide'
										});       		
				        		}else{				 
					       		$.messager.show({
										 title:'系统提示',
										   msg:data.msg,						
									  showType:'slide'
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
function SaveOrUpdateUserInfo(){
	if(flag){
		   	 $.messager.progress();	// 显示进度条
			 $('#NewUserForm').form('submit', {    
					url:'${pageContext.request.contextPath}/UserManager/SaveOrUpdateUserInfo',    
			    success:function(data){ 
					var obj=$.parseJSON(data);   
					$.messager.progress('close');	// 如果提交成功则隐藏进度条  
					if(obj.success){
						$('#UpdateUser_dialog').dialog('close');
						$('#userManager_datagrid').datagrid('reload');
						$.messager.show({
									 title:'系统提示',
									   msg:obj.msg,						
								  showType:'slide'
										});       		
					}else{
						 $('#UpdateUser_dialog').dialog('close');
						 $.messager.show({
									 title:'系统提示',
									   msg:obj.msg,						
								  showType:'slide'
									   });       
							       }  
							    }    
							});	  
					} 				
	}
function searchUser(){
	var datajson;
	if($("#search_startdate").val()!='' && $("#search_end_date").val()!=''){
			datajson={
								user_name:$("#search_name").val(),
								      sex:$("#search_sex").val(),
								  role_id:$("#search_role_id").val(),
								   status:$("#search_status").val(),
							   star_tdate:$("#search_startdate").val(),
								 end_date:$("#search_end_date").val(),		  
							};		
	  }else{
	  	 datajson={
						user_name:$("#search_name").val(),
						      sex:$("#search_sex").val(),
						  role_id:$("#search_role_id").val(),
						   status:$("#search_status").val(),				  
					};		
	  }
		$('#userManager_datagrid').datagrid({
				    url:'${pageContext.request.contextPath}/UserManager/findALLUserInfoRecord',
			queryParams: datajson
		});
	}
function ajaxUserNick(){
		var user_name=document.getElementById("_easyui_textbox_input2").value;
		   $.ajax({
			       url:'${pageContext.request.contextPath}/UserManager/ajaxUsernick',
			      type:"post",
			  dataType:'json',
			beforeSend:function(){
				    $('#erro_ajax_tip').css('display','none');  
					$('#ok_ajax_tip').css('display','none'); 
					flag=true;
			    },
			    data:{user_name:user_name},
			    success:function(data){
			    	if(data.success){
			    		 $('#erro_ajax_tip').css('display','');
			    		 flag=false;
			    	}else{
			    		 $('#ok_ajax_tip').css('display','');
			    	}
			    }	
		});
	}
</script>
<div style="margin: 10px">
<table id="userManager_datagrid" title="员工列表" class="easyui-datagrid" style="width:960px;height:500px"   
      			  data-options="url:'${pageContext.request.contextPath}/UserManager/findALLUserInfoRecord',
      			  		 fitColumns:true,
      			  	   singleSelect:true,
      			  	       striped:true,
      			  	    pagination:true,     			  	   
      			  	      pageList:['10','20','30','40','50'],
      			  	      checkbox:true,
      			  	      toolbar: '#userManager_tools'    			  	   
      			  	   ">   
    <thead>   
        <tr>   
            <th data-options="field:'user_id',width:100,align:'center'">用户编号</th>   
            <th data-options="field:'user_name',width:100,align:'center'">用户姓名</th>   
            <th data-options="field:'sex',width:100,align:'center',formatter: function(value,row,index){
	            	if(row.sex=='1'){return '男';}
	            	if(row.sex=='0'){return '女';}
            	}">性别</th>   
            <th data-options="field:'birthday',width:120,align:'center'">出生年月</th>  
            <th data-options="field:'role_id',width:100,align:'center',formatter:function(value,row,index){
	            	if(row.role_id=='1'){return '系统管理员';}
	            	if(row.role_id=='2'){return '业务经理';}
	            	if(row.role_id=='3'){return '销售';}
	         }">角色</th>  
            <th data-options="field:'status',width:100,align:'center',formatter:function(value,row,index){
	            	if(row.status=='1'){return '正常';}
	            	if(row.status=='0'){return '禁用';}	         
	         }">状态</th>  
            <th data-options="field:'caozuo',width:150,align:'center',formatter:function(value,row,index){
            	 return caozuo(value,row,index);
            }">相关操作</th>  
        </tr>   
    </thead>   
</table>
<div id="userManager_tools" style="padding: 5px;" >
	<form id="searchForm" method="post">
		<div class="fitem" >
			&nbsp;用&nbsp;户&nbsp;名：<input id="search_name"  name="user_name" class="easyui-textbox" style="width:250px">(支持模糊查询)
			&nbsp;&nbsp;&nbsp;&nbsp;
			   性&nbsp;&nbsp;&nbsp;&nbsp;别：&nbsp;<select class="easyui-combobox"  id="search_sex" data-options="panelHeight:100" name="sex" style="width:250px;">   
				    <option value="">选择性别</option>
				    <option value="0">女</option>   
				    <option value="1">男</option>      
				</select>  
		</div>
		<div class="fitem">
			出生日期：<input id="search_startdate" name="star_tdate" class= "easyui-datebox" ></input>
						-
					 <input id="search_end_date"  name="end_date"   class="easyui-datebox" ></input>
			&nbsp;&nbsp;&nbsp;
			角&nbsp;&nbsp;&nbsp;&nbsp;色：<select  class="easyui-combobox" id="search_role_id" data-options="panelHeight:100" name="role_id" style="width:250px;">   
				    <option value="">全部</option> 
				    <option value="1">系统管理员</option>   
				    <option value="2">业务经理</option>      
				    <option value="3">销售</option>  
				</select>  
		</div>
		<div class="fitem">
			状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：<select  id="search_status" data-options="panelHeight:100" title="全部" class="easyui-combobox" name="status" style="width:250px;">   
				    <option value="">选择状态</option> 
				    <option value="1">正常</option>   
				    <option value="0">禁用</option>      		
				</select> 
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser()">查询用户</a>  
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="NewsUser()">新增用户</a>    
		</div>
	</form>
</div>
<!-- 新增用户对话框 -->
<div id="UpdateUser_dialog" class="easyui-dialog"  style="width:500px;height:380px;padding: 10px;"   
         data-options="iconCls:'icon-admin',resizable:true,modal:true,buttons:'#UpdateUser_buttons',closed:true,closable:false">   
   <div class="ftitle">新增/编辑用户界面 </div>
   <form id="NewUserForm" method="post">
	   <div class="fitem" style="text-align: center;">
	                 <input type="hidden" name="user_id">
	   		用户姓名：<input class="easyui-textbox" id="user_name1" name="user_name" style="width:250px" data-options="events:{blur:function(){ajaxUserNick()}}" onchange="ajaxUserNick()">
	   </div>
	   <div id="erro_ajax_tip" class="fiftem" style="text-align: center;display: none">
	    <span><font style="font-weight: bolder;font-family: '宋体';color: red">用户昵称已被占用！</font></span>
	   </div> 
	   <div id="ok_ajax_tip" class="fiftem" style="text-align: center;display: none">
	    <span><font style="font-weight: bolder;font-family: '宋体';color: green">用户昵称可用！</font></span>
	   </div> 
	   <div class="fitem" style="text-align: center;">
	   		性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
	   		<select  class="easyui-combobox" data-options="panelHeight:100" name="sex" style="width:250px;">   
					   <option value="0">女</option>   
					   <option value="1">男</option>      
			</select>  
	   </div>
	   <div class="fitem" style="text-align: center;">
	   	  出生日期： <input  name="birthday" class= "easyui-datebox" style="width:250px"></input>
	   </div>
	   <div class="fitem" style="text-align: center;">
	   		角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：
	   		<select class="easyui-combobox" name="role_id" style="width:250px;" data-options="panelHeight:100">   
					   <option value="1">系统管理员</option>   
					   <option value="2">业务经理</option>      
					   <option value="3" selected="selected">销售</option>  
			</select>  
	   </div>
	    <div class="fitem" style="text-align: center;">
	   		用户邮箱：<input class="easyui-textbox"  name="user_qq" style="width:250px"> 
	   </div>
	   <div class="fitem" style="text-align: center;">
	   		状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：
	   		<input class="easyui-switchbutton" id="status" name="status" data-options="onText:'正常',offText:'禁用',checked:true,value:'1'" style="width: 250px" checked>
	   </div>
   </form>
</div> 
<div id="UpdateUser_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="SaveOrUpdateUserInfo()">保存</a>
	<a href="javascript:$('#UpdateUser_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div> 
<!-- 更新用户密码 -->
<div id="updateUserPwd_dialog" title="更新用户密码" class="easyui-dialog" style="width:400px;height:280px;padding: 10px;"   
          data-options="iconCls:'icon-password',resizable:true,modal:true,buttons:'#UpdateUserpwd_buttons',closed:true,closable:false">   
      <div class="ftitle">更新用户密码界面 </div>
      <form id="UpdateUserPwdForm" method="post">
	      <div class="fitem" style="text-align: center;">
	     	   用户姓名：<input class="easyui-textbox" name="user_name" style="width:250px" data-options="readonly:true">
	      </div>
	      <div class="fitem" style="text-align: center;">
		   		密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
		   		<input id="pwd" class="easyui-validatebox" data-options="required:true" name="password" type="password" style="width:250px">
		   </div>
		   <div class="fitem" style="text-align: center;">
		   		确认密码：<input id="rpwd" class="easyui-validatebox" required="required" validType="equals['#pwd']" type="password" style="width:250px">
		   </div>
	   </form>
</div>
<div id="UpdateUserpwd_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="UpdateUserPWd()">更新密码</a>
	<a href="javascript:$('#updateUserPwd_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
</div>   
</div>