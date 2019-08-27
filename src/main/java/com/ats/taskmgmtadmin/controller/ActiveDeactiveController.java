package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.ActivityPeriodDetails;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.task.model.Task;

@Controller
@Scope("session")
public class ActiveDeactiveController {

	@RequestMapping(value = "/activeDeactiveService", method = RequestMethod.GET)
	public String activeDeactiveService(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "master/activeDeactiveservice";

		try {

			int servId = Integer.parseInt(request.getParameter("serviceId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("serviceId", servId);
			ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById",
					map, ServiceMaster.class);
			model.addAttribute("service", servicemMap);

			ActivityPeriodDetails[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getActivityDetails", map, ActivityPeriodDetails[].class);
			List<ActivityPeriodDetails> activityList = new ArrayList<>(Arrays.asList(activityArr));

			map = new LinkedMultiValueMap<>();
			map.add("servId", servId);
			Task[] task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskListForisactive", map,
					Task[].class);
			List<Task> taskList = new ArrayList<>(Arrays.asList(task));

			model.addAttribute("actList", activityList);
			model.addAttribute("taskList", taskList);

		} catch (Exception e) {
			e.getMessage();
		}

		return mav;
	}

	@RequestMapping(value = "/updateServiceIsActiveStatus", method = RequestMethod.POST)
	public String activeDeactiveService(HttpServletRequest request, HttpServletResponse response) {

		String mav = "redirect:/serviceList";

		try {

			int servId = Integer.parseInt(request.getParameter("serviceId"));
			int isActiveStatus = Integer.parseInt(request.getParameter("isActiveStatus"));
			String[] taskIds = request.getParameterValues("taskIds");

			String ids = "0";

			try {

				 
				
				for(int i=0 ; i<taskIds.length ; i++) {
					ids=ids+","+taskIds[i];
				}

			} catch (Exception e) {
				ids="0";
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("servId", servId);
			map.add("isActiveStatus", isActiveStatus);
			map.add("taskIds", ids);

			Info updateIsActiveStatus = Constants.getRestTemplate()
					.postForObject(Constants.url + "/updateServiceIsActiveStatus", map, Info.class);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}
