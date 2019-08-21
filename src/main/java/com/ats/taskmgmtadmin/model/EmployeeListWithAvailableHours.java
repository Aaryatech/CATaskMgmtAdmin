package com.ats.taskmgmtadmin.model;
   
public class EmployeeListWithAvailableHours {
 
	private int leaveId; 
	private int calYrId; 
	private int empId; 
	private int leaveDuration; 
	private String leaveFromdt; 
	private String leaveTodt ; 
	private float leaveNumDays; 
	private String empName; 
	float bsyHours;
	public int getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}
	public int getCalYrId() {
		return calYrId;
	}
	public void setCalYrId(int calYrId) {
		this.calYrId = calYrId;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getLeaveDuration() {
		return leaveDuration;
	}
	public void setLeaveDuration(int leaveDuration) {
		this.leaveDuration = leaveDuration;
	}
	public String getLeaveFromdt() {
		return leaveFromdt;
	}
	public void setLeaveFromdt(String leaveFromdt) {
		this.leaveFromdt = leaveFromdt;
	}
	public String getLeaveTodt() {
		return leaveTodt;
	}
	public void setLeaveTodt(String leaveTodt) {
		this.leaveTodt = leaveTodt;
	}
	public float getLeaveNumDays() {
		return leaveNumDays;
	}
	public void setLeaveNumDays(float leaveNumDays) {
		this.leaveNumDays = leaveNumDays;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public float getBsyHours() {
		return bsyHours;
	}
	public void setBsyHours(float bsyHours) {
		this.bsyHours = bsyHours;
	}
	@Override
	public String toString() {
		return "EmployeeListWithAvailableHours [leaveId=" + leaveId + ", calYrId=" + calYrId + ", empId=" + empId
				+ ", leaveDuration=" + leaveDuration + ", leaveFromdt=" + leaveFromdt + ", leaveTodt=" + leaveTodt
				+ ", leaveNumDays=" + leaveNumDays + ", empName=" + empName + ", bsyHours=" + bsyHours + "]";
	}
	
	
}
