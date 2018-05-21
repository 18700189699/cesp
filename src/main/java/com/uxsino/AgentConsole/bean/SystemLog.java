package com.uxsino.AgentConsole.bean;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/*
 * 系统日志表（javaWeb端只是从服务端调取）
 */
@Entity
public class SystemLog {

	@Id
    @GeneratedValue
    public String id;
}
