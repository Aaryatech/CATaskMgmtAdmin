package com.ats.taskmgmtadmin.model.custdetail;

public class GetCustSignatory {
	
	private int signId;
	
	private String custFirmName;
	private String signfName;
	private String signlName;
	private String signRegNo;
	private String signDesign;
	private String signPhno;
	private String contactName;
	private String contactEmail;
	private String contactPhno;
	
	private String custRemark;
	
	private int custId;
	
	public int getSignId() {
		return signId;
	}
	public void setSignId(int signId) {
		this.signId = signId;
	}
	public String getCustFirmName() {
		return custFirmName;
	}
	public void setCustFirmName(String custFirmName) {
		this.custFirmName = custFirmName;
	}
	
	public String getSignfName() {
		return signfName;
	}
	public void setSignfName(String signfName) {
		this.signfName = signfName;
	}
	public String getSignlName() {
		return signlName;
	}
	public void setSignlName(String signlName) {
		this.signlName = signlName;
	}
	public String getSignRegNo() {
		return signRegNo;
	}
	public void setSignRegNo(String signRegNo) {
		this.signRegNo = signRegNo;
	}
	public String getSignDesign() {
		return signDesign;
	}
	public void setSignDesign(String signDesign) {
		this.signDesign = signDesign;
	}
	public String getSignPhno() {
		return signPhno;
	}
	public void setSignPhno(String signPhno) {
		this.signPhno = signPhno;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getContactEmail() {
		return contactEmail;
	}
	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}
	public String getContactPhno() {
		return contactPhno;
	}
	public void setContactPhno(String contactPhno) {
		this.contactPhno = contactPhno;
	}
	
	
	
	public String getCustRemark() {
		return custRemark;
	}
	public void setCustRemark(String custRemark) {
		this.custRemark = custRemark;
	}
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	@Override
	public String toString() {
		return "GetCustSignatory [signId=" + signId + ", custFirmName=" + custFirmName + ", signfName=" + signfName
				+ ", signlName=" + signlName + ", signRegNo=" + signRegNo + ", signDesign=" + signDesign + ", signPhno="
				+ signPhno + ", contactName=" + contactName + ", contactEmail=" + contactEmail + ", contactPhno="
				+ contactPhno + ", custRemark=" + custRemark + ", custId=" + custId + "]";
	}
	

	


}
