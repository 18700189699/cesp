package com.uxsino.Netty.socket.test;

import io.netty.buffer.ByteBuf;

import java.io.*;
import java.net.Socket;

public class TestClient {

	public final  long FRAGMENT_SIZE=1024;
	public final long  FRAGMENT_HEAD_SIZE =12;
	public final long MSG_CONNECT_INIT =13;
	public final long MSG_XML_DATA= 1;
	public final long MSG_MAX_BUF_LEN =(1024*10);

	//TLV 发送数据的类型和长度、内容
	class ComprotoT{
		public char type1;
		public int  len;                  /*总长度*/
		public ByteBuf[] buf;			/*消息数据*/
	}

	//发包数据及大小
	class FragmentT{
		public int cur_frag;
		public int total_frag;
		public int seq;
	}

	Socket zSockFd;
	public static int g_cur_seq = 0;
	public long m_nMsgNumber;

	//数组copy方法
	int bcopy(String src,ByteBuf dest,int len)
	{
		return 0;
	}

	//
	public static String sendMessage(String serverIP, int port, String msg) {
		String retv = "";
		try {
			Socket socket = new Socket(serverIP, port);
			InputStream is = socket.getInputStream();
			OutputStream os = socket.getOutputStream();
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
			bw.write(msg);
			bw.flush();

			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			while (!br.ready()) {
				try {
					Thread.currentThread().sleep(100);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			while (br.ready()) {
				char[] cb = new char[500];
				int len = br.read(cb);
				retv += String.copyValueOf(cb, 0, len);
				try {
					if(!br.ready())
						Thread.currentThread().sleep(100);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			is.close();
			os.close();
			br.close();
			socket.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return retv;
	}



}
