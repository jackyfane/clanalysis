package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2015/6/4.
 */
public abstract class AbstractService<T extends Serializable> implements IOperations<T> {

	@Override
	public T findById(Serializable id) {
		return getDao().findById(id);
	}

	@Override
	public List<T> findAll(T entity) {
		return getDao().findAll(entity);
	}

	@Override
	public List<T> findByPage(T entity, int firstResult, int maxResults) {
		return getDao().findByPage(entity, firstResult, maxResults);
	}

	@Override
	public int findCount(T entity) {
		return getDao().findCount(entity);
	}

	@Override
	public void save(T entity) {
		getDao().save(entity);
	}

	@Override
	public void update(T entity) {
		getDao().update(entity);
	}

	@Override
	public void saveOrUpdate(T entity) {
		getDao().saveOrUpdate(entity);
	}

	@Override
	public void delete(T entity) {
		getDao().delete(entity);
	}

	@Override
	public void delete(List<T> entities) {
		getDao().delete(entities);
	}

	@Override
	public void deleteById(Serializable id) {
		getDao().deleteById(id);
	}

	@Override
	public void refresh(T entity) {
		getDao().refresh(entity);
	}

	@Override
	public void flush() {
		getDao().flush();
	}

	protected abstract IOperations<T> getDao();
}
