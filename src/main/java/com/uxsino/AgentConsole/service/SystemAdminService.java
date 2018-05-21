package com.uxsino.AgentConsole.service;

import com.uxsino.AgentConsole.bean.Role;

/**
 * 系统管理员对用户及系统角色的操作
 * @author admin
 */
public interface SystemAdminService {

	//对系统管理员进行操作
	public Role insertRole(Role role);  //添加其他管理员方法
	
	public Role updateLockStatus(Role role); //更改状态（锁定）
	
	public Role updateUnlockStatus(Role role); //更改状态（解锁）
	
	public Role deleteRole(Role role);  //删除管理员账户（不可删除自己）
	
	//系统暂停、启动服务（与代理端沟通更改标志位）
	
	//账号审批及空间配置管理
	
	
}
