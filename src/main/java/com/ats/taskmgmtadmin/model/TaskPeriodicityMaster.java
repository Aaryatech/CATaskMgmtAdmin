package com.ats.taskmgmtadmin.model;


public class TaskPeriodicityMaster {
	
	
	private int taskpId;
	private int finYearId;
	private int actvId;
	private int periodicityId;
	private String taskpDuration;
	private String taskpSubline;
	private String taskpRefdate;
	private String taskpStatutoryDueDate;
	private int delStatus;
	private String updateDatetime;
	private int updateUsername;
	private int ex_int1;
	private int ex_int2;
	private String exVar1;
	private String exVar2;
	
	
	public int getTaskpId() {
		return taskpId;
	}
	public void setTaskpId(int taskpId) {
		this.taskpId = taskpId;
	}
	public int getFinYearId() {
		return finYearId;
	}
	public void setFinYearId(int finYearId) {
		this.finYearId = finYearId;
	}
	public int getActvId() {
		return actvId;
	}
	public void setActvId(int actvId) {
		this.actvId = actvId;
	}
	public int getPeriodicityId() {
		return periodicityId;
	}
	public void setPeriodicityId(int periodicityId) {
		this.periodicityId = periodicityId;
	}
	public String getTaskpDuration() {
		return taskpDuration;
	}
	public void setTaskpDuration(String taskpDuration) {
		this.taskpDuration = taskpDuration;
	}
	public String getTaskpSubline() {
		return taskpSubline;
	}
	public void setTaskpSubline(String taskpSubline) {
		this.taskpSubline = taskpSubline;
	}
	
	public String getTaskpRefdate() {
		return taskpRefdate;
	}
	public void setTaskpRefdate(String taskpRefdate) {
		this.taskpRefdate = taskpRefdate;
	}
	
	public String getTaskpStatutoryDueDate() {
		return taskpStatutoryDueDate;
	}
	public void setTaskpStatutoryDueDate(String taskpStatutoryDueDate) {
		this.taskpStatutoryDueDate = taskpStatutoryDueDate;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public String getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	public int getUpdateUsername() {
		return updateUsername;
	}
	public void setUpdateUsername(int updateUsername) {
		this.updateUsername = updateUsername;
	}
	public int getEx_int1() {
		return ex_int1;
	}
	public void setEx_int1(int ex_int1) {
		this.ex_int1 = ex_int1;
	}
	public int getEx_int2() {
		return ex_int2;
	}
	public void setEx_int2(int ex_int2) {
		this.ex_int2 = ex_int2;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	@Override
	public String toString() {
		return "TaskPeriodicityMaster [taskpId=" + taskpId + ", finYearId=" + finYearId + ", actvId=" + actvId
				+ ", periodicityId=" + periodicityId + ", taskpDuration=" + taskpDuration + ", taskpSubline="
				+ taskpSubline + ", taskpRefdate=" + taskpRefdate + ", taskpStatutoryDueDate=" + taskpStatutoryDueDate
				+ ", delStatus=" + delStatus + ", updateDatetime=" + updateDatetime + ", updateUsername="
				+ updateUsername + ", ex_int1=" + ex_int1 + ", ex_int2=" + ex_int2 + ", exVar1=" + exVar1 + ", exVar2="
				+ exVar2 + "]";
	}
	
}
