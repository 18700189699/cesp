package com.uxsino.AgentConsole.bean;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/*
 * 角色表（账号管理表）
 */
@Entity
@Data
public class Role {

	@Id
	@GeneratedValue
	public Integer accountId;

	public String accountName;

	public String accountRole;

	public String way;

	public String Status;

	public String Certificate;


}
