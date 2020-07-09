package com.ats.taskmgmtadmin.model.report;

 


public class WorkLogSub {

 	private int empId;

 
	private String workDate;

	private String workHours;

 
	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	 

	 
	public String getWorkDate() {
		return workDate;
	}

	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}

	public String getWorkHours() {
		return workHours;
	}

	public void setWorkHours(String workHours) {
		this.workHours = workHours;
	}
 
	@Override
	public String toString() {
		return "WorkLogSub [empId=" + empId + ", workDate=" + workDate + ", workHours=" + workHours +  "]";
	}
 
 
}
