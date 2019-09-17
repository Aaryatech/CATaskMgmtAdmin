package com.ats.taskmgmtadmin.model;

import java.util.ArrayList;

public class ManagerListWithEmpIds {
	
	private int empId;
	private String empName;
	private String memberIds; 
	private float bugetedWork; 
	private String allWork; 
	private String actlWork;
	ArrayList<String> ids;
	
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getMemberIds() {
		return memberIds;
	}
	public void setMemberIds(String memberIds) {
		this.memberIds = memberIds;
	}
	public float getBugetedWork() {
		return bugetedWork;
	}
	public void setBugetedWork(float bugetedWork) {
		this.bugetedWork = bugetedWork;
	}
	public String getAllWork() {
		return allWork;
	}
	public void setAllWork(String allWork) {
		this.allWork = allWork;
	}
	public String getActlWork() {
		return actlWork;
	}
	public void setActlWork(String actlWork) {
		this.actlWork = actlWork;
	}
	public ArrayList<String> getIds() {
		return ids;
	}
	public void setIds(ArrayList<String> ids) {
		this.ids = ids;
	}
	@Override
	public String toString() {
		return "ManagerListWithEmpIds [empId=" + empId + ", empName=" + empName + ", memberIds=" + memberIds
				+ ", bugetedWork=" + bugetedWork + ", allWork=" + allWork + ", actlWork=" + actlWork + ", ids=" + ids
				+ "]";
	}
	
	

}
