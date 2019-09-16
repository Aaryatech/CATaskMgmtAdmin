package com.ats.taskmgmtadmin.model;

import java.util.List;

public class ActiveHomeTaskList {

	
	 List<TaskListHome> taskList;
	
	 List<ServiceMaster> servicMstrList;
	
	 List<CustNameId> custList;
	
	 List<StatusMaster> statusMstrList;

	public List<TaskListHome> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<TaskListHome> taskList) {
		this.taskList = taskList;
	}

	public List<ServiceMaster> getServicMstrList() {
		return servicMstrList;
	}

	public void setServicMstrList(List<ServiceMaster> servicMstrList) {
		this.servicMstrList = servicMstrList;
	}

	public List<CustNameId> getCustList() {
		return custList;
	}

	public void setCustList(List<CustNameId> custList) {
		this.custList = custList;
	}

	public List<StatusMaster> getStatusMstrList() {
		return statusMstrList;
	}

	public void setStatusMstrList(List<StatusMaster> statusMstrList) {
		this.statusMstrList = statusMstrList;
	}

	@Override
	public String toString() {
		return "ActiveHomeTaskList [taskList=" + taskList + ", servicMstrList=" + servicMstrList + ", custList="
				+ custList + ", statusMstrList=" + statusMstrList + "]";
	}
	
	
}
