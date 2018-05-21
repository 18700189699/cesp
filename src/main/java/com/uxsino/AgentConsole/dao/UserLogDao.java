package com.uxsino.AgentConsole.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.uxsino.AgentConsole.bean.UserLog;

/**
 * 审计管理员，查询所有用户日志,可对用户的日志进行增删改查
 * @author admin
 * dao层接口
 */
public interface UserLogDao extends JpaRepository<UserLog, Integer> {

	/*@Query("select * from userLog u where u.name = :name")
	UserLog findById(@Param("name") String name);*/
}
