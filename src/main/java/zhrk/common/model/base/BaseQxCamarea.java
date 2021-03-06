package zhrk.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseQxCamarea<M extends BaseQxCamarea<M>> extends Model<M> implements IBean {

	public M setId(java.lang.Integer id) {
		set("ID", id);
		return (M)this;
	}
	
	public java.lang.Integer getId() {
		return getInt("ID");
	}

	public M setCamname(java.lang.String camname) {
		set("CAMNAME", camname);
		return (M)this;
	}
	
	public java.lang.String getCamname() {
		return getStr("CAMNAME");
	}

	public M setAddress(java.lang.String address) {
		set("ADDRESS", address);
		return (M)this;
	}
	
	public java.lang.String getAddress() {
		return getStr("ADDRESS");
	}

	public M setParam(java.lang.String param) {
		set("PARAM", param);
		return (M)this;
	}
	
	public java.lang.String getParam() {
		return getStr("PARAM");
	}

	public M setUrl(java.lang.String url) {
		set("URL", url);
		return (M)this;
	}
	
	public java.lang.String getUrl() {
		return getStr("URL");
	}

	public M setPort(java.lang.String port) {
		set("PORT", port);
		return (M)this;
	}
	
	public java.lang.String getPort() {
		return getStr("PORT");
	}

	public M setRemark(java.lang.String remark) {
		set("REMARK", remark);
		return (M)this;
	}
	
	public java.lang.String getRemark() {
		return getStr("REMARK");
	}

}
