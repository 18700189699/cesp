package com.uxsino.Netty.socket;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.ReferenceCountUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.TimeUnit;

public class ClientHandler extends ChannelInboundHandlerAdapter{

	private static final Logger LOGGER = LoggerFactory.getLogger(ClientHandler.class);
	private User user;

	public ClientHandler(User user) {
		this.user = user;
	}

	public ClientHandler() {
	}
	/**
	 * 接收服务端通信的核心代码，通过二进制ByteBuf
	 */
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		String str = "";
		try {
			ByteBuf buf = (ByteBuf) msg;
			byte[] date = new byte[buf.readableBytes()];
			buf.readBytes(date);
			str = new String(date, "utf-8");
			System.out.println("服务端返回的内容："+str);
			if (str!=null){
				user.setUserName(str);
				//ctx.close();
				LOGGER.info("系统退出");
			}else{

			}
			//strRsponse = new String(date, "utf-8");
			//System.out.println(strRsponse.length());
			//String head = strRsponse.substring(0, 6);
			//System.out.println(head);

			//超时处理
			//TimeUnit.SECONDS.sleep(5);

		} finally {
            ReferenceCountUtil.release(msg);
        }
		LOGGER.info("--- [Now is] {}", str);
	}

	/**
	 * 当出现异常时调用
	 */
	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
		cause.printStackTrace();
        ctx.close();
        System.out.println("异常退出:" + cause.getMessage());
	}
	
	/**
	 * channel 通道 Inactive 不活跃的
	 * 当客户端主动断开服务端的链接的，这个通道就是不活跃的。也就是说客户端与服务端的关闭了通信通道并且不可以传输数据
	 */
	@Override
	public void channelInactive(ChannelHandlerContext ctx) throws Exception {
        System.out.println("客户端与服务端通道-关闭：" + ctx.channel().localAddress() + "channelInactive");
	}
	
}
