package ua.cn.stu.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import ua.cn.stu.domain.Visitor;

public class VisitorDAO {

	private Session session;

	public VisitorDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public Visitor createVisitor(Visitor visitor) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(visitor);
		transaction.commit();
		return visitor;
	}

	/**
	 * This method update existing product
	 */
	public Visitor updateVisitor(Visitor visitor) {
		Transaction transaction = session.beginTransaction();
		session.merge(visitor);
		transaction.commit();
		return visitor;
	}

	/**
	 * This method delete existing product
	 */
	public void deleteVisitor(Visitor visitor) {
		Transaction transaction = session.beginTransaction();
		session.delete(visitor);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteVisitorById(Long visitorId) {
		Visitor visitor = (Visitor) session.get(Visitor.class, visitorId);
		deleteVisitor(visitor);
	}

	/**
	 * This method return all entities
	 */
	public List<Visitor> getAllVisitor() {
		SQLQuery query = session.createSQLQuery(
				"select * from visitor").addEntity(Visitor.class);
		List<Visitor> visitorList = query.list();
		return visitorList;
	}

	/**
	 * This method return all products by name
	 * This method is specific for Product domain object
	 *instead of other methods from this class
	 * All other methods can be moved to generic class and
	 *can be used for other domain objects.
	 */
	public List<Visitor> getVisitorByName(String name) {
		Criteria criteria = session.createCriteria(Visitor.class)
				.add(Restrictions.eq("name", name));
		return criteria.list();
	}

	public List<Visitor> getTopFromMany() {
		
		String sql = "select * from visitor order by visitor_name limit 3";
		SQLQuery query = session.createSQLQuery(sql);
		query.addEntity(Visitor.class);
		List<Visitor> results = query.list();
		return results;
		
		/*
		SQLQuery query = session.createSQLQuery(
				"select * from visitor order by visitor_name desc limit 2").addEntity(Visitor.class);
		List<Visitor> visitorList = query.list();
		return visitorList;
		*/
	}
	public Visitor getVisitorById(Long visitorId) {
		Visitor visitor = (Visitor) session.get(Visitor.class, visitorId);
		return visitor;
	}
	


}
