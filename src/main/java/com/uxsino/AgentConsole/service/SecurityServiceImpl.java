package com.uxsino.AgentConsole.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uxsino.AgentConsole.bean.Users;
import com.uxsino.AgentConsole.dao.SecurityAdminDao;

/**
 * 安全管理员，对用户进行操作
 * @author admin
 * service层接口
 */

@Service
public class SecurityServiceImpl implements SecurityService {

	@Autowired
	private SecurityAdminDao securityAdminDao;
	
	//查看审批通过人员和待审批人员
	@Override
	public List<Users> findUserApplication(String status) {
		return securityAdminDao.findByStatus(status);
	}

	//通过审批
	@Override
	public Users passApplication(Users user) {
		// TODO Auto-generated method stub
		return null;
	}

	//拒绝审批
	@Override
	public Users outApplication(Users user) {
		// TODO Auto-generated method stub
		return null;
	}

	//修改用户信息（角色、姓名等）
	@Override
	public Users updateUser(Users user) {
		// TODO Auto-generated method stub
		return null;
	}

}
