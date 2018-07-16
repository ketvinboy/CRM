<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>客户关系管理系统</title> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.5.4/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.5.4/themes/icon.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/formstyle.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css" type="text/css"></link>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.5.4/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.5.4/jquery.easyui.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.5.4/locale/easyui-lang-zh_CN.js"></script>	
  	<script>
  		function NewTabs(opts){
  			var home_tab=$('#home_tab');
  			if(home_tab.tabs('exists',opts.title)){
  				home_tab.tabs('select',opts.title);
  			}else{
  				home_tab.tabs('add',opts);
  			}
  		}
  		function destoryAccount(){
  			$.messager.confirm('温馨提示','您确定要注销系统吗？',function(r){    
			    if (r){    
			       $.ajax({
			       		 url:'${pageContext.request.contextPath}/home/destoryAccount',
			       		type:"GET",
			       		  dataType:'json',
			       	 success:function(data){	
			       	 	 window.location.href='${pageContext.request.contextPath}/home/login_index';       				       			       		
			       		},
			       		error:function(){
			       			alert("出错了，请联系管理员处理！");
			       		}
			       }); 
			    }    
			}); 
  		}
  	</script>
  </head>
  <body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:80px;padding:20px;
		 background-image: url('${pageContext.request.contextPath}/images/titlejpg.jpg');">
		<font style="font-family: '微软雅黑';font-size: 25px;font-weight:bold;color: white;">MyCRM 客户关系管理系统</font>
	</div>
	<div data-options="region:'west',split:true,title:'客户关系管理系统',iconCls:'icon-relation'" style="width:300px;">
		 <ul id="menuTree" class="easyui-tree" data-options="url:'${pageContext.request.contextPath}/home/GetAllTreeNode',
		 									 lines:true,
		 								   onClick: function(node){		 								
												if($('#menuTree').tree('isLeaf',node.target)){
													NewTabs({
														   title:node.text,
													    closable:true,
													   iconCls:node.iconCls,
													     href:'${pageContext.request.contextPath}'+node.url
													})
												}
												}
		 									 ">
		 </ul>  
	</div>
	<div data-options="region:'south',border:false" style="height:40px;padding:5px;text-align: center;">版权所有 @2018 SunShine团队制作</div>
	<div data-options="region:'center',title:'管理员：${admin.user_name}！你好',iconCls:'icon-center'">
		<div id="home_tab" class="easyui-tabs" data-options="fit:true,border:false,tools:'#tab-tools'">   
		    <div title="主页" style="padding:20px;display:none;text-align: center;">   
		    	<img alt="客户关系管理系统" src="${pageContext.request.contextPath}/images/home_background.gif">
		    </div>   
		</div> 
	</div>
	<div id="tab-tools">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-no',border:false" onclick="destoryAccount()">注销登陆</a>
	</div>
</body>
</html>
	