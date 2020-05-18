package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.common.HoursConversion;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.DevPeriodicityMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FinancialYear;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.task.model.GetTaskList;

@Controller
@Scope("session")
public class YearlyActController {

	@RequestMapping(value = "/showYearlyActivity", method = RequestMethod.GET)
	public ModelAndView showYearlyActivity(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showYearlyActivity", "showYearlyActivity", "1", "0", "0", "0",
				newModuleList);
		try {

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("yearlyTask/yearly_task");
				MappingData[] mappingDataArray = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getCustActMapListYearly", MappingData[].class);
				List<MappingData> mapDataList = new ArrayList<>(Arrays.asList(mappingDataArray));
				mav.addObject("mapDataList", mapDataList);
				// getNextFinYear
				FinancialYear finYear = Constants.getRestTemplate().getForObject(Constants.url + "/getNextFinYear",
						FinancialYear.class);
				mav.addObject("finYear", finYear);
			}
		} catch (Exception e) {

			e.printStackTrace();

		}

		return mav;
	}

	@RequestMapping(value = "/submitGenTask", method = RequestMethod.POST)
	public String submitGenTask(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;
		System.err.println("In submitGenTask ");
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info add = AccessControll.checkAccess("showYearlyActivity", "showYearlyActivity", "0", "1", "0", "0",
				newModuleList);
		try {

			System.err.println("add "+add.toString());
			if (add.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {

				String[] mappingIdArray = request.getParameterValues("mappingId");
				System.err.println(" mappingIdArray " + mappingIdArray.toString());
				// List<String> strMappingList=Arrays.asList(mappingIdArray);
				// System.err.println(" strMappingList " +strMappingList.toString());

				StringBuilder sb = new StringBuilder();

				for (int i = 0; i < mappingIdArray.length; i++) {
					sb = sb.append(mappingIdArray[i] + ",");

					System.out.println("grnIdList id are**" + mappingIdArray[i]);

				}

				String strMappingList = sb.toString();

				strMappingList = strMappingList.substring(0, strMappingList.length() - 1);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("strMappingList", strMappingList);

				String info = Constants.getRestTemplate().postForObject(Constants.url + "/genSaveYearlyTasks", map,
						String.class);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/assignTask";
	}

	@RequestMapping(value = "/saveEditeMapping", method = RequestMethod.POST)
	public @ResponseBody Object saveEditeMapping(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;
		Integer x = 0;
		System.err.println("In saveEditeMapping ");
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info edit = AccessControll.checkAccess("showYearlyActivity", "showYearlyActivity", "0", "0", "1", "0",
				newModuleList);
		try {

			if (edit.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

				String edit_emptime = request.getParameter("edit_emptime");
				System.err.println("edit_emptime" + edit_emptime);
				String edit_mngrtime = request.getParameter("edit_mngrtime");
				System.err.println("edit_mngrtime" + edit_mngrtime);
				int bilAmt = Integer.parseInt(request.getParameter("bilAmt"));
				int dueDays = Integer.parseInt(request.getParameter("due_Days"));
				int mappingId = Integer.parseInt(request.getParameter("mappingId"));

				String emphr = HoursConversion.convertHoursToMin(edit_emptime);
				String mngHr = HoursConversion.convertHoursToMin(edit_mngrtime);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("mappingId", mappingId);
				map.add("dueDays", dueDays);
				map.add("bilAmt", bilAmt);
				map.add("emphr", Integer.parseInt(emphr));
				map.add("mngHr", Integer.parseInt(mngHr));
				map.add("userId", emp.getEmpId());

				Info info = Constants.getRestTemplate()
						.postForObject(Constants.url + "/saveEditeMappingTableByMappingId", map, Info.class);
				if (info.isError() == false) {
					System.out.println("successMsg");
					session.setAttribute("successMsg", " Updated Successfully");
					x = 1;
				} else {
					System.out.println("errorMsg");
					session.setAttribute("errorMsg", "Failed to Update");
					x = 0;
				}
			}
		} catch (Exception e) {
			try {
				session.setAttribute("errorMsg", "Failed to Update");
				return x;
				// return "redirect:/showYearlyActivity";
			} catch (Exception f) {
				return "redirect:/";
			}
		}
		return x;
	}

}
