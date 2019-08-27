package com.ats.taskmgmtadmin.model;

public class CustNameId {
	
	private int custId;
	
	private String custName;

	public int isActive;
	
	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}
	
	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	@Override
	public String toString() {
		return "CustNameId [custId=" + custId + ", custName=" + custName + ", isActive=" + isActive + "]";
	}

	
}
