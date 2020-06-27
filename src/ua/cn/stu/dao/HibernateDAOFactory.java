package ua.cn.stu.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import ua.cn.stu.domain.Product;
import ua.cn.stu.domain.Visitor;
import ua.cn.stu.domain.Waiter;

public class HibernateDAOFactory {
	private static HibernateDAOFactory instance;

	private VisitorDAO visitorDAO;
	private WaiterDAO waiterDAO;
	private ProductDAO productDAO;
	private Session session;

	//Ініціалізація синглетону
	public static HibernateDAOFactory getInstance() {
		if (null == instance) {
			instance = new HibernateDAOFactory();
		}
		return instance;
	}

	//Створення обєкта Session для взаємодії з Hibernate
	public Session getSession() {
		if (null == session) {
			Configuration configuration = new Configuration();
			configuration.setProperty(Environment.DRIVER, "org.postgresql.Driver");
			configuration.setProperty(Environment.URL,
					"jdbc:postgresql://localhost:5432/shop");
			configuration.setProperty(Environment.USER, "postgres");
			configuration.setProperty(Environment.PASS, "4321");
			configuration.setProperty(Environment.DIALECT, 
					"org.hibernate.dialect.PostgreSQLDialect");
			configuration.setProperty(Environment.HBM2DDL_AUTO, "create");
			configuration.setProperty(Environment.SHOW_SQL, "true");
			configuration.addAnnotatedClass(Product.class);
			configuration.addAnnotatedClass(Waiter.class);
			configuration.addAnnotatedClass(Visitor.class);
			StandardServiceRegistryBuilder serviceRegistryBuilder = 
					new StandardServiceRegistryBuilder();
			serviceRegistryBuilder.applySettings(configuration.getProperties());
			ServiceRegistry serviceRegistry = serviceRegistryBuilder.build();
			SessionFactory sessionFactory =
					configuration.buildSessionFactory(serviceRegistry);
			session = sessionFactory.openSession();
		}
		return session;
	}

	public ProductDAO getProductDAO() {
		if (null == productDAO) {
			productDAO = new ProductDAO(getSession());
		}
		return productDAO;
	}

	public WaiterDAO getWaiterDAO() {
		if (null == waiterDAO) {
			waiterDAO = new WaiterDAO(getSession());
		}
		return waiterDAO;
	}
	
	public VisitorDAO getVisitorDAO() {
		if (null == visitorDAO) {
			visitorDAO = new VisitorDAO(getSession());
		}
		return visitorDAO;
	}

	public void closeSession() {
		getSession().close();
	}

}
