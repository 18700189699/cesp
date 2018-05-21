package com.uxsino.AgentConsole.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.uxsino.AgentConsole.bean.AdminLog;
import com.uxsino.AgentConsole.bean.SystemLog;
import com.uxsino.AgentConsole.bean.UserLog;
import com.uxsino.AgentConsole.service.AuditServiceImpl;

import javax.servlet.http.HttpServletRequest;

/**
 * 系统审计员
 * 查询日志相关操作
 * @author admin
 * 包括：
 *  1.审计日志
 *  2.日志查询
 */
@RestController
public class AuditController {

	@Autowired
	private AuditServiceImpl auditServiceImpl;
	
	//查询所有用户日志信息
	@GetMapping(value="/queryUserLog")
	public Map queryUserLog(HttpServletRequest request){
		List<UserLog> list = auditServiceImpl.findUserLog();
		Map map = new HashMap();
		map.put("map1",list);
		request.getSession().setAttribute("listUserLog",list);
		return map;
	}
	
	//查询所有系统日志信息
	@GetMapping(value="/querySystemLog")
	public List<SystemLog> querySystemLog(HttpServletRequest request){
		//request.getSession().getAttribute()
		return auditServiceImpl.findSystemLog();
	}

	//查询所有管理员日志信息
	@GetMapping(value="/queryAdminLog")
	public List<AdminLog> queryAdminLog(){
		return auditServiceImpl.findAdminLog();
	}

	//根据条件查询用户日志信息
    @GetMapping(value="/queryUserLogAnd")
    public Map<String,String> listUser(@RequestParam("page") String page,
                                       @RequestParam("startTime") String startTime,
                                       @RequestParam("endTime") String endTime,
                                       @RequestParam("computerIP") String computerIP,
                                       @RequestParam("userName") String userName,
                                       @RequestParam("type") String type){
        Map<String,String> map = new HashMap();
        return map;
    }

    //根据条件查询管理员日志信息
    @GetMapping(value="/queryAdminLogAnd")
    public Map<String,String> queryAdminLogAnd(@RequestParam("page") String page,
                                       @RequestParam("startTime") String startTime,
                                       @RequestParam("endTime") String endTime,
                                       @RequestParam("computerIP") String computerIP,
                                       @RequestParam("userName") String userName,
                                       @RequestParam("type") String type){
        Map<String,String> map = new HashMap();
        return map;
    }

    //根据条件查询系统日志信息
    @GetMapping(value="/querySystemLogAnd")
    public Map<String,String> querySystemLogAnd(@RequestParam("page") String page,
                                       @RequestParam("startTime") String startTime,
                                       @RequestParam("endTime") String endTime,
                                       @RequestParam("computerIP") String computerIP,
                                       @RequestParam("userName") String userName,
                                       @RequestParam("type") String type){
        Map<String,String> map = new HashMap();
        return map;
    }

}
