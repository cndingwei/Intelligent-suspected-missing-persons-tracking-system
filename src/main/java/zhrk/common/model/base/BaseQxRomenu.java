package zhrk.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseQxRomenu<M extends BaseQxRomenu<M>> extends Model<M> implements IBean {

	public M setId(java.lang.Integer id) {
		set("ID", id);
		return (M)this;
	}
	
	public java.lang.Integer getId() {
		return getInt("ID");
	}

	public M setRoleid(java.lang.Integer roleid) {
		set("ROLEID", roleid);
		return (M)this;
	}
	
	public java.lang.Integer getRoleid() {
		return getInt("ROLEID");
	}

	public M setMenuid(java.lang.Integer menuid) {
		set("MENUID", menuid);
		return (M)this;
	}
	
	public java.lang.Integer getMenuid() {
		return getInt("MENUID");
	}

}