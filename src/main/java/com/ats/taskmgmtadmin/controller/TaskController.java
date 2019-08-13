package com.ats.taskmgmtadmin.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("session")
public class TaskController {
	
	
	@RequestMapping(value = "/assignTask", method = RequestMethod.GET)
	public String assignTask(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/assigntask" ;

		return mav;
	}
	
	/*@RequestMapping(value = "/selectEmployeeToAssigTask", method = RequestMethod.GET)
	public String selectEmployeeToAssigTask(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/empListToAssignTask" ;

		return mav;
	}*/
	
	@RequestMapping(value = "/selectEmployeeToAssigTask", method = RequestMethod.GET)
	public String selectEmployeeToAssigTask(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/showEmpListForAssignTask" ;

		return mav;
	}
	
	@RequestMapping(value = "/showDailyWorkLog", method = RequestMethod.GET)
	public String showDailyWorkLog(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "task/showDailyWorkLog" ;

		return mav;
	}

}
