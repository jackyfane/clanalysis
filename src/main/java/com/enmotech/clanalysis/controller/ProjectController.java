package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Project;
import com.enmotech.clanalysis.service.IProjectService;
import com.enmotech.clanalysis.util.DateUtils;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by Administrator on 2015/5/22.
 */
@Controller
@RequestMapping(value = "/project")
public class ProjectController extends AbstractController<Project> {

	private final static Logger LOGGER = Logger.getLogger(ProjectController.class);

	@Autowired
	private IProjectService projectService;

	@Override
	protected IOperations<Project> getService() {
		return this.projectService;
	}

	/**
	 * 预览报表
	 *
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/viewIndex")
	public ModelAndView getGeneralIndex(String id, String startTime, String endTime) {
		Project project = projectService.findById(id);

		return null;
	}

	@RequestMapping(value = "/timestamp")
	@ResponseBody
	public String getTimestamp(String startTime, String endTime, int calendarType, HttpServletResponse response) {

		List<String> timestamps = new LinkedList<String>();

		Date sTime = DateUtils.parseToDate(startTime, "");
		DateUtils utils = new DateUtils(sTime);

		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(sTime.getTime());

		String timestamp = DateUtils.getTimestamp(calendar.getTime(), "");
		timestamps.add(timestamp);

		String timeStr = "";
		Date date = null;
		switch (calendarType) {
		case Calendar.HOUR: // 获取下个小时的开始时间
			date = utils.getNextHourStartTime();
			break;
		case Calendar.DAY_OF_YEAR:// 获取第二天的开始时间
			date = utils.getNextDayStartTime();
			break;
		case Calendar.WEEK_OF_YEAR:// 获取下周的开始时间
			date = utils.getCurrentWeekDayEndTime();
			break;
		case Calendar.MONTH: // 获取下个月的开始时间
			date = utils.getNextMonthStartTime();
			break;
		case Calendar.YEAR:// 获取第二年的开始时间
			date = utils.getNextYearStartTime();
			break;
		case 4: // 获取下个季度的开始时间
			date = utils.getNextQuarterStartTime();
			break;
		case 5: // 获取下个半年的开始时间
			date = utils.getNextHalfYearStartTime();
		}

		Date eTime = DateUtils.parseToDate(endTime, "");

		calendar.setTimeInMillis(date.getTime());
		while (calendar.getTimeInMillis() <= eTime.getTime()) {
			timestamp = DateUtils.getTimestamp(calendar.getTime(), "");
			timestamps.add(timestamp);
			switch (calendarType) {
			case 4: // 获取下个季度的开始时间
				calendar.add(Calendar.MONTH, 3);
				break;
			case 5: // 获取下个半年的开始时间
				calendar.add(Calendar.MONTH, 6);
				break;
			default:
				calendar.add(calendarType, 1);
				break;
			}

		}

		String lst = timestamps.get(timestamps.size() - 1);
		Date lDate = DateUtils.parseToDate(lst, "yyyyMMddHHmmss");
		Date eDate = DateUtils.parseToDate(endTime, "");

		if (lDate.getTime() < eDate.getTime()) {
			timestamps.add(DateUtils.getTimestamp(eDate, ""));
		}

		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < timestamps.size() - 1; i++) {
			JSONArray ja = new JSONArray();
			ja.add(Long.parseLong(timestamps.get(i)));
			ja.add(Long.parseLong(timestamps.get(i + 1)));

			jsonArray.add(ja);
		}

		return jsonArray.toString();
	}
}
