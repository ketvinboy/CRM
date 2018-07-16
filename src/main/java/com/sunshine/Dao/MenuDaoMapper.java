package com.sunshine.Dao;

import java.util.List;

import com.sunshine.Model.Menu;

public interface MenuDaoMapper {

	public List<Menu> getTreeParentNode();
	
	public List<Menu> getTreeNode(String id);
}
