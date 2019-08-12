package com.ats.taskmgmtadmin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope("session")
public class LeaveController {

	@RequestMapping(value = "/showEmpListForLeave", method = RequestMethod.GET)
	public String showEmpListForLeave(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "leave/showEmpListForLeave" ;

		return mav;
	}
	
	
	@RequestMapping(value = "/leaveApply", method = RequestMethod.GET)
	public String leaveApply(HttpServletRequest request, HttpServletResponse response, Model model) {

		
		String mav =  "leave/leaveApplication" ;

		return mav;
	}
	
	@RequestMapping(value = "/showLeaveHistList", method = RequestMethod.GET)
	public String showLeaveHistList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav =  "leave/showLeaveHistList" ;

		return mav;
	}
}
