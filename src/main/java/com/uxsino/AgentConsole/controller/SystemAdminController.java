package com.uxsino.AgentConsole.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.uxsino.AgentConsole.bean.Role;
import com.uxsino.AgentConsole.service.SystemAdminServiceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统管理员controller
 * @author admin
 * 包括：
 *  1.创建并管理其他账号
 *  2.用户账号审批
 *  3.暂停、启动系统服务
 */
@RestController
@RequestMapping(value = "/systemAdmin")
public class SystemAdminController {

	@Autowired
	private SystemAdminServiceImpl systemAdminServiceImpl;

	//添加角色信息
	@PostMapping(value="/roleAdd")
	public Map<String,String> roleAdd(@RequestParam("accountname") String accountname,
									  @RequestParam("accountRole") String accountRole){
		Map<String,String> map = new HashMap();
		Role role = new Role();
		role.setAccountName(accountname);
		role.setAccountRole(accountRole);
		Role role1 = systemAdminServiceImpl.insertRole(role);
		if (role1!=null){
			map.put("Data","添加成功");
			map.put("Code","201");
		}
		return map;
	}

	//解锁、锁定各管理员账号
	@PutMapping(value = "/updateRoleStatus")
	public Map<String,String> updateStatus(@RequestParam("status") String status,
                                            @RequestParam("name") String name){
		Map<String,String> map = new HashMap();

		return map;
	}

	//删除管理员账号
    @DeleteMapping(value = "/deleteRole")
    public Map<String,String> deleteRole(@RequestParam("name") String name){
        Map<String,String> map = new HashMap();
        return map;
    }

    //查询所有管理员账号信息
    @GetMapping(value = "/listRole")
    public Map<String,String> listRole(@RequestParam("page") String page){
        Map<String,String> map = new HashMap();
        return map;
    }

    //审批用户状态和解锁、锁定用户状态接口
    @PutMapping(value = "/updateUserStatus")
    public Map<String,String> updateUserStatus(@RequestParam("status") String status,
                                                @RequestParam("userName") String userName){
        Map<String,String> map = new HashMap();
        return map;
    }

    //删除用户账号
    @DeleteMapping(value = "/deleteuser")
    public Map<String,String> deleteuser(@RequestParam("userName") String userName){
        Map<String,String> map = new HashMap();
        return map;
    }

    //查询所有用户账号信息
    @GetMapping(value = "/listUser")
    public Map<String,String> listUser(@RequestParam("page") String page,
                                        @RequestParam("status") String status){
        Map<String,String> map = new HashMap();
        return map;
    }

    //根据用户名查询用户
    @GetMapping(value = "/getByUserName")
    public Map<String,String> getByUserName(@RequestParam("userName") String userName){
        Map<String,String> map = new HashMap();
        return map;
    }

    //修改用户控件配额信息
    @PutMapping(value = "/updatUserSpace")
    public Map<String,String> updatUserSpace(@RequestParam("userName") String userName,
                                             @RequestParam("applicationSpace") String applicationSpace){
        Map<String,String> map = new HashMap();
        return map;
    }

}
