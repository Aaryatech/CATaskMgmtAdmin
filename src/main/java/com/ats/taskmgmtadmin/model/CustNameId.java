package com.ats.taskmgmtadmin.model;

public class CustNameId {
	
	private int custId;
	
	private String custName;

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

	@Override
	public String toString() {
		return "CustNameId [custId=" + custId + ", custName=" + custName + "]";
	}
	
	

}
