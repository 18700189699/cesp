package com.uxsino.Netty.Test;

import io.netty.buffer.ByteBuf;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

import io.netty.channel.SimpleChannelInboundHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class HelloClientIntHandler extends SimpleChannelInboundHandler<RequestInfo> {
	private static Logger logger = LoggerFactory.getLogger(HelloClientIntHandler.class);

	// Stateful properties
	private volatile Channel channel;
	private final BlockingQueue<RequestInfo> answer = new LinkedBlockingQueue<RequestInfo>();

	public HelloClientIntHandler() {
		super(false);
	}

	// 接收server端的消息，并打印出来
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		logger.info("HelloClientIntHandler.channelRead");
		ByteBuf result = (ByteBuf) msg;
		byte[] result1 = new byte[result.readableBytes()];
		result.readBytes(result1);
		System.out.println("Server said:" + new String(result1));
		result.release();
	}

	// 连接成功后，向server发送消息
	public String sendMsg(String msg) {
		channel.writeAndFlush(msg);
		return "发送成功";
	}


	/*@Override
	public void channelActive(ChannelHandlerContext ctx) throws Exception {
		logger.info("HelloClientIntHandler.channelActive");
		String msg = "Are you ok?";
		ByteBuf encoded = ctx.alloc().buffer(4 * msg.length());

		encoded.writeBytes(msg.getBytes());
		ctx.write(encoded);
		ctx.flush();
	}*/

	@Override
	public void channelRegistered(ChannelHandlerContext ctx) {
		channel = ctx.channel();
	}

	@Override
	protected void channelRead0(ChannelHandlerContext ctx, RequestInfo msg) throws Exception {
		answer.add(msg);
	}

	//异常
	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
		cause.printStackTrace();
		ctx.close();
	}
}
