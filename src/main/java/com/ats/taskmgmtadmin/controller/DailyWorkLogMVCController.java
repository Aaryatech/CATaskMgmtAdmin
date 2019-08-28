package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.CustNameId;
import com.ats.taskmgmtadmin.model.DailyWorkLog;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.ServiceMaster;

@Controller
@SessionScope
public class DailyWorkLogMVCController {

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	String curDateTime = dateFormat.format(cal.getTime());

	MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
	HttpSession session = null;
	
	/************************Daily Work Log************************/
	
	@RequestMapping(value = "/workLogList", method = RequestMethod.GET)
	public ModelAndView serviceListForm(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		ModelAndView mav = new ModelAndView("master/homeTaskList");
		try {
			MultiValueMap<String, Object> map =  new LinkedMultiValueMap<String, Object>();	
			
			 session = request.getSession();
			 			
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");				
			map.add("empid", empSes.getEmpId());
			
			DailyWorkLog[] logArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllDailyWorkLogs",
					DailyWorkLog[].class);
			List<DailyWorkLog> logList = new ArrayList<>(Arrays.asList(logArr));
			mav.addObject("logList", logList);

			// logger.info("Service List"+srvcMstrList);

		} catch (Exception e) {
			System.err.println("Exce in workLogList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	
	@RequestMapping(value = "/newWorkLog", method = RequestMethod.POST)
	public String newWorkLog(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
				int logId = 0;
						try {
							logId = Integer.parseInt(request.getParameter("logId"));
						}catch (Exception e) {
							e.getMessage();
						}
			
				session = request.getSession();
			
				EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			
				DailyWorkLog workLog = new DailyWorkLog();
				String hrs = request.getParameter("workHour");
				String workHrs = hrs.replace(":", ".");
				workLog.setDelStatus(1);
				workLog.setEmpId(empSes.getEmpId());
				workLog.setExInt1(0);
				workLog.setExInt2(0);
				workLog.setExVar1("NA");
				workLog.setExVar2("NA");
				workLog.setTaskId(Integer.parseInt(request.getParameter("taskId")));
				workLog.setUpdateDatetime(curDateTime);
				workLog.setUpdateUsername(empSes.getEmpId());
				workLog.setWorkDate(request.getParameter("workDate"));
				workLog.setWorkHours(Float.parseFloat(workHrs));
				workLog.setWorkLogId(logId);
				workLog.setWorkRemark(request.getParameter("remark"));
				
				DailyWorkLog logData = Constants.getRestTemplate().postForObject(Constants.url + "/addNewWorkLog",workLog, DailyWorkLog.class);
				
							
		}catch (Exception e) {
			System.err.println("Exce in newWorkLog " + e.getMessage());
			e.printStackTrace();
		}
		
		return "redirect:/taskListForEmp";
		
	}
	
	@RequestMapping(value = "/getDailyWorkLogByTaskId", method = RequestMethod.GET)
	public @ResponseBody List<DailyWorkLog> getDailyWorkLogByEmpId(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			List<DailyWorkLog> logList = null;
		try {
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			System.out.println("getDailyWorkLogByEmpId ----- Service Called "+ taskId);
			MultiValueMap<String, Object> map =  new LinkedMultiValueMap<String, Object>();	
			
			 session = request.getSession();
			 			
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");				
			map.add("taskId", taskId);
			
			DailyWorkLog[] logArr = Constants.getRestTemplate().postForObject(Constants.url + "/getAllDailyWorkLogs", map,
					DailyWorkLog[].class);
			 logList = new ArrayList<>(Arrays.asList(logArr));
			
			 System.out.println("Log List----------"+logList.toString());
			/*
			 * for (int i = 0; i < logList.size(); i++) {
			 * 
			 * logList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(logList.get(i)
			 * .getWorkLogId())));
			 * 
			 * }
			 */

		} catch (Exception e) {
			System.err.println("Exce in workLogList " + e.getMessage());
			e.printStackTrace();
		}
		return logList;
	}
	
	@RequestMapping(value = "/editWorkLogById", method = RequestMethod.GET)
	public ModelAndView editWorkLogById(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		ModelAndView mav = new ModelAndView("master/homeTaskList");
		try {
			String base64encodedString = request.getParameter("logId");			
			String logId = FormValidation.DecodeKey(base64encodedString);
			
			
			MultiValueMap<String, Object> map =  new LinkedMultiValueMap<String, Object>();	
			
			 session = request.getSession();
			 			
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");				
			map.add("empid", empSes.getEmpId());
			
			map.add("logId", logId);
			
			DailyWorkLog workLog = Constants.getRestTemplate().postForObject(Constants.url + "/getAllDailyWorkLogs",map,
					DailyWorkLog.class);
			
			mav.addObject("workLog", workLog);

			// logger.info("Service List"+srvcMstrList);

		} catch (Exception e) {
			System.err.println("Exce in workLogList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
}
