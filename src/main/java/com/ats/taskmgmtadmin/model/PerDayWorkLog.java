package com.ats.taskmgmtadmin.model;

public class PerDayWorkLog {
	
	private int workLogId;
	private String workDate;
	private int empId;
	private int taskId;
	private String workHours;
	private String empName; 
	private int empType;
	//private int extInt1;
	//private String exVar1;
	public int getWorkLogId() {
		return workLogId;
	}
	public void setWorkLogId(int workLogId) {
		this.workLogId = workLogId;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public String getWorkHours() {
		return workHours;
	}
	public void setWorkHours(String workHours) {
		this.workHours = workHours;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public int getEmpType() {
		return empType;
	}
	public void setEmpType(int empType) {
		this.empType = empType;
	}
	/*public int getExtInt1() {
		return extInt1;
	}
	public void setExtInt1(int extInt1) {
		this.extInt1 = extInt1;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}*/
	@Override
	public String toString() {
		return "PerDayWorkLog [workLogId=" + workLogId + ", workDate=" + workDate + ", empId=" + empId + ", taskId="
				+ taskId + ", workHours=" + workHours + ", empName=" + empName + ", empType=" + empType + "]";
	}
	
}
