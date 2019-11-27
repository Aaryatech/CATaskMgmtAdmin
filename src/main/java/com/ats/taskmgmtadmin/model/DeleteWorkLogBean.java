package com.ats.taskmgmtadmin.model;

import java.util.List;

public class DeleteWorkLogBean {
	
	List<DailyWorkLog> logList;
	
	List<PerDayWorkLog> perDayLog;
	
	Info inf;


	public List<PerDayWorkLog> getPerDayLog() {
		return perDayLog;
	}

	public void setPerDayLog(List<PerDayWorkLog> perDayLog) {
		this.perDayLog = perDayLog;
	}

	public List<DailyWorkLog> getLogList() {
		return logList;
	}

	public void setLogList(List<DailyWorkLog> logList) {
		this.logList = logList;
	}	

	public Info getInf() {
		return inf;
	}

	public void setInf(Info inf) {
		this.inf = inf;
	}

	@Override
	public String toString() {
		return "DeleteWorkLogBean [logList=" + logList + ", perDayLog=" + perDayLog + ", inf=" + inf + "]";
	}

}
