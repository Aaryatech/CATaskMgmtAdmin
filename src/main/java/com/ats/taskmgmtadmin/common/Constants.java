package com.ats.taskmgmtadmin.common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

public class Constants {

	public static String statusIds = "0,8,9,7";
	
	// Web Api Path url
	public static final String url = "http://localhost:8098/";//172.28.10.10 
	//public static final String url = "http://172.28.10.10:8080/CATaskMngtApi/";
	public static RestTemplate rest = new RestTemplate();
	public static final String imageSaveUrl = "/opt/tomcat/webapps/uploads/empImg/";

	public static final String REPORT_SAVE = "/opt/tomcat/webapps/uploads/report.pdf";

	
	
	public static final String Sucessmsg = "success";

	public static final String Failmsg = "error"; public
	  static String[] values = { "jpg", "jpeg", "gif", "png" };
	 public static RestTemplate getRestTemplate() {
			rest=new RestTemplate();
			rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1cr"));
			return rest;
			
			} 
public static String imageViewUrl="http://35.200.218.166:8080/uploads/empImg/";
	public static String getCurDateTime() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String curDateTime = dateFormat.format(cal.getTime());
		return curDateTime;

	}
	/*SELECT a.emp_id, a.work_hrs,a.work_date,SUM(a.flag) as flag FROM  ( SELECT SUM(t_daily_work_log.work_hours) as work_hrs,t_daily_work_log.work_date, t_daily_work_log.emp_id ,COALESCE((SELECT 1 from DUAL WHERE SUM(t_daily_work_log.work_hours) <490 ),0) as flag FROM t_daily_work_log 

WHERE t_daily_work_log.work_date BETWEEN (SELECT
  CURDATE() - INTERVAL 2 DAY  FROM DUAL) and (select  CURDATE() - INTERVAL 1 DAY FROM DUAL) 
  
  and t_daily_work_log.del_status=1  
  
  GROUP by t_daily_work_log.work_date,t_daily_work_log.emp_id 
  ORDER by t_daily_work_log.emp_id ) a  group by emp_id   HAVING SUM(flag) > 1
--- flag==1 one account correct 0 mean all correct 2 mean both wrong
select m_emp.emp_id,m_emp.emp_email,coalesce(b.flag,2)+coalesce((select 1 from dual where b.flag=1 and b.work_hrs ),0) flag ,coalesce(b.work_hrs,0) work_hrs,coalesce(b.row_count,0) row_count  from m_emp left join (
SELECT a.emp_id, a.work_hrs,a.work_date,SUM(a.flag) as flag,count(*) as row_count FROM  ( SELECT SUM(t_daily_work_log.work_hours) as work_hrs,t_daily_work_log.work_date, t_daily_work_log.emp_id ,COALESCE((SELECT 1 from DUAL WHERE SUM(t_daily_work_log.work_hours) <490 ),0) as flag FROM t_daily_work_log 

WHERE t_daily_work_log.work_date BETWEEN (SELECT
  CURDATE() - INTERVAL 2 DAY  FROM DUAL) and (select  CURDATE() - INTERVAL 1 DAY FROM DUAL) 
  
  and t_daily_work_log.del_status=1  
  
  GROUP by t_daily_work_log.work_date,t_daily_work_log.emp_id 
  ORDER by t_daily_work_log.emp_id ) a  group by emp_id ) b on m_emp.emp_id=b.emp_id  HAVING flag>1
  
   
   **9-1-2020
   *select m_emp.emp_id,m_emp.emp_email,m_emp.emp_type,coalesce(b.flag,2)+coalesce((select 1 from dual where b.flag=1 and b.work_hrs ),0) flag ,coalesce(b.work_hrs,0) work_hrs,coalesce(b.row_count,0) row_count  from m_emp left join (
SELECT a.emp_id, a.work_hrs,a.work_date,SUM(a.flag) as flag,count(*) as row_count FROM  ( SELECT SUM(t_daily_work_log.work_hours) as work_hrs,t_daily_work_log.work_date, t_daily_work_log.emp_id ,COALESCE((SELECT 1 from DUAL WHERE SUM(t_daily_work_log.work_hours) <490 ),0) as flag FROM t_daily_work_log 

WHERE t_daily_work_log.work_date BETWEEN (SELECT
  CURDATE() - INTERVAL 2 DAY  FROM DUAL) and (select  CURDATE() - INTERVAL 1 DAY FROM DUAL) 
  
  and t_daily_work_log.del_status=1  
  
  GROUP by t_daily_work_log.work_date,t_daily_work_log.emp_id 
  ORDER by t_daily_work_log.emp_id ) a  group by emp_id ) b on m_emp.emp_id=b.emp_id  WHERE m_emp.emp_type=5  and m_emp.del_status=1 and m_emp.is_active=1 HAVING flag>1 
*/
}
