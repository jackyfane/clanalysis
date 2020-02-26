package com.enmotech.clanalysis.dao;

import com.enmotech.clanalysis.exception.ClanalysisException;

import java.io.Serializable;
import java.util.List;

/**
 * 数据层通用类接口
 */
public interface IOperations<T extends Serializable> {

	/**
	 * 根据ID查询
	 *
	 * @param id
	 * @return
	 * @throws ClanalysisException
	 */
	public T findById(final Serializable id);

	/**
	 * 查询指定对象数据
	 *
	 * @return
	 * @throws ClanalysisException
	 */
	public List<T> findAll(T entity);

	/**
	 * 分页查询
	 *
	 * @param entity
	 * @param firstResult
	 * @param maxResults
	 * @return
	 * @throws ClanalysisException
	 */
	public List<T> findByPage(final T entity, final int firstResult, final int maxResults);

	/**
	 * 总数
	 *
	 * @param entity
	 * @return
	 * @throws ClanalysisException
	 */
	public int findCount(final T entity);

	/**
	 * 保存对象
	 *
	 * @param entity
	 * @throws ClanalysisException
	 */
	public void save(final T entity);

	/**
	 * 更新对象
	 *
	 * @param entity
	 * @throws ClanalysisException
	 */
	public void update(final T entity);

	/**
	 * 保存和更新对象
	 *
	 * @param entity
	 * @throws ClanalysisException
	 */
	public void saveOrUpdate(final T entity);

	/**
	 * 批量删除对象
	 *
	 * @param entities
	 * @throws ClanalysisException
	 */
	public void delete(final List<T> entities);

	/**
	 * 删除指定对象 备注：删除对象时，如果数据库中字段为not-null,那么与数据库映射的对象属性必须不能为空，否则抛出以下异常 #
	 * DataIntegrityViolationException: not-null property references a null or
	 * transient value
	 *
	 * @param entity
	 */
	public void delete(final T entity);

	/**
	 * 根据ID删除对象
	 *
	 * @param id
	 * @throws ClanalysisException
	 */
	public void deleteById(final Serializable id);

	/**
	 * 刷新指定对象
	 *
	 * @param entity
	 * @throws ClanalysisException
	 */
	public void refresh(final T entity);

	/**
	 * 刷新所有对象
	 *
	 * @throws ClanalysisException
	 */
	public void flush();
}
