package com.enmotech.clanalysis.util;

import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	/**
	 * 获取 当前年、半年、季度、月、日、小时 开始结束时间
	 */
	private SimpleDateFormat shortSdf;

	private SimpleDateFormat longHourSdf;

	private SimpleDateFormat longSdf;

	private Calendar c = Calendar.getInstance();

	private DateUtils() {
		this.shortSdf = new SimpleDateFormat("yyyy-MM-dd");
		this.longHourSdf = new SimpleDateFormat("yyyy-MM-dd HH");
		this.longSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	}

	public DateUtils(long time) {
		this();
		c.setTimeInMillis(time);
	}

	public DateUtils(Date date) {
		this();
		c.setTime(date);
	}

	/**
	 * 获取时间戳
	 *
	 * @param date
	 * @return
	 */
	public static String getTimestamp(Date date, String format) {
		if (StringUtils.isEmpty(format)) {
			format = "yyyyMMddHHmmss";
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		return dateFormat.format(date);
	}

	/**
	 * 字符串转换为Date格式
	 *
	 * @param date
	 * @param format
	 * @return
	 */
	public static Date parseToDate(String date, String format) {
		if (StringUtils.isEmpty(format)) {
			format = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		try {
			return dateFormat.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static void main(String[] args) {

		Date date = DateUtils.parseToDate("2016-12-20 21:00:00", "");
		DateUtils du = new DateUtils(new Date());
		String time = du.getLongTime(du.getNextHalfYearStartTime(date.getTime()));
		System.out.println(time);
	}

	private void initDate() {
		String[] weekDays = { "周日", "周一", "周二", "周三", "周四", "周五", "周六" };
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		int i = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (i < 0) {
			i = 0;
		}
		String yesterday = new SimpleDateFormat("yyyy年MM月dd日").format(cal.getTime());
		String w = weekDays[i];
	}

	/**
	 * 获得本周的第一天，周一
	 *
	 * @return
	 */
	public Date getCurrentWeekDayStartTime() {
		try {
			int weekday = c.get(Calendar.DAY_OF_WEEK) - 2;
			c.add(Calendar.DATE, -weekday);
			c.setTime(longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c.getTime();
	}

	/**
	 * 获得本周的最后一天，周日
	 *
	 * @return
	 */
	public Date getCurrentWeekDayEndTime() {
		try {
			int weekday = c.get(Calendar.DAY_OF_WEEK);
			c.add(Calendar.DATE, 8 - weekday);
			c.setTime(longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c.getTime();
	}

	/**
	 * 获取下周的开始时间
	 *
	 * @return
	 */
	public Date getNextWeekStartTime() {
		try {
			int weekday = c.get(Calendar.DAY_OF_WEEK);
			c.add(Calendar.DATE, 9 - weekday);
			c.setTime(longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00"));
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return c.getTime();
	}

	/**
	 * 获得本天的开始时间，即2012-01-01 00:00:00
	 *
	 * @return
	 */
	public Date getCurrentDayStartTime() {
		Date now = c.getTime();
		try {
			now = shortSdf.parse(shortSdf.format(now));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获得本天的结束时间，即2012-01-01 23:59:59
	 *
	 * @return
	 */
	public Date getCurrentDayEndTime() {
		Date now = c.getTime();
		try {
			now = longSdf.parse(shortSdf.format(now) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下一天的开始时间
	 *
	 * @return
	 */
	public Date getNextDayStartTime() {
		Date next = null;
		try {
			c.add(Calendar.DAY_OF_YEAR, 1);
			next = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return next;
	}

	/**
	 * 获得本小时的开始时间，即2012-01-01 23:59:59
	 *
	 * @return
	 */
	public Date getCurrentHourStartTime() {
		Date now = c.getTime();
		try {
			now = longHourSdf.parse(longHourSdf.format(now));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获得本小时的结束时间，即2012-01-01 23:59:59
	 *
	 * @return
	 */
	public Date getCurrentHourEndTime() {
		Date now = c.getTime();
		try {
			now = longSdf.parse(longHourSdf.format(now) + ":59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下个小时的开始时间
	 *
	 * @return
	 */
	public Date getNextHourStartTime() {
		Date date = null;
		try {
			c.add(Calendar.HOUR_OF_DAY, 1);
			date = longSdf.parse(longHourSdf.format(c.getTime()) + ":00:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return date;
	}

	/**
	 * 获得本月的开始时间，即2012-01-01 00:00:00
	 *
	 * @return
	 */
	public Date getCurrentMonthStartTime() {
		Date now = null;
		try {
			c.set(Calendar.DATE, 1);
			now = shortSdf.parse(shortSdf.format(c.getTime()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前月的结束时间，即2012-01-31 23:59:59
	 *
	 * @return
	 */
	public Date getCurrentMonthEndTime() {

		Date now = null;
		try {
			c.set(Calendar.DATE, 1);
			c.add(Calendar.MONTH, 1);
			c.add(Calendar.DATE, -1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下个月的开始时间
	 *
	 * @return
	 */
	public Date getNextMonthStartTime() {
		Date date = null;
		try {
			c.add(Calendar.MONTH, 1);
			c.set(Calendar.DATE, 1);
			date = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return date;
	}

	/**
	 * 当前年的开始时间，即2012-01-01 00:00:00
	 *
	 * @return
	 */
	public Date getCurrentYearStartTime() {
		Date now = null;
		try {
			c.set(Calendar.MONTH, 0);
			c.set(Calendar.DATE, 1);
			now = shortSdf.parse(shortSdf.format(c.getTime()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前年的结束时间，即2012-12-31 23:59:59
	 *
	 * @return
	 */
	public Date getCurrentYearEndTime() {
		Date now = null;
		try {
			c.set(Calendar.MONTH, 11);
			c.set(Calendar.DATE, 31);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下一年的开始时间
	 *
	 * @return
	 */
	public Date getNextYearStartTime() {
		Date now = null;
		try {
			c.set(Calendar.MONTH, 0);
			c.set(Calendar.DATE, 1);
			c.add(Calendar.YEAR, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下一年的结束时间
	 *
	 * @return
	 */
	public Date getNextYearEndTime() {
		Date now = null;
		try {
			c.set(Calendar.MONTH, 11);
			c.set(Calendar.DATE, 31);
			c.add(Calendar.YEAR, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前季度的开始时间，即2012-01-1 00:00:00
	 *
	 * @return
	 */
	public Date getCurrentQuarterStartTime() {
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3)
				c.set(Calendar.MONTH, 0);
			else if (currentMonth >= 4 && currentMonth <= 6)
				c.set(Calendar.MONTH, 3);
			else if (currentMonth >= 7 && currentMonth <= 9)
				c.set(Calendar.MONTH, 4);
			else if (currentMonth >= 10 && currentMonth <= 12)
				c.set(Calendar.MONTH, 9);
			c.set(Calendar.DATE, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下个季度的开始时间 如：2016-01-01 00:00:00
	 *
	 * @return
	 */
	public Date getNextQuarterStartTime() {
		c.add(Calendar.MONTH, 3);
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3)
				c.set(Calendar.MONTH, 0);
			else if (currentMonth >= 4 && currentMonth <= 6)
				c.set(Calendar.MONTH, 3);
			else if (currentMonth >= 7 && currentMonth <= 9)
				c.set(Calendar.MONTH, 4);
			else if (currentMonth >= 10 && currentMonth <= 12)
				c.set(Calendar.MONTH, 9);
			c.set(Calendar.DATE, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下个季度的开始时间 如：2016-01-01 00:00:00
	 *
	 * @return
	 */
	public Date getNextQuarterStartTime(long time) {
		c.setTimeInMillis(time);
		c.add(Calendar.MONTH, 3);
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3)
				c.set(Calendar.MONTH, 0);
			else if (currentMonth >= 4 && currentMonth <= 6)
				c.set(Calendar.MONTH, 3);
			else if (currentMonth >= 7 && currentMonth <= 9)
				c.set(Calendar.MONTH, 4);
			else if (currentMonth >= 10 && currentMonth <= 12)
				c.set(Calendar.MONTH, 9);
			c.set(Calendar.DATE, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前季度的结束时间，即2012-03-31 23:59:59
	 *
	 * @return
	 */
	public Date getCurrentQuarterEndTime() {
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3) {
				c.set(Calendar.MONTH, 2);
				c.set(Calendar.DATE, 31);
			} else if (currentMonth >= 4 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 5);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 7 && currentMonth <= 9) {
				c.set(Calendar.MONTH, 8);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 10 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 11);
				c.set(Calendar.DATE, 31);
			}
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取当前季度的结束时间
	 *
	 * @param time
	 * @return
	 */
	public Date getCurrentQuarterEndTime(long time) {
		c.setTimeInMillis(time);
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3) {
				c.set(Calendar.MONTH, 2);
				c.set(Calendar.DATE, 31);
			} else if (currentMonth >= 4 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 5);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 7 && currentMonth <= 9) {
				c.set(Calendar.MONTH, 8);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 10 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 11);
				c.set(Calendar.DATE, 31);
			}
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取前/后半年的开始时间
	 *
	 * @return
	 */
	public Date getHalfYearStartTime() {
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 0);
			} else if (currentMonth >= 7 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 6);
			}
			c.set(Calendar.DATE, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取下个半年的开始时间
	 *
	 * @return
	 */
	public Date getNextHalfYearStartTime() {
		c.add(Calendar.MONTH, 6);
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 0);
			} else if (currentMonth >= 7 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 6);
			}
			c.set(Calendar.DATE, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	public Date getNextHalfYearStartTime(long time) {
		c.setTimeInMillis(time);
		c.add(Calendar.MONTH, 6);
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 0);
			} else if (currentMonth >= 7 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 6);
			}
			c.set(Calendar.DATE, 1);
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取前/后半年的结束时间
	 *
	 * @return
	 */
	public Date getHalfYearEndTime() {
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 5);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 7 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 11);
				c.set(Calendar.DATE, 31);
			}
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 获取前/后半年的结束时间
	 *
	 * @return
	 */
	public Date getHalfYearEndTime(long time) {
		c.setTimeInMillis(time);
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 5);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 7 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 11);
				c.set(Calendar.DATE, 31);
			}
			now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	public String getLongTime(Date date) {
		return longSdf.format(date);
	}
}
