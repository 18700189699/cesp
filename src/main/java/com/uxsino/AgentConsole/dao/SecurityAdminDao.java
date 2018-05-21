package com.uxsino.AgentConsole.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uxsino.AgentConsole.bean.Users;

public interface SecurityAdminDao extends JpaRepository<Users, Integer> {
	
	//根据审批情况查询用户
	public List<Users> findByStatus(String status);

}
