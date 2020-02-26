package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.entity.Element;
import com.enmotech.clanalysis.entity.Report;
import com.enmotech.clanalysis.entity.ReportParam;
import com.enmotech.clanalysis.service.IDataSourceService;
import com.enmotech.clanalysis.service.IReportService;
import com.enmotech.clanalysis.service.IViewReportService;
import com.enmotech.clanalysis.util.DateUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;

import java.util.*;

/**
 * Created by Administrator on 2015/9/24.
 */
// @Service("viewReportService")
public class ViewReportService implements IViewReportService {
	private IReportService reportService;

	private IDataSourceService dataSourceService;

	private Report report = null;

	// 从页面传入的指标参数
	private ReportParam param = null;

	// 接口查询状态
	private boolean status = false;

	// 接口错误信息
	private String error = "";

	// 接口参数
	private JSONArray indexJSON = null;

	// 接口返回的指标数据
	private JSONArray indexResult = null;

	public ViewReportService() {
	}

	public ViewReportService(ReportParam param, IReportService reportService, IDataSourceService dataSourceService) {
		this.reportService = reportService;
		this.dataSourceService = dataSourceService;
		this.indexJSON = new JSONArray();
		init(param);
	}

	public void init(ReportParam param) {
		this.param = param;
		this.report = reportService.findById(param.getReport());
		createIntfIndexParams();
		callInterface();
	}

	@Override
	public boolean isCallOK() {
		return status;
	}

	@Override
	public JSONObject getErrorInfo() {
		JSONObject errObject = new JSONObject();
		errObject.put("status", status);
		errObject.put("message", error);
		return errObject;
	}

	@Override
	public JSONObject getChartIndex() {
		JSONObject chartDataObject = null;
		if (this.param.getTimestamp().length <= 1) {
			chartDataObject = createChartSeries(this.param.getSubType());
		} else {
			chartDataObject = createSeriesByTimeSplit();
		}
		chartDataObject.put("status", status);
		return chartDataObject;
	}

	@Override
	public JSONObject getTableIndex() {
		JSONArray rowsData = new JSONArray();
		LinkedList<String> tableHeader = createTableHeader();
		rowsData.add(tableHeader);
		for (int i = 0; i < indexResult.size(); i++) {
			for (int j = 0; j < indexResult.getJSONArray(i).size(); j++) {
				// if (j >= this.param.getTotal()) break;
				rowsData.add(j + 1, indexResult.getJSONArray(i).getJSONArray(j));
			}
		}

		JSONObject object = new JSONObject();
		object.put("size", this.param.getRow());
		object.put("rows", rowsData);
		return object;
	}

	@Override
	public JSONArray getTextIndex() {
		String metric = this.param.getyAxis().get(0).get("id");
		int val = 0;
		for (int i = 0; i < indexResult.size(); i++) {
			JSONArray rowArray = indexResult.getJSONArray(i);
			for (int j = 0; j < rowArray.size(); j++) {
				JSONArray cols = rowArray.getJSONArray(j);
				switch (metric) {
				case "PV":
					val += cols.getInt(1);
					break;
				case "UV":
					val += cols.getInt(2);
					break;
				case "VT":
					val += cols.getInt(3);
					break;
				}

			}
		}

		Map<String, Integer> valMap = new HashMap<String, Integer>();
		valMap.put("total", val);
		JSONArray rowsData = new JSONArray();
		rowsData.add(valMap);

		return rowsData;
	}

	/**
	 * 不按时间分组
	 *
	 * @return
	 */
	private JSONObject createChartSeries(String chartType) {
		List<String> categories = new LinkedList<String>();

		JSONArray serieArray = new JSONArray();
		for (int i = 0; i < this.indexResult.size(); i++) {
			JSONArray data = new JSONArray();

			JSONArray objArray = this.indexResult.getJSONArray(i);
			for (int j = 0; j < objArray.size(); j++) {
				JSONArray rowData = objArray.getJSONArray(j);
				if (j == 0) {
					JSONObject selectedObj = new JSONObject();
					selectedObj.put("name", rowData.getString(0));
					selectedObj.put("y", rowData.getLong(1));
					selectedObj.put("sliced", true);
					data.add(selectedObj);
				} else {
					JSONArray jsonData = new JSONArray();
					jsonData.add(rowData.getString(0));
					jsonData.add(rowData.getLong(1));
					data.add(jsonData);
				}

				categories.add(rowData.getString(0));
			}

			JSONObject serieObj = new JSONObject();
			serieObj.put("type", chartType);
			serieObj.put("name", createSeriesName().get(0));
			serieObj.put("data", data);

			serieArray.add(serieObj);
		}

		JSONObject series = new JSONObject();
		series.put("categories", categories);
		series.put("series", serieArray);

		return series;
	}

	/**
	 * 创建蜘蛛网状图表数据
	 *
	 * @return
	 */
	private JSONObject createPolarSeriesData() {
		LinkedList<String> categories = new LinkedList<String>();

		JSONArray serieArray = new JSONArray();
		for (int i = 0; i < this.indexResult.size(); i++) {
			JSONArray data = new JSONArray();

			JSONArray objArray = this.indexResult.getJSONArray(i);
			for (int j = 0; j < objArray.size(); j++) {
				JSONArray rowData = objArray.getJSONArray(j);
				JSONArray jsonData = new JSONArray();
				categories.add(rowData.getString(0));
				jsonData.add(rowData.getLong(jsonData.size() - 1));
				data.add(jsonData);
			}

			JSONObject serieObj = new JSONObject();
			serieObj.put("pointPlacement", "no");
			serieObj.put("name", createSeriesName().get(0));
			serieObj.put("data", data);

			serieArray.add(serieObj);
		}

		JSONObject series = new JSONObject();
		series.put("categories", categories);
		series.put("series", serieArray);

		return series;
	}

	/**
	 * 创建有Y轴的图表数据
	 */
	private JSONObject createSeriesDataY() {
		JSONObject chartData = null;
		if (indexResult == null)
			return chartData;
		if (StringUtils.isNotEmpty(this.param.getxAxis())) {
			chartData = createSeriesByxAxis();
		} else {
			chartData = createSeriesByTimeSplit();
		}

		return chartData;
	}

	/**
	 * 根据配置的X轴创建图表数据
	 */
	private JSONObject createSeriesByxAxis() {

		LinkedList<String> categories = new LinkedList<String>();
		LinkedList<JSONArray> rData = new LinkedList<JSONArray>();

		for (int i = 0; i < this.indexResult.size(); i++) {
			JSONArray objArray = this.indexResult.getJSONArray(i);
			for (int j = 0; j < objArray.size(); j++) {
				JSONArray rowData = objArray.getJSONArray(j);
				JSONArray jsonData = new JSONArray();
				for (int k = 0; k < rowData.size(); k++) {
					if (k == 0) {
						categories.add(rowData.getString(k));
						continue;
					}
					jsonData.add(rowData.getLong(k));
				}
				rData.add(jsonData);
			}
		}

		JSONObject chartData = new JSONObject();
		chartData.put("categories", categories);

		LinkedList<String> seriesName = createSeriesName();

		JSONArray series = new JSONArray();
		JSONArray axisArray = JSONArray.fromObject(this.param.getyAxis());
		for (int i = 0; i < axisArray.size(); i++) {
			JSONObject yAxis = axisArray.getJSONObject(i);
			String yIndex = yAxis.getString("id");
			String text = yAxis.getString("text");
			boolean isFirst = yAxis.getBoolean("secondAxis");
			for (int j = 0; j < seriesName.size(); j++) {
				JSONObject serie = new JSONObject();
				serie.put("name", seriesName.get(j) + "_" + yIndex);
				serie.put("tooltip", new JSONObject().put("valueSuffix", text));
				JSONArray jData = new JSONArray();
				for (int k = 0; k < rData.size(); k++) {
					JSONArray data = rData.get(k);
					if (!StringUtils.isEmpty(this.report.getVid())) {
						switch (yIndex) {
						case "PV":
							jData.add(data.getLong(0));
							break;
						case "UV":
							jData.add(data.getLong(1));
							break;
						case "VT":
							jData.add(data.getLong(2));
							break;
						}
					} else {
						jData.add(data.getLong(0));
					}
				}
				serie.put("yAxis", j);
				serie.put("data", jData);
				series.add(serie);
			}
		}

		chartData.put("series", series);

		return chartData;

	}

	/**
	 * 根据时间分片创建Series
	 */
	private JSONObject createSeriesByTimeSplit() {
		LinkedList<Long> timeInterval = new LinkedList<Long>();
		for (int i = 0; i < param.getTimestamp().length; i++) {
			long[] timestamp = param.getTimestamp()[i];
			Date date = DateUtils.parseToDate(String.valueOf(timestamp[1]), "yyyyMMddHHmmss");
			timeInterval.add(date.getTime());
		}

		Map<String, JSONArray> seriesMap = new LinkedHashMap<String, JSONArray>();

		JSONArray axisArray = JSONArray.fromObject(this.param.getyAxis());
		for (int i = 0; i < axisArray.size(); i++) {
			JSONObject yAxis = axisArray.getJSONObject(i);
			String yIndex = yAxis.getString("id");
			String text = yAxis.getString("text");
			boolean isFirst = yAxis.getBoolean("secondAxis");

			for (int j = 0; j < timeInterval.size(); j++) {
				for (int k = 0; k < indexResult.getJSONArray(j).size(); k++) {
					JSONArray rowData = indexResult.getJSONArray(j).getJSONArray(k);

					String serieName = "";
					long data = 0;

					for (int l = 0; l < rowData.size(); l++) {
						if (l == 0) {
							serieName = rowData.getString(l);
							continue;
						}
						if (!StringUtils.isEmpty(this.report.getVid())) {
							switch (yIndex) {
							case "PV":
								data = rowData.getLong(1);
								break;
							case "UV":
								data = rowData.getLong(2);
								break;
							case "VT":
								data = rowData.getLong(3);
								break;
							}
						} else {
							data = rowData.getLong(1);
						}
					}
					JSONArray jaData = seriesMap.get(serieName);
					if (jaData == null) {
						jaData = new JSONArray();
					}
					jaData.add(new Long[] { timeInterval.get(j), data });
					seriesMap.put(serieName, jaData);
				}
			}
		}

		JSONArray series = new JSONArray();
		Set<Map.Entry<String, JSONArray>> entrySet = seriesMap.entrySet();
		for (Map.Entry<String, JSONArray> entry : entrySet) {
			JSONObject serie = new JSONObject();
			serie.put("name", entry.getKey());
			serie.put("data", entry.getValue());
			// if(entry.getValue().size() == timeInterval.size())
			// {
			// serie.put("data", entry.getValue());
			// }
			// else
			// {
			// //对数据不全的处理
			// JSONArray data = new JSONArray();
			// for(int i=0;i < timeInterval.size(); i++)
			// {
			// if(i < entry.getValue().size())
			// {
			// JSONArray d = entry.getValue().getJSONArray(i);
			// for (int j = 0; j < timeInterval.size(); j++)
			// {
			// if (d.getLong(0) == timeInterval.get(j))
			// {
			// data.add(i, d);
			// break;
			// }
			// }
			// }
			// else
			// {
			// data.add(i, new long[]{timeInterval.get(i), 0});
			// }
			// }
			// serie.put("data", data);
			// }

			series.add(serie);
		}

		JSONObject chartData = new JSONObject();
		chartData.put("categories", "");
		chartData.put("series", series);

		return chartData;
	}

	/**
	 * 获取X轴
	 *
	 * @return
	 */
	private LinkedList<String> createSeriesName() {
		LinkedList<String> seriesName = new LinkedList<String>();
		JSONObject tabHeaderObj = null;
		if (StringUtils.isEmpty(this.report.getVid())) {
			tabHeaderObj = indexJSON.getJSONObject(0).getJSONObject("col");
		} else {
			tabHeaderObj = indexJSON.getJSONArray(0).getJSONObject(3);
		}

		for (int i = 0; i < tabHeaderObj.names().size(); i++) {
			String family = tabHeaderObj.names().getString(i);
			JSONArray fields = tabHeaderObj.getJSONArray(family);
			for (int j = 0; j < fields.size(); j++) {
				seriesName.add(fields.getString(j));
			}
		}

		return seriesName;
	}

	/**
	 * 创建头表
	 */
	private LinkedList<String> createTableHeader() {

		LinkedList<String> tabHeader = new LinkedList<String>();
		JSONObject tabHeaderObj = null;
		if (StringUtils.isEmpty(this.report.getVid())) {
			tabHeaderObj = indexJSON.getJSONObject(0).getJSONObject("col");
		} else {
			tabHeaderObj = indexJSON.getJSONArray(0).getJSONObject(3);
		}

		for (int i = 0; i < tabHeaderObj.names().size(); i++) {
			String family = tabHeaderObj.names().getString(i);
			JSONArray fields = tabHeaderObj.getJSONArray(family);
			for (int j = 0; j < fields.size(); j++) {
				tabHeader.add(fields.getString(j));
			}
			tabHeader.add("PV");
			if (StringUtils.isNotEmpty(this.report.getVid())) {
				tabHeader.add("UV");
				tabHeader.add("VT");
			}
		}

		return tabHeader;
	}

	/**
	 * 创建接口参数
	 */
	private void createIntfIndexParams() {
		try {
			Map<String, JSONArray> colMap = new LinkedHashMap<String, JSONArray>();
			// 没有配置Y坐标
			for (Element el : this.report.getDimension()) {
				if (!el.getId().equals(this.param.getElement()))
					continue;
				buildSearchCols(el, colMap);
				break;
			}

			if (StringUtils.isEmpty(this.report.getVid())) {
				JSONObject jo = new JSONObject();
				jo.put("sid", this.report.getLogSource());
				jo.put("col", colMap);
				for (int i = 0; i < this.param.getTimestamp().length; i++) {
					jo.put("dmt", this.param.getTimestamp()[i]);
					indexJSON.add(jo);
				}
			} else {
				Set<Map.Entry<String, JSONArray>> entrySet = colMap.entrySet();
				for (Map.Entry<String, JSONArray> entry : entrySet) {
					for (int i = 0; i < this.param.getTimestamp().length; i++) {
						JSONArray ja = new JSONArray();

						ja.add(this.report.getLogSource());
						ja.add(this.report.getVid());
						ja.add(colMap);

						JSONArray jsa = new JSONArray();
						for (int j = 0; j < entry.getValue().size(); j++) {
							JSONArray fc = new JSONArray();
							fc.add(entry.getKey());
							fc.add(entry.getValue().getString(j));
							jsa.add(fc);
						}
						JSONArray jArray = new JSONArray();
						jArray.add(jsa);
						ja.add(jArray);

						ja.add(2, this.param.getTimestamp()[i]);
						indexJSON.add(ja);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println(this.param.getSubType());
		// System.out.println(this.indexJSON.toString());
	}

	/**
	 * 构建查询列参数
	 *
	 * @param el
	 * @param colMap
	 */
	private void buildSearchCols(Element el, Map<String, JSONArray> colMap) {
		String family = "", field = "";
		try {
			if ("".equals(el.getSearchCol())) {
				family = "raw";
				field = el.getFamily();
			} else {
				if (el.getSearchCol().contains(":")) {
					family = el.getSearchCol().split(":")[0];
					field = el.getSearchCol().split(":")[1];
				} else {
					family = "param";
					field = el.getSearchCol();
				}
			}
			JSONArray cols = colMap.get(family);
			if (cols == null) {
				cols = new JSONArray();
			}
			cols.add(field);
			colMap.put(family, cols);
		} catch (Exception e) {
			e.printStackTrace();
			;
		}
	}

	/**
	 * 调用接口
	 */
	private void callInterface() {
		String result = "";
		if (StringUtils.isEmpty(this.report.getVid())) {
			result = dataSourceService.callGeneralIndex(indexJSON.toString());
		} else {
			result = dataSourceService.callVisitIndex(indexJSON.toString());
		}
		if (StringUtils.isEmpty(result)) {
			this.error = "接口调用失败，请联系管理员";
			return;
		}
		JSONObject obj = JSONObject.fromObject(result);
		this.status = obj.getBoolean("status");
		if (!this.status) {
			this.error = obj.getString("result");
			return;
		}

		this.indexResult = obj.getJSONArray("result");
	}

}
