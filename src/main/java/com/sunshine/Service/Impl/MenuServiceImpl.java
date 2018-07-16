package com.sunshine.Service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;

import com.sunshine.Dao.MenuDaoMapper;
import com.sunshine.Model.Menu;
import com.sunshine.Model.User;
import com.sunshine.Service.MenuServiceI;

@Service
public class MenuServiceImpl implements MenuServiceI{

	@Resource
	private MenuDaoMapper menuDaoMapper;

	@Override
	public List<Menu> getALlTreeNode(String id) {
		Subject subject=SecurityUtils.getSubject();
		User user=(User) subject.getPrincipal();
		List<Menu> menus=new ArrayList<Menu>();
		if(id!=null && !id.equals("")){
			List<Menu> nodeList=menuDaoMapper.getTreeNode(id);
			for(int j=0;j<nodeList.size();j++){
				Menu menu1=nodeList.get(j);
				Map<String, String> map1=new HashMap<String, String>();
				map1.put("url", menu1.getUrl());
				menu1.setAttributes(map1);
				List<Menu> nodeList1=menuDaoMapper.getTreeNode(menu1.getId());
			    if(nodeList1!=null && nodeList1.size()>0){
			    	menu1.setState("closed");
			    }else{
			    	menu1.setState("open");
			    }
			    if(menu1.getText().equals("用户管理")){//获取功能菜单时判断当前用户是否为系统管理员，如果是系统管理员，增加用户管理功能，否则不予以显示（只有系统管理员		    						
			    	if(user.getRole_id().equals("1")){//才可以管理员工用户，进行增删该查操作）
			    		menus.add(menu1);
			    	}
			    }else{
			    	menus.add(menu1);
			    }
			}	
		}else{
			List<Menu> pNodeList=menuDaoMapper.getTreeParentNode();
			if(pNodeList!=null && pNodeList.size()>0){
				for(int i=0;i<pNodeList.size();i++){
					Menu menu=pNodeList.get(i);
					Map<String, String> map=new HashMap<String, String>();
					map.put("url", menu.getUrl());
					menu.setAttributes(map);
				    List<Menu> nodeList=menuDaoMapper.getTreeNode(menu.getId());
				    if(nodeList!=null && nodeList.size()>0){
				    	menu.setState("closed");
				    }else{
				    	menu.setState("open");
				    }
				    menus.add(menu);
				   }
				}
		}
		return menus;
}
}
