package zhrk.role;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxMenu;
import zhrk.common.model.QxRole;
import zhrk.common.model.QxRomenu;
import zhrk.utils.MapUtils;

public class RoleService {

	public static final RoleService me = new RoleService();
	private QxRole dao = new QxRole().dao();
	private QxMenu mDao = new QxMenu().dao();
	
	/**
	 * 分页获得角色列表信息
	 * @param pager
	 * @return
	 */
	public Page<QxRole> paginate(Integer pageNum) {
		return dao.paginate(pageNum, 10, "select *", "from qx_role  order by id desc");
	}

	/**
	 * 校验角色名称
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String name,String code, Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_role where 1=1  ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(name)){
			sql.append("and name = ?");
			li.add(name);
		}
		if(!StrKit.isBlank(code)){
			sql.append("and code = ?");
			li.add(code);
		}
		List<QxRole> list = dao.find(sql.toString(), li.toArray());
		if (list.size() == 0)
			return true;
		else {
			Integer oid = list.get(0).getId();
			if (id == null) {
				return false;
			}
			if (list.size() == 1 && oid.equals(id)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 角色添加
	 * @param role
	 * @return
	 */
	public Ret addRole(QxRole role) {
		String name = role.getName();
		String code = role.getCode();
		if(StrKit.isBlank(name))
			return Ret.fail("msg", "角色名称不能为空");
		if(StrKit.isBlank(code))
			return Ret.fail("msg", "角色编码不能为空");
		boolean nameValid = valid(name, "", null);
		if(!nameValid)
			return Ret.fail("msg", "该角色名称已存在");
		boolean codeValid = valid("",code,null);
		if(!codeValid)
			return Ret.fail("msg", "该角色编码已存在");
		Map<String,Object> map = MapUtils.java2Map(role);
		Boolean flag = role.save(map);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	/**
	 * 根据id查找角色
	 * @param id
	 * @return
	 */
	public QxRole findById(Integer id) {
		return dao.findById(id);
	}

	/**
	 * 角色跟新
	 * @param role
	 * @return
	 */
	public Ret upRole(QxRole role) {
		String name = role.getName();
		String code = role.getCode();
		if(StrKit.isBlank(name))
			return Ret.fail("msg", "角色名称不能为空");
		if(StrKit.isBlank(code))
			return Ret.fail("msg", "角色编码不能为空");
		boolean nameValid = valid(name, "", role.getId());
		if(!nameValid)
			return Ret.fail("msg", "该角色名称已存在");
		boolean codeValid = valid("",code,role.getId());
		if(!codeValid)
			return Ret.fail("msg", "该角色编码已存在");
		Boolean flag = role.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	/**
	 * 保存角色权限
	 * @param roleId
	 * @param strs
	 * @return
	 * 2018年7月16日 上午11:34:50
	 */
	public Ret savePer(Integer roleId, String[] strs) {
		if(strs.length == 0 )
			return Ret.fail("msg", "请选择相应的菜单");
		Db.delete("delete from qx_romenu where roleid = ?", roleId);
		List<QxRomenu> list = new ArrayList<>();
		HashSet<Integer> topIds = new HashSet<>();
		for(String str :strs) {
			String[] ids = str.split("-");
			topIds.add(Integer.parseInt(ids[0]));
			QxRomenu romenu = new QxRomenu();
			romenu.setRoleid(roleId);
			romenu.setMenuid(Integer.parseInt(ids[1]));
			list.add(romenu);
		}
		for(Integer id:topIds) {
			QxRomenu romenu = new QxRomenu();
			romenu.setRoleid(roleId);
			romenu.setMenuid(id);
			list.add(romenu);
		}
		Db.batchSave(list, 20);
		return Ret.ok("msg", "保存成功");
	}
	/**
	 * 删除角色
	 * @param id
	 * @return
	 */
	public Ret delRole(Integer id) {
		Boolean flag = dao.deleteById(id);
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	/**
	 * 
	 * @param id
	 * @return
	 * 2018年7月13日 上午11:42:30
	 */
	public Map<QxMenu, List<Record>> findMenuByRoleId(Integer id) {
		List<QxMenu> tMlist = mDao.find("select id,name from qx_menu where istop = '0'");
		if(tMlist.size() == 0)
			return null;
		Map<QxMenu,List<Record>> map = new HashMap<>();
		for (QxMenu qxMenu : tMlist) {
			List<Record> list = Db.find("select m.id,m.name,m.istop,m.parid,case when rm.id is null then 0 else 1 end as istrue from qx_menu m left join qx_romenu rm on m.id = rm.menuid and rm.roleid = ? where m.parid = ? order by m.id asc", id,qxMenu.getId());
			map.put(qxMenu, list);
		}
		return map;
	}
}
