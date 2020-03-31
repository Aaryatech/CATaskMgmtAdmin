package com.ats.taskmgmtadmin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.model.Info;

/*
 class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true"

class="form-control form-control-sm select"
										data-container-css-class="select-sm" data-fouc
 */

@Controller
public class EmailController {

	@RequestMapping(value = "/showAddLogEmail", method = RequestMethod.GET)
	public ModelAndView showAddLogEmail(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showAddLogEmail", "showAddLogEmail", "1", "", "0", "0", newModuleList);
		try {

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {

				mav = new ModelAndView("email/log_email");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/sendEmailWorkLog", method = RequestMethod.POST)
	public String sendEmailWorkLog(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", request.getParameter("workDate"));
			String info = Constants.getRestTemplate().postForObject(Constants.url + "/sendLogEmail", map, String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/showAddLogEmail";
	}
}
