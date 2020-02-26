package com.enmotech.clanalysis.util;

import com.enmotech.clanalysis.entity.ReportParam;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import java.util.*;

public class ChartUtils {
	private ReportParam param;

	private JSONArray indexParam;

	private JSONArray indexData;

	private Set<String> categories = null;

	private JSONArray series = null;

	private List<String> timeInterval = null;

	public ChartUtils(ReportParam param, JSONArray indexParam, JSONArray indexData) {
		this.param = param;
		this.indexParam = indexParam;
		this.indexData = indexData;

		this.getCategoryNames();
		this.getTimeInterval();
		this.getDimensionData();
	}

	public void line() {

	}

	public void pie() {

	}

	public void bar() {

	}

	public void column() {

	}

	public void area() {

	}

	public void funnel() {

	}

	public void gauge() {

	}

	public void polar() {

	}

	public void scatter() {

	}

	/**
	 * 获取时间区间
	 */
	private void getTimeInterval() {
		timeInterval = new LinkedList<String>();
		for (int i = 0; i < param.getTimestamp().length; i++) {
			long[] timestamp = param.getTimestamp()[i];
			timeInterval.add(String.valueOf(timestamp[1]));
		}
	}

	/**
	 * 获取X周坐标指标名
	 */
	private void getCategoryNames() {
		categories = new HashSet<String>();
		try {
			JSONObject jo = indexParam.getJSONObject(0);
			JSONObject cols = jo.getJSONObject("col");
			JSONArray names = cols.names();
			for (int i = 0; i < names.size(); i++) {
				String name = names.getString(i);
				JSONArray fields = cols.getJSONArray(name);
				for (int j = 0; j < fields.size(); j++) {
					String field = fields.getString(i);
					categories.add(name + '[' + field + ']');
				}
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取维度和值
	 */
	private void getDimensionData() {
		series = new JSONArray();
		Map<String, JSONArray> seriesMap = new LinkedHashMap();

		for (int i = 0; i < indexData.size(); i++) {
			try {
				JSONArray ja = indexData.getJSONArray(i);
				for (int j = 0; j < ja.size(); j++) {
					Date date = DateUtils.parseToDate(this.timeInterval.get(i), "yyyyMMddHHmmss");
					JSONArray rowData = ja.getJSONArray(j);
					Map<String, Long> map = new LinkedHashMap<String, Long>();
					String categoryName = "";
					for (int k = 0; k < rowData.size() - 1; k++) {
						if (k >= rowData.size() - 2) {
							categoryName += rowData.getString(i);
						} else {
							categoryName += rowData.getString(i) + "_";
						}
					}

					JSONArray value = new JSONArray();
					value.add(date.getTime());
					value.add(rowData.getLong(rowData.size() - 1));
					JSONArray data = seriesMap.get(categoryName);
					if (data == null) {
						data = new JSONArray();
					}
					data.add(value);
					seriesMap.put(categoryName, data);
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}

		Set<Map.Entry<String, JSONArray>> entrySet = seriesMap.entrySet();
		for (Map.Entry<String, JSONArray> entry : entrySet) {
			JSONObject serie = new JSONObject();
			try {
				serie.put("name", entry.getKey());
				serie.put("data", entry.getValue());
				series.add(serie);
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}

	public JSONArray getSeries() {
		return series;
	}

	public void setSeries(JSONArray series) {
		this.series = series;
	}
}
