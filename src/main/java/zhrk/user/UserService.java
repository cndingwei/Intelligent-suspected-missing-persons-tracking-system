package zhrk.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxRole;
import zhrk.common.model.QxUr;
import zhrk.common.model.QxUser;
import zhrk.utils.MapUtils;

public class UserService {

	public static final UserService me = new UserService();
	private QxRole roDao = new QxRole().dao();
	private QxUser dao = new QxUser().dao();
	private QxUr urDao = new QxUr().dao();
	
	/**
	 * 分页获得部门列表信息
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select u.id,r.name as rolename,u.name,u.usercode,u.tel,u.type,case when u.status = 0 then '待审核' when u.status = 2 then '已审核不通过' else '已审核通过' end as status ", 
				"from qx_user u,qx_ur ru,qx_role r WHERE u.id = ru.userid and ru.roleid = r.id ORDER BY u.id DESC");
	}

	/**
	 * 校验登录账号
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String tel,String code,Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_user where 1=1 ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(code)){
			sql.append("and usercode = ?");
			li.add(code);
		}
		if(!StrKit.isBlank(tel)){
			sql.append("and tel = ?");
			li.add(code);
		}
		List<QxUser> list = dao.find(sql.toString(), li.toArray());
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
	 * 用户添加
	 * @param Depart
	 * @return
	 */
	public Ret addUser(QxUser user) {
		Map<String,Object> usermap = MapUtils.java2Map(user);
		boolean flag = user.save(usermap);
		boolean urf = true;
		if(flag){
			QxUser qu = dao.findFirst("select * from qx_user order by id desc");
			Integer userId = qu.getId();
			QxUr ru = new QxUr();
			ru.setRoleid(3);
			ru.setUserid(userId);
			Map<String,Object> urmap = MapUtils.java2Map(ru);
			urf = ru.save(urmap);
		}
		if(flag && urf)
			return Ret.ok("msg", "添加成功,默认密码：000000,等待审核");
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
	 * 部门跟新
	 * @param Depart
	 * @return
	 */
	public Ret upUser(QxUser user) {
		Boolean flag = user.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public List<QxRole> findRoleList() {
		return roDao.find("select * from qx_role order by id desc");
	}

	public QxUser findModelById(Integer id) {
		return dao.findById(id);
	}
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public Ret delUser(QxUser user) {
		Boolean flag = user.delete();
		QxUr ru = urDao.findFirst("select * from  qx_ur WHERE userId = ? ", user.getId());
		ru.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	/**
	 * 根据用户id获得角色列表
	 * @param id
	 * @return
	 * 2018年8月6日 上午11:49:19
	 */
	public List<Record> findRoleById(Integer id) {
		return Db.find("select r.*,case when ur.userid is null then 0 else 1 end as status from qx_role r left join qx_ur ur on r.id = ur.roleid and ur.userid = ? ", id);
	}

	public Ret saveRole(Integer userId, Integer roleId) {
		QxUr ru = urDao.findFirst("select * from  qx_ur WHERE userId = ? ", userId);
		ru.delete();
		QxUr userRole = new QxUr();
		userRole.setRoleid(roleId);
		userRole.setUserid(userId);
		Map<String,Object> urmap = MapUtils.java2Map(userRole);
		boolean urf = userRole.save(urmap);
		if(urf)
			return Ret.ok("msg", "分配成功。");
		return Ret.fail("msg", "分配失败。");
	}

}
