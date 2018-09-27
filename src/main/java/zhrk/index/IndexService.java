package zhrk.index;
import java.util.Date;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

import zhrk.common.model.QxMissing;
import zhrk.common.model.QxUr;
import zhrk.common.model.QxUser;
import zhrk.common.model.QxUserLibrary;
import zhrk.utils.EncryptUtil;
import zhrk.utils.MapUtils;

public class IndexService {

	public static final IndexService me = new IndexService();
	private QxUser dao = new QxUser().dao();
	private QxUserLibrary ulDao = new QxUserLibrary().dao();
	
	// 存放登录用户的 cacheName
	public static final String loginAccountCacheName = "loginAccount";
	
	public static final String sessionIdName = "jfinalId";


	public Ret regSub(QxUser user, String name, String code, String tel) {
		if(StrKit.isBlank(name))
			return Ret.fail("msg", "注册名称不能为空");
		if(StrKit.isBlank(code))
			return Ret.fail("msg", "注册编号不能为空");
		if(StrKit.isBlank(tel))
			return Ret.fail("msg","电话号码不能为空");
		QxUserLibrary ul = ulDao.findFirst("select * from qx_user_library where usercode = ? ", code);
		if(ul == null)
			return Ret.fail("msg","该身份编号不在人员信息库中，请重新填写");
		QxUser ou = dao.findFirst("select * from qx_user where usercode = ?", code);
		if(ou != null)
			return Ret.fail("msg","该身份编号已经存在");
		String ulName = ul.getName();
		if(!ulName.equals(name))
			return Ret.fail("msg","姓名与身份证信息姓名不一致，请重新输入");
		user.setName(name);
		user.setUsercode(code);
		user.setTel(tel);
		user.setPwd(EncryptUtil.md5("000000"));
		user.setCreatetime(new Date());
		user.setStatus(0);//0表示待审核，1表示已经审核通过  2表示已经审核不通过
		Map<String,Object> usermap = MapUtils.java2Map(user);
		boolean flag = user.save(usermap);
		boolean urf = true;
		if(flag){
			QxUser qu = dao.findFirst("select * from qx_user order by id desc");
			Integer userId = qu.getId();
			QxUr roleuser = new QxUr();
			roleuser.setRoleid(3);
			roleuser.setUserid(userId);
			Map<String,Object> urmap = MapUtils.java2Map(roleuser);
			urf = roleuser.save(urmap);
		}
		if(flag && urf)
			return Ret.ok("msg", "注册成功，默认密码为000000，请等待管理员审核");
		return Ret.fail("msg","注册失败");
	}

	public Ret doLogin(String code, String pwd) {
		if(StrKit.isBlank(code))
			return Ret.fail("msg", "登录名不能为空");
		if(StrKit.isBlank(pwd))
			return Ret.fail("msg", "密码不能为空");
		code = code.trim();
		pwd = pwd.trim();
		Record user = Db.findFirst("select r.code as rolecode,u.* from qx_user u,qx_ur ru,qx_role r WHERE u.id = ru.userid and ru.roleid = r.id and u.usercode = ?", code);
		if(user == null)
			return Ret.fail("msg", "用户名或密码不正确！");
		if(user.getInt("STATUS") == 0)
			return Ret.fail("msg", "该用户未审核，请等待管理员审核。");
		if(user.getInt("STATUS") == 2)
			return Ret.fail("msg", "该用户审核未通过，不能登录。");
		if(user.getStr("PWD").equals(EncryptUtil.md5(pwd)) == false)
			return Ret.fail("msg", "用户名或密码不正确！");
		String sessionId = StrKit.getRandomUUID();
		
		int maxAgeInSeconds = 7 * 24 * 60 * 60;//最长7天
		CacheKit.put(loginAccountCacheName, sessionId, user);
		return Ret.ok(sessionIdName, sessionId).set(loginAccountCacheName, user).set("maxAgeInSeconds", maxAgeInSeconds);  
	}

	/**
	 * 对急救信息的平台保存
	 * @param userId
	 * @param addr
	 * @param remark
	 * @param cardId 
	 * @return
	 * 2018年7月30日 下午5:03:19
	 */
	public Ret saveMis(Integer userId, String addr, String remark, String cardId) {
		QxUserLibrary ul = ulDao.findFirst("select * from qx_user_library where usercode = ? ", cardId);
		QxMissing mis = new QxMissing();
		mis.setType("紧急求救");
		mis.setMisdate(new Date());
		mis.setMiuser(ul.getId());
		mis.setContent(remark);
		mis.setAddress(addr);
		mis.setReuser(userId);
		mis.setInfstate("审核通过");
		Map<String,Object> map = MapUtils.java2Map(mis);
		boolean flag = mis.save(map);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	public Ret getMsg(Integer userId) {
		Record record = Db.findFirst("select count(*) as count from qx_send where userid = ? and isread = '未查看'",userId);
		return Ret.ok("msg", record.getInt("COUNT"));
	}

}
