package com.enmotech.clanalysis.controller.base;

import com.enmotech.clanalysis.dao.IOperations;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 控制层抽象类
 *
 * @param <T>
 *            Created by Administrator on 2015/5/11.
 */
public abstract class AbstractController<T extends Serializable> {
	private final static Logger LOGGER = Logger.getLogger(AbstractController.class);

	private int firstResult = 0;

	private int maxResults = 10;

	/**
	 * 管理页面
	 *
	 * @return
	 */
	@RequestMapping(value = "/list")
	protected ModelAndView index(HttpServletRequest request) {
		String path = getDirectPath(request);
		ModelAndView mv = new ModelAndView();
		mv.setViewName(path);
		return mv;
	}

	/**
	 * 获取所有的数据
	 */
	@RequestMapping(value = "/get-all")
	@ResponseBody
	protected List<T> getAll(T entity) {
		return getService().findAll(entity);
	}

	/**
	 * 分页查询
	 *
	 * @param entity
	 */
	@RequestMapping(value = "/list/{page}/{rows}")
	@ResponseBody
	protected Map<String, Object> list(@PathVariable("page") int page, @PathVariable("rows") int rows, T entity) {
		Map<String, Object> map = new HashMap<String, Object>();
		initPage(page, rows);

		try {
			List<T> list = getService().findByPage(entity, getFirstResult(), getMaxResults());
			map.put("list", list);
			int total = getService().findCount(entity);
			map.put("total", total);
		} catch (Exception e) {
			map.put("error", "系统异常，请联系管理员！");
			map.put("error", e.getMessage());
			LOGGER.error(e.getMessage());
		}

		return map;
	}

	@RequestMapping(value = "/treegrid")
	@ResponseBody
	protected Map<String, Object> getTreeGrid(int rows, int page, String sidx, String sord, T entity) {
		Map<String, Object> map = null;
		initPage(page, rows);

		try {
			map = new HashMap<String, Object>();
			List<T> list = getService().findByPage(entity, getFirstResult(), getMaxResults());
			int records = getService().findCount(entity);
			map.put("total", (records + rows - 1) / rows);
			map.put("page", page);
			map.put("records", records);
			map.put("rows", list);
		} catch (Exception e) {
			map = new HashMap<String, Object>();
			map.put("error", "系统异常，请联系管理员！");
			map.put("error", e.getMessage());
			LOGGER.error(e.getMessage());
		}

		return map;
	}

	/**
	 * @param entity
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	protected Map<String, Object> add(@RequestBody T entity, HttpServletRequest request) {
		Map<String, Object> infoMap = new HashMap<String, Object>();
		try {
			getService().save(entity);
			if (entity != null) {
				infoMap.put("success", true);
				infoMap.put("message", "添加成功！");
			} else {
				infoMap.put("success", false);
				infoMap.put("message", "添加失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			infoMap.put("success", false);
			infoMap.put("message", "添加失败！系统异常，请联系管理员");
		}

		return infoMap;
	}

	/**
	 * 上传文件到指定目录 支持多文件上传
	 *
	 * @param entity
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/upload/{directory}", method = RequestMethod.POST)
	// @ResponseBody
	protected ModelAndView upload(T entity, @PathVariable("directory") String directory, HttpServletRequest request) {

		boolean isUpload = false;
		try {
			ServletContext context = request.getSession().getServletContext();
			String cxtPath = context.getRealPath("/upload");
			CommonsMultipartResolver resolver = new CommonsMultipartResolver(context);

			if (resolver.isMultipart(request)) {
				MultipartRequest multipartRequest = (MultipartRequest) request;
				Iterator iter = multipartRequest.getFileNames();

				while (iter.hasNext()) {
					MultipartFile file = multipartRequest.getFile(iter.next().toString());
					if (file != null && !StringUtils.isEmpty(file.getOriginalFilename())) {

						String filePath = cxtPath + File.separator + directory + File.separator
								+ file.getOriginalFilename();
						File target = new File(filePath);
						if (!target.exists()) {
							target.mkdirs();
						}
						file.transferTo(target);
						isUpload = true;

						Class cls = entity.getClass();
						Method method = cls.getMethod("setFilePath", new Class[] { String.class });
						method.invoke(entity, new Object[] { filePath });
					} else {
						// 修改，不上传文件
						isUpload = true;
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}

		Map<String, Object> infoMap = new HashMap<String, Object>();
		if (isUpload) {
			String id = request.getParameter("id");
			if (StringUtils.isEmpty(id)) {
				getService().save(entity);
				infoMap.put("success", isUpload);
				infoMap.put("message", "添加成功！");
			} else {
				getService().update(entity);
				infoMap.put("success", isUpload);
				infoMap.put("message", "修改成功！");
			}
		} else {
			infoMap.put("success", isUpload);
			infoMap.put("message", "文件上传失败！");
		}

		String url = request.getRequestURL().toString();
		url = url.substring(0, url.length() - ("/upload/" + directory).length() + 1) + "list";
		RedirectView view = new RedirectView(url);
		view.addStaticAttribute("result", infoMap);
		view.setAttributesMap(infoMap);
		return new ModelAndView(view);
	}

	/**
	 * 文件上传(将文件转为为二进制保存到数据库)
	 *
	 * @return
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	protected String upload(T entity, @ModelAttribute("file") MultipartFile file, String id, String uploadFile) {
		T t = null;
		if (!StringUtils.isEmpty(id)) {
			t = getService().findById(id);
		}
		try {
			Class cls = entity.getClass();
			Field uploadFileField = null;
			Field fileDataField = null;

			Method method;

			byte[] bytes = null;

			if (t != null) {
				Class tCls = t.getClass();
				uploadFileField = tCls.getDeclaredField("uploadFile");
				fileDataField = tCls.getDeclaredField("fileData");
				method = tCls.getMethod("getUploadFile");
				if (((String) method.invoke(t)).equals(uploadFile)) {
					method = tCls.getMethod("getFileData");
					bytes = (byte[]) method.invoke(t);
					if (!bytes.equals(file.getBytes())) {
						bytes = file.getBytes();
					}
				} else {
					bytes = file.getBytes();
					uploadFile = file.getOriginalFilename();
				}
			} else {
				uploadFileField = cls.getDeclaredField("uploadFile");
				fileDataField = cls.getDeclaredField("fileData");
				bytes = file.getBytes();
				uploadFile = file.getOriginalFilename();
			}

			method = cls.getMethod("setFileData", new Class[] { fileDataField.getType() });
			method.invoke(entity, new Object[] { bytes });

			method = cls.getMethod("setUploadFile", new Class[] { uploadFileField.getType() });
			method.invoke(entity, new Object[] { uploadFile });
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (StringUtils.isEmpty(id)) {
			getService().save(entity);
		} else {
			getService().update(entity);
		}
		return "redirect:list";
	}

	/**
	 * 获取表单页面
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/form")
	protected ModelAndView form(String id, String action, ModelMap model, HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		if (!StringUtils.isEmpty(id)) {
			T entity = getService().findById(id);
			model.addAttribute("entity", entity);
			model.addAttribute("action", StringUtils.isEmpty(action) ? "update" : action);
		} else {
			model.addAttribute("action", StringUtils.isEmpty(action) ? "add" : action);
		}
		String path = getDirectPath(request);
		modelAndView.setViewName(path);
		modelAndView.addAllObjects(model);
		return modelAndView;
	}

	/**
	 * @param prefix
	 * @return
	 */
	@RequestMapping(value = "/{prefix}-form")
	protected ModelAndView loadForm(@PathVariable("prefix") String prefix) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(prefix + "-form");
		return modelAndView;
	}

	/**
	 * 更新
	 *
	 * @param entity
	 * @return
	 */
	@RequestMapping(value = "/update")
	@ResponseBody
	protected Map<String, Object> update(@RequestBody T entity, HttpServletRequest request) {
		Map<String, Object> infoMap = new HashMap<String, Object>();
		try {
			getService().update(entity);
			if (entity != null) {
				infoMap.put("success", true);
				infoMap.put("message", "修改成功！");
			} else {
				infoMap.put("success", false);
				infoMap.put("message", "修改失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			infoMap.put("success", false);
			infoMap.put("message", "更新失败！系统异常，请联系管理员");
		}

		return infoMap;
	}

	/**
	 * 批量删除
	 *
	 * @param list
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	protected Map<String, Object> delete(@RequestBody List<T> list) {
		Map<String, Object> infoMap = new HashMap<String, Object>();
		try {
			getService().delete(list);
			infoMap.put("success", true);
			infoMap.put("message", "删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
			infoMap.put("success", false);
			infoMap.put("message", "删除失败！");
		}

		return infoMap;
	}

	/**
	 * 根据ID删除或根据对象删除
	 *
	 * @param id
	 * @param entity
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}")
	@ResponseBody
	protected Map<String, Object> delete(@PathVariable("id") String id, T entity) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			getService().deleteById(id);
			map.put("success", true);
			map.put("message", "删除成功！");
		} catch (Exception e) {
			map.put("success", false);
			map.put("message", "删除失败！");
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 根据ID获取详细
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/detail")
	protected ModelAndView detail(String id, ModelMap modelMap, String target, HttpServletRequest request) {
		String path = getDirectPath(request);
		ModelAndView modelAndView = new ModelAndView();
		if ("report".equalsIgnoreCase(target)) {
			path = path.substring(0, path.lastIndexOf("/") + 1) + target;
		}
		modelAndView.setViewName(path);

		T entity = getService().findById(id);
		modelMap.addAttribute("entity", entity);
		modelAndView.addAllObjects(modelMap);

		return modelAndView;
	}

	@RequestMapping(value = "/queryOne")
	@ResponseBody
	protected T detail(String id, HttpServletRequest request) {
		T entity = getService().findById(id);
		return entity;
	}

	/**
	 * 初始换分页
	 *
	 * @param model
	 */
	protected void initPage(ModelMap model) {
		int page = 1, rows = 10;
		if (model.get("page") != null) {
			page = Integer.parseInt(model.get("page").toString(), 1);
		}
		if (model.get("rows") != null) {
			rows = Integer.parseInt(model.get("rows").toString(), 10);
		}
		initPage(page, rows);
	}

	/**
	 * 初始化分页信息
	 *
	 * @param page
	 * @param rows
	 */
	protected final void initPage(int page, int rows) {
		if (page == 0)
			page = 1;
		if (rows == 0)
			rows = 10;
		setFirstResult((page - 1) * rows);
		setMaxResults(rows);
	}

	public int getFirstResult() {
		return firstResult;
	}

	public void setFirstResult(int firstResult) {
		this.firstResult = firstResult;
	}

	public int getMaxResults() {
		return maxResults;
	}

	public void setMaxResults(int maxResults) {
		this.maxResults = maxResults;
	}

	/**
	 * @param request
	 * @return
	 */
	protected String getDirectPath(HttpServletRequest request) {
		String ctx = request.getContextPath();
		String uri = request.getRequestURI();
		return uri.substring(ctx.length());
	}

	/**
	 * 获取业务层抽象方法
	 *
	 * @return
	 */
	protected abstract IOperations<T> getService();

}
