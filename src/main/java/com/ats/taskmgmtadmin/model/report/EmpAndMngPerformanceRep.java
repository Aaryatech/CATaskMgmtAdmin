package com.ats.taskmgmtadmin.model.report;

 
public class EmpAndMngPerformanceRep {
	
	 private int empId;
		
		private String empName;
		
		private int empType;

		private String taskCount;
		
		private String allWork;
		
		private String actWork;
		
		private String budgetedCap;
		
		private String tillDate;
		
		private String exVar1;

		public int getEmpId() {
			return empId;
		}

		public void setEmpId(int empId) {
			this.empId = empId;
		}

		public String getEmpName() {
			return empName;
		}

		public void setEmpName(String empName) {
			this.empName = empName;
		}

		public int getEmpType() {
			return empType;
		}

		public void setEmpType(int empType) {
			this.empType = empType;
		}

		public String getTaskCount() {
			return taskCount;
		}

		public void setTaskCount(String taskCount) {
			this.taskCount = taskCount;
		}

		public String getAllWork() {
			return allWork;
		}

		public void setAllWork(String allWork) {
			this.allWork = allWork;
		}

		public String getActWork() {
			return actWork;
		}

		public void setActWork(String actWork) {
			this.actWork = actWork;
		}

		public String getBudgetedCap() {
			return budgetedCap;
		}

		public void setBudgetedCap(String budgetedCap) {
			this.budgetedCap = budgetedCap;
		}

		public String getTillDate() {
			return tillDate;
		}

		public void setTillDate(String tillDate) {
			this.tillDate = tillDate;
		}

		public String getExVar1() {
			return exVar1;
		}

		public void setExVar1(String exVar1) {
			this.exVar1 = exVar1;
		}

		@Override
		public String toString() {
			return "EmpAndMngPerformanceRep [empId=" + empId + ", empName=" + empName + ", empType=" + empType
					+ ", taskCount=" + taskCount + ", allWork=" + allWork + ", actWork=" + actWork + ", budgetedCap="
					+ budgetedCap + ", tillDate=" + tillDate + ", exVar1=" + exVar1 + "]";
		}
}