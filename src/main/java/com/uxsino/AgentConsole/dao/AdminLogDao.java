package com.uxsino.AgentConsole.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uxsino.AgentConsole.bean.AdminLog;

/**
 * 审计管理员，查询所有管理员日志,可对管理员的日志进行增删改查
 * @author admin
 * dao层接口
 */

public interface AdminLogDao extends JpaRepository<AdminLog, Integer> {

}
