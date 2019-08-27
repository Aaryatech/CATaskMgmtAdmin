package com.ats.taskmgmtadmin.model;

public class CustomerDetails {
		
	private int custId;
	private String custFirmName;
	private String custGroupName;
	private String custAssesseeName;
	private String custPanNo;
	private String custEmailId;
	private String custPhoneNo;
	private String empName;
	private int isActive;
	public String exVar1;
	public String exVar2;
	
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public String getCustFirmName() {
		return custFirmName;
	}
	public void setCustFirmName(String custFirmName) {
		this.custFirmName = custFirmName;
	}
	public String getCustGroupName() {
		return custGroupName;
	}
	public void setCustGroupName(String custGroupName) {
		this.custGroupName = custGroupName;
	}
	public String getCustAssesseeName() {
		return custAssesseeName;
	}
	public void setCustAssesseeName(String custAssesseeName) {
		this.custAssesseeName = custAssesseeName;
	}
	public String getCustPanNo() {
		return custPanNo;
	}
	public void setCustPanNo(String custPanNo) {
		this.custPanNo = custPanNo;
	}
	public String getCustEmailId() {
		return custEmailId;
	}
	public void setCustEmailId(String custEmailId) {
		this.custEmailId = custEmailId;
	}
	public String getCustPhoneNo() {
		return custPhoneNo;
	}
	public void setCustPhoneNo(String custPhoneNo) {
		this.custPhoneNo = custPhoneNo;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
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
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	@Override
	public String toString() {
		return "CustomerDetails [custId=" + custId + ", custFirmName=" + custFirmName + ", custGroupName="
				+ custGroupName + ", custAssesseeName=" + custAssesseeName + ", custPanNo=" + custPanNo
				+ ", custEmailId=" + custEmailId + ", custPhoneNo=" + custPhoneNo + ", empName=" + empName
				+ ", isActive=" + isActive + ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + "]";
	}
	
	
}
