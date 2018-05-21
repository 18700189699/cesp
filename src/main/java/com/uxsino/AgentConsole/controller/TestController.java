package com.uxsino.AgentConsole.controller;

import com.uxsino.AgentConsole.bean.Role;
import com.uxsino.AgentConsole.bean.UserLog;
import com.uxsino.AgentConsole.service.AuditServiceImpl;
import com.uxsino.AgentConsole.service.SystemAdminServiceImpl;
import com.uxsino.Netty.socket.ByteBufImpl;
import com.uxsino.Netty.socket.Client;
import com.uxsino.Netty.socket.TestNetty;
import com.uxsino.Netty.socket.User;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 测试到页面的方法
 * @author admin
 *
 */

@Controller
public class TestController {

	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private AuditServiceImpl auditServiceImpl;

	@RequestMapping(value="/hello",method=RequestMethod.GET)
	public String hello(HttpServletRequest request){
        //TestNetty.test();
		List<UserLog> list = auditServiceImpl.findUserLog();
		Map map = new HashMap();
		map.put("map1",list);
		request.getSession().setAttribute("return",map);
		return "FtC0m11_JS/success";
	}

	@RequestMapping(value="/login2",method=RequestMethod.GET)
    @ResponseBody
	public List<String> login2( Model model, HttpServletRequest request, HttpServletResponse response){
		List<String> result = new ArrayList<String>();
		result.add("fail");
	    return result;
	}

	@RequestMapping("/index")
	@ResponseBody
	public Map<String,String> index(){
		Map<String,String> hashMap = new HashMap<>();
		hashMap.put("msg", "登录成功");

		return hashMap;
	}

	@Autowired
	private SystemAdminServiceImpl systemAdminServiceImpl;
	@RequestMapping(value="/rolelog")
	@ResponseBody
	public ModelAndView roleAdd(@RequestParam("accountname") String accountname,
								@RequestParam("accountRole") String accountRole){
		Role role = new Role();
		role.setAccountName(accountname);
		role.setAccountRole(accountRole);

		ModelAndView model = new ModelAndView("/success/hello2");
		model.addObject("role",role);
		model.addObject("message","登录成功");
		return model;
	}

	@RequestMapping(value="/hello2",method=RequestMethod.GET)
	public String hello2(){
		return "success";
	}

	@RequestMapping(value="/index1")
	public ModelAndView index(ModelAndView view) {
		view.setViewName("FtC0m11_JS/success");
		return view;
	}

	Client client = new Client();
	User user = new User();
	@RequestMapping(value="/index2")
	@ResponseBody
	public String index1() {

		char[] helloArray = { 1, 0, 0, 0, 1,0, 0, 0, 0, 0, 0,0,13,8, 0, 0, 0};
		String str1 = String.valueOf(helloArray );
		String str9 = "";
		StringBuffer str2 = new StringBuffer(str1);
		/*StringBuffer sb = new StringBuffer();
		sb = str.*/
		str2 = str2.append("scnouser");
		String str = str2.toString();
		System.out.println(str);

		char[] chars = new char[1036];
		//将消息头部信息放入到char数组中
		for(int i=0;i<str.length();i++)
		{
			chars[i]=str.charAt(i);
		}
		String msg = String.valueOf(chars );

		client.sendMessage("192.168.0.201",3580,msg,user);


		String res = user.getUserName();
		System.out.println(res);
		return res;
	}

}
