package zhrk.index;
import javax.servlet.http.HttpSession;

import com.jfinal.core.Controller;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Record;
import zhrk.common.model.QxUser;

public class IndexController extends Controller{

	IndexService ins = IndexService.me;
	
	public void index() {
		render("signin.jsp");
	}
	
	public void desktop() {
		render("index.jsp");
	}
	
	public void register() {
		render("register.jsp");
	}
	
	/**
	 * 获得未读消息的数量
	 * 
	 * 2018年8月11日 下午1:47:51
	 */
	public void getMsg() {
 		Record user = getSessionAttr("user");
		if(user != null) {
			Integer userId = user.getInt("ID");
			Ret ret = ins.getMsg(userId);
			renderJson(ret);
		}else {
			renderJson(Ret.ok("msg", 0));
		}
	}
	
	public void regSub() {
		QxUser user = getBean(QxUser.class,"user");
		String name,code,tel;
		if(user.getType().equals("个人")) {
			name = getPara("pername");
			code = getPara("percode");
			tel = getPara("pertel");
		}else {
			name = getPara("zzname");
			code = getPara("zzcode");
			tel = getPara("zztel");
		}
		Ret ret = ins.regSub(user, name, code, tel);
		renderJson(ret);
	}
	
	public void login() {
		String type = getPara("userCategory");
		String code = "";
		if(type.equals("个人")) {
			code = getPara("cardId");
		}else {
			code = getPara("orgId");
		}
		String pwd = getPara("pwd");
		Ret ret = ins.doLogin(code,pwd);
		if(ret.isOk()){
			String sessionId = ret.getStr(IndexService.sessionIdName);
			int maxAgeInSeconds = ret.getInt("maxAgeInSeconds");
			setCookie(IndexService.sessionIdName, sessionId, maxAgeInSeconds, true);
			HttpSession session = getSession();
			session.setMaxInactiveInterval(60*60*2);
			setSessionAttr("user", ret.get(IndexService.loginAccountCacheName));
		}
		renderJson(ret);
	}
	
	public void findUser() {
		Record data = getSessionAttr("user");
		renderJson(data);
	}
	
	/**
	 * 保存紧急求救信息
	 * 
	 * 2018年7月30日 下午4:31:46
	 */
	public void saveMis() {
		Integer userId = getParaToInt("userId");
		String addr = getPara("addr");
		String remark = getPara("remark");
		String cardId = getPara("cardId");
		Ret ret = ins.saveMis(userId,addr,remark,cardId);
		renderJson(ret);
	}
	
	/**
	 * 用户退出
	 * 
	 * 2018年8月11日 下午11:14:41
	 */
	public void logout () {
		removeSessionAttr("user");
		redirect("/");
	}
}
