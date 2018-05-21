package com.uxsino.AgentConsole.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uxsino.AgentConsole.bean.SystemLog;

/**
 * 审计管理员，查询所有系统日志,可对系统的日志进行增删改查
 * @author admin
 * dao层接口
 */
public interface SystemLogDao extends JpaRepository<SystemLog, Integer> {

}
