<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script>
	function NewsdestineProject(){
		$('#customer_id').combobox({    
				           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
				    valueField:'customer_id',    
				     textField:'cust_name' ,
				   panelHeight:150,
			}); 
		$('#NewYudingForm').form('clear');
		$('#UpdateYuding_dialog').dialog('open').dialog('setTitle','新增客户预订计划');
	}
	function caozuo4(value,row,index){
		return "<a href='javascript:void(0)' onclick='editdestineInfo("+index+")'><img alt='编辑' src='${pageContext.request.contextPath}/images/edit.png'></a>"+
			       "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
			   "<a href='javascript:void(0)' onclick='deletedestineInfo("+index+")'><img alt='删除' src='${pageContext.request.contextPath}/images/cancel_destin.png'></a>";				  
	}
	function project_change(value,row,index){
		if(row.deal_state=='1'){
			return "<img alt='正常提示' src='${pageContext.request.contextPath}/images/emenercy_deal.png'>";
		}else{
			return "<img alt='紧急处理' src='${pageContext.request.contextPath}/images/ok_deal.png'>";
		}
	}
	function SaveOrUpdateCustomerBookfos(){
		$.messager.progress(); 
		$('#NewYudingForm').form('submit', {    
		        url:'${pageContext.request.contextPath}/YuDingManager/SaveorUpdateCustomerBookfos',   
		    success:function(data){  
		    	$.messager.progress('close');		   
		        var obj=$.parseJSON(data);
		        if(obj.success){
		        	$('#UpdateYuding_dialog').dialog('close');
		        	$('#destineManager_datagrid').datagrid('reload');
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
			        $('#UpdateYuding_dialog').dialog('close');			     
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
	
	function editdestineInfo(rowindex){
				$('#destineManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#destineManager_datagrid').datagrid('getSelected');
		if(row){
			$('#customer_id').combobox({    
				           url:'${pageContext.request.contextPath}/ContactManager/getCustomerName',    
				    valueField:'customer_id',    
				     textField:'cust_name' ,
				   panelHeight:150,
			}); 
			$('#NewYudingForm').form('load',row);
			$('#customer_id').combobox('setValue',row.customer_id);
			$('#UpdateYuding_dialog').dialog('open').dialog('setTitle','编辑客户预订计划');
		}
	} 
	
	function deletedestineInfo(rowindex){
				$('#destineManager_datagrid').datagrid('selectRow',rowindex);
		var row=$('#destineManager_datagrid').datagrid('getSelected');
		if(row){
			$.messager.confirm('温馨提示','您确认要删除预订日期为'+row.book_time+'和'+row.cust_name+'进行'+row.title+'该条预约记录吗？',function(r){    
				    if (r){    
				         $.ajax({
				         	 url:'${pageContext.request.contextPath}/YuDingManager/deleteCustomerBookfosRecord',
				         	type:"post",
				        dataType:'json',
				      beforeSend:function(){
				         	$.messager.progress(); 
				         	},
				         	data:{
				         	   book_id:row.book_id
				         	},
				         	success:function(data){
				         		$.messager.progress('close'); 
				         		if(data.success){
				         			$('#destineManager_datagrid').datagrid('reload');
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
				         		$('#destineManager_datagrid').datagrid('reload');
				         		alert("出错了，请联系管理员！");
				         	}
				         });   
				    }    
				}); 
		}
	}
	function searchdestioneInfo(){
	    var queryparams={};
	    if($("#search_Yuding_star_date").val()!=''&& $("#search_Yuding_end_date").val()!=''){
	    	queryparams={
	    		       cust_name:$("#searchyuding_cust_name").val(),
	    		Yuding_star_date:$("#search_Yuding_star_date").val(),
	    		 Yuding_end_date:$("#search_Yuding_end_date").val()
	    	};
	    }else{
		  	  queryparams={
		    		       cust_name:$("#searchyuding_cust_name").val()
		    	};
	     }
		$('#destineManager_datagrid').datagrid({
					  url:'${pageContext.request.contextPath}/YuDingManager/GetALLCustomerBookfosRecord',
			  queryParams: queryparams
		});
	}
</script>
<div style="margin: 10px">
<table id="destineManager_datagrid" title="管理预定" class="easyui-datagrid" style="width:1024px;height:500px"   
      			  data-options="url:'${pageContext.request.contextPath}/YuDingManager/GetALLCustomerBookfosRecord',
      			  		 fitColumns:true,
      			  	   singleSelect:true,
      			  	       striped:true,
      			  	    pagination:true,
      			  	    rownumbers:true,     			  	  
      			  	      pageList:['10','20','30','40','50'],     			  	   
      			  	       toolbar: '#destineManager_tools'    			  	   
      			  	   ">   
    <thead>   
        <tr>   
            <th data-options="field:'deal_state',width:60,align:'center',formatter:function(value,row,index){
            	 return project_change(value,row,index);
            }">预约状态</th>   
            <th data-options="field:'cust_name',width:150,align:'center'">客户名称</th>   
            <th data-options="field:'title',width:80,align:'center'">标题</th>   
            <th data-options="field:'destine_desc',width:200,align:'center'">描述</th>  
            <th data-options="field:'book_time',width:80,align:'center'">预定日期</th>         
            <th data-options="field:'create_time',width:80,align:'center'">创建日期</th>  
            <th data-options="field:'caozuo4',width:120,align:'center',formatter:function(value,row,index){
            	 return caozuo4(value,row,index);
            }">相关操作</th>  
        </tr>   
    </thead>   
</table>
<div id="destineManager_tools" style="padding: 5px;" >
		<div class="fitem" >
			客&nbsp;户&nbsp;名&nbsp;称：&nbsp;
			<input id="searchyuding_cust_name"  name="cust_name" class="easyui-textbox" style="width:250px">(支持模糊查询)	
		</div>
		<div class="fitem">
			预&nbsp;定&nbsp;日&nbsp;期：&nbsp;
			<input id="search_Yuding_star_date" name="Yuding_star_date" class= "easyui-datebox" ></input>
						-
			<input id="search_Yuding_end_date"  name="Yuding_end_date"   class="easyui-datebox" ></input>
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchdestioneInfo()">查询预订</a>  
			<a  href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="NewsdestineProject()">新增预订</a>    
		</div>
</div>
<!-- 新增预订对话框 -->
<div id="UpdateYuding_dialog" class="easyui-dialog"  style="width:500px;height:380px;padding: 10px;"   
         data-options="iconCls:'icon-destine',resizable:true,modal:true,buttons:'#UpdateYuding_buttons',closed:true,closable:false">   
   <div class="ftitle">新增/编辑客户预约信息界面 </div>
   <form id="NewYudingForm" method="post">
	   <div class="fitem" style="text-align: center;">
	        <input type="hidden" name="book_id">
	   		单&nbsp;&nbsp;&nbsp;&nbsp;位：&nbsp;&nbsp;<input id="customer_id" name="customer_id" style="width: 250px;">
	   </div>
	   <div class="fitem" style="text-align: center;">
	   		标&nbsp;&nbsp;&nbsp;&nbsp;题：&nbsp;&nbsp;<input class="easyui-textbox"  name="title" style="width:250px">
	   </div>
	   <div class="fitem" style="text-align: center;">
	   	         描&nbsp;&nbsp;&nbsp;&nbsp;述：&nbsp;&nbsp;<input class="easyui-textbox"  name="destine_desc" style="width:250px;height: 120px;" data-options="multiline:true">
	   </div>
	   <div class="fitem" style="text-align: center;">
	   		预订日期:&nbsp;<input  name="book_time" class= "easyui-datebox" style="width:250px"></input>
	   </div>
   </form>
</div> 
<div id="UpdateYuding_buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-destine'" onclick="SaveOrUpdateCustomerBookfos()">保存预订</a>
	<a href="javascript:$('#UpdateYuding_dialog').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-no'">关闭窗口</a>
</div> 
</div>