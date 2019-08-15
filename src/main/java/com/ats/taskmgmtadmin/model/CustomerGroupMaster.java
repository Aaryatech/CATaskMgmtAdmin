package com.ats.taskmgmtadmin.model;

public class CustomerGroupMaster {
	
	private int custGroupId;
	private String custGroupName;
	private String custGroupRemark;
	private int delStatus;
	private String updateDatetime;
	private int updateUsername;
	private int exInt1;
	private int exInt2;
	private String exVar1;
	private String exVar2;
	public int getCustGroupId() {
		return custGroupId;
	}
	public void setCustGroupId(int custGroupId) {
		this.custGroupId = custGroupId;
	}
	public String getCustGroupName() {
		return custGroupName;
	}
	public void setCustGroupName(String custGroupName) {
		this.custGroupName = custGroupName;
	}
	
	public String getCustGroupRemark() {
		return custGroupRemark;
	}
	public void setCustGroupRemark(String custGroupRemark) {
		this.custGroupRemark = custGroupRemark;
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
	public int getExInt1() {
		return exInt1;
	}
	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}
	public int getExInt2() {
		return exInt2;
	}
	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
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
		return "CustomerGroupMaster [custGroupId=" + custGroupId + ", custGroupName=" + custGroupName
				+ ", custGroupRemark=" + custGroupRemark + ", delStatus=" + delStatus + ", updateDatetime="
				+ updateDatetime + ", updateUsername=" + updateUsername + ", exInt1=" + exInt1 + ", exInt2=" + exInt2
				+ ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + "]";
	}
	
}
