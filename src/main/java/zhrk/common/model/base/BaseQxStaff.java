package zhrk.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseQxStaff<M extends BaseQxStaff<M>> extends Model<M> implements IBean {

	public M setId(java.lang.Integer id) {
		set("ID", id);
		return (M)this;
	}
	
	public java.lang.Integer getId() {
		return getInt("ID");
	}

	public M setName(java.lang.String name) {
		set("NAME", name);
		return (M)this;
	}
	
	public java.lang.String getName() {
		return getStr("NAME");
	}

	public M setUsercode(java.lang.String usercode) {
		set("USERCODE", usercode);
		return (M)this;
	}
	
	public java.lang.String getUsercode() {
		return getStr("USERCODE");
	}

	public M setSex(java.lang.Integer sex) {
		set("SEX", sex);
		return (M)this;
	}
	
	public java.lang.Integer getSex() {
		return getInt("SEX");
	}

	public M setAddr(java.lang.String addr) {
		set("ADDR", addr);
		return (M)this;
	}
	
	public java.lang.String getAddr() {
		return getStr("ADDR");
	}

	public M setBrity(java.util.Date brity) {
		set("BRITY", brity);
		return (M)this;
	}
	
	public java.util.Date getBrity() {
		return get("BRITY");
	}

	public M setParam1(java.lang.Integer param1) {
		set("PARAM1", param1);
		return (M)this;
	}
	
	public java.lang.Integer getParam1() {
		return getInt("PARAM1");
	}

	public M setP1name(java.lang.String p1name) {
		set("P1NAME", p1name);
		return (M)this;
	}
	
	public java.lang.String getP1name() {
		return getStr("P1NAME");
	}

	public M setP1tel(java.lang.String p1tel) {
		set("P1TEL", p1tel);
		return (M)this;
	}
	
	public java.lang.String getP1tel() {
		return getStr("P1TEL");
	}

	public M setParam2(java.lang.Integer param2) {
		set("PARAM2", param2);
		return (M)this;
	}
	
	public java.lang.Integer getParam2() {
		return getInt("PARAM2");
	}

	public M setP2name(java.lang.String p2name) {
		set("P2NAME", p2name);
		return (M)this;
	}
	
	public java.lang.String getP2name() {
		return getStr("P2NAME");
	}

	public M setP2tel(java.lang.String p2tel) {
		set("P2TEL", p2tel);
		return (M)this;
	}
	
	public java.lang.String getP2tel() {
		return getStr("P2TEL");
	}

	public M setRemark(java.lang.String remark) {
		set("REMARK", remark);
		return (M)this;
	}
	
	public java.lang.String getRemark() {
		return getStr("REMARK");
	}

	public M setCreatetime(java.util.Date createtime) {
		set("CREATETIME", createtime);
		return (M)this;
	}
	
	public java.util.Date getCreatetime() {
		return get("CREATETIME");
	}

}