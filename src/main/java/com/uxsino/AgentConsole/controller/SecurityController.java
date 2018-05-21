package com.uxsino.AgentConsole.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.uxsino.AgentConsole.bean.Users;
import com.uxsino.AgentConsole.service.SecurityServiceImpl;

/**
 * 系统安全员controller
 * @author admin
 * 包括：
 *  1.用户账号审批
 *  2.账号审批设置
 *  3.应急恢复任务管理
 */
@RestController
@RequestMapping(value = "/security")
public class SecurityController {

	@Autowired
	private SecurityServiceImpl securityServiceImpl;

	//审批用户状态（拒绝、等待系统管理员审批通过）
	@GetMapping(value="/updateUserStatus")
	public Map<String,String> updateUserStatus(@RequestParam("userName") String userName,
										 		@RequestParam("status") String statuse){
		Map<String,String> map = new HashMap();
		return map;
	}

	//修改用户名和用户部门信息
	@PutMapping(value = "/updatUser")
	public Map<String,String> updatUser(@RequestParam("userName") String userName,
										 @RequestParam("dept") String dept){
		Map<String,String> map = new HashMap();
		return map;
	}

	//通过用户名查询用户信息
	@GetMapping(value = "/getByUserName")
	public Map<String,String> getByUserName(@RequestParam("userName") String userName){
		Map<String,String> map = new HashMap();
		return map;
	}

	//根据用户状态分页显示所有用户信息
	@GetMapping(value = "/listUser")
	public Map<String,String> listUser(@RequestParam("page") String page,
									    @RequestParam("status") String statuse){
		Map<String,String> map = new HashMap();
		return map;
	}

}
