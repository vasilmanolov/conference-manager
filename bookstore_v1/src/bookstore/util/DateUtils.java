package bookstore.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtils {
	
	/**
	 * Creates a Date object based on given parameters
	 * @param year year
	 * @param monthOfYear zero based month of year (0-11)
	 * @param dayOfMonth day of month (1-31)
	 * @return
	 */
	public static Date createDate(int year, int monthOfYear, int dayOfMonth) {
		return new GregorianCalendar(year, monthOfYear, dayOfMonth).getTime();
	}
	
	public static String getYearFromDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		return sdf.format(date);
	}
	public static String getMonthFromDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("M");
		return sdf.format(date);
	}
	public static String getDayFromDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd");
		return sdf.format(date);
	}
}
