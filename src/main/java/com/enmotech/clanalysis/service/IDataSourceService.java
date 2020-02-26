package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DataSource;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/10.
 */
public interface IDataSourceService extends IOperations<DataSource> {
	/**
	 * 获取日志源配置
	 * 调出日志采集和解析服务器中日志源配置文件(logsources.xml)中的各列信息定义，可以拿到前台给前台用户自定义指标作为参考依据
	 *
	 * @return
	 */
	public String getLogSources();

	/**
	 * @param sid
	 *            日志源ID
	 * @return
	 */
	public String getVids(String sid);

	/**
	 * 根据日志配置ID获取日志字段
	 *
	 * @param cid
	 */
	public List<Map<String, String>> getFields(String cid);

	/**
	 * 根据日志配置ID获取日志源字段
	 *
	 * @param cid
	 */
	public List<Map<String, String>> getLSFields(String cid);

	/**
	 * 读取普通/简单的指标的结果数据
	 *
	 * @param idxs
	 * @return
	 */
	public String callGeneralIndex(String idxs);

	/**
	 * 获取访次相关的可自由组合计算指标的结果
	 *
	 * @param idxs
	 * @return
	 */
	public String callVisitIndex(String idxs);

	/**
	 * 读取定式/给定指标的结果数据
	 *
	 * @param idxs
	 * @return
	 */
	public String callFixedIndex(String idxs);

	/**
	 * 提取指标菜单，即获取给定的指标以菜单的形式
	 *
	 * @return
	 */
	public String callIndexMenu();
}
