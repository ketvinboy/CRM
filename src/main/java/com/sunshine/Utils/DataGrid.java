package com.sunshine.Utils;

import java.util.List;

public class DataGrid {

	private int total;
	private List rows;
	
	private static class DatagridClass{
		private static final DataGrid datagrid=new DataGrid();
	}
	
	public static DataGrid getDataGrid(){
		
		return DatagridClass.datagrid;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}
	
	
}
