package com.ats.taskmgmtadmin.model;

public class TaskListHome {
	
	private int taskId;
	private String taskText;
	private String taskStartDate;
	private String taskEndDate;
	private String taskStatutoryDueDate;
	private String mngrBudHr;
	private String empBudHr;
	private String taskEmpIds;
	private String empName;
	private int empId;
	private String servName;
	private String actiName;
	private String periodicityName;
	private String custGroupName;
	private String finYearName;
	private String taskStatus;
	private String statusColor;
	private int exInt1;
	private String exVar1;
	private int exInt2;
	private String exVar2;
	private String employees;	
	
	
	public String getEmployees() {
		return employees;
	}
	public void setEmployees(String employees) {
		this.employees = employees;
	}
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public String getTaskText() {
		return taskText;
	}
	public void setTaskText(String taskText) {
		this.taskText = taskText;
	}
	
	public String getTaskStartDate() {
		return taskStartDate;
	}
	public void setTaskStartDate(String taskStartDate) {
		this.taskStartDate = taskStartDate;
	}
	
	public String getTaskEndDate() {
		return taskEndDate;
	}
	public void setTaskEndDate(String taskEndDate) {
		this.taskEndDate = taskEndDate;
	}
	
	public String getTaskStatutoryDueDate() {
		return taskStatutoryDueDate;
	}
	public void setTaskStatutoryDueDate(String taskStatutoryDueDate) {
		this.taskStatutoryDueDate = taskStatutoryDueDate;
	}
	public String getMngrBudHr() {
		return mngrBudHr;
	}
	public void setMngrBudHr(String mngrBudHr) {
		this.mngrBudHr = mngrBudHr;
	}
	public String getEmpBudHr() {
		return empBudHr;
	}
	public void setEmpBudHr(String empBudHr) {
		this.empBudHr = empBudHr;
	}
	public String getTaskEmpIds() {
		return taskEmpIds;
	}
	public void setTaskEmpIds(String taskEmpIds) {
		this.taskEmpIds = taskEmpIds;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getServName() {
		return servName;
	}
	public void setServName(String servName) {
		this.servName = servName;
	}
	public String getActiName() {
		return actiName;
	}
	public void setActiName(String actiName) {
		this.actiName = actiName;
	}
	public String getPeriodicityName() {
		return periodicityName;
	}
	public void setPeriodicityName(String periodicityName) {
		this.periodicityName = periodicityName;
	}
	public String getFinYearName() {
		return finYearName;
	}
	public void setFinYearName(String finYearName) {
		this.finYearName = finYearName;
	}
	
	  public String getCustGroupName() 
	  { 
		  return custGroupName; 
	  } 
	  public void setCustGroupName(String custGroupName) 
	  { 
		  this.custGroupName = custGroupName;
	  } 
	
	public String getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}
	public String getStatusColor() {
		return statusColor;
	}
	public void setStatusColor(String statusColor) {
		this.statusColor = statusColor;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getExInt1() {
		return exInt1;
	}
	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public int getExInt2() {
		return exInt2;
	}
	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	@Override
	public String toString() {
		return "TaskListHome [taskId=" + taskId + ", taskText=" + taskText + ", taskStartDate=" + taskStartDate
				+ ", taskEndDate=" + taskEndDate + ", taskStatutoryDueDate=" + taskStatutoryDueDate + ", mngrBudHr="
				+ mngrBudHr + ", empBudHr=" + empBudHr + ", taskEmpIds=" + taskEmpIds + ", empName=" + empName
				+ ", empId=" + empId + ", servName=" + servName + ", actiName=" + actiName + ", periodicityName="
				+ periodicityName + ", custGroupName=" + custGroupName + ", finYearName=" + finYearName
				+ ", taskStatus=" + taskStatus + ", statusColor=" + statusColor + ", exInt1=" + exInt1 + ", exVar1="
				+ exVar1 + ", exInt2=" + exInt2 + ", exVar2=" + exVar2 + ", employees=" + employees + "]";
	}
	
}
