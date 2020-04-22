package com.ats.taskmgmtadmin.model.report;

public class WorkLogDetailReport {
	
	private Integer workLogId;
	
	private String workDate;
	
	private int empId;
	private int taskId;
	private String workHours;
	private String workRemark;
	private String workMin;
	private String updateDatetime;
	public Integer getWorkLogId() {
		return workLogId;
	}
	public void setWorkLogId(Integer workLogId) {
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
	public String getWorkRemark() {
		return workRemark;
	}
	public void setWorkRemark(String workRemark) {
		this.workRemark = workRemark;
	}
	public String getWorkMin() {
		return workMin;
	}
	public void setWorkMin(String workMin) {
		this.workMin = workMin;
	}
	public String getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	@Override
	public String toString() {
		return "WorkLogDetailReport [workLogId=" + workLogId + ", workDate=" + workDate + ", empId=" + empId
				+ ", taskId=" + taskId + ", workHours=" + workHours + ", workRemark=" + workRemark + ", workMin="
				+ workMin + ", updateDatetime=" + updateDatetime + "]";
	}
	
	
	
	
	

}
