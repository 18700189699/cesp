package com.uxsino.AgentConsole.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.uxsino.AgentConsole.bean.AdminLog;
import com.uxsino.AgentConsole.bean.SystemLog;
import com.uxsino.AgentConsole.bean.UserLog;
import com.uxsino.AgentConsole.dao.AdminLogDao;
import com.uxsino.AgentConsole.dao.SystemLogDao;
import com.uxsino.AgentConsole.dao.UserLogDao;

/**
 * 审计管理员，查询所有日志,可对日志进行增删改查
 * @author admin
 * service层接口
 */

@Service
public class AuditServiceImpl implements AuditService{

	@Autowired
	private AdminLogDao adminLogDao;
	
	@Autowired
	private SystemLogDao systemLogDao;
	
	@Autowired
	private UserLogDao userLogDao;
	
	@Override
	public List<UserLog> findUserLog() {
		return userLogDao.findAll();
	}

	@Override
	public List<AdminLog> findAdminLog() {
		return adminLogDao.findAll();
	}

	@Override
	public List<SystemLog> findSystemLog() {
		return systemLogDao.findAll();
	}

	//分页
	@Override
	public Page<SystemLog> findByPNameNot(Pageable pageable) {
		return systemLogDao.findAll(pageable);
	}

}
