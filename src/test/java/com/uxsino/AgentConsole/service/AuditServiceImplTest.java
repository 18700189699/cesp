package com.uxsino.AgentConsole.service;

import com.uxsino.AgentConsole.bean.SystemLog;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AuditServiceImplTest {

    @Autowired
    private AuditServiceImpl auditService;

    @Test
    public void findByPNameNot() {
        PageRequest request = new PageRequest(0,1);
        Page<SystemLog> systemLogs = auditService.findByPNameNot(request);
        System.out.println(systemLogs.getTotalElements());
    }
}