package com.enmotech.clanalysis.dao;

import com.enmotech.clanalysis.entity.User;

import java.util.List;

/**
 * 数据层：用户接口 Created by Administrator on 2015/5/25.
 */
public interface IUserDao extends IOperations<User> {
	/**
	 * 用户登录
	 *
	 * @param username
	 * @param password
	 * @return
	 */
	public User login(String username, String password);

	/**
	 * 用户登录历史
	 *
	 * @param username
	 * @return
	 */
	public List<User> loginHistory(String username);

	/**
	 * @param user
	 */
	public void logout(User user);

	/**
	 * @param hql
	 * @param values
	 */
	public boolean updatepwd(String hql, Object[] values);

}
