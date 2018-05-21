package com.uxsino.AgentConsole.dao;

import com.uxsino.AgentConsole.bean.AdminLog;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AdminLogDaoTest {

    @Autowired
    private AdminLogDao adminLogDao;

    @Test
    public void findOneTest(){
        AdminLog adminLog = adminLogDao.findOne(1);
        System.out.println(adminLog);
    }

    @Test
    public void saveTest(){
        AdminLog adminLog = adminLogDao.findOne(1);
        System.out.println(adminLog);
    }
}