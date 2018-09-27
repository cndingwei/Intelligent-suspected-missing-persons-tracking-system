package zhrk.person;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

import zhrk.common.model.QxRela;
import zhrk.utils.MapUtils;

public class RelaService {

	public static final RelaService me = new RelaService();
	private QxRela dao = new QxRela().dao();
	
	/**
	 * 分页获得关系信息
	 * @param pager
	 * @return
	 */
	public Page<QxRela> paginate(Integer pageNum) {
		return dao.paginate(pageNum, 10, "select *", "from qx_rela  order by id desc");
	}

	/**
	 * 校验关系名称
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String name,Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_rela where 1=1  ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(name)){
			sql.append("and name = ?");
			li.add(name);
		}
		List<QxRela> list = dao.find(sql.toString(), li.toArray());
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
	 * 关系添加
	 * @param role
	 * @return
	 */
	public Ret addRela(QxRela rela) {
		Map<String,Object> map = MapUtils.java2Map(rela);
		Boolean flag = rela.save(map);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	/**
	 * 根据id查找
	 * @param id
	 * @return
	 * 2018年7月10日 下午4:40:45
	 */
	public QxRela findById(Integer id) {
		return dao.findById(id);
	}

	/**
	 * 更新关系信息
	 * @param role
	 * @return
	 */
	public Ret upRela(QxRela rela) {	
		Boolean flag = rela.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	/**
	 * 删除关系信息
	 * @param id
	 * @return
	 */
	public Ret delRela(Integer id) {
		Integer count = Db.queryInt("select count(s.id) from qx_staff s,qx_rela r where param1 = r.id or param2 = r.id ");
		if(count != 0)
			return Ret.fail("msg", "删除失败,人员信息存在基础关系");
		Boolean flag = dao.deleteById(id);
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}
}
