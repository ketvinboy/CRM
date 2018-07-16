package com.sunshine.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sunshine.Model.Menu;
import com.sunshine.Model.User;
import com.sunshine.Service.MenuServiceI;
import com.sunshine.Service.UserServiceI;
import com.sunshine.Utils.DataGrid;
import com.sunshine.Utils.MD5keyBean;
import com.sunshine.Utils.MessageNotify;

@Controller
@RequestMapping("/home")
public class HomeController {

	@Autowired
	private MenuServiceI menuServiceI;
	
	@Autowired
	private UserServiceI userServiceI;
	
	private MD5keyBean md5keyBean=new MD5keyBean();
	
	private MessageNotify notify=MessageNotify.getMessageNotify();
	/**
	 * 返回功能菜单（异步操作）
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/GetAllTreeNode",method=RequestMethod.POST)
	@ResponseBody
	public List<Menu> GetAllTreeNode(String id){
		return menuServiceI.getALlTreeNode(id);
	}
	/**
	 * 用户登陆校验用户名和密码
	 * @param user_name
	 * @param password
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/LoginSystem",method=RequestMethod.POST)
	@ResponseBody
	public MessageNotify LoginSystem(String user_name,String password,HttpServletRequest request){
		//获取当前的用户主题
		Subject subject=SecurityUtils.getSubject();
		//存储当前的用户和密码，进行权限认证
		UsernamePasswordToken usernamePasswordToken=new UsernamePasswordToken(user_name, md5keyBean.getkeyBeanofStr(password));
		if(!subject.isAuthenticated()){
			try{
				subject.login(usernamePasswordToken);
				User user=(User) subject.getPrincipal();
				if(user.getStatus().equals("1")){
					notify.setSuccess(true);
					notify.setMsg("登陆成功！");
					request.getSession().setAttribute("admin", user);
				}else{
					subject.logout();
					notify.setSuccess(false);
					notify.setMsg("账号异常，登陆系统失败，请联系管理员处理！");
				}
			}catch (UnknownAccountException e) {
				notify.setSuccess(false);
				notify.setMsg("不合法的账号，登陆系统失败，请联系管理员处理！");
			}catch (IncorrectCredentialsException e) {
				notify.setSuccess(false);
				notify.setMsg("密码错误，登陆系统失败，请重试！");
			}
		}
		return notify;
	}
	/**
	 * 返回系统主页面
	 * @return
	 */
	@RequestMapping(value="/main_index",method=RequestMethod.GET)
	public String main_index(){
		return "client/home";
	}
	/**
	 * 返回登陆首页面
	 * @return
	 */
	@RequestMapping(value="/login_index",method=RequestMethod.GET)
	public String login_index(){
		return "client/login";
	}
	/**
	 * 注销系统
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/destoryAccount",method=RequestMethod.GET)
	@ResponseBody
	public MessageNotify destoryAccount(HttpServletRequest request){
		Subject subject=SecurityUtils.getSubject();
		subject.logout();	
		request.getSession().removeAttribute("admin");
		notify.setSuccess(true);
		notify.setMsg("注销成功！");
		return notify;
	}
}
