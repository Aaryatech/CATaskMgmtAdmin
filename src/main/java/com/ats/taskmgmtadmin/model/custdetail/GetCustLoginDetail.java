package com.ats.taskmgmtadmin.model.custdetail;

public class GetCustLoginDetail {

	private int custDetailId;
	
	private int custId;
	
	
	private String custFirmName;
	private String servName;
	private String actiName;
	private String loginId;
	
	private String loginPass;
	private String loginQue1;
	private String loginAns1;
	private String loginQue2;
	private String loginAns2;
	private String loginRemark;
	public int getCustDetailId() {
		return custDetailId;
	}
	public void setCustDetailId(int custDetailId) {
		this.custDetailId = custDetailId;
	}
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
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginPass() {
		return loginPass;
	}
	public void setLoginPass(String loginPass) {
		this.loginPass = loginPass;
	}
	public String getLoginQue1() {
		return loginQue1;
	}
	public void setLoginQue1(String loginQue1) {
		this.loginQue1 = loginQue1;
	}
	public String getLoginAns1() {
		return loginAns1;
	}
	public void setLoginAns1(String loginAns1) {
		this.loginAns1 = loginAns1;
	}
	public String getLoginQue2() {
		return loginQue2;
	}
	public void setLoginQue2(String loginQue2) {
		this.loginQue2 = loginQue2;
	}
	public String getLoginAns2() {
		return loginAns2;
	}
	public void setLoginAns2(String loginAns2) {
		this.loginAns2 = loginAns2;
	}
	public String getLoginRemark() {
		return loginRemark;
	}
	public void setLoginRemark(String loginRemark) {
		this.loginRemark = loginRemark;
	}
	@Override
	public String toString() {
		return "GetCustLoginDetail [custDetailId=" + custDetailId + ", custId=" + custId + ", custFirmName="
				+ custFirmName + ", servName=" + servName + ", actiName=" + actiName + ", loginId=" + loginId
				+ ", loginPass=" + loginPass + ", loginQue1=" + loginQue1 + ", loginAns1=" + loginAns1 + ", loginQue2="
				+ loginQue2 + ", loginAns2=" + loginAns2 + ", loginRemark=" + loginRemark + "]";
	}
	
	
	
}
