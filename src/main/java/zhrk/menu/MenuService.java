package zhrk.menu;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxMenu;
import zhrk.utils.MapUtils;

public class MenuService {

	public static final MenuService me = new MenuService();
	private QxMenu dao = new QxMenu().dao();
	
	/**
	 * 分页
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select id,name,pic,path,case istop when 0 then '是' else '否' end as istop,to_char(createtime,'YYYY-MM-DD HH24:MI:SS') as createtime ", 
				"from qx_menu ORDER BY id DESC");
	}

	/**
	 * 校验
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String code,Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_menu where 1=1 ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(code)){
			sql.append("and name = ?");
			li.add(code);
		}
		List<QxMenu> list = dao.find(sql.toString(), li.toArray());
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
	 * 添加
	 * @param Depart
	 * @return
	 */
	public Ret addMenu(QxMenu menu) {
		Map<String,Object> menumap = MapUtils.java2Map(menu);
		boolean flag = menu.save(menumap);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	/**
	 * 根据id查找部门
	 * @param id
	 * @return
	 */
	public Record findById(Integer id) {
		Record user = Db.findFirst("SELECT u.id, r.id as roleId, u.name , u.usercode, u.type, u.isvolun, u.tel,u.remark FROM qx_user u, qx_ur ru, qx_role r WHERE u.id = ru.userId AND ru.roleId = r.id AND u.id = ? ORDER BY u.id DESC", id);
		return user;
	}

	/**
	 * 更新
	 * @param Depart
	 * @return
	 */
	public Ret upMenu(QxMenu menu) {
		Boolean flag = menu.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public List<QxMenu> findMenuList() {
		return dao.find("select id,name from qx_menu where istop = 0 order by id desc");
	}

	public QxMenu findModelById(Integer id) {
		return dao.findById(id);
	}
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public Ret delMenu(QxMenu menu) {
		Boolean flag = menu.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

}
