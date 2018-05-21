package com.uxsino.AgentConsole.service;

import java.util.List;

import com.uxsino.AgentConsole.bean.Users;

/**
 * 安全管理员，对用户进行操作
 * @author admin
 * service层接口
 */
public interface SecurityService {

	public List<Users> findUserApplication(String status); //查看待审批人员
	
	public Users passApplication(Users user); //通过审批
	
	public Users outApplication(Users user); //拒绝审批
	
	public Users updateUser(Users user); //修改用户信息（角色、姓名等）
	
	
}
