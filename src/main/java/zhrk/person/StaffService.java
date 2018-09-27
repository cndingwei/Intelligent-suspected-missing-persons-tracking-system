package zhrk.person;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxRela;
import zhrk.common.model.QxStaff;
import zhrk.common.model.QxUserLibrary;
import zhrk.utils.IdcardUtil;
import zhrk.utils.MapUtils;

public class StaffService {

	public static final StaffService me = new StaffService();
	private QxStaff dao = new QxStaff().dao();
	private QxRela reDao = new QxRela().dao();
	private QxUserLibrary ulDao = new QxUserLibrary().dao();
	
	/**
	 * 分页获得人员信息
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select id,name,usercode,brity,case SEX when 1 then '男' else '女' end as sex,tel,to_char(createtime,'YYYY-MM-DD HH24:MI:SS') as createtime ", "from qx_user_library ORDER BY id DESC");
	}

	/**
	 * 校验登录账号
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String code,Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_staff where 1=1 ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(code)){
			sql.append("and usercode = ?");
			li.add(code);
		}
		List<QxStaff> list = dao.find(sql.toString(), li.toArray());
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
	public Ret addStaff(QxStaff staff) {
		staff = setBrity(staff);
		Map<String,Object> usermap = MapUtils.java2Map(staff);
		boolean flag = staff.save(usermap);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	/**
	 * 根据身份证号，获取性别 出生年月
	 * @param staff
	 * @return
	 * 2018年7月11日 上午9:49:46
	 */
	private QxStaff setBrity(QxStaff staff) {
		String code = staff.getUsercode();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			staff.setBrity(sdf.parse(IdcardUtil.getBirthByIdCard(code)));
		} catch (ParseException e) {
			staff.setBrity(null);
		}
		staff.setSex(IdcardUtil.getGenderByIdCard(code));
		return staff;
	}

	/**
	 * 根据id查找部门
	 * @param id
	 * @return
	 */
	public QxStaff findById(Integer id) {
		return dao.findById(id);
	}

	/**
	 * 部门跟新
	 * @param Depart
	 * @return
	 */
	public Ret upStaff(QxStaff staff) {
		staff = setBrity(staff);
		Boolean flag = staff.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public List<QxRela> findRelaList() {
		return reDao.find("select * from qx_rela order by id desc");
	}
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public Ret delStaff(QxStaff staff) {
		Boolean flag = staff.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

}
