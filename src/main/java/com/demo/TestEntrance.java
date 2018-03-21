package com.demo;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.le.ag.breeze.server.facade.BreezeServerFacade;

public class TestEntrance extends BreezeServerFacade{

	public static void main(String[] args) {
		TestEntrance entrance = new TestEntrance();
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
		SpringUtils.setApplicationContext(ctx);
		entrance.startup(7040);
	}
	
}
