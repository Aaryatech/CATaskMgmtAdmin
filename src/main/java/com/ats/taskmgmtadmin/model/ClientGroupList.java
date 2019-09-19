package com.ats.taskmgmtadmin.model;
 

public class ClientGroupList {
	 
	private int id; 
	private String name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "ClientGroupList [id=" + id + ", name=" + name + "]";
	}
	
	

}
