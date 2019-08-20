package com.ats.taskmgmtadmin.controller;

 

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;


import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.EmployeeFreeBsyList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
 import com.ats.taskmgmtadmin.task.model.GetTaskList;

@Controller
@Scope("session")
public class TaskController {
	
	List<EmployeeMaster> empList=new ArrayList<EmployeeMaster>();
	RestTemplate rest = new RestTemplate();
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String curDate = dateFormat.format(new Date());
	String dateTime = dateFormat.format(now);
	
	@RequestMapping(value = "/assignTask", method = RequestMethod.GET)
	public String assignTask(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/assigntask" ;
		
		GetTaskList[] holListArray = rest.getForObject(Constants.url + "/getAllTaskList", GetTaskList[].class);

		List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

		for (int i = 0; i < taskList.size(); i++) {

			taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
		}
		model.addAttribute("taskList", taskList);


		return mav;
	}
	
	
	
	@RequestMapping(value = "/selectEmployeeToAssigTask", method = RequestMethod.GET)
	public String selectEmployeeToAssigTask(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/showEmpListForAssignTask" ;
		
		//String[] TaskId = request.getParameterValues("TaskId");
		//System.out.println("task id are**"+TaskId.toString());

		return mav;
	}
	
	
	@RequestMapping(value = "/getFreeEmployeeList", method = RequestMethod.GET)
	public @ResponseBody List<EmployeeMaster> getFreeEmployeeList(HttpServletRequest request,
			HttpServletResponse response) {
		
		try {
		int catId = Integer.parseInt(request.getParameter("catId"));
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("roleId", catId);
		EmployeeMaster[] holListArray = rest.postForObject(Constants.url + "/getEmpByEmpTypeId",map, EmployeeMaster[].class);

		empList = new ArrayList<>(Arrays.asList(holListArray));
		
		System.out.println("emp list by type"+empList.toString());
		}catch (Exception e) {

			e.printStackTrace();
		}
		
		return empList;
	}
	
	
	@RequestMapping(value = "/moveEmp", method = RequestMethod.GET)
	public @ResponseBody EmployeeFreeBsyList moveEmp(HttpServletRequest request, HttpServletResponse response) {
		EmployeeFreeBsyList empListTot=new EmployeeFreeBsyList();
		try {
			System.out.println("Hii in moveEmp");

			String empIds = request.getParameter("empId");
			String[] empId = empIds.split(",");
			System.out.println(Arrays.asList(empId));

			List<EmployeeMaster> empListNew=new ArrayList<EmployeeMaster>();
			
			for (int j = 0; j < empList.size(); j++) {
			
			for (int i = 1; i < empId.length; i++) {
				
				if(empList.get(j).getEmpId() == Integer.parseInt(empId[i])) {
					empListNew.add(empList.get(j));
					empList.remove(j);
					
					break;
					
				}
			}
			}
			
			System.out.println("Complete emp 1** "+empList.toString());
			System.out.println("Complete emp 2** "+empListNew.toString());
			empListTot.setBsyList(empList);
			empListTot.setFreeList(empListNew);
			System.out.println("Complete emp list is** "+empListTot.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return empListTot;
	}

	
	@RequestMapping(value = "/showDailyWorkLog", method = RequestMethod.GET)
	public String showDailyWorkLog(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/showDailyWorkLog" ;

		return mav;
	}

}
