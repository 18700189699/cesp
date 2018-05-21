package com.uxsino.AgentConsole.service;

import java.util.List;

import com.uxsino.AgentConsole.bean.AdminLog;
import com.uxsino.AgentConsole.bean.SystemLog;
import com.uxsino.AgentConsole.bean.UserLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 审计管理员，查询所有日志,可对日志进行增删改查
 * @author admin
 * service层接口
 */
public interface AuditService {

	public List<UserLog> findUserLog();   //查找所有用户日志，动态查询带着条件
	
	public List<AdminLog> findAdminLog(); //查找所有管理员日志
	
	public List<SystemLog> findSystemLog(); //查找所有系统日志

    Page<SystemLog> findByPNameNot(Pageable pageable);
	
}
