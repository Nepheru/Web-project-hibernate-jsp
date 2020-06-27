package ua.cn.stu.service;

import java.util.List;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import ua.cn.stu.dao.HibernateDAOFactory;
import ua.cn.stu.domain.Product;
import ua.cn.stu.domain.Visitor;
import ua.cn.stu.domain.Waiter;

@Path("waiter")

public class WaiterService {
	@GET
	@Path("getAllWaiter")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Waiter> getAllWaiter() {
		return HibernateDAOFactory.getInstance().getWaiterDAO().getAllWaiter();
	}

	@PUT
	@Path("addWaiter/name/{waiter_name}/sername/{waiter_sername}")
	public void addWaiter(@PathParam("waiter_name") String waitername,
			@PathParam("waiter_sername") String waitersername) {
		Waiter waiter = new Waiter();
		waiter.setName(waitername);
		waiter.setSername(waitersername);
		System.out.println("Adding waiter");
		HibernateDAOFactory.getInstance().getWaiterDAO().createWaiter(waiter);
		System.out.println("Waited added");
	}

	@DELETE
	@Path("deleteWaiter/{waiter_id}")
	public void deleteWaiter(@PathParam("waiter_id") String waiterid) {
		Long waiterId = Long.parseLong(waiterid);
		System.out.println("Deleting waiter");
		HibernateDAOFactory.getInstance().getWaiterDAO().deleteWaiterById(waiterId);
		System.out.println("Waiter deleted");
	}

	@POST
	@Path("updateWaiter/id/{waiter_id}/name/{waiter_name}/sername/{waiter_sername}")
	public void updateWaiter(@PathParam("waiter_id") String waiterid,
			@PathParam("waiter_name") String waitername,
			@PathParam("waiter_sername") String waitersername) {
		Long waiterId = Long.parseLong(waiterid);
		Waiter waiter = HibernateDAOFactory.getInstance().getWaiterDAO().getWaiterById(waiterId);
		waiter.setName(waitername);
		waiter.setSername(waitersername);
		System.out.println("Updating waiter");
		HibernateDAOFactory.getInstance().getWaiterDAO().updateWaiter(waiter);
		System.out.println("Waiter deleted");
	}
	//visitor jjjj

	@GET
	@Path("getAllVisitor")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Visitor> getAllVisitor() {
		return HibernateDAOFactory.getInstance().getVisitorDAO().getAllVisitor();
	}

	@PUT
	@Path("addVisitor/name/{visitor_name}/sername/{visitor_sername}/waiter/{waiter_id}")
	public void addVisitor(@PathParam("visitor_name") String visitorname,
			@PathParam("visitor_sername") String visitorsername, 
			@PathParam("waiter_id") Long waiterid) {
		Visitor visitor = new Visitor();
		System.out.println(waiterid);
		visitor.setName(visitorname);
		visitor.setSername(visitorsername);
		System.out.println("Receiving waiter id for adding visitor");
		Waiter waiter = HibernateDAOFactory.getInstance().getWaiterDAO().getWaiterById(waiterid);
		System.out.println("Waiter received");
		visitor.setWaiter(waiter);
		System.out.println("Adding visitor");
		HibernateDAOFactory.getInstance().getVisitorDAO().createVisitor(visitor);
		System.out.println("Visitor added");
	}

	@DELETE
	@Path("deleteVisitor/{visitor_id}")
	public void deleteVisitor(@PathParam("visitor_id") String visitorid) {
		Long visitorId = Long.parseLong(visitorid);
		System.out.println("Deleting visitor");
		HibernateDAOFactory.getInstance().getVisitorDAO()
		.deleteVisitorById(visitorId);
		System.out.println("Visitor deleted");
	}

	@POST
	@Path("updateVisitor/id/{visitor_id}/name/{visitor_name}/sername/{visitor_sername}/waiter/{waiter_id}")
	public void updateVisitor(@PathParam("visitor_id") String visitorid,
			@PathParam("visitor_name") String visitorname,
			@PathParam("visitor_sername") String visitorsername,
			@PathParam("waiter_id") String waiterid){
		Long visitorId = Long.parseLong(visitorid);
		Long waiterId = Long.parseLong(waiterid);
		Visitor visitor = HibernateDAOFactory.getInstance().getVisitorDAO().getVisitorById(visitorId);
		visitor.setName(visitorname);
		visitor.setSername(visitorsername);
		System.out.println("Receiving waiter id for updating visitor");
		Waiter waiter = HibernateDAOFactory.getInstance().getWaiterDAO().getWaiterById(waiterId);
		System.out.println("Waiter received");
		visitor.setWaiter(waiter);
		System.out.println("Updating visitor");
		HibernateDAOFactory.getInstance().getVisitorDAO().updateVisitor(visitor);
		System.out.println("Visitor Updated");
	}	  
	@GET
	@Path("getTop10/id/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Visitor> getTopTenVisitors(@PathParam("id") Long Wid) {
		return HibernateDAOFactory.getInstance().getWaiterDAO().getTop10(Wid);
	}

}
