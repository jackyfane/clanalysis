package com.enmotech.clanalysis.util;

import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

import java.util.Locale;
import java.util.Map;

/**
 * Created by Administrator on 2015/4/28. 多视图处理
 */
public class MultipleViewResolver implements ViewResolver {

	private Map<String, ViewResolver> viewResolvers = null;

	@Override
	public View resolveViewName(String viewName, Locale locale) throws Exception {
		int n = viewName.lastIndexOf("."); // 获取
		// viewName(modelAndView中的名字)看其有没有下划线
		String suffix = "";

		// 没有默认使用“jsp“方式 解析,有的话截取下划线后面的字符串 这里一般是jsp,ftl,vm与配置文件中的<entry
		// key="ftl">的key匹配
		if (n == (-1)) {
			suffix = "jsp";
		} else {
			suffix = viewName.substring(n + 1);
			// 取下划线前面的部分 那时真正的资源名.比如我们要使用hello.jsp 那viewName就应该是hello.jsp
			viewName = viewName.substring(0, n);
		}

		// 根据下划线后面的字符串去获取托管的视图解析类对象
		ViewResolver resolver = viewResolvers.get(suffix);
		if (resolver != null) {
			return resolver.resolveViewName(viewName, locale);
		} else {
			return null;
		}
	}

	public void setViewResolvers(Map<String, ViewResolver> viewResolvers) {
		this.viewResolvers = viewResolvers;
	}

	public Map<String, ViewResolver> getViewMap() {
		return viewResolvers;
	}
}
