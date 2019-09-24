package com.ats.taskmgmtadmin.model;

public class EmpIdNameList {
	
	private String id; 
	private int empId; 
	private String empName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	@Override
	public String toString() {
		return "EmpIdNameList [id=" + id + ", empId=" + empId + ", empName=" + empName + "]";
	}
	
	

}
