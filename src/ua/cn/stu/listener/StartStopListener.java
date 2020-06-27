package ua.cn.stu.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import ua.cn.stu.dao.HibernateDAOFactory;

public class StartStopListener implements ServletContextListener{
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		HibernateDAOFactory.getInstance().getSession();
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		HibernateDAOFactory.getInstance().closeSession();
	}
}
