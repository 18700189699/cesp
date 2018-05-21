package com.uxsino.Netty.socket;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;

/**
 * Netty通讯方法
 * @author admin
 *
 */
public class Client {

	public static void sendMessage(String serverIP,int port,String msg,User user){
		//workerGroup负责读写数据
		EventLoopGroup workerGroup = new NioEventLoopGroup();
		ClientHandler client = new ClientHandler(user);

		try {
			//辅助启动类
			Bootstrap bootstrap = new Bootstrap();
			//注册线程池
	        bootstrap.group(workerGroup)  
	                 .channel(NioSocketChannel.class)  // 使用NioSocketChannel来作为连接用的channel类
	                 .handler(new ChannelInitializer<SocketChannel>() {  //设置管道
	                    @Override  
	                    protected void initChannel(SocketChannel socketChannel) throws Exception {
	                    	//获取管道
	                        ChannelPipeline pipeline = socketChannel.pipeline();
	                    	
	                        //pipeline.addLast(new StringEncoder(CharsetUtil.UTF_16BE));
	                        //处理类

	                        pipeline.addLast(client);
	                    }
	                });  
	        ChannelFuture future;
	        //异步连接服务器
	        future = bootstrap.connect(serverIP, port).sync();
	        //System.out.println("服务器连接成功");
	        
	        //将数据写入到buffer缓冲区中
	        future.channel().writeAndFlush(Unpooled.copiedBuffer(msg.getBytes()));

	        future.channel().closeFuture().sync();
	        System.out.println("连接已关闭");
	        
	        //退出并释放NIO线程组
	        workerGroup.shutdownGracefully();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
	}
	
	
	
}
