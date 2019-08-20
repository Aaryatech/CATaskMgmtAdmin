package com.ats.taskmgmtadmin.model;

import java.util.List;

public class EmployeeFreeBsyList {
	
	List<EmployeeMaster> freeList; 
	List<EmployeeMaster> bsyList;
	public List<EmployeeMaster> getFreeList() {
		return freeList;
	}
	public void setFreeList(List<EmployeeMaster> freeList) {
		this.freeList = freeList;
	}
	public List<EmployeeMaster> getBsyList() {
		return bsyList;
	}
	public void setBsyList(List<EmployeeMaster> bsyList) {
		this.bsyList = bsyList;
	}
	@Override
	public String toString() {
		return "EmployeeFreeBsyList [freeList=" + freeList + ", bsyList=" + bsyList + "]";
	}
	
	 
	
}
