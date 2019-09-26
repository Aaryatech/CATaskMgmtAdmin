package com.ats.taskmgmtadmin.controller;

import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.ExceUtil;
import com.ats.taskmgmtadmin.common.ExportToExcel;
import com.ats.taskmgmtadmin.model.BugetedAmtAndRevenue;
import com.ats.taskmgmtadmin.model.ClientGroupList;
import com.ats.taskmgmtadmin.model.ClientWiseTaskReport;
import com.ats.taskmgmtadmin.model.EmpIdNameList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.EmpwithPartnerList;

@Controller
@Scope("session")
public class ParterDashboardController {

	@RequestMapping(value = "/clientWiseReport", method = RequestMethod.GET)
	public String clientWiseReport(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) {

		String mav = new String();
		try {

			mav = "report/Partner/clientWiseReport";

			ClientGroupList[] clientGroup = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getClientGroupList", ClientGroupList[].class);
			List<ClientGroupList> clientGroupList = new ArrayList<ClientGroupList>(Arrays.asList(clientGroup));
			model.addAttribute("clientGroupList", clientGroupList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/clientwisetaskcostreport", method = RequestMethod.GET)
	public @ResponseBody List<ClientWiseTaskReport> clientwisetaskcostreport(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		List<ClientWiseTaskReport> list = new ArrayList<>();

		try {

			int rateType = Integer.parseInt(request.getParameter("rateType"));
			String month = request.getParameter("monthyear");
			String[] monthyear = month.split(" to ");
			int typeId = Integer.parseInt(request.getParameter("typeId"));
			int groupId = 0;
			String serchby = new String();
			String rateserchby = new String();

			try {

				groupId = Integer.parseInt(request.getParameter("groupId"));

			} catch (Exception e) {
				// e.printStackTrace();
				groupId = -1;
			}
			int clientId = Integer.parseInt(request.getParameter("clientId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("rateType", rateType);
			map.add("yearId", 5);
			map.add("groupId", groupId);
			map.add("clientId", clientId);
			map.add("fromDate", DateConvertor.convertToYMD(monthyear[0]));
			map.add("toDate", DateConvertor.convertToYMD(monthyear[1]));
			ClientWiseTaskReport[] clientWiseTaskReport = Constants.getRestTemplate()
					.postForObject(Constants.url + "/clientWiseTaskReport", map, ClientWiseTaskReport[].class);
			list = new ArrayList<>(Arrays.asList(clientWiseTaskReport));

			// exel code
			String reportName = "Cliet Wise Task Cost Report";
			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			if (typeId == 0) {
				serchby = "Search Type : Group";
			} else {
				serchby = "Search Type : Individual";
			}

			if (rateType == 0) {
				rateserchby = "Rate Type : Budgeted Rate";
			} else {
				rateserchby = "Rate Type : Actual Rate";
			}
			
			

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	
	@RequestMapping(value = "/showClientwisetaskcostreport", method = RequestMethod.POST)
	public void showClientwisetaskcostreport(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		List<ClientWiseTaskReport> list = new ArrayList<>();

		try {

			int rateType = Integer.parseInt(request.getParameter("rateType"));
			String month = request.getParameter("monthyear");
			String[] monthyear = month.split(" to ");
			int typeId = Integer.parseInt(request.getParameter("typeId"));
			int groupId = 0;
			String serchby = new String();
			String rateserchby = new String();

			try {

				groupId = Integer.parseInt(request.getParameter("groupId"));

			} catch (Exception e) {
				// e.printStackTrace();
				groupId = -1;
			}
			int clientId = Integer.parseInt(request.getParameter("clientId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("rateType", rateType);
			map.add("yearId", 5);
			map.add("groupId", groupId);
			map.add("clientId", clientId);
			map.add("fromDate", DateConvertor.convertToYMD(monthyear[0]));
			map.add("toDate", DateConvertor.convertToYMD(monthyear[1]));
			ClientWiseTaskReport[] clientWiseTaskReport = Constants.getRestTemplate()
					.postForObject(Constants.url + "/clientWiseTaskReport", map, ClientWiseTaskReport[].class);
			list = new ArrayList<>(Arrays.asList(clientWiseTaskReport));

			// exel code
			String reportName = "Cliet Wise Task Cost Report";
			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			if (typeId == 0) {
				serchby = "Search Type : Group";
			} else {
				serchby = "Search Type : Individual";
			}

			if (rateType == 0) {
				rateserchby = "Rate Type : Budgeted Rate";
			} else {
				rateserchby = "Rate Type : Actual Rate";
			}
			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Client Name");
			rowData.add("Task Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Task/ Periodicity");
			rowData.add("Owner Partner");
			rowData.add("Execution Partner");
			rowData.add("Employee Name");
			rowData.add("Employee Budgeted Hrs");
			rowData.add("Employee Budgeted Cost");
			rowData.add("Employee Actual Hrs");
			rowData.add("Employee Actual Cost");
			rowData.add("Manager Name");
			rowData.add("Manager Budgeted Hrs");
			rowData.add("Manager Budgeted Cost");
			rowData.add("Manager Actual Hrs");
			rowData.add("Manager Actual Cost");
			rowData.add("TL Name");
			rowData.add("TL Actual Hrs");
			rowData.add("TL Actual Cost");
			rowData.add("Budgeted Revenue");
			rowData.add("Actual Revenue");
			rowData.add("Google Drive link");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < list.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + list.get(i).getCustFirmName());
				rowData.add("" + list.get(i).getTaskText());
				rowData.add("" + list.get(i).getServName());
				rowData.add("" + list.get(i).getActiName());
				rowData.add("" + list.get(i).getPeriodicityName());
				rowData.add("" + list.get(i).getPartner());
				rowData.add("" + list.get(i).getOwnerPartner());

				rowData.add("" + list.get(i).getEmployee());
				rowData.add("" + list.get(i).getEmpBugetedHrs());
				rowData.add("" + list.get(i).getEmpBugetedCost());
				rowData.add("" + list.get(i).getEmpActualHrs());
				rowData.add("" + list.get(i).getEmpActualCost());

				rowData.add("" + list.get(i).getManager());
				rowData.add("" + list.get(i).getMngrBugetedHrs());
				rowData.add("" + list.get(i).getMngrBugetedCost());
				rowData.add("" + list.get(i).getMngrActualHrs());
				rowData.add("" + list.get(i).getMngrActualCost());

				rowData.add("" + list.get(i).getTeamLeader());
				rowData.add("" + list.get(i).getTlActualHrs());
				rowData.add("" + list.get(i).getTlActualCost());

				rowData.add("" + list.get(i).getRevenue());

				if (list.get(i).getTaskStatus() == 9) {
					rowData.add("" + list.get(i).getRevenue());
				} else {
					rowData.add("" + 0);
				}

				rowData.add("" + list.get(i).getGoogleDriveLink());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						serchby + "," + rateserchby + "From Date:" + monthyear[0] + "   To Date:" + monthyear[1] + "",
						"", 'X');

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
			e.printStackTrace();
		}

	}
	
	@RequestMapping(value = "/employeePartnerwiseReport", method = RequestMethod.GET)
	public String employeePartnerwiseReport(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) {

		String mav = new String();
		try {

			mav = "report/Partner/employeePartnerwiseReport";
			
			String monthyear = request.getParameter("monthyear"); 
			
			EmpIdNameList[] empIdNameList = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getPartnerList",  EmpIdNameList[].class);
			List<EmpIdNameList> partnerList = new ArrayList<>(Arrays.asList(empIdNameList));
			model.addAttribute("partnerList",partnerList);
			
			
			if(monthyear!=null) {
				 
				String[] fromDate = monthyear.split(" to ");
				int partnerType = Integer.parseInt(request.getParameter("partnerType"));
				 
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("partnerType", partnerType); 
				map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
				
				EmpwithPartnerList[] empwithPartnerList = Constants.getRestTemplate()
						.postForObject(Constants.url + "/employeepartnerwiseworkreport",map,  EmpwithPartnerList[].class);
				List<EmpwithPartnerList> empwithpartnerlist = new ArrayList<>(Arrays.asList(empwithPartnerList));
				model.addAttribute("empwithpartnerlist",empwithpartnerlist);
				
				model.addAttribute("fromDate",monthyear);
				model.addAttribute("partnerType",partnerType);
			}
			
			
 
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}
