package com.ats.taskmgmtadmin.acsrights;

public class Info {
	
	private boolean isError;
	private String msg;
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	@Override
	public String toString() {
		return "Info [isError=" + isError + ", msg=" + msg + "]";
	}
	public void setMessage(String string) {
		// TODO Auto-generated method stub
		
	}
	
	
	

}
