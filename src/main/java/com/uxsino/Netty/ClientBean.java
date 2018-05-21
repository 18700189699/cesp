package com.uxsino.Netty;

import lombok.Data;

@Data
public class ClientBean {

	public String ip;

	public int port;

	public String message;

	public ClientBean(String ip, int port, String message) {
		this.ip = ip;
		this.port = port;
		this.message = message;
	}

	public ClientBean() {
	}
}
