package com.uxsino.AgentConsole.bean;

/*
 * 管理员日志表（javaWeb端只是从服务端调取）
 */

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.io.Serializable;

@Entity
public class AdminLog implements Serializable {

    @Id
    @GeneratedValue
    public Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "AdminLog{" +
                "id=" + id +
                '}';
    }
}
