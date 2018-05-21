package com.uxsino.AgentConsole.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uxsino.AgentConsole.bean.Role;
import com.uxsino.AgentConsole.dao.SystemAdminRoleDao;

/**
 * 系统管理员对用户及系统角色的操作
 * @author admin
 */
@Service
public class SystemAdminServiceImpl implements SystemAdminService{

	@Autowired
	private SystemAdminRoleDao systemAdminRoleDao;
	
	/*@Autowired
	private SystemAdminUsersDao systemAdminUsersDao;*/
	
	//添加其他管理员方法
	@Override
	public Role insertRole(Role role) {
		return systemAdminRoleDao.save(role);
	}

	//更改状态（锁定）
	@Override
	public Role updateLockStatus(Role role) {
		// TODO Auto-generated method stub
		return null;
	}

	//更改状态（解锁）
	@Override
	public Role updateUnlockStatus(Role role) {
		// TODO Auto-generated method stub
		return null;
	}

	//删除管理员账户（不可删除自己）
	@Override
	public Role deleteRole(Role role) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
