package com.uxsino.Netty.socket;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import net.sf.json.JSONObject;

public class TestNetty {

	public static void test(){
		int offset = 0;
		ByteBufImpl bufImpl = new ByteBufImpl();
		bufImpl.writeByte(1024);
		
		bufImpl.writeBytes(Unpooled.copiedBuffer("abcd".getBytes()), offset);
		offset= offset+ 4;
		bufImpl.writeBytes(Unpooled.copiedBuffer("efgh".getBytes()), offset);
		offset= offset+ 4;
		bufImpl.writeBytes(Unpooled.copiedBuffer("swd".getBytes()), offset);
		System.out.println("bufImpl:"+bufImpl);
		
		JSONObject jsonObject = null;
		String IP = "192.168.0.236";
		int port = 6000;
		String msg = "uxsion信息n信息n信息客户端";
		jsonObject = new JSONObject();
		jsonObject.put("IP", "192.168.0.240");
		jsonObject.put("port", "60000");
		jsonObject.put("msg", "uxsino客户端信息");
		System.out.println(jsonObject);

		String json = "{IP:'192.168.0.240',port:60000,msg:'uxsion'}";
		//System.out.println(ByteOrder.nativeOrder().toString());
		ByteBuf buf = Unpooled.copiedBuffer("abcd".getBytes());
		System.out.println(buf);

		//ClientHandler c = new ClientHandler();

		/*User user = new User();
		Client.sendMessage(jsonObject.getString("IP"), Integer.parseInt(jsonObject.getString("port")),jsonObject.getString("msg"),user);
		String str = user.getUserName();
		System.out.println("返回数据（结束）："+str);*/
	}
	public static void main(String[] args) {
		test();

	}
}
