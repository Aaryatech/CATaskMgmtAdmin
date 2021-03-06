package com.ats.taskmgmtadmin.model;

public class ShowCustActiMapped {
	
	private int mapping_id;
	private String actvStartDate;
	private String actvEndDate;
	private int actvStatutoryDays;
	private String actvManBudgHr;
	private String actvEmpBudgHr;
	private int actvBillingAmt;
	private String custGroupName;
	private String servName;
	private String actiName;
	private String periodicityName;
	public int getMapping_id() {
		return mapping_id;
	}
	public void setMapping_id(int mapping_id) {
		this.mapping_id = mapping_id;
	}
	public String getActvStartDate() {
		return actvStartDate;
	}
	public void setActvStartDate(String actvStartDate) {
		this.actvStartDate = actvStartDate;
	}
	public String getActvEndDate() {
		return actvEndDate;
	}
	public void setActvEndDate(String actvEndDate) {
		this.actvEndDate = actvEndDate;
	}
	public int getActvStatutoryDays() {
		return actvStatutoryDays;
	}
	public void setActvStatutoryDays(int actvStatutoryDays) {
		this.actvStatutoryDays = actvStatutoryDays;
	}
	public String getActvManBudgHr() {
		return actvManBudgHr;
	}
	public void setActvManBudgHr(String actvManBudgHr) {
		this.actvManBudgHr = actvManBudgHr;
	}
	public String getActvEmpBudgHr() {
		return actvEmpBudgHr;
	}
	public void setActvEmpBudgHr(String actvEmpBudgHr) {
		this.actvEmpBudgHr = actvEmpBudgHr;
	}
	public int getActvBillingAmt() {
		return actvBillingAmt;
	}
	public void setActvBillingAmt(int actvBillingAmt) {
		this.actvBillingAmt = actvBillingAmt;
	}
	public String getCustGroupName() {
		return custGroupName;
	}
	public void setCustGroupName(String custGroupName) {
		this.custGroupName = custGroupName;
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
	public String getPeriodicityName() {
		return periodicityName;
	}
	public void setPeriodicityName(String periodicityName) {
		this.periodicityName = periodicityName;
	}
	@Override
	public String toString() {
		return "ShowCustActiMapped [mapping_id=" + mapping_id + ", actvStartDate=" + actvStartDate + ", actvEndDate="
				+ actvEndDate + ", actvStatutoryDays=" + actvStatutoryDays + ", actvManBudgHr=" + actvManBudgHr
				+ ", actvEmpBudgHr=" + actvEmpBudgHr + ", actvBillingAmt=" + actvBillingAmt + ", custGroupName="
				+ custGroupName + ", servName=" + servName + ", actiName=" + actiName + ", periodicityName="
				+ periodicityName + "]";
	}
	
	
}
