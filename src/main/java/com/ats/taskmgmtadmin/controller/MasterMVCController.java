package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ats.taskmgmtadmin.acsrights.CreatedRoleList;
import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.common.TaskText;
import com.ats.taskmgmtadmin.common.VpsImageUpload;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.ActivityPeriodDetails;
import com.ats.taskmgmtadmin.model.CustNameId;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.CustomerGroupMaster;
import com.ats.taskmgmtadmin.model.CustomerHeaderMaster;
import com.ats.taskmgmtadmin.model.DevPeriodicityMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FirmType;
import com.ats.taskmgmtadmin.model.GetActivityPeriodicity;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.model.StatusMaster;
import com.ats.taskmgmtadmin.task.model.Task;

@Controller
@Scope("session")
public class MasterMVCController {

	private static final Logger logger = LoggerFactory.getLogger(MasterMVCController.class);

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	String curDateTime = dateFormat.format(cal.getTime());

	MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
	HttpSession session = null;
	List<Task> empListNew = new ArrayList<Task>();

	String redirect = null;

	/**************************** Service Master ************************/
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public ModelAndView serviceListForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		HttpSession session = request.getSession();
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		try {
			Info info = AccessControll.checkAccess("serviceList", "serviceList", "1", "0", "0", "0", newModuleList);
			if (info.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/serviceList");

				ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
						ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				mav.addObject("serviceList", srvcMstrList);

				Info add = AccessControll.checkAccess("serviceList", "serviceList", "0", "1", "0", "0", newModuleList);
				Info edit = AccessControll.checkAccess("serviceList", "serviceList", "0", "0", "1", "0", newModuleList);
				Info delete = AccessControll.checkAccess("serviceList", "serviceList", "0", "0", "0", "1",
						newModuleList);

				if (add.isError() == false) {
					// System.out.println(" add Accessable ");
					mav.addObject("addAccess", 0);

				}
				if (edit.isError() == false) {
					// System.out.println(" edit Accessable ");
					mav.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					// System.out.println(" delete Accessable ");
					mav.addObject("deleteAccess", 0);

				}
			}
		} catch (Exception e) {
			System.err.println("Exce in serviceList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/service", method = RequestMethod.GET)
	public ModelAndView serviceForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		HttpSession session = request.getSession();
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		try {
			Info info = AccessControll.checkAccess("service", "serviceList", "0", "1", "0", "0", newModuleList);
			if (info.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/serviceAdd");
				ServiceMaster service = new ServiceMaster();
				mav.addObject("service", service);

				mav.addObject("title", "Add Service");
			}
		} catch (Exception e) {
			System.err.println("Exce in service " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/addService", method = RequestMethod.GET)
	public String addService(HttpServletRequest request, HttpServletResponse response) {
		try {
			session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			ServiceMaster service = new ServiceMaster();
			int servcId = 0;

			try {
				servcId = Integer.parseInt(request.getParameter("service_id"));
			} catch (Exception e) {
				e.getMessage();
				servcId = 0;
			}

			if (servcId != 0) {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("serviceId", servcId);
				ServiceMaster srvc = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById", map,
						ServiceMaster.class);
				System.err.println("Exce in editService " + srvc.getExInt1());
				service.setExInt1(srvc.getExInt1());// Service Status 1=active, 2=deactive
			} else {
				System.err.println("Exce in addService ");
				service.setExInt1(1);// Service Status 1=active, 2=deactive
			}
			service.setServId(servcId);
			service.setServName(request.getParameter("serviceName"));
			service.setServDesc(request.getParameter("serviceDesc"));
			service.setDelStatus(1);
			service.setUpdateDatetime(curDateTime);
			service.setUpdateUsername(userId);

			service.setExInt2(0);
			service.setExVar1("NA");
			service.setExVar2("NA");

			ServiceMaster saveSrvc = Constants.getRestTemplate().postForObject(Constants.url + "/saveService", service,
					ServiceMaster.class);

			if (saveSrvc != null) {
				session.setAttribute("successMsg", Constants.Sucessmsg);
				redirect = "redirect:/serviceList";
			} else {
				session.setAttribute("errorMsg", Constants.Failmsg);
				redirect = "redirect:/serviceList";
			}

		} catch (Exception e) {
			System.err.println("Exce in addService " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/editService", method = RequestMethod.GET)
	public ModelAndView editService(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info info = AccessControll.checkAccess("editService", "serviceList", "0", "0", "1", "0", newModuleList);
			if (info.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/serviceAdd");

				int serviceId = Integer.parseInt(request.getParameter("serviceId"));

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

				map.add("serviceId", serviceId);
				ServiceMaster service = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById",
						map, ServiceMaster.class);

				mav.addObject("service", service);

				mav.addObject("title", "Edit Service");
			}
		} catch (Exception e) {
			System.err.println("Exce in editService " + e.getMessage());
			e.printStackTrace();
		}

		return mav;

	}

	@RequestMapping(value = "/deleteService", method = RequestMethod.GET)
	public String deleteService(HttpServletRequest request, HttpServletResponse response) {
		String redirect = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info info = AccessControll.checkAccess("editService", "serviceList", "0", "0", "0", "1", newModuleList);
			if (info.isError() == true) {

				redirect = "redirect:/accessDenied";

			} else {
				session = request.getSession();

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				int serviceId = Integer.parseInt(request.getParameter("serviceId"));

				System.out.println("Delete:" + serviceId);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("userId", userId);
				map.add("serviceId", serviceId);

				Info del = Constants.getRestTemplate().postForObject(Constants.url + "/deleteService", map, Info.class);
				if (del.isError()) {
					session.setAttribute("errorMsg", "Failed to Delete");
					redirect = "redirect:/serviceList";
				} else {
					session.setAttribute("successMsg", "Deleted Successfully");
					redirect = "redirect:/serviceList";
				}
			}
		} catch (Exception e) {
			System.err.println("Exce in deleteService " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	/**************************** Activity Controller ****************************/

	@RequestMapping(value = "/activity", method = RequestMethod.GET)
	public ModelAndView activityForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info info = AccessControll.checkAccess("activity", "activity", "1", "0", "0", "0", newModuleList);
			if (info.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/activityList");

				ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
						ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));

				mav.addObject("serviceList", srvcMstrList);

				Info add = AccessControll.checkAccess("activity", "activity", "0", "1", "0", "0", newModuleList);

				if (add.isError() == false) {

					mav.addObject("addAccess", 0);

				}
			}
		} catch (Exception e) {
			System.err.println("Exce in activity " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/activityAdd", method = RequestMethod.POST)
	public ModelAndView activityAddForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info info = AccessControll.checkAccess("activity", "activity", "1", "0", "0", "0", newModuleList);
			if (info.isError() == true) {

				mav = new ModelAndView("accessDenied");

			}else { 

			mav = new ModelAndView("master/activityAdd");
			ActivityMaster activity = new ActivityMaster();
			mav.addObject("activity", activity);
			MultiValueMap<String, Object> map = null;

			int serviceId = Integer.parseInt(request.getParameter("map_service_id"));
			System.out.println("Mapping Service Id = " + serviceId);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);

			ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById",
					map, ServiceMaster.class);

			mav.addObject("service", servicemMap);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);

			ActivityPeriodDetails[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getActivityDetails", map, ActivityPeriodDetails[].class);
			List<ActivityPeriodDetails> activityList = new ArrayList<>(Arrays.asList(activityArr));
			System.out.println("Act List:" + activityList);
			mav.addObject("actList", activityList);

			DevPeriodicityMaster[] priodArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllPeriodicityDurations", DevPeriodicityMaster[].class);
			List<DevPeriodicityMaster> periodList = new ArrayList<DevPeriodicityMaster>(Arrays.asList(priodArr));
			mav.addObject("periodList", periodList);

			mav.addObject("title", "Add Activity");
			
			Info edit = AccessControll.checkAccess("activity", "activity", "0", "0", "1", "0", newModuleList);
			Info delete = AccessControll.checkAccess("activity", "activity", "0", "0", "0", "1",
					newModuleList);

			if (edit.isError() == false) {
				// System.out.println(" edit Accessable ");
				mav.addObject("editAccess", 0);
			}
			if (delete.isError() == false) {
				// System.out.println(" delete Accessable ");
				mav.addObject("deleteAccess", 0);

			}
			}
		} catch (Exception e) {
			System.err.println("Exce in activityAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/activityBackPage", method = RequestMethod.GET)
	public ModelAndView activityBackPage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {

			mav = new ModelAndView("master/activityAdd");
			ActivityMaster activity = new ActivityMaster();
			mav.addObject("activity", activity);
			MultiValueMap<String, Object> map = null;

			int serviceId = Integer.parseInt(request.getParameter("servId"));
			System.out.println("Mapping Service Id = " + serviceId);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);

			ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById",
					map, ServiceMaster.class);

			mav.addObject("service", servicemMap);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);

			ActivityPeriodDetails[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getActivityDetails", map, ActivityPeriodDetails[].class);
			List<ActivityPeriodDetails> activityList = new ArrayList<>(Arrays.asList(activityArr));
			System.out.println("Act List:" + activityList);
			mav.addObject("actList", activityList);

			DevPeriodicityMaster[] priodArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllPeriodicityDurations", DevPeriodicityMaster[].class);
			List<DevPeriodicityMaster> periodList = new ArrayList<DevPeriodicityMaster>(Arrays.asList(priodArr));
			mav.addObject("periodList", periodList);

			mav.addObject("title", "Add Activity");

		} catch (Exception e) {
			System.err.println("Exce in activityAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/addNewActivity", method = RequestMethod.POST)
	public String addServcActvtMaping(HttpServletRequest request, HttpServletResponse response) {

		try {
			session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			ActivityMaster activity = new ActivityMaster();

			int actId = 0;
			try {
				actId = Integer.parseInt(request.getParameter("activity_id"));
			} catch (Exception e) {
				actId = 0;
				e.getMessage();
			}

			if (actId != 0) {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("activityId", actId);

				ActivityMaster actvt = Constants.getRestTemplate().postForObject(Constants.url + "/getActivityById",
						map, ActivityMaster.class);

				activity.setExInt1(actvt.getExInt1()); // 1=active, 0=deactive
			} else {
				activity.setExInt1(1); // 1=active, 0=deactive
			}

			activity.setActiId(actId);
			activity.setActiName(request.getParameter("activityName"));
			activity.setPeriodicityId(Integer.parseInt(request.getParameter("periodicity")));
			activity.setActiDesc(request.getParameter("activityDesc"));
			activity.setServId(Integer.parseInt(request.getParameter("service_id")));
			activity.setDelStatus(1);
			activity.setUpdateDatetime(curDateTime);
			activity.setUpdateUsername(userId);
			activity.setExInt2(0);
			activity.setExVar1("NA");
			activity.setExVar2("NA");

			ActivityMaster actMastr = Constants.getRestTemplate().postForObject(Constants.url + "/saveActivity",
					activity, ActivityMaster.class);
			if (actMastr != null) {
				session.setAttribute("successMsg", Constants.Sucessmsg);
				redirect = "redirect:/activity";
			} else {
				session.setAttribute("errorMsg", Constants.Failmsg);
				redirect = "redirect:/activity";
			}
		} catch (Exception e) {
			System.err.println("Exce in addNewActivity " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;

	}

	@RequestMapping(value = "/editActivity", method = RequestMethod.GET)
	public ModelAndView editActivity(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info info = AccessControll.checkAccess("editActivity", "activity", "0", "0", "1", "0", newModuleList);
			if (info.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/activityAdd");

				MultiValueMap<String, Object> map = null;

				int activityId = Integer.parseInt(request.getParameter("actiId"));
				System.err.println("In Activity Edit--------" + activityId);

				map = new LinkedMultiValueMap<>();
				map.add("activityId", activityId);

				ActivityMaster activity = Constants.getRestTemplate().postForObject(Constants.url + "/getActivityById",
						map, ActivityMaster.class);
				System.out.println("Ativity=" + activity);
				mav.addObject("activity", activity);

				map = new LinkedMultiValueMap<>();
				map.add("serviceId", activity.getServId());

				ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById",
						map, ServiceMaster.class);
				System.out.println("Service=" + servicemMap);
				mav.addObject("service", servicemMap);

				map = new LinkedMultiValueMap<>();
				map.add("serviceId", activity.getServId());

				ActivityPeriodDetails[] activityArr = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getActivityDetails", map, ActivityPeriodDetails[].class);
				List<ActivityPeriodDetails> activityList = new ArrayList<>(Arrays.asList(activityArr));
				System.out.println("Act List:" + activityList);
				mav.addObject("actList", activityList);

				DevPeriodicityMaster[] priodArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllPeriodicityDurations", DevPeriodicityMaster[].class);
				List<DevPeriodicityMaster> periodList = new ArrayList<DevPeriodicityMaster>(Arrays.asList(priodArr));
				System.out.println("Periodicit-------------" + periodList);
				mav.addObject("periodList", periodList);

				mav.addObject("title", "Edit Activity");

			}
		} catch (Exception e) {
			System.err.println("Exce in editActivity " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/deleteActivity/{activityId}", method = RequestMethod.GET)
	public String deleteActivity(HttpServletRequest request, HttpServletResponse response,
			@PathVariable int activityId) {

		int serviceId = 0;
		String redirect = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info info = AccessControll.checkAccess("deleteActivity", "activity", "0", "0", "1", "0", newModuleList);
			if (info.isError() == true) {

				redirect = "redirect:/accessDenied";

			} else {
				MultiValueMap<String, Object> map = null;
				session = request.getSession();

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				System.out.println("Delete:" + activityId);

				map = new LinkedMultiValueMap<>();
				map.add("activityId", activityId);

				ActivityMaster activity = Constants.getRestTemplate().postForObject(Constants.url + "/getActivityById",
						map, ActivityMaster.class);

				serviceId = activity.getServId();

				map = new LinkedMultiValueMap<>();
				map.add("userId", userId);
				map.add("activityId", activityId);

				Info del = Constants.getRestTemplate().postForObject(Constants.url + "/deleteActivity", map,
						Info.class);
				redirect = "redirect:/activity";
			}
		} catch (Exception e) {
			System.err.println("Exce in deleteActivity " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	@RequestMapping(value = "/activityAdd/{serviceId}", method = RequestMethod.GET)
	public ModelAndView activityAddForm(HttpServletRequest request, HttpServletResponse response,
			@PathVariable int serviceId) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/activityAdd");
			ActivityMaster activity = new ActivityMaster();
			mav.addObject("activity", activity);
			MultiValueMap<String, Object> map = null;

			System.out.println("Mapping Service Id = " + serviceId);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);

			ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById",
					map, ServiceMaster.class);
			mav.addObject("service", servicemMap);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);

			ActivityMaster[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllActivitesByServiceId", map, ActivityMaster[].class);
			List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
			System.out.println("Act List:" + activityList);
			mav.addObject("actList", activityList);

		} catch (Exception e) {
			System.err.println("Exce in activityAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	/*********************** Employee Master *************************/

	@RequestMapping(value = "/employeeList", method = RequestMethod.GET)
	public ModelAndView employeeListForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();

			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");

			Info view = AccessControll.checkAccess("employeeList", "employeeList", "1", "0", "0", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {

				mav = new ModelAndView("master/employeeList");

				EmployeeMaster[] employee = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEmployeesActiveInactive", EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);
				mav.addObject("imageUrl", Constants.imageViewUrl);

				for (int i = 0; i < epmList.size(); i++) {

					epmList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(epmList.get(i).getEmpId())));
				}

				Info add = AccessControll.checkAccess("employeeList", "employeeList", "0", "1", "0", "0",
						newModuleList);
				Info edit = AccessControll.checkAccess("employeeList", "employeeList", "0", "0", "1", "0",
						newModuleList);
				Info delete = AccessControll.checkAccess("employeeList", "employeeList", "0", "0", "0", "1",
						newModuleList);

				if (add.isError() == false) {
					// System.out.println(" add Accessable ");
					mav.addObject("addAccess", 0);

				}
				if (edit.isError() == false) {
					// System.out.println(" edit Accessable ");
					mav.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					// System.out.println(" delete Accessable ");
					mav.addObject("deleteAccess", 0);

				}
			}

		} catch (Exception e) {
			System.err.println("Exce in employeeList " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/employeeAdd", method = RequestMethod.GET)
	public ModelAndView employeeAddForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");

			Info view = AccessControll.checkAccess("employeeAdd", "employeeList", "0", "1", "0", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/employeeAdd");

				EmployeeMaster employee = new EmployeeMaster();
				mav.addObject("employee", employee);

				ServiceMaster[] srvsMstr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));

				mav.addObject("serviceList", srvcMstrList);

				mav.addObject("title", "Add Employee");
				mav.addObject("imageUrl", Constants.imageViewUrl);
				mav.addObject("isEdit", 0);
			}

		} catch (Exception e) {
			System.err.println("Exce in employeeAdd " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/addNewEmployee", method = RequestMethod.POST)
	public String addNwEmployee(@RequestParam("profilePic") List<MultipartFile> profilePic, HttpServletRequest request,
			HttpServletResponse response) {
		String redirect = null;
		try {
			MultiValueMap<String, Object> map = null;
			Date date = new Date();

			HttpSession sess = request.getSession(true);

			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
			EmployeeMaster emp = (EmployeeMaster) sess.getAttribute("empLogin");
			int userId = emp.getEmpId();
			VpsImageUpload upload = new VpsImageUpload();
			EmployeeMaster employee = new EmployeeMaster();
			String imageName = new String();
			int empId = 0;
			int roleId = 0;

			try {
				empId = Integer.parseInt(request.getParameter("employee_id"));
				roleId = Integer.parseInt(request.getParameter("roleId"));
			} catch (Exception e) {
				e.getMessage();
			}

			String email = request.getParameter("email");
			Info info = new Info();

			if (empId > 0) {

				map = new LinkedMultiValueMap<String, Object>();

				map.add("email", email);
				map.add("eid", empId);
				info = Constants.getRestTemplate().postForObject(Constants.url + "/checkEmployeeEmail", map,
						Info.class);
				System.out.println("Info" + info);

				if (info.isError() == false) {
					String msg = "Operation Failed ! This email-id is already exist.";
					sess.setAttribute("errMsg", msg);

					redirect = "redirect:/editEmployee?empId=" + empId;

				} else {

					String servicesList = null;
					try {
						String[] services = request.getParameterValues("empService");

						StringBuilder sb = new StringBuilder();

						for (int i = 0; i < services.length; i++) {
							sb = sb.append(services[i] + ",");

						}
						servicesList = sb.toString();
						System.out.println("Serviceas:" + servicesList);
					} catch (Exception e) {

						servicesList = "NA";
						e.printStackTrace();
					}

					if (profilePic.get(0).getOriginalFilename() != "") {
						imageName = dateTimeInGMT.format(date) + "_" + profilePic.get(0).getOriginalFilename();
						if (profilePic.get(0).getOriginalFilename() != null) {
							try {
								upload.saveUploadedImge(profilePic.get(0), Constants.imageSaveUrl, imageName,
										Constants.values, 0, 0, 0, 0, 0);

							} catch (Exception e) {
								System.out.println(e.getMessage());
							}
						}
					} else {

						imageName = request.getParameter("profPic");
						System.out.println(imageName);
					}

					employee.setEmpPic(imageName);

					employee.setEmpId(empId);
					employee.setEmpType(Integer.parseInt(request.getParameter("empType")));
					employee.setEmpName(request.getParameter("empName"));
					employee.setEmpNickname(request.getParameter("empNickname"));
					employee.setEmpDob(request.getParameter("dob"));

					if (empId != 0) {
						employee.setEmpRoleId(roleId);
						map = new LinkedMultiValueMap<>();
						map.add("empId", empId);
						EmployeeMaster empMst = Constants.getRestTemplate()
								.postForObject(Constants.url + "/getEmployeeById", map, EmployeeMaster.class);
						employee.setIsActive(empMst.getIsActive());
					} else {
						employee.setEmpRoleId(0);
						employee.setIsActive(1);
					}
					employee.setEmpMob(request.getParameter("phone"));
					employee.setEmpEmail(email);
					employee.setEmpPass(request.getParameter("pwd"));
					employee.setEmpDesc(servicesList);
					employee.setEmpPic(imageName);
					employee.setEmpSalary(request.getParameter("empSal"));
					employee.setDelStatus(1);
					employee.setUpdateDatetime(curDateTime);
					employee.setUpdateUsername(userId);
					employee.setExInt1(0); // isEnroll
					employee.setExInt2(0);
					employee.setExVar1("NA");
					employee.setExVar2("NA");

					System.err.println("employee " + employee.toString());
					EmployeeMaster empl = Constants.getRestTemplate().postForObject(Constants.url + "/saveNewEmployee",
							employee, EmployeeMaster.class);

					if (empl != null) {
						sess.setAttribute("successMsg", Constants.Sucessmsg);
						redirect = "redirect:/employeeList";
					} else {
						sess.setAttribute("errorMsg", Constants.Failmsg);
						redirect = "redirect:/employeeList";
					}

				}
			} else {
				System.out.println("--------------New Record");
				String servicesList = null;
				try {
					String[] services = request.getParameterValues("empService");

					StringBuilder sb = new StringBuilder();

					for (int i = 0; i < services.length; i++) {
						sb = sb.append(services[i] + ",");

					}
					servicesList = sb.toString();
					System.out.println("Serviceas:" + servicesList);
				} catch (Exception e) {

					servicesList = "NA";
				}

				if (profilePic.get(0).getOriginalFilename() != "") {
					imageName = dateTimeInGMT.format(date) + "_" + profilePic.get(0).getOriginalFilename();
					if (profilePic.get(0).getOriginalFilename() != null) {
						try {
							upload.saveUploadedImge(profilePic.get(0), Constants.imageSaveUrl, imageName,
									Constants.values, 0, 0, 0, 0, 0);

						} catch (Exception e) {
							System.out.println(e.getMessage());
						}
					}
				} else {

					imageName = request.getParameter("profPic");
					System.out.println(imageName);
				}

				employee.setEmpPic(imageName);

				employee.setEmpId(empId);
				employee.setEmpType(Integer.parseInt(request.getParameter("empType")));
				employee.setEmpName(request.getParameter("empName"));
				employee.setEmpNickname(request.getParameter("empNickname"));
				employee.setEmpDob(request.getParameter("dob"));

				if (empId != 0) {
					employee.setEmpRoleId(roleId);
					map = new LinkedMultiValueMap<>();
					map.add("empId", empId);
					EmployeeMaster empMst = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getEmployeeById", map, EmployeeMaster.class);
					employee.setIsActive(empMst.getIsActive());
				} else {
					employee.setEmpRoleId(0);
					employee.setIsActive(1);
				}
				employee.setEmpMob(request.getParameter("phone"));
				employee.setEmpEmail(email);
				employee.setEmpPass(request.getParameter("pwd"));
				employee.setEmpDesc(servicesList);
				employee.setEmpPic(imageName);
				employee.setEmpSalary(request.getParameter("empSal"));
				employee.setDelStatus(1);
				employee.setUpdateDatetime(curDateTime);
				employee.setUpdateUsername(userId);
				employee.setExInt1(0); // isEnroll
				employee.setExInt2(0);
				employee.setExVar1("NA");
				employee.setExVar2("NA");

				System.err.println("employee " + employee.toString());
				EmployeeMaster empl = Constants.getRestTemplate().postForObject(Constants.url + "/saveNewEmployee",
						employee, EmployeeMaster.class);

				if (empl != null) {
					sess.setAttribute("successMsg", Constants.Sucessmsg);
					redirect = "redirect:/employeeList";
				} else {
					sess.setAttribute("errorMsg", Constants.Failmsg);
					redirect = "redirect:/employeeList";
				}

			}

		} catch (Exception e) {
			System.err.println("Exce in addNwEmployee " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	@RequestMapping(value = "/editEmployee", method = RequestMethod.GET)
	public ModelAndView editEmployee(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		MultiValueMap<String, Object> map = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");

			Info view = AccessControll.checkAccess("editEmployee", "employeeList", "0", "0", "1", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {

				mav = new ModelAndView("master/employeeAdd");

				int empId = Integer.parseInt(request.getParameter("empId"));

				map = new LinkedMultiValueMap<>();

				map.add("empId", empId);
				EmployeeMaster employee = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById",
						map, EmployeeMaster.class);
				System.err.println("EmpSrvcList-------" + employee.getEmpDesc());
				mav.addObject("employee", employee);

				mav.addObject("imageUrl", Constants.imageViewUrl);

				ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
						ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				System.out.println("srvcMstrList------------" + srvcMstrList);
				mav.addObject("serviceList", srvcMstrList);

				CreatedRoleList createdRoleList = Constants.getRestTemplate()
						.getForObject(Constants.url + "getAllAccessRole", CreatedRoleList.class);
				System.out.println("Access List " + createdRoleList.toString());
				mav.addObject("createdRoleList", createdRoleList.getAssignRoleDetailList());

				mav.addObject("isEdit", 1);

				mav.addObject("title", "Edit Employee");

				List<Integer> empSrvc = new ArrayList<>();
				try {

					empSrvc = Stream.of(employee.getEmpDesc().split(",")).map(Integer::parseInt)
							.collect(Collectors.toList());
				} catch (Exception e) {
					mav.addObject("empSrvcIds", empSrvc.add(0));
				}
				System.out.println("Res------------" + empSrvc);
				mav.addObject("empSrvcIds", empSrvc);
			}
		} catch (Exception e) {
			System.err.println("Exce in editEmployee " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/deleteEmployee", method = RequestMethod.GET)
	public String deleteEmployee(HttpServletRequest request, HttpServletResponse response) {

		String base64encodedString = request.getParameter("empId");
		String employeeId = FormValidation.DecodeKey(base64encodedString);
		String redirect = null;
		int serviceId = 0;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");

			Info view = AccessControll.checkAccess("editEmployee", "employeeList", "0", "0", "0", "1", newModuleList);

			if (view.isError() == true) {

				redirect = "redirect:/accessDenied";

			} else {
				MultiValueMap<String, Object> map = null;
				session = request.getSession();

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				System.out.println("Delete:" + employeeId);

				map = new LinkedMultiValueMap<>();
				map.add("employeeId", employeeId);

				map = new LinkedMultiValueMap<>();
				map.add("userId", userId);
				map.add("empId", employeeId);

				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteEmployee", map,
						Info.class);
				if (info.isError()) {
					session.setAttribute("errorMsg", "Failed to Delete");
					redirect = "redirect:/employeeList";
				} else {
					session.setAttribute("successMsg", "Deleted Successfully");
					redirect = "redirect:/employeeList";
				}

			}
		} catch (Exception e) {
			System.err.println("Exce in deleteEmployee " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	@RequestMapping(value = "/checkEmailText", method = RequestMethod.POST)
	@ResponseBody
	public int checkEmailText(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();
		int res = 0;
		int eid = 0;
		try {
			try {
				eid = Integer.parseInt(request.getParameter("eid"));
			} catch (Exception e) {
				e.printStackTrace();
			}

			String email = request.getParameter("email");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("email", email);
			map.add("eid", eid);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/checkEmployeeEmail", map, Info.class);
			System.out.println("Info" + info);
			if (info.isError() == false) {
				res = 1;
				System.out.println("1" + res);
			} else {
				res = 0;
				System.out.println("0" + res);
			}

		} catch (Exception e) {
			System.err.println("Exception in checkEmailText : " + e.getMessage());
			e.printStackTrace();
		}

		return res;

	}

	@RequestMapping(value = "/updateIsActive", method = RequestMethod.GET)
	public String updateIsActive(HttpServletRequest request, HttpServletResponse response) {

		String base64encodedString = request.getParameter("empId");
		String empId = FormValidation.DecodeKey(base64encodedString);

		try {
			MultiValueMap<String, Object> map = null;
			session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			System.out.println("Delete:" + empId);

			map = new LinkedMultiValueMap<>();
			map.add("employeeId", empId);

			map = new LinkedMultiValueMap<>();
			map.add("userId", userId);
			map.add("empId", empId);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateEmployeeActiveness", map,
					Info.class);

			if (info.isError()) {
				session.setAttribute("errorMsg", "Status Not Changed");
				return "redirect:/employeeList";

			} else {
				session.setAttribute("successMsg", "Status Changed ");
				return "redirect:/employeeList";
			}
		} catch (Exception e) {
			System.err.println("Exce in deleteEmployee " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	/********************** Customer Group Master **************************/

	@RequestMapping(value = "/customerGroupList", method = RequestMethod.GET)
	public ModelAndView customerGroupListForm(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("customerGroupList", "customerGroupList", "1", "0", "0", "0",
					newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/customerGroupList");

				CustomerGroupMaster[] custGrpArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerGroups", CustomerGroupMaster[].class);
				List<CustomerGroupMaster> custGrpList = new ArrayList<CustomerGroupMaster>(Arrays.asList(custGrpArr));

				mav.addObject("custGrpList", custGrpList);

				Info add = AccessControll.checkAccess("customerGroupList", "customerGroupList", "0", "1", "0", "0",
						newModuleList);
				Info edit = AccessControll.checkAccess("customerGroupList", "customerGroupList", "0", "0", "1", "0",
						newModuleList);
				Info delete = AccessControll.checkAccess("customerGroupList", "customerGroupList", "0", "0", "0", "1",
						newModuleList);

				if (add.isError() == false) {
					// System.out.println(" add Accessable ");
					mav.addObject("addAccess", 0);

				}
				if (edit.isError() == false) {
					// System.out.println(" edit Accessable ");
					mav.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					// System.out.println(" delete Accessable ");
					mav.addObject("deleteAccess", 0);

				}
			}

		} catch (Exception e) {
			System.err.println("Exce in customerGroupList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/customerGroupAdd", method = RequestMethod.GET)
	public ModelAndView customerGroupAddForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("customerGroupAdd", "customerGroupList", "0", "1", "0", "0",
					newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/customerGroupAdd");

				CustomerGroupMaster cust = new CustomerGroupMaster();
				mav.addObject("cust", cust);

				mav.addObject("title", "  Add Customer Group");
			}
		} catch (Exception e) {

			System.err.println("Exce in customerGroupAdd " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/newCustomerGroup", method = RequestMethod.POST)
	public String newCustomerGroup(HttpServletRequest request, HttpServletResponse response) {
		try {

			session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			CustomerGroupMaster cust = new CustomerGroupMaster();

			int cusrGrpId = 0;
			try {
				cusrGrpId = Integer.parseInt(request.getParameter("cust_group_id"));
			} catch (Exception e) {
				e.getMessage();
				cusrGrpId = 0;
			}

			cust.setCustGroupId(cusrGrpId);
			cust.setCustGroupName(request.getParameter("grpName"));
			cust.setCustGroupRemark(request.getParameter("remark"));
			cust.setDelStatus(1);
			cust.setUpdateDatetime(curDateTime);
			cust.setUpdateUsername(userId);
			cust.setExInt1(0);
			cust.setExInt2(0);
			cust.setExVar1("NA");
			cust.setExVar2("NA");

			CustomerGroupMaster custGrp = Constants.getRestTemplate()
					.postForObject(Constants.url + "/saveNewCustomerGroup", cust, CustomerGroupMaster.class);

			if (custGrp != null) {
				session.setAttribute("successMsg", Constants.Sucessmsg);
				return "redirect:/customerGroupList";

			} else {
				session.setAttribute("errorMsg", Constants.Failmsg);
				return "redirect:/customerGroupList";
			}

		} catch (Exception e) {
			System.err.println("Exce in newCustomerGroup " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;

	}

	@RequestMapping(value = "/editCustGrp", method = RequestMethod.GET)
	public ModelAndView editCustGrp(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("customerGroupAdd", "customerGroupList", "0", "1", "0", "0",
					newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				int custGrpId = Integer.parseInt(request.getParameter("custGrpId"));

				mav = new ModelAndView("master/customerGroupAdd");

				CustomerGroupMaster cust = new CustomerGroupMaster();
				mav.addObject("cust", cust);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("custGrpId", custGrpId);
				CustomerGroupMaster custGrp = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getCustomerGroupById", map, CustomerGroupMaster.class);

				mav.addObject("cust", custGrp);

				mav.addObject("title", "Edit Customer Group");
			}
		} catch (Exception e) {

			System.err.println("Exce in customerGroupAdd " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/deleteCustGrp", method = RequestMethod.GET)
	public String deleteCustGrp(HttpServletRequest request, HttpServletResponse response) {
		String redirect = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("customerGroupAdd", "customerGroupList", "0", "1", "0", "0",
					newModuleList);

			if (view.isError() == true) {

				redirect = "redirect:/accessDenied";

			} else {
				MultiValueMap<String, Object> map = null;

				int custGrpId = Integer.parseInt(request.getParameter("custGrpId"));
				System.out.println("ID:" + custGrpId);

				session = request.getSession();

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				map = new LinkedMultiValueMap<>();
				map.add("userId", userId);
				map.add("custGrpId", custGrpId);

				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteCustomerGroup", map,
						Info.class);

				if (info.isError()) {
					session.setAttribute("errorMsg", "Failed to Delete");
					redirect = "redirect:/customerGroupList";

				} else {
					session.setAttribute("successMsg", "Deleted Successfully");
					redirect = "redirect:/customerGroupList";
				}

			}
		} catch (Exception e) {
			System.err.println("Exce in deleteCustGrp " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	/******************** Customer Header Master *************************/

	@RequestMapping(value = "/customerAdd", method = RequestMethod.GET)
	public ModelAndView clientForm(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("customerAdd", "customerList", "0", "1", "0", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("master/customerAdd");

				CustomerHeaderMaster custHead = new CustomerHeaderMaster();
				mav.addObject("custHead", custHead);

				CustomerGroupMaster[] custGrpArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerGroups", CustomerGroupMaster[].class);
				List<CustomerGroupMaster> custGrpList = new ArrayList<CustomerGroupMaster>(Arrays.asList(custGrpArr));
				mav.addObject("custGrpList", custGrpList);

				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getEmployees",
						EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);

				mav.addObject("title", "Add Customer");
				mav.addObject("custId", 0);
			}
		} catch (Exception e) {
			System.err.println("Exce in customerAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/customerList", method = RequestMethod.GET)
	public ModelAndView clientListForm(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("master/customerList");
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("customerList", "customerList", "1", "0", "0", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerInfoActiveInactive", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
				for (int i = 0; i < custHeadList.size(); i++) {

					custHeadList.get(i)
							.setExVar1(FormValidation.Encrypt(String.valueOf(custHeadList.get(i).getCustId())));
				}
				mav.addObject("custHeadList", custHeadList);

				Info add = AccessControll.checkAccess("customerList", "customerList", "0", "1", "0", "0",
						newModuleList);
				Info edit = AccessControll.checkAccess("customerList", "customerList", "0", "0", "1", "0",
						newModuleList);
				Info delete = AccessControll.checkAccess("customerList", "customerList", "0", "0", "0", "1",
						newModuleList);

				if (add.isError() == false) {
					// System.out.println(" add Accessable ");
					mav.addObject("addAccess", 0);

				}
				if (edit.isError() == false) {
					// System.out.println(" edit Accessable ");
					mav.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					// System.out.println(" delete Accessable ");
					mav.addObject("deleteAccess", 0);

				}
			}
		} catch (Exception e) {
			System.err.println("Exce in customerList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/addCustomerHeader", method = RequestMethod.POST)
	public String addCustomerHeader(HttpServletRequest request, HttpServletResponse response) {
		try {
			session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			CustomerHeaderMaster cust = new CustomerHeaderMaster();
			int custHeadId = 0;
			try {
				custHeadId = Integer.parseInt(request.getParameter("cust_head_id"));
			} catch (Exception e) {
				e.getMessage();
			}
			if (custHeadId == 0) {
				cust.setIsActive(1);
			} else {
				cust.setIsActive(Integer.parseInt(request.getParameter("isActv")));
			}
			int custType = Integer.parseInt(request.getParameter("custType"));

			cust.setCustId(custHeadId);
			cust.setOwnerEmpId(Integer.parseInt(request.getParameter("ownerPartner")));

			cust.setCustType(custType);
			try {
				cust.setCustGroupId(Integer.parseInt(request.getParameter("clientGrp")));
			} catch (Exception e) {
				cust.setCustGroupId(0);
			}
			cust.setCustFirmName(request.getParameter("firmName"));
			cust.setCustAssesseeTypeId(Integer.parseInt(request.getParameter("assesseeType")));
			cust.setCustAssesseeName(request.getParameter("assesseeName"));
			cust.setCustPanNo(request.getParameter("panNo"));
			cust.setCustEmailId(request.getParameter("emailId"));
			cust.setCustPhoneNo(request.getParameter("phone"));
			cust.setCustAddr1(request.getParameter("address1"));
			cust.setCustAddr2(request.getParameter("address2"));
			cust.setCustCity(request.getParameter("city"));
			cust.setCustPinCode(Integer.parseInt(request.getParameter("pincode")));
			cust.setCustBusinNatute(request.getParameter("business"));
			cust.setCustIsDscAvail(Integer.parseInt(request.getParameter("dsc")));
			cust.setCustFolderId(request.getParameter("filePath"));
			cust.setCustFileNo(request.getParameter("fileNo"));

			try {
				cust.setCustAadhar(request.getParameter("aadhar"));
			} catch (Exception e) {
				e.getMessage();
				cust.setCustAadhar(request.getParameter("-"));
			}

			cust.setCustDob(request.getParameter("dob"));
			cust.setDelStatus(1);

			cust.setUpdateDatetime(curDateTime);
			cust.setUpdateUsername(userId);
			cust.setExInt1(0);
			cust.setExInt2(0);
			cust.setExVar1("NA");
			cust.setExVar2("NA");
			System.out.println("Customer:" + cust);
			CustomerHeaderMaster custHead = Constants.getRestTemplate()
					.postForObject(Constants.url + "/saveNewCustomerHeader", cust, CustomerHeaderMaster.class);

			if (custHead != null) {
				session.setAttribute("successMsg", Constants.Sucessmsg);
				redirect = "redirect:/customerList";
			} else {
				session.setAttribute("errorMsg", Constants.Failmsg);
				redirect = "redirect:/customerList";

			}
		} catch (Exception e) {
			System.err.println("Exce in addCustomerHeader " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	@RequestMapping(value = "/editCust", method = RequestMethod.GET)
	public ModelAndView editCust(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {

			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("editCust", "customerList", "0", "0", "1", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");
			} else {

				MultiValueMap<String, Object> map = null;
				mav = new ModelAndView("master/customerAdd");

				String base64encodedString = request.getParameter("custId");
				String custId = FormValidation.DecodeKey(base64encodedString);

				map = new LinkedMultiValueMap<>();
				map.add("custHeadId", custId);

				CustomerHeaderMaster custHead = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getCustomerHeadById", map, CustomerHeaderMaster.class);
				mav.addObject("custHead", custHead);

				FirmType[] firmArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllFirms",
						FirmType[].class);
				List<FirmType> firmList = new ArrayList<FirmType>(Arrays.asList(firmArr));
				mav.addObject("firmList", firmList);

				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
						EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);

				CustomerGroupMaster[] custGrpArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerGroups", CustomerGroupMaster[].class);
				List<CustomerGroupMaster> custGrpList = new ArrayList<CustomerGroupMaster>(Arrays.asList(custGrpArr));
				mav.addObject("custGrpList", custGrpList);

				mav.addObject("title", "Edit Customer");
				mav.addObject("custId", custId);
			}
		} catch (Exception e) {
			System.err.println("Exce in editCust " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/deletCust", method = RequestMethod.GET)
	public String deletCustcustId(HttpServletRequest request, HttpServletResponse response) {
		String redirect = null;
		try {
			HttpSession session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("deletCust", "customerList", "0", "0", "1", "0", newModuleList);

			if (view.isError() == true) {

				redirect = "redirect:/accessDenied";
			} else {
				MultiValueMap<String, Object> map = null;

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				String base64encodedString = request.getParameter("custId");
				String custId = FormValidation.DecodeKey(base64encodedString);
				// int custId = Integer.parseInt(request.getParameter("custId"));

				map = new LinkedMultiValueMap<>();
				map.add("userId", userId);
				map.add("custHeadId", custId);

				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteCustomerHeader", map,
						Info.class);

				if (info.isError()) {
					session.setAttribute("errorMsg", "Fail to Delete");
					redirect = "redirect:/customerList";

				} else {
					session.setAttribute("successMsg", "Deleted Successfully");
					redirect = "redirect:/customerList";
				}
			}
		} catch (Exception e) {
			System.err.println("Exce in deletCust " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	/**********************************
	 * Periodicity
	 ************************************/

	@RequestMapping(value = "/getPeridicityByActivity", method = RequestMethod.GET)
	public @ResponseBody GetActivityPeriodicity getPeridicityByActivity(HttpServletRequest request,
			HttpServletResponse response) {
		GetActivityPeriodicity period = null;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			int activityId = Integer.parseInt(request.getParameter("actvityId"));
			System.err.println("Id Found--------------" + activityId);

			map = new LinkedMultiValueMap<>();
			map.add("activityId", activityId);

			period = Constants.getRestTemplate().postForObject(Constants.url + "/getPeriodicityByActivityId", map,
					GetActivityPeriodicity.class);
			System.out.println("Periodicity-------------" + period);

		} catch (Exception e) {
			System.err.println("Exce in customerActivityAddMap " + e.getMessage());
			e.printStackTrace();
		}
		return period;

	}

	/******************************* Status Master ********************************/

	@RequestMapping(value = "/statusList", method = RequestMethod.GET)
	public ModelAndView statusList(Locale locale, Model model, HttpServletRequest request) {

		ModelAndView mav = null;
		try {
			HttpSession session = request.getSession();
			mav = new ModelAndView("master/statusList");

			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");

			Info view = AccessControll.checkAccess("statusList", "statusList", "1", "0", "0", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				StatusMaster[] statusMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllStatus",
						StatusMaster[].class);
				List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
				mav.addObject("statusList", statusList);

				Info add = AccessControll.checkAccess("statusList", "statusList", "0", "1", "0", "0", newModuleList);
				Info edit = AccessControll.checkAccess("statusList", "statusList", "0", "0", "1", "0", newModuleList);
				Info delete = AccessControll.checkAccess("statusList", "statusList", "0", "0", "0", "1", newModuleList);

				if (add.isError() == false) {
					// System.out.println(" add Accessable ");
					mav.addObject("addAccess", 0);

				}
				if (edit.isError() == false) {
					// System.out.println(" edit Accessable ");
					mav.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					// System.out.println(" delete Accessable ");
					mav.addObject("deleteAccess", 0);

				}
			}
		} catch (Exception e) {
			System.err.println("Exce in statusList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/addStatus", method = RequestMethod.GET)
	public ModelAndView addStatus(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/addNewStatus");

			session = request.getSession();
			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("addStatus", "statusList", "0", "1", "0", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				StatusMaster status = new StatusMaster();

				mav.addObject("status", status);
				mav.addObject("title", "Add Status");
			}
		} catch (Exception e) {
			System.err.println("Exce in addStatus " + e.getMessage());
		}

		return mav;

	}

	@RequestMapping(value = "/addStatus", method = RequestMethod.POST)
	public String addStatus(HttpServletRequest request, HttpServletResponse response) {

		try {
			session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			int edit = 0;
			int statusId = 0;
			try {
				statusId = Integer.parseInt(request.getParameter("status_id"));
				edit = Integer.parseInt(request.getParameter("isEdit"));
			} catch (Exception e) {
				e.getMessage();
			}
			int maxStat = 0;
			int maxStaVal = Constants.getRestTemplate().getForObject(Constants.url + "/getMaxStatusValue",
					Integer.class);
			if (edit != 1) {

				maxStat = maxStaVal + 1;
			} else {
				maxStat = maxStaVal;
			}

			StatusMaster status = new StatusMaster();

			status.setStatusMstId(statusId);
			status.setStatusText(request.getParameter("statusText"));
			status.setStatusValue(maxStat);
			status.setStatusDesc(request.getParameter("statusDesc"));
			status.setStatusColor("Green");
			status.setIsEditable(1);
			status.setTypeIds("0");
			status.setDelStatus(1);
			status.setUpdateDatetime(curDateTime);
			status.setUpdateUsername(userId);

			StatusMaster actMastr = Constants.getRestTemplate().postForObject(Constants.url + "/saveStatus", status,
					StatusMaster.class);

			if (actMastr != null) {
				session.setAttribute("successMsg", Constants.Sucessmsg);
				redirect = "redirect:/statusList";

			} else {
				session.setAttribute("errorMsg", Constants.Failmsg);
				redirect = "redirect:/statusList";
			}

		} catch (Exception e) {
			System.err.println("Exce in addStatus " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;

	}

	@RequestMapping(value = "/editStatus", method = RequestMethod.GET)
	public ModelAndView statusList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/addNewStatus");

			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("editStatus", "statusList", "0", "0", "1", "0", newModuleList);

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				int statusId = Integer.parseInt(request.getParameter("statusId"));

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("statusId", statusId);
				StatusMaster status = Constants.getRestTemplate().postForObject(Constants.url + "/getStatusById", map,
						StatusMaster.class);
				mav.addObject("status", status);

				mav.addObject("isEdit", 1);

				mav.addObject("title", "Edit Status");
			}
		} catch (Exception e) {
			System.err.println("Exce in statusList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/deleteStatus", method = RequestMethod.GET)
	public String deleteStatus(HttpServletRequest request, HttpServletResponse response) {
		String redirect = null;
		try {
			HttpSession session = request.getSession();

			List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
			Info view = AccessControll.checkAccess("editStatus", "statusList", "0", "0", "1", "0", newModuleList);

			if (view.isError() == true) {

				redirect = "redirect:/accessDenied";

			} else {
				MultiValueMap<String, Object> map = null;

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				int statusId = Integer.parseInt(request.getParameter("statusId"));

				map = new LinkedMultiValueMap<>();
				map.add("userId", userId);
				map.add("statusId", statusId);

				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteStatusById", map,
						Info.class);
				if (info.isError()) {
					session.setAttribute("errorMsg", "Fail to Deleted");
					redirect = "redirect:/statusList";

				} else {
					session.setAttribute("successMsg", "Deleted Successfully");
					redirect = "redirect:/statusList";
				}

			}
		} catch (Exception e) {
			System.err.println("Exce in deletCust " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	@RequestMapping(value = "/updateTaskStatus", method = RequestMethod.POST)
	public String updateTaskStatus(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String redirect = null;
		try {
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			int statusVal = Integer.parseInt(request.getParameter("status"));
			HttpSession session1 = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session1.getAttribute("empLogin");
			int userId = emp.getEmpId();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("taskId", taskId);
			map.add("statusVal", statusVal);

			Task task = Constants.getRestTemplate().postForObject(Constants.url + "/updateTaskByTaskId", map,
					Task.class);
			if (task != null) {
				FormValidation.updateTaskLog(TaskText.taskTex3, userId, taskId);

			}

			redirect = "redirect:/taskListForEmp";
			// "redirect:/communication?taskId=" + taskId;

		} catch (Exception e) {
			System.err.println("Exce in updateTaskStatus " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;
	}

	/*********** Customer Active Decative *******************/

	@RequestMapping(value = "/activeDeactiveCustomer", method = RequestMethod.GET)
	public String activeDeactiveService(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "master/customerDeactive";

		try {

			String base64encodedString = request.getParameter("custId");
			String custId = FormValidation.DecodeKey(base64encodedString);
			System.err.println("base64encodedString custId---------" + custId);
			// int custId = Integer.parseInt(request.getParameter("custId"));

			MultiValueMap<String, Object> map = null;
			map = new LinkedMultiValueMap<>();
			map.add("custId", custId);

			CustNameId custName = Constants.getRestTemplate().postForObject(Constants.url + "/getCustNameById", map,
					CustNameId.class);

			model.addAttribute("custName", custName);

			Task[] task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskListCustIsActive", map,
					Task[].class);
			List<Task> taskList = new ArrayList<>(Arrays.asList(task));
			model.addAttribute("taskList", taskList);

			// model.addAttribute("actList", custActList);
		} catch (Exception e) {
			e.getMessage();
		}

		return mav;
	}

	@RequestMapping(value = "/updateCustomerIsActiveStatus", method = RequestMethod.POST)
	public String activeDeactiveService(HttpServletRequest request, HttpServletResponse response) {
		session = request.getSession();
		try {

			int custId = Integer.parseInt(request.getParameter("custId"));
			int isActiveStatus = Integer.parseInt(request.getParameter("isActiveStatus"));
			String[] taskIds = request.getParameterValues("taskIds");

			String ids = "0";

			try {

				for (int i = 0; i < taskIds.length; i++) {
					ids = ids + "," + taskIds[i];
				}

			} catch (Exception e) {
				ids = "0";
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("custId", custId);
			map.add("isActiveStatus", isActiveStatus);
			map.add("taskIds", ids);

			Info updateIsActiveStatus = Constants.getRestTemplate()
					.postForObject(Constants.url + "/updateCustomerIsActiveStatus", map, Info.class);
			if (updateIsActiveStatus.isError()) {
				session.setAttribute("errorMsg", Constants.Failmsg);
				redirect = "redirect:/customerList";

			} else {
				if (isActiveStatus == 1) {
					session.setAttribute("successMsg", "Status is Active");
				} else {
					session.setAttribute("successMsg", "Status is InActive");
				}
				redirect = "redirect:/customerList";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/deletCustDetail", method = RequestMethod.GET)
	public String deletCustDetail(HttpServletRequest request, HttpServletResponse response) {
		String redirect = null;
		try {
			HttpSession session = request.getSession();

			MultiValueMap<String, Object> map = null;

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			int custDetId = Integer.parseInt(request.getParameter("custDetId"));

			map = new LinkedMultiValueMap<>();
			map.add("custDetId", custDetId);
			map.add("userId", userId);
			map.add("curDateTime", Constants.getCurDateTime());

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteCustomerDetail", map,
					Info.class);

			if (info.isError()) {
				session.setAttribute("errorMsg", "Fail to Deleted");
				redirect = "redirect:/customerDetailList";

			} else {
				session.setAttribute("successMsg", "Deleted Successfully");
				redirect = "redirect:/customerDetailList";
			}

		} catch (Exception e) {
			System.err.println("Exce in deletCust " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;
	}

	/*********************************
	 * Add Deliverable Link
	 ******************************/

	@RequestMapping(value = "/insertDeliverableLink", method = RequestMethod.POST)
	public @ResponseBody Info addDeliverLink(HttpServletRequest request, HttpServletResponse response) {
		Info info = null;
		try {
			int taskId = 0;
			try {
				taskId = Integer.parseInt(request.getParameter("taskId"));
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

			String link = request.getParameter("link");

			System.out.println("Data----------" + link + " " + taskId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("taskId", taskId);
			map.add("link", link);

			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateTaskDeliverLink", map, Info.class);

		} catch (Exception e) {
			System.err.println("Exception in insertDeliverableLink : " + e.getMessage());
			e.printStackTrace();
		}

		return info;

	}

	// checkUniquePan Sachin 25-11-2019

	@RequestMapping(value = "/checkUniquePan", method = RequestMethod.POST)
	public @ResponseBody Info checkUniquePan(HttpServletRequest request, HttpServletResponse response) {
		Info info = null;
		try {

			int custId = Integer.parseInt(request.getParameter("custId"));
			String panNo = request.getParameter("panNo");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("panNo", panNo);
			map.add("custId", custId);

			info = Constants.getRestTemplate().postForObject(Constants.url + "/checkUniquePan", map, Info.class);
			System.err.println(info.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	// Sachin 26-11-2019
	@RequestMapping(value = "/getCountofManagers", method = RequestMethod.GET)
	public @ResponseBody Object getCountofManagers(HttpServletRequest request, HttpServletResponse response) {
		int count = 0;
		try {

			String empIds = request.getParameter("empIds");
			System.err.println("empIds" + empIds.toString());
			empIds = empIds.substring(1, empIds.length() - 1);
			empIds = empIds.replaceAll("\"", "");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empIdList", empIds);

			count = Constants.getRestTemplate().postForObject(Constants.url + "/getCountofManagers", map, int.class);
			// System.err.println(count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;

	}

	// completeAndDeliverTask Sachin 26-11-2019
	@RequestMapping(value = "/completeAndDeliverTask", method = RequestMethod.GET)
	public @ResponseBody Object completeAndDeliverTask(HttpServletRequest request, HttpServletResponse response) {
		int count = 0;
		try {
session=request.getSession();
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			String delLink = request.getParameter("delLink");
			String statusText=request.getParameter("selectedStatus");
System.err.println("statusText " +statusText);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			map = new LinkedMultiValueMap<>();
			map.add("taskId", taskId);
			map.add("link", delLink);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateTaskDeliverLink", map, Info.class);

			
			map = new LinkedMultiValueMap<>();
			map.add("taskId", taskId);
			map.add("statusVal", 9);
			map.add("userId", userId);
			map.add("curDateTime", Constants.getCurDateTime());
			map.add("compltnDate", Constants.getCurDateTime());

			 info = Constants.getRestTemplate().postForObject(Constants.url + "/updateStatusByTaskId", map, Info.class);
			System.err.println(info.toString());
			if (info != null) {
				FormValidation.updateTaskLog(TaskText.taskTex8+"-"+statusText, userId, taskId);
				count=1;
			}
			 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;

	}

}
