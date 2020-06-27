<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Waiter page</title>
<script src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
  jQuery( document ).ready(function() {
    //Send ajax request for show product list
    jQuery.ajax({
      url: 'rest/waiter/getAllWaiter',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        jQuery('#headerrow').after(createDataRowsFromJson(data));
      }
    });
    jQuery( "#addwaiter").click(function() {
      var url = 'rest/waiter/addWaiter/name/' +
        jQuery("#waiter_name").val() + '/sername/' +
        jQuery("#waiter_sername").val();
      //Send ajax request for adding new product
      jQuery.ajax({
        url: url,
        dataType: 'json',
        type: 'PUT',
        success: function(data) {
          //Send ajax request for refresh product list after adding product
          jQuery.ajax({
            url: 'rest/waiter/getAllWaiter',
            dataType: 'json',
            type: 'GET',
            success: function(data) {
              jQuery('.datarow').remove();
              jQuery('#headerrow').after(createDataRowsFromJson(data));
              jQuery("#waiter_name").val('');
              jQuery("#waiter_sername").val('');
            }
          });
        }
      });
    });
  });
  
  jQuery( document ).ready(function() {
	    //Send ajax request for show product list
	    jQuery.ajax({
	      url: 'rest/waiter/getAllVisitor',
	      dataType: 'json',
	      type: 'GET',
	      success: function(data) {
	        jQuery('#headerrow1').after(createDataRowsFromJson1(data));
	      }
	    });
	    jQuery( "#addvisitor").click(function() {
		      console.log("adding visitor");
		      var url = 'rest/waiter/addVisitor/name/' +
		        jQuery("#visitor_name").val() + '/sername/' +
		        jQuery("#visitor_sername").val() + '/waiter/' +
		        jQuery("#waiter_id").val();
		      //Send ajax request for adding new product
	      jQuery.ajax({
	        url: url,
	        dataType: 'json',
	        type: 'PUT',
	        success: function(data) {
	          //Send ajax request for refresh product list after adding product
	          jQuery.ajax({
	            url: 'rest/waiter/getAllVisitor',
	            dataType: 'json',
	            type: 'GET',
	            success: function(data) {
	              jQuery('.datarow1').remove();
	              jQuery('#headerrow1').after(createDataRowsFromJson1(data));
	              jQuery("#visitor_name").val('');
	              jQuery("#visitor_sername").val('');
	              jQuery("#waiter_id").val('');
	            }
	          });
	        }
	      });
	    });
	  });
  
  function createCustomDataRowsFromJson(data,data1) {
	    var tableContent = "";
		 for (var key in data) {
		 if (data.hasOwnProperty(key)) {
		        tableContent = tableContent + "<tr class='datarow3'>";
		        tableContent = tableContent + "<td>";
		        tableContent = tableContent + data[key].id;
		        tableContent = tableContent + "</td>";
		        tableContent = tableContent + "<td>";
		        tableContent = tableContent + data[key].name;
		        tableContent = tableContent + "</td>";
		        tableContent = tableContent + "<td>";
		        tableContent = tableContent + data[key].sername;
		        tableContent = tableContent + "</td>";
		        tableContent = tableContent + "<td>";
		        tableContent = tableContent + "<input type='button' onclick='deleteWaiter(" + data[key].id + ")' value='Delete waiter'/>";
		        tableContent = tableContent + "<input type='button' onclick='editWaiter(this)' value='Edit waiter'/>";
		        tableContent = tableContent + "<input type='button' onclick='getTop10Visitors(" + data[key].id + ")' value='Get top 10 visitors'/>";
		        tableContent = tableContent + "</td>";
		        tableContent = tableContent + "<td>";
		        	for (var key1 in data1) {
		        		if(data[key].id == data1[key1].waiter.id)
		        		tableContent = tableContent + data1[key1].name + " ";
		        	}
		        tableContent = tableContent + "</td>";
		        tableContent = tableContent + "</tr>";
		 	}
		 }
		 return tableContent;
}
  
  function createDataRowsFromJson(data) {
	  jQuery('.datarow3').remove();
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
        tableContent = tableContent + data[key].sername;
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + "<input type='button' onclick='deleteWaiter(" + data[key].id + ")' value='Delete waiter'/>";
        tableContent = tableContent + "<input type='button' onclick='editWaiter(this)' value='Edit waiter'/>";
        tableContent = tableContent + "<input type='button' onclick='getTop10Visitors(" + data[key].id + ")' value='Get top 10 visitors'/>";
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "<td>";
        tableContent = tableContent + "</td>";
        tableContent = tableContent + "</tr>";
      }
    }
    return tableContent;
  }

	function getTop10Visitors(id) {
		var url = 'rest/waiter/getTop10/id/' + id;		
		jQuery.ajax({
			url : url,
			dataType : 'json',
			type : 'GET',
			success : function(data) {
				jQuery.ajax({
					url : 'rest/waiter/getAllWaiter',
					dataType : 'json',
					type : 'GET',
					success : function(data1) {
						jQuery('.datarow3').remove();
						jQuery('.datarow').remove();
						jQuery('#headerrow').after(createCustomDataRowsFromJson(data1,data));
					}
				});
				
			}
		});
	}

	function createDataRowsFromJson1(data) {
		var tableContent = "";
		for ( var key in data) {
			if (data.hasOwnProperty(key)) {
				tableContent = tableContent + "<tr class='datarow1'>";
				tableContent = tableContent + "<td>";
				tableContent = tableContent + data[key].id;
				tableContent = tableContent + "</td>";
				tableContent = tableContent + "<td>";
				tableContent = tableContent + data[key].name;
				tableContent = tableContent + "</td>";
				tableContent = tableContent + "<td>";
				tableContent = tableContent + data[key].sername;
				tableContent = tableContent + "</td>";
				tableContent = tableContent + "<td>";
				tableContent = tableContent + data[key].waiter.id;
				tableContent = tableContent + "</td>";
				tableContent = tableContent + "<td>";
				tableContent = tableContent
						+ "<input type='button'onclick=' deleteVisitor("
						+ data[key].id + ")' value='Delete visitor'/>";
				tableContent = tableContent
						+ "<input type='button' onclick='editVisitor(this)' value='Edit visitor'/>";
				tableContent = tableContent + "</td>";
				tableContent = tableContent + "</tr>";
			}
		}
		return tableContent;
	}

	function deleteWaiter(id) {
		var url = 'rest/waiter/deleteWaiter/' + id;
		//Send ajax request for deleting product
		jQuery.ajax({
			url : url,
			dataType : 'json',
			type : 'DELETE',
			success : function(data) {
				jQuery.ajax({
					url : 'rest/waiter/getAllWaiter',
					dataType : 'json',
					type : 'GET',
					success : function(data) {
						jQuery('.datarow').remove();
						jQuery('#headerrow').after(createDataRowsFromJson(data));
					}
				});
			}
		});
	}

	function deleteVisitor(id) {
		var url = 'rest/waiter/deleteVisitor/' + id;
		//Send ajax request for deleting product
		jQuery.ajax({
			url : url,
			dataType : 'json',
			type : 'DELETE',
			success : function(data) {
				jQuery.ajax({
					url : 'rest/waiter/getAllVisitor',
					dataType : 'json',
					type : 'GET',
					success : function(data) {
						jQuery('.datarow1').remove();
						jQuery('#headerrow1').after(
								createDataRowsFromJson1(data));
					}
				});
			}
		});
	}

	function editWaiter(button) {
		jQuery(button)
				.closest('tr')
				.children()
				.each(
						function(index, value) {
							if (index == 1) {
								jQuery(this).html(
										"<input type='text' id='editname' value='"
												+ jQuery(this).text() + "'/>");
							} else if (index == 2) {
								jQuery(this).html(
										"<input type='text' id='editsername' value='"
												+ jQuery(this).text() + "'/>");
							} else if (index == 3) {
								var actionHtml = "<input type='button' onclick='applyEditWaiter(this)' value='Update waiter'/>"
								actionHtml = actionHtml
										+ "<input type='button' onclick='cancelEditW(this)' value='Cancel edit'/>"
								jQuery(this).html(actionHtml);
							}
						});
	}

	function editVisitor(button) {
		jQuery(button)
				.closest('tr')
				.children()
				.each(
						function(index, value) {
							if (index == 1) {
								jQuery(this).html(
										"<input type='text' id='editname' value='"
												+ jQuery(this).text() + "'/>");
							} else if (index == 2) {
								jQuery(this).html(
										"<input type='text' id='editsername' value='"
												+ jQuery(this).text() + "'/>");
							} else if (index == 3) {
								jQuery(this).html(
										"<input type='text' id='editwaiterid' value='"
												+ jQuery(this).text() + "'/>");
							} else if (index == 4) {
								var actionHtml = "<input type='button' onclick='applyEditVisitor(this)' value='Update visitor'/>"
								actionHtml = actionHtml
										+ "<input type='button' onclick='cancelEditV(this)' value='Cancel edit'/>"
								jQuery(this).html(actionHtml);
							}
						});
	}

	function cancelEditW(button) {
		var id;
		jQuery(button)
				.closest('tr')
				.children()
				.each(
						function(index, value) {
							if (index == 0) {
								id = jQuery(this).text();
							} else if (index != 0 && index != 3) {
								jQuery(this).html(
										jQuery(this).find('input').val());
							} else if (index == 3) {
								var actionHtml = "<input type='button' onclick='deleteWaiter("
										+ id + ")' value='Delete waiter'/>"
								actionHtml = actionHtml
										+ "<input type='button' onclick='editWaiter(this)' value='Edit waiter'/>"
								jQuery(this).html(actionHtml);
							}
						});
	}

	function cancelEditV(button) {
		var id;
		jQuery(button)
				.closest('tr')
				.children()
				.each(
						function(index, value) {
							if (index == 0) {
								id = jQuery(this).text();
							} else if (index != 0 && index != 4) {
								jQuery(this).html(
										jQuery(this).find('input').val());
							} else if (index == 4) {//weda
								var actionHtml = "<input type='button' onclick='deleteVisitor("
										+ id + ")' value='Delete visitor'/>"
								actionHtml = actionHtml
										+ "<input type='button' onclick='editVisitor(this)' value='Edit visitor'/>"
								jQuery(this).html(actionHtml);
							}
						});
	}
	function applyEditWaiter(button) {
		var id, name, sername;
		jQuery(button).closest('tr').children().each(function(index, value) {
			if (index == 0) {
				id = jQuery(this).text();
			} else if (index == 1) {
				name = jQuery(this).find('input').val();
			} else if (index == 2) {
				sername = jQuery(this).find('input').val();
			}
		});
		//Send ajax request for upating product
		var url = 'rest/waiter/updateWaiter/id/' + id + '/name/' + name
				+ '/sername/' + sername;
		jQuery.ajax({
			url : url,
			dataType : 'json',
			type : 'POST',
			success : function(data) {
				jQuery.ajax({
					url : 'rest/waiter/getAllWaiter',
					dataType : 'json',
					type : 'GET',
					success : function(data) {
						jQuery('.datarow').remove();
						jQuery('#headerrow')
								.after(createDataRowsFromJson(data));
					}
				});
			}
		});
	}

	function applyEditVisitor(button) {
		var id, name, sername, waiter;
		jQuery(button).closest('tr').children().each(function(index, value) {
			if (index == 0) {
				id = jQuery(this).text();
			} else if (index == 1) {
				name = jQuery(this).find('input').val();
			} else if (index == 2) {
				sername = jQuery(this).find('input').val();
			} else if (index == 3) {
				waiter = jQuery(this).find('input').val();
			}
		});

		//Send ajax request for upating product
		var url = 'rest/waiter/updateVisitor/id/' + id + '/name/' + name
				+ '/sername/' + sername + '/waiter/' + waiter;
		jQuery.ajax({
			url : url,
			dataType : 'json',
			type : 'POST',
			success : function(data) {
				jQuery.ajax({
					url : 'rest/waiter/getAllVisitor',
					dataType : 'json',
					type : 'GET',
					success : function(data) {
						jQuery('.datarow1').remove();
						jQuery('#headerrow1').after(
								createDataRowsFromJson1(data));
					}
				});
			}
		});
	}
</script>
</head>
<body>
	<h1>Waiter page</h1>
	<table style="width: 100%" border="1" id="waiter">
		<tr id="headerrow">
			<td>Id</td>
			<td>Name</td>
			<td>Sername</td>
			<td>Action</td>
			<td>ShowedTop</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" name="waiter_name" id="waiter_name" /></td>
			<td><input type="text" name="waiter_sername" id="waiter_sername" /></td>
			<td><input type="button" name="addwaiter" id="addwaiter"
				value="Add waiter"></td>
		</tr>
	</table>

	<h1>Visitor page</h1>
	<table style="width: 100%" border="1" id="visitor">
		<tr id="headerrow1">
			<td>Id</td>
			<td>Name</td>
			<td>Sername</td>
			<td>Waiter id</td>
			<td>Action</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" name="visitor_name" id="visitor_name" /></td>
			<td><input type="text" name="visitor_sername"
				id="visitor_sername" /></td>
			<td><input type="text" name="visitor_waiter_id" id="waiter_id" /></td>
			<td><input type="button" name="addvisitor" id="addvisitor"
				value="Add visitor"></td>
		</tr>
	</table>

</body>
</html>
