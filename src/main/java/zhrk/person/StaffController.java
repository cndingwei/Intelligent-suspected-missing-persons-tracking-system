package zhrk.person;
import com.jfinal.core.Controller;

import java.util.Date;
import java.util.List;

import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxRela;
import zhrk.common.model.QxStaff;
import zhrk.utils.IdcardUtil;

public class StaffController extends Controller{

	StaffService srv = StaffService.me;
	
	/**
	 * 人员基础信息
	 */
	public void index(){
		Page<Record> staffList = srv.paginate(getParaToInt("p", 1));
		setAttr("staffList", staffList);
		render("list.jsp");
	}
	
	/**
	 * 新增人员
	 */
	public void form(){
		Integer id = getParaToInt(0);
		List<QxRela> relaList = srv.findRelaList();
		setAttr("relaList", relaList);
		if(id != null){
			QxStaff staff = srv.findById(id);
			setAttr("staff", staff);
		}
		render("form.jsp");
	}
	
	/**
	 * 校验身份信息
	 */
	public void validCode(){
		Integer id = getParaToInt(0);
		String code = getPara("param");
		if(!IdcardUtil.is18ByteIdCardComplex(code)) {
			renderJson("{\"info\":\"身份证号码不正确\",\"status\":\"n\"}");
			return;
		}
		boolean l = srv.valid(code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该身份证号已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 新增用户
	 */
	public void addStaff(){
		QxStaff staff = getBean(QxStaff.class,"staff");
		staff.setCreatetime(new Date());
		Ret ret = srv.addStaff(staff);
		renderJson(ret);
	}
	/**
	 * 更新用户信息
	 */
	public void upStaff(){
		QxStaff staff = getBean(QxStaff.class,"staff");
		Ret ret = srv.upStaff(staff);
		renderJson(ret);
	}
	
	/**
	 * 删除用户
	 */
	public void delStaff(){
		Integer id = getParaToInt("id");
		QxStaff staff = srv.findById(id);
		Ret ret = srv.delStaff(staff);
		renderJson(ret);
	}
	
}
