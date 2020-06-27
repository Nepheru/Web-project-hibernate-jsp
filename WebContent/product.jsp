<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product page</title>
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
  jQuery( document ).ready(function() {
    //Send ajax request for show product list
    jQuery.ajax({
      url: 'rest/product/getAllProducts',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addproduct").click(function() {
      var url = 'rest/product/addProduct/name/' +
        jQuery("#product_name").val() + '/description/' +
        jQuery("#product_description").val();
      //Send ajax request for adding new product
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'PUT',
        success: function(data) {
          //Send ajax request for refresh product list after adding product
          jQuery.ajax({
            url: 'rest/product/getAllProducts',
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#product_name").val('');
              jQuery("#product_description").val('');
            }
          });
        }
      });
    });
  });

  function createDataRowsFromJson(data) {
    var tableContent = "";
    for (var key in data) {
      if (data.hasOwnProperty(key)) {
        tableContent = tableContent + "<tr class='datarow'>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + data[key].id;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + data[key].name;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + data[key].description;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + "<input type='button'onclick=' deleteProduct(" + data[key].id + ")' value='Delete product'/>";
        tableContent = tableContent + "<input type='button' onclick='editProduct(this)' value='Edit product'/>";
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "</tr>";
      }
    }
    return tableContent;
  }

  function deleteProduct(id) {
    var url = 'rest/product/deleteProduct/' + id;
    //Send ajax request for deleting product
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/product/getAllProducts',
          dataType: 'json',
          type: 'GET',
          success: function(data) {
            jQuery('.datarow').remove();
            jQuery('#headerrow').after(createDataRowsFromJson(data));
          }
        });
      }
    });
  }

  function editProduct(button) {
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index == 1){
        jQuery(this).html("<input type='text' id='editname' value='" +
          jQuery(this).text() + "'/>");
      } else if(index == 2){
        jQuery(this).html("<input type='text' id='editdescription' value='" +
          jQuery(this).text() + "'/>");
      } else if (index == 3){
        var actionHtml = "<input type='button' onclick='applyEditProduct(this)' value='Update product'/>"
        actionHtml = actionHtml + "<input type='button' onclick='cancelEdit(this)' value='Cancel edit'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }

  function cancelEdit(button) {
    var id;
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index == 0){
        id = jQuery(this).text();
      } else if(index != 0 && index != 3){
        jQuery(this).html(jQuery(this).find('input').val());	
      } else if (index == 3){
        var actionHtml = "<input type='button' onclick='deleteProduct(" + id + ")' value='Delete product'/>"
        actionHtml = actionHtml + "<input type='button' onclick='editProduct(this)' value='Edit product'/>"
        jQuery(this).html(actionHtml);	
      }
    });
  }

  function applyEditProduct(button){
    var id, name, description;
    jQuery(button).closest('tr').children().each(function(index, value){
      if(index == 0){
        id = jQuery(this).text();
      } else if(index == 1){
        name = jQuery(this).find('input').val();
      } else if (index == 2){
        description = jQuery(this).find('input').val();
      }
    });
    //Send ajax request for upating product
    var url = 'rest/product/updateProduct/id/' + id + '/name/' + name + '/description/' + description;
    jQuery.ajax({
      url: url,
      dataType: 'json',
      type: 'POST',
      success: function(data) {
        jQuery.ajax({
          url: 'rest/product/getAllProducts',
          dataType: 'json',
          type: 'GET',
          success: function(data) {
            jQuery('.datarow').remove();
            jQuery('#headerrow').after(createDataRowsFromJson(data));
          }
        });
      }
    });
  }
</script>
</head>
<body>
  <h1>Product page</h1>
  <table style="width: 100%" border="1" id="product">
    <tr id="headerrow">
      <td>Id</td>
      <td>Name</td>
      <td>Description</td>
      <td>Action</td>
    </tr>
    <tr>
      <td></td>
      <td><input type="text" name="product_name" id="product_name" /></td>
      <td><input type="text" name="product_description"
        id="product_description" /></td>
      <td><input type="button" name="addproduct" id="addproduct"
        value="Add product"></td>
    </tr>
  </table>
</body>
</html>
