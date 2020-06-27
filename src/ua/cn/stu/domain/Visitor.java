package ua.cn.stu.domain;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import ua.cn.stu.domain.Waiter;

@Entity
@Table(name = "visitor")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Visitor {

	public Visitor() {
	}
	/*
	public Visitor(String name, String sername,Long id) {
		this.name = name;
		this.sername = sername;
		//this.waiter_id = id;
	}
	*/
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private Long id;

	//******
	/*
	@Column(name = "waiter_id")
	private Long waiter_id;
	*/
	
	@ManyToOne(fetch = FetchType.LAZY)
	//@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property="@id")
	private Waiter waiter;

	public Waiter getWaiter() {
		return waiter;
	}

	public void setWaiter(Waiter waiter) {
		this.waiter = waiter;
	}

	@Column(name = "visitor_name")
	private String name;

	@Column(name = "visitor_sername")
	private String sername;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	public Long getWid() {
		return waiter.getId();
	}
	/*
	public Long getWaiter_id() {
		return waiter_id;
	}

	public void setWaiter_id(Long waiter_id) {
		this.waiter_id = waiter_id;
	}
	*/
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSername() {
		return sername;
	}

	public void setSername(String sername) {
		this.sername = sername;
	}
}
