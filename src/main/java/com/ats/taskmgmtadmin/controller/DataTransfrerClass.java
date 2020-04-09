package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.List;

import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.ServiceMaster;

public class DataTransfrerClass {

	List<ServiceMaster> servList;
	List<CustomerDetails> custList;
	
	
	public List<ServiceMaster> getServList() {
		return servList;
	}


	public void setServList(List<ServiceMaster> servList) {
		this.servList = servList;
	}


	public List<CustomerDetails> getCustList() {
		return custList;
	}


	public void setCustList(List<CustomerDetails> custList) {
		this.custList = custList;
	}


	@Override
	public String toString() {
		return "DataTransfrerClass [servList=" + servList + ", custList=" + custList + "]";
	}
	
	

}
