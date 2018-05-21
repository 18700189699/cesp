package com.uxsino.Netty.socket.test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.nio.CharBuffer;

public class SocketClient {

	/**
	 * 实现对某服务器发送信息，并接收返回数据
	 * 
	 * @param serverIP
	 *            远程服务器
	 * @param port
	 *            远程服务器端口号
	 * @param msg
	 *            要发送的信息
	 * @return
	 */
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
