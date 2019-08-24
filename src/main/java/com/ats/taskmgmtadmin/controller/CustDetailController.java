package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.CustNameId;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.model.custdetail.CustSignatoryMaster;
import com.ats.taskmgmtadmin.model.custdetail.CustomerDetailMaster;
import com.ats.taskmgmtadmin.model.custdetail.GetCustLoginDetail;
import com.ats.taskmgmtadmin.model.custdetail.GetCustSignatory;

@Controller
public class CustDetailController {

	// this mapping copied from HomeController
	// this shows list of customer added and have two buttons to add cust Login
	// detail
	// and cust signatory
	// Sachin
	@RequestMapping(value = "/customerDetailList", method = RequestMethod.GET)
	public ModelAndView clientDetailListForm(Locale locale, Model model) {
		
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView("master/customerDetailList");
						
			CustomerDetails[] custHeadArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllCustomerInfo", CustomerDetails[].class);
			List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
			for (int i = 0; i < custHeadList.size(); i++) {

				custHeadList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(custHeadList.get(i).getCustId())));
				custHeadList.get(i).setExVar2(FormValidation.Encrypt(String.valueOf(custHeadList.get(i).getCustGroupName())));
			}
			mav.addObject("custHeadList", custHeadList);				
				
			}catch (Exception e) {
				e.getMessage();
			}
		
		

		return mav;
	}

	// this mapping copied from HomeController
	// this mapping is to show add cust login detail and show records added for
	// particular cust
	// Sachin
	@RequestMapping(value = "/customerDetailAdd", method = RequestMethod.GET)
	public ModelAndView clientDetailAddForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("master/addCustDetailSignatory");///customerDetailAdd
		try {
			MultiValueMap<String, Object> map = null;
			
			String base64encodedString = request.getParameter("custId");			
			String custId = FormValidation.DecodeKey(base64encodedString);
			System.err.println("base64encodedString custId---------" +custId);
						
			map = new LinkedMultiValueMap<String, Object>();			
			map.add("custId", custId);
			
			CustNameId cust= Constants.getRestTemplate().postForObject(Constants.url + "/getCustNameById",map, CustNameId.class);
			mav.addObject("custName", cust.getCustName());			

			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));

			mav.addObject("serviceList", srvcMstrList);
			
			
			GetCustSignatory[] custSignArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getCustSignatoryByCustId", map, GetCustSignatory[].class);
			List<GetCustSignatory> custSignList = new ArrayList<>(Arrays.asList(custSignArray));
			System.err.println("custSignList" +custSignList.toString());
			mav.addObject("custSignList", custSignList);

			GetCustLoginDetail[] custDetArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getCustLoginDetailByCustId", map, GetCustLoginDetail[].class);
			List<GetCustLoginDetail> custDetailList = new ArrayList<>(Arrays.asList(custDetArray));

			mav.addObject("custDetailList", custDetailList);
			mav.addObject("custId", custId);

		} catch (Exception e) {
			System.err.println("Exce in show customerDetailAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/getActivityByService", method = RequestMethod.GET)
	public @ResponseBody List<ActivityMaster> getActivityByService(HttpServletRequest request,
			HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map = new LinkedMultiValueMap<>();
		map.add("serviceId", Integer.parseInt(request.getParameter("servId")));

		ActivityMaster[] activityArr = Constants.getRestTemplate().postForObject(Constants.url + "/getAllActivitesByServiceId", map,
				ActivityMaster[].class);
		List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));

		return activityList;
	}

	// addCustLoginDetail
	@RequestMapping(value = "/addCustLoginDetail", method = RequestMethod.POST)
	public String addCustLoginDetail(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		//ModelAndView mav = new ModelAndView("master/customerDetailList");//customerDetailAdd
		int custId = 0;
		try {
			
		//	String base64encodedString = request.getParameter("custId");			
		//	String customerId = FormValidation.DecodeKey(base64encodedString);
		//	System.err.println(customerId);
			
			try {			
				custId = Integer.parseInt(request.getParameter("custId"));
			}catch (Exception e) {
				e.getMessage();
				// TODO: handle exception
			}
			int custDetailId = Integer.parseInt(request.getParameter("custDetailId"));

			int servId = Integer.parseInt(request.getParameter("service"));
			int actvId = Integer.parseInt(request.getParameter("activity"));

			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String que1 = request.getParameter("que1");
			String ans1 = request.getParameter("ans1");
			String que2 = request.getParameter("que2");
			String ans2 = request.getParameter("ans2");
			String remark = request.getParameter("remark");
			
			CustomerDetailMaster custDetail=new CustomerDetailMaster();
			
			custDetail.setActvId(actvId);
			custDetail.setCustDetailId(custDetailId);
			custDetail.setCustId(custId);
			custDetail.setDelStatus(1);
			custDetail.setExInt1(1);
			custDetail.setExInt2(1);
			custDetail.setExVar1("A");
			custDetail.setExVar2("A");
			custDetail.setLoginAns1(ans1);
			custDetail.setLoginAns2(ans2);
			custDetail.setLoginId(username);
			
			custDetail.setLoginPass(password);
			custDetail.setLoginQue1(que1);
			custDetail.setLoginQue2(que2);
			custDetail.setLoginRemark(remark);
			
			custDetail.setContactEmail(request.getParameter("contPerEmail"));			
			custDetail.setContactName(request.getParameter("contPerName"));			
			custDetail.setContactPhno(request.getParameter("contPerNo"));			
			custDetail.setCustRemark(request.getParameter("sigremark"));
			custDetail.setSignDesign(request.getParameter("desg"));			
			custDetail.setSignfName(request.getParameter("signFName"));			
			custDetail.setSignlName(request.getParameter("signLName"));			
			custDetail.setSignPhno(request.getParameter("signMobile"));			
			custDetail.setSignRegNo(request.getParameter("regNo"));
			
			custDetail.setUpdateDatetime(Constants.getCurDateTime());
			
			custDetail.setUpdateUsername(1);
			
			CustomerDetailMaster custDetailSaveRes = Constants.getRestTemplate().postForObject(Constants.url+"/saveNewCustomerDetail", custDetail, CustomerDetailMaster.class);

		} catch (Exception e) {
			System.err.println("Exce in Saving Cust Login Detail " +e.getMessage());
			e.printStackTrace();
		}
		
		return "redirect:/customerDetailAdd?custId="+FormValidation.Encrypt(String.valueOf(custId));
	}

	
	@RequestMapping(value = "/customerSignAdd", method = RequestMethod.POST)
	public ModelAndView clientSignAddForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("master/customerSignAdd");

		try {
			
			int custId = Integer.parseInt(request.getParameter("custId"));


			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("custId", custId);

			GetCustSignatory[] custSignArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getCustSignatoryByCustId", map, GetCustSignatory[].class);
			List<GetCustSignatory> custSignList = new ArrayList<>(Arrays.asList(custSignArray));
			System.err.println("custSignList" +custSignList.toString());
			mav.addObject("custSignList", custSignList);

			String custName = request.getParameter("custName");
			mav.addObject("custName", custName);
			mav.addObject("custId", custId);

		} catch (Exception e) {
			
			System.err.println("Exce in show customerDetailAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	

	@RequestMapping(value = "/addCustSignatory", method = RequestMethod.POST)
	public String addCustSignatory(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		//ModelAndView mav = new ModelAndView("master/customerDetailList");//customerDetailAdd
		
		int custId = 0;
		try {

			 custId = Integer.parseInt(request.getParameter("custId"));
			
			CustSignatoryMaster custSign=new CustSignatoryMaster();
			
			String contactEmail=request.getParameter("contPerEmail");
			custSign.setContactEmail(contactEmail);
			
			String contactName=request.getParameter("contPerName");
			custSign.setContactName(contactName);
			
			String contactPhno=request.getParameter("contPerNo");
			custSign.setContactPhno(contactPhno);
			
			String custRemark=request.getParameter("remark");
			custSign.setCustRemark(custRemark);
			
			String signDesign=request.getParameter("desg");
			custSign.setSignDesign(signDesign);
			
			String signfName=request.getParameter("signFName");
			custSign.setSignfName(signfName);
			
			int signId=Integer.parseInt(request.getParameter("signId"));
			custSign.setSignId(signId);
			
			String signlName=request.getParameter("signLName");
			custSign.setSignlName(signlName);
			
			String signPhno=request.getParameter("signMobile");
			custSign.setSignPhno(signPhno);
			
			String signRegNo=request.getParameter("regNo");
			custSign.setSignRegNo(signRegNo);
			
			custSign.setCustId(custId);
			custSign.setDelStatus(1);
			custSign.setExInt1(1);
			custSign.setExInt2(1);
			custSign.setExVar1("A");
			custSign.setExVar2("A");
			
			custSign.setUpdateDatetime(Constants.getCurDateTime());
			
			custSign.setUpdateUsername(1);
			
			CustSignatoryMaster custDetailSaveRes = Constants.getRestTemplate().postForObject(Constants.url+"/saveCustSignatory", custSign, CustSignatoryMaster.class);

		} catch (Exception e) {
			System.err.println("Exce in Saving Cust Login Detail " +e.getMessage());
			e.printStackTrace();
		}
		
		return "redirect:/customerDetailAdd?custId="+custId;
	}
	
	
	@RequestMapping(value = "/getCustSignatoryBySignId", method = RequestMethod.GET)
	public @ResponseBody GetCustSignatory getCustSignatoryBySignId(HttpServletRequest request,
			HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map = new LinkedMultiValueMap<>();
		map.add("signId", Integer.parseInt(request.getParameter("signId")));

		GetCustSignatory custSignatory = Constants.getRestTemplate().postForObject(Constants.url + "/getCustSignatoryBySignId", map,
				GetCustSignatory.class);

		return custSignatory;
	}

	@RequestMapping(value = "/getCustLoginDetailByCustDetailId", method = RequestMethod.GET)
	public @ResponseBody GetCustLoginDetail getCustLoginDetailByCustDetailId(HttpServletRequest request,
			HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map = new LinkedMultiValueMap<>();
		map.add("custDetailId", Integer.parseInt(request.getParameter("custDetailId")));

		GetCustLoginDetail  custLogin = Constants.getRestTemplate().postForObject(Constants.url + "/getCustLoginDetailByCustDetailId", map,
				GetCustLoginDetail.class);

		return custLogin;
	}

}
