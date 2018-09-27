package zhrk.user;
import com.jfinal.core.Controller;

import java.util.Date;
import java.util.List;

import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import zhrk.common.model.QxUser;
import zhrk.utils.EncryptUtil;

public class UserController extends Controller{

	UserService srv = UserService.me;
	
	/**
	 * 用户管理2
	 */
	public void index(){
		Page<Record> userList = srv.paginate(getParaToInt("p", 1));
		setAttr("userList", userList);
		render("list.jsp");
	}
	
	/**
	 * 校验身份信息
	 */
	public void validCode(){
		Integer id = getParaToInt(0);
		String code = getPara("param");
		String tel = "";
		boolean l = srv.valid(tel,code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该身份证号已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 校验手机号信息
	 */
	public void validTel(){
		Integer id = getParaToInt(0);
		String code = "";
		String tel = getPara("param");
		boolean l = srv.valid(tel,code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该手机号已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 新增用户
	 */
	public void addUser(){
		QxUser user = getBean(QxUser.class,"user");
		/*QxUr roleuser = getBean(QxUr.class,"ur");
		Integer isVolun = user.getIsvolun();
		if(isVolun == null){
			user.setIsvolun(1);//0表示志愿者，1表示非志愿者
		}*/
		user.setPwd(EncryptUtil.md5("000000"));
		user.setCreatetime(new Date());
		user.setStatus(0);//默认是待审核
		Ret ret = srv.addUser(user);
		renderJson(ret);
	}
	/**
	 * 更新用户信息
	 */
	public void upUser(){
		Integer userId = getParaToInt(0);
		QxUser user = getBean(QxUser.class,"user");
		user.setId(userId);
		Ret ret = srv.upUser(user);
		renderJson(ret);
	}
	
	/**
	 * 删除用户
	 */
	public void delUser(){
		Integer id = getParaToInt("id");
		QxUser user = srv.findModelById(id);
		Ret ret = srv.delUser(user);
		renderJson(ret);
	}
	
	/**
	 * 变更状态
	 */
	public void status(){
		Integer userId = getParaToInt("userId");
		Integer status = getParaToInt("status");
		QxUser ou = srv.findModelById(userId);
		ou.setStatus(status);
		Ret ret = srv.upUser(ou);
		renderJson(ret);
	}

	/**
	 * 根据用户id获取用户信息
	 * 
	 * 2018年7月29日 上午11:28:05
	 */
	public void findById() {
		Integer id = getParaToInt("id");
		QxUser data = srv.findModelById(id);
		renderJson(data);
	}
	
	/**
	 * 根据用户id获取角色列表
	 * 2018年8月6日 上午11:40:50
	 */
	public void findRoleById(){
		Integer id = getParaToInt("id");
		List<Record> roleList = srv.findRoleById(id);
		renderJson(roleList);
	}
	
	/**
	 * 保存用户的角色信息
	 * 
	 * 2018年8月6日 下午3:50:35
	 */
	public void saveRole() {
		Integer userId = getParaToInt("userId");
		Integer roleId = getParaToInt("roleId");
		Ret ret = srv.saveRole(userId,roleId);
		renderJson(ret);
	}
}
