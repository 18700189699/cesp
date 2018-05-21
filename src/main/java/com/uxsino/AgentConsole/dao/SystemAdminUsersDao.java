package com.uxsino.AgentConsole.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uxsino.AgentConsole.bean.Users;

/**
 * 系统管理员对用户的操作
 * @author admin
 * 包括添加对用户的审批、对审批人员的查看、更改审批状态、删除人员：具体调用在service里面进行操作
 */
public interface SystemAdminUsersDao extends JpaRepository<Users, Integer> {

}
