package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.custlogindetail.GetCustLoginDetail;

@Controller
public class CustDetailController {

	// this mapping copied from HomeController
	// this shows list of customer added and have two buttons to add cust Login
	// detail
	// and cust signatory
	// Sachin
	@RequestMapping(value = "/customerDetailList", method = RequestMethod.GET)
	public ModelAndView clientDetailListForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerDetailList");

		return mav;
	}

	// this mapping copied from HomeController
	// this mapping is to show add cust login detail and show records added for
	// particular cust
	// Sachin
	@RequestMapping(value = "/customerDetailAdd", method = RequestMethod.POST)
	public ModelAndView clientDetailAddForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("master/customerDetailAdd");
		try {
			int custId = Integer.parseInt(request.getParameter("custId"));

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("custId", custId);

			GetCustLoginDetail[] custDetArray = restTemplate.postForObject(Constants.url + "/getCustLoginDetailByCustId", map,
					GetCustLoginDetail[].class);
			List<GetCustLoginDetail> custDetailList = new ArrayList<>(Arrays.asList(custDetArray));

			mav.addObject("custDetailList", custDetailList);
		} catch (Exception e) {
			System.err.println("Exce in show customerDetailAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

}
