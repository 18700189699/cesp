package com.uxsino.AgentConsole.bean;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/*
 * 用户日志表（javaWeb端只是从服务端调取）
 */

@Entity
@Data
public class UserLog {

	@Id
    @GeneratedValue
    public Integer id;

	public String name;
}
