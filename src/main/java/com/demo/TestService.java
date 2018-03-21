package com.demo;

import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Service;

import com.le.ag.breeze.message.HttpRequestMessageContext;

@Service("wms")
public class TestService {

	private static AtomicInteger i = new AtomicInteger(0);
	//private static int ii = 0;
	
	public String query(HttpRequestMessageContext msgCtx){
		
		String b = msgCtx.getParameter("b");
		String c = msgCtx.getParameter("c");
		i.incrementAndGet();
		System.out.println(i);
		return null;
	}
}
