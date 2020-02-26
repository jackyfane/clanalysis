package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Menu;
import com.enmotech.clanalysis.service.IResourceService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/menu")
public class SysMenuController extends AbstractController<Menu> {
	private static final Logger LOGGER = Logger.getLogger(SysMenuController.class);

	@Autowired
	private IResourceService resourceService;

	@Override
	protected IOperations<Menu> getService() {
		return resourceService;
	}

	@Override
	protected Map<String, Object> getTreeGrid(int rows, int page, String sidx, String sord, Menu entity) {
		Map<String, Object> map = null;

		try {
			map = new HashMap<String, Object>();
			List<Menu> menus = resourceService.queryTreeGrid(sidx, sord, entity);

			JSONArray menuCells = new JSONArray();
			getMenuTreeGridCells(menuCells, menus);
			map.put("records", menuCells.size());
			map.put("rows", menuCells);

		} catch (Exception e) {
			map = new HashMap<String, Object>();
			map.put("success", false);
			map.put("error", "系统异常，请联系管理员！");
			LOGGER.error(e.getMessage());
		}

		return map;
	}

	/**
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/menuZTree")
	@ResponseBody
	protected JSONArray getZTreeData() {
		List<Menu> menuList = resourceService.queryTreeGrid("", null, new Menu());
		if (menuList == null || menuList.isEmpty())
			return null;
		JSONArray jsonArray = buildMenuJSON(menuList);

		return jsonArray;
	}

	@Override
	@ResponseBody
	protected Map<String, Object> add(@RequestBody Menu menu, HttpServletRequest request) {
		if (menu.getParent() != null) {
			Menu parent = getService().findById(menu.getParent().getId());
			parent.setLeaf(false);
			parent.setExpanded(false);
			menu.setLevel(parent.getLevel() + 1);
			menu.setParent(parent);
		}

		return super.add(menu, request);
	}

	@Override
	protected Map<String, Object> update(@RequestBody Menu menu, HttpServletRequest request) {
		List<Menu> children = getService().findById(menu.getId()).getChildren();
		if (menu.getParent() != null) {
			Menu parent = getService().findById(menu.getParent().getId());

			parent.setLeaf(false);
			parent.setExpanded(false);
			menu.setLevel(parent.getLevel() + 1);
			incrementMenuLevel(menu.getLevel(), children);
			menu.setChildren(children);
			if (children != null && !children.isEmpty())
				menu.setExpanded(false);
			menu.setParent(parent);
		} else {
			menu.setLevel(0);
			menu.setParent(null);
			menu.setExpanded(false);
			incrementMenuLevel(0, children);
			menu.setChildren(children);
		}
		return super.update(menu, request);
	}

	/**
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getMenuJsonById")
	@ResponseBody
	protected JSONObject getMenuJSONById(String id, HttpServletRequest request) {
		Menu menu = getService().findById(id);
		JSONObject menuObject = JSONObject.fromObject(menu.toString());
		if (menu != null && !menu.getChildren().isEmpty())
			menuObject.put("children", buildMenuJSON(menu.getChildren()));
		return menuObject;
	}

	@Override
	@ResponseBody
	protected Map<String, Object> delete(@PathVariable("id") String id, Menu entity) {
		Map<String, Object> map = new HashMap<String, Object>();
		Menu menu = getService().findById(id);
		if (menu == null) {
			map.put("success", false);
			map.put("message", "删除失败！");
		} else {
			try {
				getService().delete(menu);
				map.put("success", true);
				map.put("message", "删除成功！");
			} catch (Exception e) {
				map.put("success", false);
				map.put("message", "删除失败！系统异常，请联系管理员！");
				e.printStackTrace();
			}
		}

		return map;
	}

	/**
	 * @param menus
	 * @return
	 */
	private void getMenuTreeGridCells(JSONArray menuCells, List<Menu> menus) {

		if (menus == null || menus.isEmpty())
			return;
		for (Menu m : menus) {
			JSONObject jsonObject = JSONObject.fromObject(m.toString());
			menuCells.add(jsonObject);
			if (m.getChildren() != null && !m.getChildren().isEmpty()) {
				getMenuTreeGridCells(menuCells, m.getChildren());
			}
		}
	}

	/**
	 * @param menus
	 * @return
	 */
	private JSONArray buildMenuJSON(List<Menu> menus) {
		JSONArray jsonArray = JSONArray.fromObject(menus.toString());
		for (int i = 0; i < menus.size(); i++) {
			List<Menu> children = menus.get(i).getChildren();
			if (children != null && !children.isEmpty()) {
				jsonArray.getJSONObject(i).put("children", buildMenuJSON(children));
			}
		}

		return jsonArray;
	}

	/**
	 * @return
	 */
	private void incrementMenuLevel(int level, List<Menu> menus) {
		if (menus == null || menus.isEmpty())
			return;
		for (int i = 0; i < menus.size(); i++) {
			menus.get(i).setLevel(level + 1);
			if (menus.get(i).getChildren() != null && !menus.get(i).getChildren().isEmpty())
				incrementMenuLevel(menus.get(i).getLevel() + 1, menus.get(i).getChildren());
		}
	}
}
