package com.enmotech.clanalysis.service.impl;

import com.enmotech.caa.itf.utils.InterfaceUtils;
import com.enmotech.clanalysis.dao.IDataSourceDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBConfig;
import com.enmotech.clanalysis.entity.DataSource;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IDBConfigService;
import com.enmotech.clanalysis.service.IDataSourceService;
import com.enmotech.clanalysis.util.DBHelper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("dataSourceService")
public class DataSourceService extends AbstractService<DataSource> implements IDataSourceService {

	private LinkedHashMap<String, String> pdata = new LinkedHashMap<String, String>(2);

	@Autowired
	private IDataSourceDao dataSourceDao;

	@Autowired
	private IDBConfigService dbConfigService;

	public DataSourceService() {
		pdata.put("timeout", "5000");
	}

	@Override
	protected IOperations<DataSource> getDao() {
		return dataSourceDao;
	}

	@Override
	public String getLogSources() {
		// 本地数据
		// String json = null;
		// try
		// {
		// File file = new File("E:\\Enmotech\\接口文档\\getLogSources.js");
		// ObjectMapper mapper = new ObjectMapper();
		// JsonNode node = mapper.readTree(file);
		// json = node.toString();
		// }
		// catch (IOException e)
		// {
		// e.printStackTrace();
		// }
		//
		// return json;

		String source = InterfaceUtils.call("getLogSources", null);
		JSONObject jo = JSONObject.fromObject(source);
		String json = "";
		if (jo.getBoolean("status")) {
			json = jo.getString("result");
		}

		return json;

	}

	@Override
	public String getVids(String sid) {
		String vids = "";

		String json = this.getLogSources();
		JSONArray ja = JSONArray.fromObject(json);
		if (!ja.isEmpty()) {
			Iterator<Object> iter = ja.iterator();
			while (iter.hasNext()) {
				Object obj = iter.next();
				JSONObject jo = JSONObject.fromObject(obj);
				if (jo.getString("id").equals(sid)) {
					vids = jo.getString("vids");
					break;
				}
			}
		}

		return vids;
	}

	/**
	 * 获取日志源的字段
	 *
	 * @param sid
	 * @return
	 */
	public List<Map<String, String>> getLSFields(String sid) {
		String json = this.getLogSources();
		JSONArray ja = JSONArray.fromObject(json);
		if (!ja.isEmpty()) {
			Iterator<Object> iter = ja.iterator();
			while (iter.hasNext()) {
				Object obj = iter.next();
				JSONObject jo = JSONObject.fromObject(obj);
				if (jo.getString("id").equals(sid)) {
					List<Map<String, String>> families = new ArrayList<Map<String, String>>();
					Object cols = jo.get("cols");
					return familyToObject(cols, families);
				}
			}
		}

		return null;
	}

	@Override
	public String callGeneralIndex(String idxs) {
		pdata.put("idxs", idxs);
		return InterfaceUtils.call("getGeneralIndexResult", pdata);
	}

	@Override
	public String callVisitIndex(String idxs) {
		pdata.put("idxs", idxs);
		return InterfaceUtils.call("getVisitIndexResult", pdata);
	}

	@Override
	public String callFixedIndex(String idxs) {
		pdata.put("idxs", idxs);
		return InterfaceUtils.call("getFixedIndexResult", pdata);
	}

	@Override
	public String callIndexMenu() {
		return InterfaceUtils.call("getIndexMenu", null);
	}

	private List<Map<String, String>> familyToObject(Object object, List<Map<String, String>> families) {

		if (object instanceof JSONArray) {
			JSONArray ja = JSONArray.fromObject(object);
			Iterator iter = ja.iterator();
			while (iter.hasNext()) {
				familyToObject(iter.next(), families);
			}
		} else {
			JSONObject jo = JSONObject.fromObject(object);
			if (jo.get("subCols") != null) {
				familyToObject(jo.get("subCols"), families);
			} else {
				Map<String, String> map = new HashMap<String, String>();
				String family = jo.getString("family");
				String name = jo.getString("name");
				map.put("id", family + ":" + name);
				map.put("name", name);
				families.add(map);
			}
		}
		return families;
	}

	@Override
	public List<Map<String, String>> getFields(String sid) {
		DataSource ds = findById(sid);
		if ("log".equals(ds.getSrcType())) // 标准日志
		{
			return getLSFields(ds.getLogType());
		} else if ("db".equals(ds.getSrcType())) // 数据库
		{
			String sql = ds.getSql();
			if (sql.toLowerCase().contains("where")) {
				sql += " and 1=2";
			} else {
				sql += " where 1=2";
			}
			DBConfig dbConfig = ds.getDbConfig();
			Map<String, Object> map = dbConfigService.getDBHelper(dbConfig.getId());
			DBHelper dbHelper = (DBHelper) map.get("dbHelper");
			List<String> dataset = dbHelper.getColumns(sql);
			return dbConfigService.generateMapList(dataset);
		} else// 本地文件
		{

		}

		return null;
	}
}
