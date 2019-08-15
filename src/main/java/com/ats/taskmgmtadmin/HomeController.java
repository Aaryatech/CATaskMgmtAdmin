package com.ats.taskmgmtadmin;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
/*	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}*/
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(Locale locale, Model model) {

		//ModelAndView mav = new ModelAndView("login");
		
		ModelAndView mav = new ModelAndView("home");

		return mav;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {

		//ModelAndView mav = new ModelAndView("login");
		
		ModelAndView mav = new ModelAndView("loginDemo");

		return mav;
	}
	
	/*
	 * @RequestMapping(value = "/customerAdd", method = RequestMethod.GET) public
	 * ModelAndView clientForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerAdd");
	 * 
	 * return mav; }
	 * 
	 * @RequestMapping(value = "/customerList", method = RequestMethod.GET) public
	 * ModelAndView clientListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerList");
	 * 
	 * return mav; }
	 */
	
	
	
	
	
	@RequestMapping(value = "/customerSignAdd", method = RequestMethod.GET)
	public ModelAndView clientSignAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerSignAdd");

		return mav;
	}

	/*@RequestMapping(value = "/service", method = RequestMethod.GET)
	public ModelAndView serviceForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/serviceAdd");

		return mav;
	}*/
	
	/*@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public ModelAndView serviceListForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/serviceList");

		return mav;
	}*/

	/*@RequestMapping(value = "/activity", method = RequestMethod.GET)
	public ModelAndView activityForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/activityList");

		return mav;
	}*/
	
	/*@RequestMapping(value = "/activityAdd", method = RequestMethod.GET)
	public ModelAndView activityAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/activityAdd");

		return mav;
	}*/
	
	
	@RequestMapping(value = "/taskPeriodicityList", method = RequestMethod.GET)
	public ModelAndView taskPeriodicityListForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/taskPeriodicityList");

		return mav;
	}

	@RequestMapping(value = "/taskPeriodicityAdd", method = RequestMethod.GET)
	public ModelAndView taskPeriodicityAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/taskPeriodicityAdd");

		return mav;
	}

	
	
	
	/*
	 * @RequestMapping(value = "/employeeList", method = RequestMethod.GET) public
	 * ModelAndView employeeListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/employeeList");
	 * 
	 * return mav; }
	 */
	
	/*
	 * @RequestMapping(value = "/employeeAdd", method = RequestMethod.GET) public
	 * ModelAndView employeeAddForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/employeeAdd");
	 * 
	 * return mav; }
	 */
	
	
	/*
	 * @RequestMapping(value = "/customerGroupList", method = RequestMethod.GET)
	 * public ModelAndView customerGroupListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerGroupList");
	 * 
	 * return mav; }
	 */
	
	/*
	 * @RequestMapping(value = "/customerGroupAdd", method = RequestMethod.GET)
	 * public ModelAndView customerGroupAddForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerGroupAdd");
	 * 
	 * return mav; }
	 */
	
	
	@RequestMapping(value = "/customerActivityAddMap", method = RequestMethod.GET)
	public ModelAndView customerActivityAddMapForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerActivityAddMap");

		return mav;
	}
	
	
	@RequestMapping(value = "/communication", method = RequestMethod.GET)
	public ModelAndView communicationForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/communication");

		return mav;
	}
	
	@RequestMapping(value = "/manualTaskAdd", method = RequestMethod.GET)
	public ModelAndView manualTaskAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/manualTaskAdd");

		return mav;
	}
	
	
	@RequestMapping(value = "/taskListForEmp", method = RequestMethod.GET)
	public ModelAndView taskListForEmpForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/homeTaskList");

		return mav;
	}

	

}
