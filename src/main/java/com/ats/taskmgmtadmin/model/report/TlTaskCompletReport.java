package com.ats.taskmgmtadmin.model.report;

import java.util.Date;

public class TlTaskCompletReport {

	private int taskId;
	private String clientName;
	private String service;
	private String activity;
	private String taskPeriodicity;
	private String executionPartner;
	private String managerName;
	private String teamLeadName;
	private String dueDate;
	private String completionDate;
	private String startDate;
	private String empBudHr;
	private String mngrBudHr;
	private String admin;
	private String employee;
	private String ttlEmpHrs;
	private String tlPeriodHrs;
	private String workHours;
	private String taskText;
	private String tlTotalHrs;
	
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getTaskPeriodicity() {
		return taskPeriodicity;
	}
	public void setTaskPeriodicity(String taskPeriodicity) {
		this.taskPeriodicity = taskPeriodicity;
	}
	public String getExecutionPartner() {
		return executionPartner;
	}
	public void setExecutionPartner(String executionPartner) {
		this.executionPartner = executionPartner;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	
	public String getTeamLeadName() {
		return teamLeadName;
	}
	public void setTeamLeadName(String teamLeadName) {
		this.teamLeadName = teamLeadName;
	}
	public String getDueDate() {
		return dueDate;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	public String getCompletionDate() {
		return completionDate;
	}
	public void setCompletionDate(String completionDate) {
		this.completionDate = completionDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEmpBudHr() {
		return empBudHr;
	}
	public void setEmpBudHr(String empBudHr) {
		this.empBudHr = empBudHr;
	}
	public String getMngrBudHr() {
		return mngrBudHr;
	}
	public void setMngrBudHr(String mngrBudHr) {
		this.mngrBudHr = mngrBudHr;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getEmployee() {
		return employee;
	}
	public void setEmployee(String employee) {
		this.employee = employee;
	}
	public String getTtlEmpHrs() {
		return ttlEmpHrs;
	}
	public void setTtlEmpHrs(String ttlEmpHrs) {
		this.ttlEmpHrs = ttlEmpHrs;
	}
	public String getTlPeriodHrs() {
		return tlPeriodHrs;
	}
	public void setTlPeriodHrs(String tlPeriodHrs) {
		this.tlPeriodHrs = tlPeriodHrs;
	}
	public String getWorkHours() {
		return workHours;
	}
	public void setWorkHours(String workHours) {
		this.workHours = workHours;
	}
	public String getTaskText() {
		return taskText;
	}
	public void setTaskText(String taskText) {
		this.taskText = taskText;
	}
	public String getTlTotalHrs() {
		return tlTotalHrs;
	}
	public void setTlTotalHrs(String tlTotalHrs) {
		this.tlTotalHrs = tlTotalHrs;
	}
	@Override
	public String toString() {
		return "TlTaskCompletReport [taskId=" + taskId + ", clientName=" + clientName + ", Service=" + service
				+ ", Activity=" + activity + ", taskPeriodicity=" + taskPeriodicity + ", executionPartner="
				+ executionPartner + ", managerName=" + managerName + ", teamLeadName=" + teamLeadName + ", dueDate="
				+ dueDate + ", completionDate=" + completionDate + ", startDate=" + startDate + ", empBudHr=" + empBudHr
				+ ", mngrBudHr=" + mngrBudHr + ", admin=" + admin + ", employee=" + employee + ", ttlEmpHrs="
				+ ttlEmpHrs + ", tlPeriodHrs=" + tlPeriodHrs + ", workHours=" + workHours + ", taskText=" + taskText
				+ ", tlTotalHrs=" + tlTotalHrs + "]";
	}
	
	
	
}
