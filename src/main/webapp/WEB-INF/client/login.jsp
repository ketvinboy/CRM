<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>客户关系管理界面后台登陆</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />
	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<!-- Modernizr JS -->
	<script src="${pageContext.request.contextPath}/js/modernizr-2.6.2.min.js"></script>
	<script>
		function LoginSystem(){
			var user_name=$("#user_name").val();
			var password=$("#password").val();
			console.log(user_name);
			if(user_name==""){
				$('#username_tip').css('display','');
				$("#user_name").focus();
				return;
			}
			if(password==""){
				$('#pwd_tip').css('display','');
				$("#pwd_tip").focus();
				return ;
			}
		    $.ajax({
				 url:'${pageContext.request.contextPath}/home/LoginSystem',
				type:"post",
			dataType:'json',
				data:{
				user_name:user_name,
				 password:password
				},
			 success:function(data){
				 if(data.success){
				 	alert(data.msg);
				 	window.location.href='${pageContext.request.contextPath}/home/main_index';
				 }else{
				 	alert(data.msg);
				 	window.location.href='${pageContext.request.contextPath}/home/login_index';
				 }
				},
				error:function(){
					alert("出错了，请联系管理员！");
				}
			});
		}
	</script>
	</head>
	<body class="style-2">
		<div class="container">
			<div class="row">
				<div class="col-md-12 text-center">
					 <!-- <ul class="menu">
						<li><a href="index.html">Style 1</a></li>
						<li class="active"><a href="index2.html">Style 2</a></li>
						<li><a href="index3.html">Style 3</a></li>
					</ul> -->
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<!-- Start Sign In Form -->
					<form  class="fh5co-form animate-box" data-animate-effect="fadeInLeft">
						<h2>用户登陆</h2>
						<div class="form-group">
							<label for="username" class="sr-only">用户名</label>
							<input type="text" class="form-control" id="user_name" placeholder="用户名" autocomplete="off">
							<span id="username_tip" style="font-weight: bolder;font-size: 12px;color: red;display: none">用户名不能为空</span>
						</div>
						<div class="form-group">
							<label for="password" class="sr-only">密码</label>
							<input type="password" class="form-control" id="password" placeholder="密码" autocomplete="off">
							<span id="pwd_tip" style="font-weight: bolder;font-size: 12px;color: red;display: none">密码不能为空</span>
						</div>
						<div class="form-group">
							<input type="button" value="Login" class="btn btn-primary" onclick="LoginSystem()">
						</div>
					</form>
					<!-- END Sign In Form -->
				</div>
			</div>
		</div>
	
		<!-- jQuery -->
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<!-- Placeholder -->
		<script src="${pageContext.request.contextPath}/js/jquery.placeholder.min.js"></script>
		<!-- Waypoints -->
		<script src="${pageContext.request.contextPath}/js/jquery.waypoints.min.js"></script>
		<!-- Main JS -->
		<script src="${pageContext.request.contextPath}/js/main.js"></script>

	</body>
</html>


