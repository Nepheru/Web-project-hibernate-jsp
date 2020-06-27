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

@Path("product")

public class ProductService {
	@GET
	  @Path("getAllProducts")
	  @Produces(MediaType.APPLICATION_JSON)
	  public List<Product> getAllProducts() {
	    return HibernateDAOFactory.getInstance().getProductDAO().getAllProducts();
	  }

	  @PUT
	  @Path("addProduct/name/{product_name}/description/{product_description}")
	  public void addProduct(@PathParam("product_name") String productname,
	    @PathParam("product_description") String productdescription) {
	    Product product = new Product();
	    product.setName(productname);
	    product.setDescription(productdescription);
	    HibernateDAOFactory.getInstance().getProductDAO().createProduct(product);
	  }

	  @DELETE
	  @Path("deleteProduct/{product_id}")
	  public void deleteProduct(@PathParam("product_id") String productid) {
	    Long productId = Long.parseLong(productid);
	    HibernateDAOFactory.getInstance().getProductDAO()
	      .deleteProductById(productId);
	  }

	  @POST
	  @Path("updateProduct/id/{product_id}/name/{product_name}/description/{product_description}")
	  public void updateProduct(@PathParam("product_id") String productid,
	    @PathParam("product_name") String productname,
	    @PathParam("product_description") String productdescription) {
	    Long productId = Long.parseLong(productid);
	    Product product = HibernateDAOFactory.getInstance().getProductDAO()
	      .getProductById(productId);
	    product.setName(productname);
	    product.setDescription(productdescription);
	    HibernateDAOFactory.getInstance().getProductDAO().updateProduct(product);
	  }
}
