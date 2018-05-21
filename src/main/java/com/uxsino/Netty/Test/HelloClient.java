package com.uxsino.Netty.Test;

import io.netty.bootstrap.Bootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;

public class HelloClient {

	private Channel channel;

	public void connect(String host, int port) throws Exception {
		EventLoopGroup workerGroup = new NioEventLoopGroup();

		try {
			Bootstrap b = new Bootstrap();
			b.group(workerGroup);
			b.channel(NioSocketChannel.class);
			b.option(ChannelOption.SO_KEEPALIVE, true);
			b.handler(new ChannelInitializer<SocketChannel>() {
				@Override
				public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline().addLast(new HelloClientIntHandler());
				}
			});

			// Start the client.
			ChannelFuture f = b.connect(host, port).sync();
			//channel =f.channel();


			// Wait until the connection is closed.
			f.channel().closeFuture().sync();
			//channel.close();
		} finally {
			workerGroup.shutdownGracefully();
		}

	}

	public static void main(String[] args) throws Exception {
		HelloClient client = new HelloClient();
		client.connect("192.168.0.201", 3580);
		//Channel channel = client.channel;
		//HelloClientIntHandler handler = channel.pipeline().get(HelloClientIntHandler.class);
		//handler.sendMsg("hello server");


	}
}
