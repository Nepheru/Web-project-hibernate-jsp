package ua.cn.stu.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name = "waiter")
//@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property="@id")
public class Waiter {

	public Waiter() {
	}

	public Waiter(String name, String sername) {
		this.name = name;
		this.sername = sername;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private Long id;

	@Column(name = "waiter_name")
	private String name;

	@Column(name = "waiter_sername")
	private String sername;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSername() {
		return sername;
	}
	
	public static String getCocki() {
		return cocki;
	}

	public static void setCocki(String cocki) {
		Waiter.cocki = cocki;
	}

	public void setSername(String sername) {
		this.sername = sername;
	}
	static String cocki = " ";

}
