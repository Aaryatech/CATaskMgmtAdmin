package com.ats.taskmgmtadmin.model;

public class FirmType {
	
	private int firmId;
	private String firmTypeName;
	private int delStatus;
	public int getFirmId() {
		return firmId;
	}
	public void setFirmId(int firmId) {
		this.firmId = firmId;
	}
	public String getFirmTypeName() {
		return firmTypeName;
	}
	public void setFirmTypeName(String firmTypeName) {
		this.firmTypeName = firmTypeName;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	@Override
	public String toString() {
		return "FirmType [firmId=" + firmId + ", firmTypeName=" + firmTypeName + ", delStatus=" + delStatus + "]";
	}
	
}
