package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.entity.ReportParam;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by Administrator on 2015/9/24.
 */
public interface IViewReportService {

	/**
	 * 参数初始化
	 */
	public void init(ReportParam param);

	/**
	 * 远程接口调用是否成功
	 *
	 * @return
	 */
	public boolean isCallOK();

	/**
	 * @return
	 */
	public JSONObject getErrorInfo();

	/**
	 * 获取图表数据
	 *
	 * @return
	 */
	public JSONObject getChartIndex();

	/**
	 * 获取图表数据
	 *
	 * @return
	 */
	public JSONObject getTableIndex();

	/**
	 * 获取文本指标
	 *
	 * @return
	 */
	public JSONArray getTextIndex();

}
