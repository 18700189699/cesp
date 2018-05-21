package com.uxsino.AgentConsole.bean;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/*
 * 用户表
 */

@Entity
@Data
public class Users {

	@Id
    @GeneratedValue
    public Integer id;

	//@Column(nullable = false, unique = true)
	public String status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
