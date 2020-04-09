package com.ats.taskmgmtadmin.model.report;

public class TaskLogEmpInfo {

	private int workLogId;
	private int taskId;
	private String taskText;

	private String taskStatutoryDueDate;
	private String taskCompletionDate;
	private String billingAmt;
	private int empId;
	private int empType;
	private String empName;
	private String workHrs;

	private String empBudHr;
	private String mngrBudHr;
	public int getWorkLogId() {
		return workLogId;
	}
	public void setWorkLogId(int workLogId) {
		this.workLogId = workLogId;
	}
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public String getTaskText() {
		return taskText;
	}
	public void setTaskText(String taskText) {
		this.taskText = taskText;
	}
	public String getTaskStatutoryDueDate() {
		return taskStatutoryDueDate;
	}
	public void setTaskStatutoryDueDate(String taskStatutoryDueDate) {
		this.taskStatutoryDueDate = taskStatutoryDueDate;
	}
	public String getTaskCompletionDate() {
		return taskCompletionDate;
	}
	public void setTaskCompletionDate(String taskCompletionDate) {
		this.taskCompletionDate = taskCompletionDate;
	}
	public String getBillingAmt() {
		return billingAmt;
	}
	public void setBillingAmt(String billingAmt) {
		this.billingAmt = billingAmt;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getEmpType() {
		return empType;
	}
	public void setEmpType(int empType) {
		this.empType = empType;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getWorkHrs() {
		return workHrs;
	}
	public void setWorkHrs(String workHrs) {
		this.workHrs = workHrs;
	}
	public String getEmpBudHr() {
		return empBudHr;
	}
	public void setEmpBudHr(String empBudHr) {
		this.empBudHr = empBudHr;
	}
	public String getMngrBudHr() {
		return mngrBudHr;
	}
	public void setMngrBudHr(String mngrBudHr) {
		this.mngrBudHr = mngrBudHr;
	}
	
	@Override
	public String toString() {
		return "TaskLogEmpInfo [workLogId=" + workLogId + ", taskId=" + taskId + ", taskText=" + taskText
				+ ", taskStatutoryDueDate=" + taskStatutoryDueDate + ", taskCompletionDate=" + taskCompletionDate
				+ ", billingAmt=" + billingAmt + ", empId=" + empId + ", empType=" + empType + ", empName=" + empName
				+ ", workHrs=" + workHrs + ", empBudHr=" + empBudHr + ", mngrBudHr=" + mngrBudHr + "]";
	}

	
	/*
	 * SELECT
	 * 
	 * 
	 * t_tasks.task_id, t_tasks.task_text, t_tasks.task_statutory_due_date,
	 * t_tasks.task_completion_date, t_tasks.billing_amt, m_emp.emp_id,
	 * m_emp.emp_type, m_emp.emp_name ,
	 * 
	 * t_daily_work_log.work_log_id, CONCAT( FLOOR( SUM(t_daily_work_log.work_hours)
	 * / 60 ), '.', LPAD( MOD( SUM(t_daily_work_log.work_hours), 60 ), 2, '0')) as
	 * work_hrs,
	 * 
	 * CONCAT( FLOOR( t_tasks.emp_bud_hr / 60 ), '.', LPAD(MOD( t_tasks.emp_bud_hr ,
	 * 60 ), 2, '0') ) as emp_bud_hr,
	 * 
	 * CONCAT( FLOOR( t_tasks.mngr_bud_hr / 60 ), '.', LPAD(MOD( t_tasks.mngr_bud_hr
	 * , 60 ), 2, '0') ) as mng_bud_hr
	 * 
	 * 
	 * 
	 * FROM m_emp, t_tasks ,t_daily_work_log WHERE
	 * m_emp.emp_id=t_daily_work_log.emp_id and
	 * t_daily_work_log.task_id=t_tasks.task_id and t_tasks.task_id=49 and
	 * t_daily_work_log.del_status=1 and m_emp.del_status=1 and t_tasks.del_status=1
	 * group by t_tasks.task_id,m_emp.emp_id
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
}
