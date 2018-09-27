package zhrk.role;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxMenu;
import zhrk.common.model.QxRole;

public class RoleController extends Controller{

	RoleService srv = RoleService.me;
	
	/**
	 * 角色权限
	 */
	public void index(){
		Page<QxRole> roleList = srv.paginate(getParaToInt("p", 1));
		setAttr("roleList", roleList);
		render("list.jsp");
	}
	
	/**
	 * 新增角色
	 */
	public void form(){
		Integer id = getParaToInt(0);
		if(id != null){
			QxRole role = srv.findById(id);
			setAttr("role", role);
		}
		render("form.jsp");
	}
	
	/**
	 * 分配权限
	 * 2018年7月12日 下午5:45:50
	 */
	public void perssion() {
		Integer id = getParaToInt(0);
		QxRole role = srv.findById(id);
		setAttr("role", role);
		Map<QxMenu,List<Record>> menuMap = srv.findMenuByRoleId(id);
		setAttr("menuMap", menuMap);
		render("perForm.jsp");
	}
	
	public void savePer() {
		Integer roleId = getParaToInt("roleId");
		String[] strs = getParaValues("menuId");
		Ret ret = srv.savePer(roleId,strs);
		renderJson(ret);
	}
	
	/**
	 * 校验角色名称
	 */
	public void validName(){
		Integer id = getParaToInt(0);
		String name = getPara("param");
		String code = "";
		boolean l = srv.valid(name,code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该角色名称已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 校验角色编码
	 */
	public void validCode(){
		Integer id = getParaToInt(0);
		String code = getPara("param");
		String name = "";
		boolean l = srv.valid(name,code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该角色编码已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 新增角色
	 */
	public void addRole(){
		QxRole role = getBean(QxRole.class,"role");
		Ret ret = srv.addRole(role);
		renderJson(ret);
	}
	/**
	 * 跟新角色信息
	 */
	public void upRole(){
		QxRole role = getBean(QxRole.class,"role");
		Ret ret = srv.upRole(role);
		renderJson(ret);
	}
	
	/**
	 * 删除角色
	 */
	public void delRole(){
		Integer id = getParaToInt("id");
		Ret ret = srv.delRole(id);
		renderJson(ret);
	}
	
	public void findById() {
		Integer id = getParaToInt("id");
		QxRole data = srv.findById(id);
		renderJson(data);
	}
}
