package com.ats.taskmgmtadmin.model;

import java.util.List;

public class WorkLogBean {
	
	List<DailyWorkLog> logList;
	
	List<PerDayWorkLog> perDayLog;


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

	@Override
	public String toString() {
		return "WorkLogBean [logList=" + logList + ", perDayLog=" + perDayLog + "]";
	}

	
	
	
	
}
