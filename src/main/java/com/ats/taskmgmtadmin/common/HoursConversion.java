package com.ats.taskmgmtadmin.common;

public class HoursConversion {

	public static String convertHoursToMin(String str) {
		String min = new String();

		try {

			String[] result = str.split(":");
			int hours = Integer.parseInt(result[0]);
			int minutes = Integer.parseInt(result[1]);
			min = String.valueOf((hours * 60) + minutes);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return min;

	}

	public static String convertMinToHours(String minutes1) {
		String min = new String();
		//System.out.println("prev min**" + minutes1);
		int minutes = Integer.parseInt(minutes1);
		//System.out.println("prev min converted**" + minutes);

		try {
			int hrs = minutes / 60;
			int rem = minutes % 60;
			min = String.valueOf(hrs).concat(":").concat(String.valueOf(rem));

			///System.out.println("final hrs**" + min);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return min;

	}

}
