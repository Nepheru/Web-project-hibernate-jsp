package ua.cn.stu.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import ua.cn.stu.domain.Visitor;
import ua.cn.stu.domain.Waiter;

public class WaiterDAO {

	private Session session;

	public WaiterDAO(Session session) {
		this.session = session;
	}

	/**
	 * This method create new entity
	 */
	public Waiter createWaiter(Waiter waiter) {
		Transaction transaction = session.beginTransaction();
		session.saveOrUpdate(waiter);
		transaction.commit();
		return waiter;
	}

	/**
	 * This method update existing waiter
	 */
	public Waiter updateWaiter(Waiter waiter) {
		Transaction transaction = session.beginTransaction();
		session.merge(waiter);
		transaction.commit();
		return waiter;
	}

	/**
	 * This method delete existing waiter
	 */
	public void deleteWaiter(Waiter waiter) {
		Transaction transaction = session.beginTransaction();
		session.delete(waiter);
		transaction.commit();
	}

	/**
	 * This method remove entity by id
	 */
	public void deleteWaiterById(Long waiterId) {
		Waiter waiter = (Waiter) session.get(Waiter.class, waiterId);
		deleteWaiter(waiter);
	}

	/**
	 * This method return all entities
	 */
	public List<Waiter> getAllWaiter() {
		SQLQuery query = session.createSQLQuery(
				"select * from waiter").addEntity(Waiter.class);
		List<Waiter> waiterList = query.list();
		return waiterList;
	}

	/**
	 * This method return all products by name
	 * This method is specific for waiter domain object
	 *instead of other methods from this class
	 * All other methods can be moved to generic class and
	 *can be used for other domain objects.
	 */
	public List<Waiter> getWaiterByName(String name) {
		Criteria criteria = session.createCriteria(Waiter.class)
				.add(Restrictions.eq("name", name));
		return criteria.list();
	}

	public Waiter getWaiterById(Long waiterId) {
		Waiter waiter = (Waiter) session.get(Waiter.class, waiterId);
		return waiter;
	}

	public List<Visitor> getTop10(Long id){
		Criteria criteria = session.createCriteria(Visitor.class)
				.add(Restrictions.eq("waiter.id", id)).setMaxResults(10)
				.addOrder(Order.desc("name"));
		List<Visitor> awd = criteria.list();
		for (Visitor visitor : awd) {
			System.out.println(visitor.getName());
		}
		return criteria.list();
	}
}
