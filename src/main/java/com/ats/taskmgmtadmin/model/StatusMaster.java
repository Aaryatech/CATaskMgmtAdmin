package com.ats.taskmgmtadmin.model;

public class StatusMaster {
		
	private int statusId;
	private String statusText;
	private int statusValue;
	private String statusDesc;
	private int isEdit;
	private String empTypeIds;
	private int delStatus;
	private String updateDatetime;
	private int updateUsername;
	private int exInt1;
	private String exVar1;
	public int getStatusId() {
		return statusId;
	}
	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}
	public String getStatusText() {
		return statusText;
	}
	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}
	public int getStatusValue() {
		return statusValue;
	}
	public void setStatusValue(int statusValue) {
		this.statusValue = statusValue;
	}
	public String getStatusDesc() {
		return statusDesc;
	}
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}
	public int getIsEdit() {
		return isEdit;
	}
	public void setIsEdit(int isEdit) {
		this.isEdit = isEdit;
	}	
	public String getEmpTypeIds() {
		return empTypeIds;
	}
	public void setEmpTypeIds(String empTypeIds) {
		this.empTypeIds = empTypeIds;
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
	@Override
	public String toString() {
		return "StatusMaster [statusId=" + statusId + ", statusText=" + statusText + ", statusValue=" + statusValue
				+ ", statusDesc=" + statusDesc + ", isEdit=" + isEdit + ", empTypeIds=" + empTypeIds + ", delStatus="
				+ delStatus + ", updateDatetime=" + updateDatetime + ", updateUsername=" + updateUsername + ", exInt1="
				+ exInt1 + ", exVar1=" + exVar1 + "]";
	}
		
}
