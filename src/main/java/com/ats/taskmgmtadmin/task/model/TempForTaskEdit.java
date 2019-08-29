package com.ats.taskmgmtadmin.task.model;

import java.util.List;

import com.ats.taskmgmtadmin.model.EmployeeMaster;

public class TempForTaskEdit {

	List<EmployeeMaster> empList; 
	 Task task;
	 
	 List<Integer> empId; 
	 
	 
	public List<EmployeeMaster> getEmpList() {
		return empList;
	}
	public void setEmpList(List<EmployeeMaster> empList) {
		this.empList = empList;
	}
	public Task getTask() {
		return task;
	}
	public void setTask(Task task) {
		this.task = task;
	}
	public List<Integer> getEmpId() {
		return empId;
	}
	public void setEmpId(List<Integer> empId) {
		this.empId = empId;
	}
	@Override
	public String toString() {
		return "TempForTaskEdit [empList=" + empList + ", task=" + task + ", empId=" + empId + "]";
	}
	
	
	 
	 
	
}
