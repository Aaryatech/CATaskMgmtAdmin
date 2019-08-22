package com.ats.taskmgmtadmin.model;

import java.util.List;
 

public class EmpListWithDateWiseDetail {
	
	private int empId;
	private String empName; 
	List<DateWithAttendanceSts> atndsList;
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
	public List<DateWithAttendanceSts> getAtndsList() {
		return atndsList;
	}
	public void setAtndsList(List<DateWithAttendanceSts> atndsList) {
		this.atndsList = atndsList;
	}
	@Override
	public String toString() {
		return "EmpListWithDateWiseDetail [empId=" + empId + ", empName=" + empName + ", atndsList=" + atndsList + "]";
	}
	
	

}
