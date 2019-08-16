package com.ats.taskmgmtadmin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.model.EmployeeMaster;

@Controller
@Scope("session")
public class LeaveController {

	RestTemplate rest = new RestTemplate();

	@RequestMapping(value = "/showEmpListForLeave", method = RequestMethod.GET)
	public String showEmpListForLeave(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/showEmpListForLeave";

		try {

			EmployeeMaster[] employee = rest.getForObject(Constants.url + "/getAllEmployees", EmployeeMaster[].class);
			List<EmployeeMaster> empList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
			model.addAttribute("empList", empList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/leaveApply", method = RequestMethod.GET)
	public String leaveApply(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/leaveApplication";

		try {

			int empId = Integer.parseInt(request.getParameter("empId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			EmployeeMaster employee = rest.postForObject(Constants.url + "/getEmployeeById", map, EmployeeMaster.class);

			model.addAttribute("employee", employee);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = { "/calculateHolidayBetweenDate" }, method = RequestMethod.GET)
	public @ResponseBody String calculateHolidayBetweenDate(@RequestParam("fromDate") String fromDate,
			@RequestParam("toDate") String toDate) {

		int totalcount = 0;
		int diff = difffun(fromDate, toDate);

		try {

			SimpleDateFormat yydate = new SimpleDateFormat("dd-MM-yyyy");

			for (Date j = yydate.parse(fromDate); j.compareTo(yydate.parse(toDate)) <= 0;) {

				Calendar c = Calendar.getInstance();
				c.setTime(j);
				int dayOfWeek = c.get(Calendar.DAY_OF_WEEK) - 1;

				if (dayOfWeek == 0) {

					totalcount++;
				}
				j.setTime(j.getTime() + 1000 * 60 * 60 * 24);

			}

			diff = diff - totalcount;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return String.valueOf(diff);

	}

	public int difffun(String date1, String date2) {

		SimpleDateFormat myFormat = new SimpleDateFormat("dd-MM-yyy");

		int result = 0;

		try {
			Date date3 = myFormat.parse(date1);
			Date date4 = myFormat.parse(date2);
			long diff = date4.getTime() - date3.getTime();
			result = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		} catch (Exception e) {

		}

		return result + 1;
	}

	@RequestMapping(value = "/showLeaveHistList", method = RequestMethod.GET)
	public String showLeaveHistList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/showLeaveHistList";

		return mav;
	}

	@RequestMapping(value = "/showLeaveHistListBetweenDate", method = RequestMethod.GET)
	public String showLeaveHistListBetweenDate(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/showLeaveHistListBetweenDate";

		return mav;
	}
}
