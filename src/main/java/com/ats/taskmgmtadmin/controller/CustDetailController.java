package com.ats.taskmgmtadmin.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CustDetailController {

	//this mapping copied from HomeController
	//this shows list of customer added and have two buttons to add cust Login detail
	// and cust signatory
	//Sachin 
	@RequestMapping(value = "/customerDetailList", method = RequestMethod.GET)
	public ModelAndView clientDetailListForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerDetailList");

		return mav;
	}
	
	//this mapping copied from HomeController
	//this mapping is to show add cust login detail and show records added for particular cust
	//Sachin
	@RequestMapping(value = "/customerDetailAdd", method = RequestMethod.GET)
	public ModelAndView clientDetailAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerDetailAdd");

		
		
		
		return mav;
	}
	
}
