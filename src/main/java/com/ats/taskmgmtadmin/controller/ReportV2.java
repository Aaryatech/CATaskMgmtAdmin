package com.ats.taskmgmtadmin.controller;

import java.io.IOException;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.ExportExcelController;
import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.ExceUtil;
import com.ats.taskmgmtadmin.common.ExportToExcel;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.CapacityDetailByEmp;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.model.report.ComplTaskVarienceRep;
import com.ats.taskmgmtadmin.model.report.CompletedTaskReport;
import com.ats.taskmgmtadmin.model.report.InactiveTaskReport;
import com.ats.taskmgmtadmin.model.report.OverDueTaskReport;
import com.ats.taskmgmtadmin.model.report.VarianceReportByManger;
import com.ats.taskmgmtadmin.model.report.WorkLofForReport;
import com.ats.taskmgmtadmin.model.report.WorkLogReportBetDates;
import com.ats.taskmgmtadmin.model.report.WorkLogSub;
import com.ats.taskmgmtadmin.task.model.GetTaskList;
import com.itextpdf.text.Font;

@Controller
@Scope("session")
public class ReportV2 {

	List<CapacityDetailByEmp> empCapList;

	@RequestMapping(value = "/getAllEmployeeCapacityDetail", method = RequestMethod.GET)
	public String showCompTaskReportFormanager(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		String mav = new String();
		try {

			mav = "report/v2/empCapDetails"; // copy of compTaskForManager.jsp
			String yearrange = request.getParameter("monthyear");
			if (yearrange != null) {

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

				String[] fromDate = yearrange.split(" to ");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
				CapacityDetailByEmp[] resArray = Constants.getRestTemplate().postForObject(
						Constants.url + "getAllEmployeeCapacityDetail", map, CapacityDetailByEmp[].class);
				empCapList = new ArrayList<>(Arrays.asList(resArray));

				model.addAttribute("empCapList", empCapList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);
				session.setAttribute("fromDate", fromDate[0]);
				session.setAttribute("toDate", fromDate[1]);

			} else {
				String dateFrTd = DateConvertor.getFromToDate();
				model.addAttribute("fromDate", dateFrTd.split(" to ")[0]);
				model.addAttribute("toDate", dateFrTd.split(" to ")[1]);
				model.addAttribute("yearrange", DateConvertor.getFromToDate());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/getAllEmployeeCapacityDetailExcel", method = RequestMethod.GET)
	public void getAllEmployeeCapacityDetailExcel(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Performance-Total Capacity Utilization";

		HttpSession session = request.getSession();
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
		int userId = emp.getEmpId();

		try {

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Employee Name");
			rowData.add("Budgeted Capacity");
			rowData.add("Alloted Capacity");
			rowData.add("Utilized Capacity");
			rowData.add("Budgeted vs Alloted");
			rowData.add("Budgeted vs Utilized");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < empCapList.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + empCapList.get(i).getEmpName());
				rowData.add("" + empCapList.get(i).getBugetedCap());
				rowData.add("" + empCapList.get(i).getAllWork());
				rowData.add("" + empCapList.get(i).getActWork());
				rowData.add(""
						+ roundUp((empCapList.get(i).getBugetedCap() - Float.valueOf(empCapList.get(i).getAllWork()))));
				rowData.add("" + roundUp(
						(Float) empCapList.get(i).getBugetedCap() - Float.valueOf(empCapList.get(i).getActWork())));

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {
				String fromDate = (String) session.getAttribute("fromDate");
				String toDate = (String) session.getAttribute("toDate");

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						" From Date:" + fromDate + "   To Date:" + toDate + "", "", 'G');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	public String roundUp(float value) {

		BigDecimal bd = new BigDecimal(value).setScale(2, RoundingMode.HALF_UP);

		return bd.toPlainString();

	}

	// Completed task Due date And Hours Variance
	List<ComplTaskVarienceRep> taskReportList;

	@RequestMapping(value = "/getCompTaskVariation/{reportType}", method = RequestMethod.GET)
	public String showCompTaskReportFormanager(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model, @PathVariable int reportType) {
		String reportTitle = null;

		String mav = new String();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", userId);
			EmployeeMaster[] employee = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
			List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

			model.addAttribute("epmList", epmList);

			System.err.println("report type= " + reportType);
			mav = "report/v2/compTaskVariationRep"; // copy of empMngrPerfmncReprt.jsp

			if (reportType == 1) {
				reportTitle = "Due Date Variance";

			} else {
				reportTitle = "Hours Variance";
			}
			String yearrange = request.getParameter("monthyear");
			if (yearrange != null) {

				map = new LinkedMultiValueMap<String, Object>();
				map.add("empId", Integer.parseInt(request.getParameter("empId")));
				EmployeeMaster empData = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById",
						map, EmployeeMaster.class);

				String[] fromDate = yearrange.split(" to ");
				map = new LinkedMultiValueMap<String, Object>();

				if (reportType == 1) {
					map.add("reportType", reportType);

				} else {
					map.add("reportType", empData.getEmpType());
				}

				map.add("fromDate", fromDate[0]);
				map.add("toDate", fromDate[1]);
				map.add("empIds", Integer.parseInt(request.getParameter("empId")));

				ComplTaskVarienceRep[] resArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "getComplTaskVarienceReport", map, ComplTaskVarienceRep[].class);
				taskReportList = new ArrayList<>(Arrays.asList(resArray));

				model.addAttribute("taskReportList", taskReportList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);

				model.addAttribute("empData", empData);
				model.addAttribute("reportType", reportType);
				model.addAttribute("reportTitle", reportTitle);
				model.addAttribute("empId", Integer.parseInt(request.getParameter("empId")));

				session.setAttribute("fromDateR2", fromDate[0]);
				session.setAttribute("toDateR2", fromDate[1]);

			} else {
				String dateFrTd = DateConvertor.getFromToDate();
				model.addAttribute("fromDate", dateFrTd.split(" to ")[0]);
				model.addAttribute("toDate", dateFrTd.split(" to ")[1]);
				model.addAttribute("yearrange", DateConvertor.getFromToDate());
				model.addAttribute("reportType", reportType);
				model.addAttribute("reportTitle", reportTitle);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/getCompTaskVariationExcel", method = RequestMethod.GET)
	public void getCompTaskVariationExcel(HttpServletRequest request, HttpServletResponse response) {
		String reportName = null;
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		int empId = Integer.parseInt(request.getParameter("empId"));
		int reportType = Integer.parseInt(request.getParameter("reportType"));

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		map = new LinkedMultiValueMap<String, Object>();
		map.add("empId", empId);
		EmployeeMaster empData = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
				EmployeeMaster.class);

		System.err.println(
				"para empId " + empId + "reportType" + reportType + "fromDate " + fromDate + "to date " + toDate);
		map = new LinkedMultiValueMap<String, Object>();

		if (reportType == 1) {
			map.add("reportType", reportType);

		} else {
			map.add("reportType", empData.getEmpType());
		}
		map.add("fromDate", fromDate);
		map.add("toDate", toDate);
		map.add("empIds", empId);

		ComplTaskVarienceRep[] resArray = Constants.getRestTemplate()
				.postForObject(Constants.url + "getComplTaskVarienceReport", map, ComplTaskVarienceRep[].class);
		taskReportList = new ArrayList<>(Arrays.asList(resArray));

		if (reportType == 1) {
			reportName = "Due Date Variance";

		} else {
			reportName = "Hours Variance";
		}

		try {

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Task Text");
			rowData.add("Client Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Periodicity");
			rowData.add("Owner Partner");
			rowData.add("Execution Partner");
			rowData.add("Employee Name");
			rowData.add("TL Name");
			rowData.add("Manager Name");

			if (reportType == 1) {
				rowData.add("Due Date");
				rowData.add("Work Date");
				rowData.add("Completion Date");
			}

			if (reportType == 2) {
				rowData.add("Budgeted Hrs");
				rowData.add("Actual Hrs");
			}

			rowData.add("Variance");
			rowData.add("Drive Link");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < taskReportList.size(); i++) {

				ComplTaskVarienceRep task = taskReportList.get(i);
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + task.getTaskText());
				rowData.add("" + task.getCustFirmName());
				rowData.add("" + task.getServName());
				rowData.add("" + task.getActiName());
				rowData.add("" + task.getPeriodicityName());
				rowData.add("" + task.getOwnPartner());

				rowData.add("" + task.getPartner());
				rowData.add("" + empData.getEmpName());
				rowData.add("" + task.getTeamLeader());
				rowData.add("" + task.getManager());

				if (reportType == 1) {
					rowData.add("" + task.getTaskStatutoryDueDate());
					rowData.add("" + task.getTaskWorkDate());
					rowData.add("" + task.getTaskCompletionDate());
				} else {
					if (empData.getEmpType() == 5) {
						rowData.add("" + task.getEmpBudHr());
					} else {
						rowData.add("" + task.getMngrBudHr());
					}
					rowData.add("" + task.getWorkHours());
				}

				if (reportType == 1) {
					rowData.add("" + task.getDateDiff());
				} else {
					if (empData.getEmpType() == 5) {

						rowData.add("" + task.getEmpHrVariance());
					} else {
						rowData.add("" + task.getMngHrVariance());
					}

				}
				rowData.add("" + task.getDelLink());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}
			Character endChar = ' ';
			if (reportType == 1) {
				endChar = 'O';// 15
			} else {
				endChar = 'N';// 14
			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Emp Name:" + empData.getEmpName() + " From Date:" + fromDate + "   To Date:" + toDate + "", "",
						endChar);

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

//Overdue TList  and Work log diary of Emp Report Bet Two Date 

	@RequestMapping(value = "/getOvDueOrWorkLDiEmpFdTd/{reportType}", method = RequestMethod.GET)
	public String getOverDueOrWorkDiaryEmpFdTdReport(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model, @PathVariable int reportType) {
		String reportTitle = null;

		String mav = new String();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			System.err.println("report type= " + reportType);
			mav = "report/v2/overDueOrWorkDiary"; // copy of empMngrPerfmncReprt.jsp

			if (reportType == 1) {
				reportTitle = "OverDue Tasks";
				map = new LinkedMultiValueMap<String, Object>();
				map.add("empId", userId);
				EmployeeMaster[] employee = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

				model.addAttribute("epmList", epmList);
			} else {
				reportTitle = "Employee Work Log Diary (History)";

				EmployeeMaster[] employee = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEmployeesActiveInactive", EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				model.addAttribute("epmList", epmList);
			}
			String yearrange = request.getParameter("monthyear");
			if (yearrange != null) {

				map = new LinkedMultiValueMap<String, Object>();
				map.add("empId", Integer.parseInt(request.getParameter("empId")));
				EmployeeMaster empData = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById",
						map, EmployeeMaster.class);

				String[] fromDate = yearrange.split(" to ");
				map = new LinkedMultiValueMap<String, Object>();

				map.add("reportType", reportType);

				map.add("fromDate", fromDate[0]);
				map.add("toDate", fromDate[1]);
				map.add("empIds", Integer.parseInt(request.getParameter("empId")));

				OverDueTaskReport[] resArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "getOverDueOrWorkDiaryEmpFdTd", map, OverDueTaskReport[].class);
				List<OverDueTaskReport> taskReportList = new ArrayList<>(Arrays.asList(resArray));

				model.addAttribute("taskReportList", taskReportList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);

				model.addAttribute("empData", empData);
				model.addAttribute("reportType", reportType);
				model.addAttribute("reportTitle", reportTitle);
				model.addAttribute("empId", Integer.parseInt(request.getParameter("empId")));

				session.setAttribute("fromDateR2", fromDate[0]);
				session.setAttribute("toDateR2", fromDate[1]);

			} else {
				String dateFrTd = DateConvertor.getFromToDate();
				model.addAttribute("fromDate", dateFrTd.split(" to ")[0]);
				model.addAttribute("toDate", dateFrTd.split(" to ")[1]);
				model.addAttribute("yearrange", DateConvertor.getFromToDate());
				model.addAttribute("reportType", reportType);
				model.addAttribute("reportTitle", reportTitle);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;

	}

	@RequestMapping(value = "/getOvDueOrWorkLDiEmpFdTdExcel", method = RequestMethod.GET)
	public void getOvDueOrWorkLDiEmpFdTdExcel(HttpServletRequest request, HttpServletResponse response) {
		String reportName = null;
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		int empId = Integer.parseInt(request.getParameter("empId"));
		int reportType = Integer.parseInt(request.getParameter("reportType"));

		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		map = new LinkedMultiValueMap<String, Object>();
		map.add("empId", empId);
		EmployeeMaster empData = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
				EmployeeMaster.class);

		System.err.println(
				"para empId " + empId + "reportType" + reportType + "fromDate " + fromDate + "to date " + toDate);
		map = new LinkedMultiValueMap<String, Object>();

		map.add("reportType", reportType);

		map.add("fromDate", fromDate);
		map.add("toDate", toDate);
		map.add("empIds", empId);
		OverDueTaskReport[] resArray = Constants.getRestTemplate()
				.postForObject(Constants.url + "getOverDueOrWorkDiaryEmpFdTd", map, OverDueTaskReport[].class);
		List<OverDueTaskReport> taskReportList = new ArrayList<>(Arrays.asList(resArray));

		if (reportType == 1) {
			reportName = "OverDue Tasks";
		} else {
			reportName = "Employee Work Log Diary (History)";
		}

		try {

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Task Text");
			rowData.add("Client Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Periodicity");
			rowData.add("Owner Partner");
			rowData.add("Execution Partner");
			rowData.add("Employee Name");
			rowData.add("TL Name");
			rowData.add("Manager Name");

			if (reportType == 1) {
				rowData.add("Due Date");
				rowData.add("Work Date");
				rowData.add("Status");
			}

			if (reportType == 2) {
				rowData.add("Work Log Date");
				rowData.add("Worked Hour");
			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < taskReportList.size(); i++) {

				OverDueTaskReport task = taskReportList.get(i);
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + task.getTaskText());
				rowData.add("" + task.getCustFirmName());
				rowData.add("" + task.getServName());
				rowData.add("" + task.getActiName());
				rowData.add("" + task.getPeriodicityName());
				rowData.add("" + task.getOwnPartner());

				rowData.add("" + task.getPartner());
				rowData.add("" + empData.getEmpName());
				rowData.add("" + task.getTeamLeader());
				rowData.add("" + task.getManager());

				if (reportType == 1) {
					rowData.add("" + task.getTaskStatutoryDueDate());
					rowData.add("" + task.getTaskWorkDate());
					rowData.add("" + task.getStatusText());
				} else {
					rowData.add("" + task.getTaskCompletionDate());
					rowData.add("" + task.getWorkHours());
				}

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
			}
			Character endChar = ' ';

			if (reportType == 1) {
				endChar = 'N';
			} else {
				endChar = 'M';// 12
			}
			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Emp Name:" + empData.getEmpName() + " From Date:" + fromDate + "   To Date:" + toDate + "", "",
						endChar);

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	////// *************************harsha***********************************************

	@RequestMapping(value = "/showVarianceByManger", method = RequestMethod.GET)
	public String completedTaskList(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();

		String mav = new String();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("showVarianceByManger", "showVarianceByManger", "1", "0", "0", "0",
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "report/Manager/varianceByManager";
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			System.out.println("empType is " + emp.getEmpType());

			try {

				ServiceMaster[] srvsMstr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				model.addAttribute("serviceList", srvcMstrList);

				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerInfo", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

				model.addAttribute("custList", custHeadList);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				int servId = 0;
				int actId = 0;
				int mangId = 0;
				int custId = 0;

				try {
					servId = Integer.parseInt(request.getParameter("service"));
				} catch (Exception e) {

					servId = 0;

				}
				try {
					actId = Integer.parseInt(request.getParameter("activity"));
				} catch (Exception e) {

					actId = 0;

				}
				try {
					mangId = Integer.parseInt(request.getParameter("mangId"));
				} catch (Exception e) {

					mangId = 0;

				}

				try {
					custId = Integer.parseInt(request.getParameter("customer"));
				} catch (Exception e) {

					custId = 0;

				}

				map = new LinkedMultiValueMap<>();
				map.add("serviceId", servId);

				ActivityMaster[] activityArr = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllActivitesByServiceId", map, ActivityMaster[].class);
				List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
				model.addAttribute("activityList", activityList);
				model.addAttribute("servId", servId);
				model.addAttribute("actId", actId);
				model.addAttribute("mangId", mangId);
				model.addAttribute("custId", custId);

				map = new LinkedMultiValueMap<>();
				map.add("roleId", 3);
				EmployeeMaster[] holListArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmpByEmpTypeId", map, EmployeeMaster[].class);

				List<EmployeeMaster> empList = new ArrayList<>(Arrays.asList(holListArray));
				System.err.println("empList is " + empList.toString());

				model.addAttribute("empList", empList);

				map = new LinkedMultiValueMap<>();
				map.add("custId", custId);
				map.add("servId", servId);
				map.add("actId", actId);
				map.add("empId", mangId);
				VarianceReportByManger[] repListArray = Constants.getRestTemplate().postForObject(
						Constants.url + "/getVarianceReportByManagerReport", map, VarianceReportByManger[].class);

				List<VarianceReportByManger> varianceList = new ArrayList<>(Arrays.asList(repListArray));
				model.addAttribute("varianceList", varianceList);

			} catch (Exception e) {
				System.err.println("Exce in CompletedTakList " + e.getMessage());
				e.printStackTrace();
			}

		}
		return mav;

	}

	@RequestMapping(value = "/getVarianceByManagerExcel", method = RequestMethod.GET)
	public void getVarianceByManagerExcel(HttpServletRequest request, HttpServletResponse response) {
		String reportName = "Statutory Date Variance By Manager";
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		try {

			int custId = Integer.parseInt(request.getParameter("custId"));
			int servId = Integer.parseInt(request.getParameter("servId"));
			int actId = Integer.parseInt(request.getParameter("actId"));
			System.err.println("------------------" + custId);

			int mangId = Integer.parseInt(request.getParameter("mangId"));
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", mangId);
			EmployeeMaster empData = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);

			map = new LinkedMultiValueMap<String, Object>();
			map.add("custId", custId);
			map.add("servId", servId);
			map.add("actId", actId);
			map.add("empId", mangId);
			VarianceReportByManger[] repListArray = Constants.getRestTemplate().postForObject(
					Constants.url + "/getVarianceReportByManagerReport", map, VarianceReportByManger[].class);

			List<VarianceReportByManger> varianceList = new ArrayList<>(Arrays.asList(repListArray));

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Task Text");
			rowData.add("Client Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Periodicity");
			rowData.add("Partner");
			rowData.add("Employee Name");
			rowData.add("TL Name");
			rowData.add("Manager Name");
			rowData.add("Work Date");
			rowData.add("Completion Date");
			rowData.add("Start Date");
			rowData.add("Due Date");
			rowData.add("Variance");
			rowData.add("Drive Link");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < varianceList.size(); i++) {

				VarianceReportByManger task = varianceList.get(i);
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + task.getTaskText());
				rowData.add("" + task.getCustFirmName());
				rowData.add("" + task.getServName());
				rowData.add("" + task.getActiName());
				rowData.add("" + task.getPeriodicityName());
				rowData.add("" + task.getPartner());

				rowData.add("" + task.getEmployee());
				rowData.add("" + task.getTeamLeader());
				rowData.add("" + task.getManager());

				rowData.add("" + task.getTaskEndDate());

				if (task.getCompletionDate() == null) {
					rowData.add("" + "");
				} else {
					rowData.add("" + task.getCompletionDate());

				}

				rowData.add("" + task.getTaskStartDate());
				rowData.add("" + task.getTaskStatutoryDueDate());
				rowData.add("" + task.getVarianceDays());
				rowData.add("" + task.getExVar1());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Manager Name:" + empData.getEmpName() + "", "", 'P');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	@RequestMapping(value = { "/show30DaysWorkLog" }, method = RequestMethod.GET)
	public String show30DaysWorkLog(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) {

		String mav = new String();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("show30DaysWorkLog", "show30DaysWorkLog", "1", "0", "0", "0",
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			try {

				mav = "report/30DaysWorkLog";

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;
	}

	@RequestMapping(value = "/dateRangeLogReport", method = RequestMethod.GET)
	public void daysLogReport(HttpServletRequest request, HttpServletResponse response) {
		String reportName = "30 Days work Log";
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		ExportToExcel expoExcel = new ExportToExcel();

		try {

			String range = request.getParameter("range");
			System.err.println("range" + range);
			String[] arrOfStr = range.split("to", 2);

			String starDate = DateConvertor.convertToYMD(arrOfStr[0].toString().trim());
			String endDate = DateConvertor.convertToYMD(arrOfStr[1].toString().trim());
			map.add("startDate", starDate);
			map.add("endDate", endDate);
			WorkLogReportBetDates data = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getWorkDetBetDatesReport", map, WorkLogReportBetDates.class);

			List<WorkLogSub> logList = data.getLogList();
			List<EmployeeMaster> empList = data.getEmpList();
			List<LocalDate> totalDates = new ArrayList<>();

			LocalDate start = LocalDate.parse(starDate);
			LocalDate end = LocalDate.parse(endDate);
			while (!start.isAfter(end)) {
				totalDates.add(start);
				start = start.plusDays(1);
			}

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Employee Name");
			for (int j = 0; j < totalDates.size(); j++) {
				rowData.add("" + DateConvertor.convertToDMY(String.valueOf(totalDates.get(j))));

			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;

			for (int i = 0; i < empList.size(); i++) {

				// System.err.println("emp"+empList.get(i).getEmpName());
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;
				rowData.add("" + (i + 1));
				rowData.add("" + empList.get(i).getEmpName());
				List<String> workList = new ArrayList<>();

				for (int k = 0; k < logList.size(); k++) {

					if (logList.get(k).getEmpId() == empList.get(i).getEmpId()) {

						workList = logList.get(k).getStatus();
						break;
					}
				}

				for (int j = 0; j < workList.size(); j++) {
					rowData.add("" + workList.get(j));

				}

				expoExcel.setRowData(rowData);

				exportToExcelList.add(expoExcel);

			}

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", reportName);

			XSSFWorkbook wb = null;

			wb = ExportExcelController.createWorkbook(exportToExcelList);

			ExceUtil.autoSizeColumns(wb, 3);
			response.setContentType("application/vnd.ms-excel");
			String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
			wb.write(response.getOutputStream());

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	/*
	 * List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();
	 * 
	 * @RequestMapping(value = "/exportToExcel", method = RequestMethod.GET)
	 * 
	 * public void downloadSpreadsheet(HttpServletResponse response,
	 * HttpServletRequest request) throws Exception { XSSFWorkbook wb = null;
	 * HttpSession session = request.getSession(); try {
	 * 
	 * exportToExcelList = (List) session.getAttribute("exportExcelList");
	 * System.out.println("Excel List :" + exportToExcelList.toString());
	 * 
	 * String excelName = (String) session.getAttribute("excelName"); wb =
	 * createWorkbook();
	 * 
	 * response.setContentType("application/vnd.ms-excel"); String date = new
	 * SimpleDateFormat("yyyy-MM-dd").format(new Date());
	 * response.setHeader("Content-disposition", "attachment; filename=" + excelName
	 * + "-" + date + ".xlsx"); wb.write(response.getOutputStream());
	 * 
	 * } catch (IOException ioe) { throw new
	 * RuntimeException("Error writing spreadsheet to output stream"); } finally {
	 * if (wb != null) { wb.close(); } } session.removeAttribute("exportExcelList");
	 * System.out.println("Session List" + session.getAttribute("exportExcelList"));
	 * }
	 * 
	 * private XSSFWorkbook createWorkbook() throws IOException { XSSFWorkbook wb =
	 * new XSSFWorkbook(); XSSFSheet sheet = wb.createSheet("Sheet1");
	 * 
	 * 
	 * writeHeaders(wb, sheet); writeHeaders(wb, sheet); writeHeaders(wb, sheet);
	 * 
	 * 
	 * for (int rowIndex = 0; rowIndex < exportToExcelList.size(); rowIndex++) {
	 * XSSFRow row = sheet.createRow(rowIndex); for (int j = 0; j <
	 * exportToExcelList.get(rowIndex).getRowData().size(); j++) {
	 * 
	 * XSSFCell cell = row.createCell(j);
	 * 
	 * cell.setCellValue(exportToExcelList.get(rowIndex).getRowData().get(j));
	 * 
	 * } if (rowIndex == 0) row.setRowStyle(createHeaderStyle(wb)); } return wb; }
	 * 
	 * private XSSFCellStyle createHeaderStyle(XSSFWorkbook workbook) {
	 * XSSFCellStyle style = workbook.createCellStyle(); style.setWrapText(true);
	 * style.setFillForegroundColor(new XSSFColor(new java.awt.Color(53, 119,
	 * 192)));
	 * 
	 * // style.setFillPattern(CellStyle.SOLID_FOREGROUND);
	 * 
	 * 
	 * style.setBorderRight(CellStyle.BORDER_THIN);
	 * style.setRightBorderColor(IndexedColors.BLACK.getIndex());
	 * style.setBorderBottom(CellStyle.BORDER_THIN);
	 * style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	 * style.setBorderLeft(CellStyle.BORDER_THIN);
	 * style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	 * style.setBorderTop(CellStyle.BORDER_THIN);
	 * style.setTopBorderColor(IndexedColors.BLACK.getIndex());
	 * 
	 * // style.setDataFormat(1);
	 * 
	 * XSSFFont font = workbook.createFont(); ((org.apache.poi.ss.usermodel.Font)
	 * font).setFontName("Arial"); ((org.apache.poi.ss.usermodel.Font)
	 * font).setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	 * ((org.apache.poi.ss.usermodel.Font) font).setBold(true); //
	 * font.setColor(HSSFColor.WHITE.index);
	 * style.setFont((org.apache.poi.ss.usermodel.Font) font);
	 * 
	 * return style; }
	 */
}
