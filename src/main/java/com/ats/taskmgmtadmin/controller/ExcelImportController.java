package com.ats.taskmgmtadmin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.DateValues;
import com.ats.taskmgmtadmin.common.HoursConversion;
import com.ats.taskmgmtadmin.common.PeriodicityDates;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.CustmrActivityMap;
import com.ats.taskmgmtadmin.model.DevPeriodicityMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FinancialYear;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.task.model.Task;
import com.ats.taskmgmtadmin.task.model.TempTaskSave;

@Controller
public class ExcelImportController {

	String curDateTime;
	List<Task> taskTempList = new ArrayList<Task>();
	CustmrActivityMap activityMap = new CustmrActivityMap();

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DateFormat dateFormat2 = new SimpleDateFormat("dd-MM-yyyy");

	@RequestMapping(value = "/excelCustActMap", method = RequestMethod.GET)
	public @ResponseBody List<Task> addCustomerActMap(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = null;

		// List<Task> custActMapList = null;
		try {

			FileInputStream file = new FileInputStream(new File("/home/ubuntu/Downloads/CustActMap.xlsx"));

			// Create Workbook instance holding reference to .xlsx file
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			// Get first/desired sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);

			int custId = 0;
			int servId = 0;
			int actId = 0;
			int perdId = 0;
			int endDays = 0;
			String manBdHr = null;
			String empBdHr = null;
			String billAmt = "00";
			String startDateSheet = null;
			String endDateSheet = null;
			int billAmt2 = 0;
			Row ro = null;
			System.err.println("sheet.getLastRowNum() " + sheet.getLastRowNum());
			for (int i = sheet.getFirstRowNum() + 1; i <= sheet.getLastRowNum(); i++) {
				taskTempList = new ArrayList<Task>();
				activityMap = new CustmrActivityMap();

				ro = sheet.getRow(i);

				System.err.println("match row " +ro);
				try {
					custId = (int) ro.getCell(1).getNumericCellValue();
				} catch (Exception e) {
					custId = Integer.parseInt(ro.getCell(1).getStringCellValue());
				}
				try {
					servId = (int) ro.getCell(2).getNumericCellValue();
				} catch (Exception e) {
					servId = Integer.parseInt(ro.getCell(2).getStringCellValue());
				}

				try {
					actId = (int) ro.getCell(3).getNumericCellValue();
				} catch (Exception e) {
					actId = Integer.parseInt(ro.getCell(3).getStringCellValue());
				}
				try {
					perdId = (int) ro.getCell(4).getNumericCellValue();
				} catch (Exception e) {
					perdId = Integer.parseInt(ro.getCell(4).getStringCellValue());
				}

				try {
					endDays = (int) ro.getCell(5).getNumericCellValue();
				} catch (Exception e) {
					endDays = Integer.parseInt(ro.getCell(5).getStringCellValue());
				}

				// budg
				try {
					// int manBdHr1 =(int) ro.getCell(6).getNumericCellValue();
					// manBdHr=String.valueOf(manBdHr1);
					manBdHr = ro.getCell(6).getStringCellValue();
				//	System.err.println("MY  " + manBdHr);
				} catch (Exception e) {
					// int manBdHr1 =(int) ro.getCell(6).getNumericCellValue();
					manBdHr = ro.getCell(6).getStringCellValue();
				}
				try {
					// int empBdHr1 =(int)ro.getCell(7).getNumericCellValue();
					empBdHr = ro.getCell(7).getStringCellValue();
				} catch (Exception e) {
					int empBdHr1 = (int) ro.getCell(7).getNumericCellValue();
					empBdHr = String.valueOf(empBdHr1);
				}

				try {
					billAmt = String.valueOf((ro.getCell(8).getStringCellValue()));

				} catch (Exception e) {
					double billAmt1 = ro.getCell(8).getNumericCellValue();
					billAmt = String.valueOf(billAmt1);
					billAmt2 = (int) billAmt1;

				}
				//System.err.println("BillAmt1  " + billAmt);

				try {
					Date startDateSheet1 = ro.getCell(9).getDateCellValue();
					startDateSheet = dateFormat2.format(startDateSheet1);
				} catch (Exception e) {
					double startDateSheet1 = ro.getCell(9).getNumericCellValue();
					startDateSheet = String.valueOf(startDateSheet1);
				}
				try {
					Date endDateSheet1 = ro.getCell(10).getDateCellValue();
					endDateSheet = dateFormat2.format(endDateSheet1);
				} catch (Exception e) {
					// double endDateSheet1 = ro.getCell(10).getNumericCellValue();
					// endDateSheet = String.valueOf(endDateSheet1);
				}

				HttpSession session = request.getSession();

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

				int userId = emp.getEmpId();
				String edate = new String();
				String edate1 = new String();
				
				if (endDateSheet != "" && endDateSheet != null) {
					edate = DateConvertor.convertToYMD(endDateSheet);
					edate1 = endDateSheet;
					activityMap.setActvEndDate(edate1);
				} else {
					FinancialYear srvsMstr = Constants.getRestTemplate()
							.getForObject(Constants.url + "/getCurrentFinYear", FinancialYear.class);
					edate = srvsMstr.getFinEndDate();
					activityMap.setActvEndDate(DateConvertor.convertToDMY(edate));
				}

				activityMap.setMappingId(0);
				double d1 = 0;
				try {
					d1 = Double.parseDouble(billAmt);
				} catch (Exception e) {
					d1 = 0;
				}
				activityMap.setActvBillingAmt((int) d1);
				activityMap.setActvEmpBudgHr(Integer.parseInt(HoursConversion.convertHoursToMin(empBdHr)));
				activityMap.setActvStartDate(startDateSheet);

				activityMap.setActvManBudgHr(Integer.parseInt(HoursConversion.convertHoursToMin(manBdHr)));
				activityMap.setActvStatutoryDays(endDays);
				activityMap.setCustId(custId);
				activityMap.setDelStatus(1);
				activityMap.setExInt1(0);
				activityMap.setExInt2(0);
				activityMap.setExVar1("NA");
				activityMap.setExVar2("NA");
				activityMap.setPeriodicityId(perdId);
				activityMap.setUpdateDatetime(curDateTime);
				activityMap.setUpdateUsername(userId);
				activityMap.setActvId(actId);
			
				int totdays = 0;

				Date date = Calendar.getInstance().getTime();
				DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

				int perId = perdId;

				map = new LinkedMultiValueMap<>();
				map.add("activityId", actId);

				ActivityMaster actv = Constants.getRestTemplate().postForObject(Constants.url + "/getActivityById", map,
						ActivityMaster.class);

				map = new LinkedMultiValueMap<>();
				map.add("periodicityId", perId);

				DevPeriodicityMaster period = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getDevPerodicityById", map, DevPeriodicityMaster.class);
				//System.err.println("startDateSheet " + startDateSheet);
				String strDate = DateConvertor.convertToYMD((startDateSheet));
				// System.out.println("Converted String str: " + strDate);
				String endDate = edate;
				// System.out.println("Converted String end: " + endDate);
				// System.out.println("perId: " + perId);
				List<DateValues> listDate = PeriodicityDates.getDates(strDate, endDate, perId);
				totdays = listDate.size();

				map = new LinkedMultiValueMap<>();

				map.add("serviceId", actv.getServId());
				ServiceMaster servc = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById", map,
						ServiceMaster.class);

				TempTaskSave tsk = new TempTaskSave();

				for (int j = 0; j < listDate.size(); j++) {
					System.err.println("In date list " + j);
					Task task = new Task();
					task.setTaskId(j);
					Date date1 = listDate.get(j).getDate();

					task.setTaskStatutoryDueDate(
							PeriodicityDates.addDaysToGivenDate(dateFormat.format(date1), endDays));

					FinancialYear fin = new FinancialYear();
					map = new LinkedMultiValueMap<>();

					map.add("statDate", String.valueOf(task.getTaskStatutoryDueDate()));
					fin = Constants.getRestTemplate().postForObject(Constants.url + "/getFinYearByStatdate", map,
							FinancialYear.class);

					task.setTaskStartDate(PeriodicityDates.addDaysToGivenDate(task.getTaskStatutoryDueDate(), -30));

					StringBuilder sb1 = new StringBuilder(servc.getServName());

					sb1.append("-").append(actv.getActiName()).append("-").append(listDate.get(j).getValue());
					task.setTaskId(j);
					task.setActvId(activityMap.getActvId());
					task.setCustId(activityMap.getCustId());
					task.setDelStatus(1);
					task.setEmpBudHr(HoursConversion.convertHoursToMin(empBdHr));
					task.setExInt1(0);
					task.setExInt2(0);
					task.setExVar1("NA");
					task.setExVar2("NA");
					task.setMappingId(0);
					task.setPeriodicityId(activityMap.getPeriodicityId());
					task.setIsActive(1);

					task.setMngrBudHr(HoursConversion.convertHoursToMin(manBdHr));
					task.setServId(actv.getServId());
					task.setTaskCode("NA");
					task.setTaskEmpIds("0");
					task.setTaskFyId(fin.getFinYearId());
					// task.setTaskEndDate(dateFormat.format(date));
					task.setTaskStatus(0);
					task.setTaskSubline("NA");
					task.setTaskText(String.valueOf(sb1));
					task.setUpdateDatetime(Constants.getCurDateTime());
					task.setUpdateUsername(userId);
					task.setBillingAmt(String.valueOf((billAmt)));
					task.setExVar1(DateConvertor.convertToDMY(task.getTaskStatutoryDueDate()));
					taskTempList.add(task);

				}

				tsk.setCmpList(activityMap);
				tsk.setTskList(taskTempList);

				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/saveTaskRes", tsk, Info.class);

			} // end of for Loop Row Index;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.err.println("taskTempList " + taskTempList);
		return taskTempList;
	}

}
