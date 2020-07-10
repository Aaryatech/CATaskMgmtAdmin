package com.ats.taskmgmtadmin.model.report;

 
 
import java.util.List;

 
 public class WorkLogSub {

 	private int empId;

	private List<String> status;

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public List<String> getStatus() {
		return status;
	}

	public void setStatus(List<String> status) {
		this.status = status;
	}

}
