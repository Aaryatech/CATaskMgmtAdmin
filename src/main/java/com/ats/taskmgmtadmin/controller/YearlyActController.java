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
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.DevPeriodicityMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
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

			}
		} catch (Exception e) {

			e.printStackTrace();

		}

		return mav;
	}

	@RequestMapping(value = "/submitGenTask", method = RequestMethod.POST)
	public ModelAndView submitGenTask(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;
        System.err.println("In submitGenTask ");
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info add = AccessControll.checkAccess("showYearlyActivity", "showYearlyActivity", "0", "1", "0", "0",
				newModuleList);
		try {

			if (add.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				
				String[] mappingIdArray = request.getParameterValues("mappingId");
				System.err.println(" mappingIdArray " +mappingIdArray.toString());
				List<String> strMappingList=Arrays.asList(mappingIdArray);
				System.err.println(" strMappingList " +strMappingList.toString());
				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/genSaveYearlyTasks", strMappingList, Info.class);

			}
		} catch (Exception e) {
          e.printStackTrace();
		}
		return mav;
	}
}
