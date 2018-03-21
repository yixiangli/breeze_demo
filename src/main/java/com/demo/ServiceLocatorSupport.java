package com.demo;

import com.le.ag.breeze.connector.processor.ServiceLocator;

public class ServiceLocatorSupport implements ServiceLocator {

	public Object getService(String serviceName) {
		// TODO Auto-generated method stub
		try {
			return SpringUtils.getBean(serviceName);
		} catch (Exception ex) {
			//logger.error("getService error. ", ex);
			System.out.println("error");
		}
		return null;
	}

}
