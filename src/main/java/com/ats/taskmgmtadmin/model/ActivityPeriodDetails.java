package com.ats.taskmgmtadmin.model;


public class ActivityPeriodDetails {
	

	private int actiId;
	private String actiName;
	private String actiDesc;
	private int periodicityId;
	private String periodicityName;
	private int servId;
	public int getActiId() {
		return actiId;
	}
	public void setActiId(int actiId) {
		this.actiId = actiId;
	}
	public String getActiName() {
		return actiName;
	}
	public void setActiName(String actiName) {
		this.actiName = actiName;
	}
	public int getPeriodicityId() {
		return periodicityId;
	}
	public void setPeriodicityId(int periodicityId) {
		this.periodicityId = periodicityId;
	}
	public String getPeriodicityName() {
		return periodicityName;
	}
	public void setPeriodicityName(String periodicityName) {
		this.periodicityName = periodicityName;
	}
	public int getServId() {
		return servId;
	}
	public void setServId(int servId) {
		this.servId = servId;
	}
	
	public String getActiDesc() {
		return actiDesc;
	}
	public void setActiDesc(String actiDesc) {
		this.actiDesc = actiDesc;
	}
	@Override
	public String toString() {
		return "ActivityPeriodDetails [actiId=" + actiId + ", actiName=" + actiName + ", actiDesc=" + actiDesc
				+ ", periodicityId=" + periodicityId + ", periodicityName=" + periodicityName + ", servId=" + servId
				+ "]";
	}
	

}