package com.ats.taskmgmtadmin.model;
 
public class SetttingKeyValue {
	
	 
 	private int settingId;
 	
 	private String settingKey ;
 	
	private int intValue ;
	
	private String stringValue ;
 	
	private int delStatus ;
 	
	private String reportDescription;

	public int getSettingId() {
		return settingId;
	}

	public void setSettingId(int settingId) {
		this.settingId = settingId;
	}

	public String getSettingKey() {
		return settingKey;
	}

	public void setSettingKey(String settingKey) {
		this.settingKey = settingKey;
	}

	public int getIntValue() {
		return intValue;
	}

	public void setIntValue(int intValue) {
		this.intValue = intValue;
	}

	public String getStringValue() {
		return stringValue;
	}

	public void setStringValue(String stringValue) {
		this.stringValue = stringValue;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public String getReportDescription() {
		return reportDescription;
	}

	public void setReportDescription(String reportDescription) {
		this.reportDescription = reportDescription;
	}

	@Override
	public String toString() {
		return "SetttingKeyValue [settingId=" + settingId + ", settingKey=" + settingKey + ", intValue=" + intValue
				+ ", stringValue=" + stringValue + ", delStatus=" + delStatus + ", reportDescription="
				+ reportDescription + "]";
	}
	
	

}
