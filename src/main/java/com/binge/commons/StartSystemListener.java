package com.binge.commons;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class StartSystemListener implements ServletContextListener {


    //在服务器启动时，创建Application对象是需要执行的方法
    //同时需要在web.xml文件中配置一下这个监听器
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        //1：将项目上下文路径(request.getContextPath())放置到application域中
        ServletContext servletContext = servletContextEvent.getServletContext();
        String path = servletContext.getContextPath();
        servletContext.setAttribute("APP_PATH", path);
        System.out.println(path);


    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
