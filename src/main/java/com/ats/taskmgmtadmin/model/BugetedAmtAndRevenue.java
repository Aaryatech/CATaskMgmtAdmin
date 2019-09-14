package com.ats.taskmgmtadmin.model;
 
public class BugetedAmtAndRevenue {
 
	private float bugetedHrs; 
	private float actualHrs; 
	private float bugetedRev; 
	private float actulRev ; 
	float bugetedCost; 
	float actualCost;
	
	public float getBugetedHrs() {
		return bugetedHrs;
	}
	public void setBugetedHrs(float bugetedHrs) {
		this.bugetedHrs = bugetedHrs;
	}
	public float getActualHrs() {
		return actualHrs;
	}
	public void setActualHrs(float actualHrs) {
		this.actualHrs = actualHrs;
	}
	public float getBugetedRev() {
		return bugetedRev;
	}
	public void setBugetedRev(float bugetedRev) {
		this.bugetedRev = bugetedRev;
	}
	public float getActulRev() {
		return actulRev;
	}
	public void setActulRev(float actulRev) {
		this.actulRev = actulRev;
	}
	public float getBugetedCost() {
		return bugetedCost;
	}
	public void setBugetedCost(float bugetedCost) {
		this.bugetedCost = bugetedCost;
	}
	public float getActualCost() {
		return actualCost;
	}
	public void setActualCost(float actualCost) {
		this.actualCost = actualCost;
	}
	@Override
	public String toString() {
		return "BugetedAmtAndRevenue [bugetedHrs=" + bugetedHrs + ", actualHrs=" + actualHrs + ", bugetedRev="
				+ bugetedRev + ", actulRev=" + actulRev + ", bugetedCost=" + bugetedCost + ", actualCost=" + actualCost
				+ "]";
	}
	 
	
	
	
}
