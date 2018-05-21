package com.uxsino.AgentConsole.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uxsino.AgentConsole.bean.Role;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * 系统管理员对管理员角色的操作
 * @author admin
 * 包括添加其他管理员方法、更改状态、删除管理员账户
 */
public interface SystemAdminRoleDao extends JpaRepository<Role, Integer> {

    //锁定、解锁管理员账号
    @Query( value = "update Role set Status=?1 where accountname = ?2")
    @Modifying
    public Role updateStatus(String status,String accountname);

    //删除管理员账户
    @Query(value = "delete from Role where accountname=?1")
    @Modifying
    public Role updateStatus(String name);



}
