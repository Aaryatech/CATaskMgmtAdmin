package com.ats.taskmgmtadmin.model;

import java.util.List;
 
public class EmpListForDashboard {

	private int empId; 
	private String empName;
	List<TaskCountByStatus> list;
	
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
	public List<TaskCountByStatus> getList() {
		return list;
	}
	public void setList(List<TaskCountByStatus> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "EmpListForDashboard [empId=" + empId + ", empName=" + empName + ", list=" + list + "]";
	}
	
	
}
