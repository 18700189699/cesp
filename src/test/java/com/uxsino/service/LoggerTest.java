package com.uxsino.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LoggerTest {

    private final Logger logger = LoggerFactory.getLogger(LoggerTest.class);

    @Test
    public void test(){
        String name = "swd123";
        String pwd = "123456";
        logger.debug("debug...");
        logger.info("name:"+name+" pwd:"+pwd);
        logger.info("name:{}  pwd:{}",name,pwd);
        logger.error("error...");
        logger.warn("warning....");
    }

}
