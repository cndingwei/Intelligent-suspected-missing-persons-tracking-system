package zhrk.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseQxDisaster<M extends BaseQxDisaster<M>> extends Model<M> implements IBean {

	public M setId(java.lang.Integer id) {
		set("ID", id);
		return (M)this;
	}
	
	public java.lang.Integer getId() {
		return getInt("ID");
	}

	public M setDname(java.lang.String dname) {
		set("DNAME", dname);
		return (M)this;
	}
	
	public java.lang.String getDname() {
		return getStr("DNAME");
	}

	public M setCode(java.lang.String code) {
		set("CODE", code);
		return (M)this;
	}
	
	public java.lang.String getCode() {
		return getStr("CODE");
	}

	public M setContent(java.lang.String content) {
		set("CONTENT", content);
		return (M)this;
	}
	
	public java.lang.String getContent() {
		return getStr("CONTENT");
	}

	public M setOpentime(java.util.Date opentime) {
		set("OPENTIME", opentime);
		return (M)this;
	}
	
	public java.util.Date getOpentime() {
		return get("OPENTIME");
	}

	public M setAddress(java.lang.String address) {
		set("ADDRESS", address);
		return (M)this;
	}
	
	public java.lang.String getAddress() {
		return getStr("ADDRESS");
	}

	public M setCount(java.lang.Integer count) {
		set("COUNT", count);
		return (M)this;
	}
	
	public java.lang.Integer getCount() {
		return getInt("COUNT");
	}

}
