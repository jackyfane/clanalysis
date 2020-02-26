package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.ILocalFileDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.LocalFile;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.ILocalFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("localFileService")
public class LocalFileService extends AbstractService<LocalFile> implements ILocalFileService {
	@Autowired
	private ILocalFileDao localFileDao;

	@Override
	protected IOperations<LocalFile> getDao() {
		return localFileDao;
	}
}
