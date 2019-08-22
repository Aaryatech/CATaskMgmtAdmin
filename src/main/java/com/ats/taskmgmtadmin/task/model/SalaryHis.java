package com.ats.taskmgmtadmin.task.model;

import java.util.List;

import com.ats.taskmgmtadmin.model.EmployeeMaster;

 
public class SalaryHis {
	
	List<EmployeeMaster> empList; 
	List<EmpSalary> empSalList;
	public List<EmployeeMaster> getEmpList() {
		return empList;
	}
	public void setEmpList(List<EmployeeMaster> empList) {
		this.empList = empList;
	}
	public List<EmpSalary> getEmpSalList() {
		return empSalList;
	}
	public void setEmpSalList(List<EmpSalary> empSalList) {
		this.empSalList = empSalList;
	}
	@Override
	public String toString() {
		return "SalaryHis [empList=" + empList + ", empSalList=" + empSalList + "]";
	}
	 
	 

}
