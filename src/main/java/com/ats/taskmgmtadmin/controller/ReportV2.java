package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.model.CapacityDetailByEmp;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.report.InactiveTaskReport;

@Controller
@Scope("session")
public class ReportV2 {

	
	@RequestMapping(value = "/getAllEmployeeCapacityDetail", method = RequestMethod.GET)
	public String showCompTaskReportFormanager(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		String mav = new String();
		try {

			mav = "report/v2/empCapDetails"; //copy of compTaskForManager.jsp
			String yearrange = request.getParameter("monthyear");
			if (yearrange != null) {

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				String[] fromDate = yearrange.split(" to ");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
				CapacityDetailByEmp[] resArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "getAllEmployeeCapacityDetail", map, CapacityDetailByEmp[].class);
				List<CapacityDetailByEmp> empCapList = new ArrayList<>(Arrays.asList(resArray));
				
				model.addAttribute("empCapList", empCapList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);
			}else {
				String dateFrTd=DateConvertor.getFromToDate();
				model.addAttribute("fromDate", dateFrTd.split(" to ")[0]);
				model.addAttribute("toDate",  dateFrTd.split(" to ")[1]);
				model.addAttribute("yearrange",DateConvertor.getFromToDate());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
}
