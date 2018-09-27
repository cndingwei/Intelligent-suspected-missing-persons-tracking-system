package zhrk.person;
import com.jfinal.core.Controller;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import zhrk.common.model.QxRela;
public class RelaController extends Controller{

	RelaService srv = RelaService.me;
	
	/**
	 * 亲属基础信息
	 */
	public void index(){
		Page<QxRela> relaList = srv.paginate(getParaToInt("p", 1));
		setAttr("relaList", relaList);
		render("list.jsp");
	}
	
	/**
	 * 表单
	 */
	public void form(){
		Integer id = getParaToInt(0);
		if(id != null){
			QxRela rela = srv.findById(id);
			setAttr("rela", rela);
		}
		render("form.jsp");
	}
	
	/**
	 * 校验亲属名称
	 */
	public void validName(){
		Integer id = getParaToInt(0);
		String name = getPara("param");
		boolean l = srv.valid(name,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该关系名称已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 新增关系信息
	 */
	public void addRela(){
		QxRela rela = getBean(QxRela.class,"rela");
		Ret ret = srv.addRela(rela);
		renderJson(ret);
	}
	/**
	 * 更新关系信息
	 */
	public void upRela(){
		QxRela rela = getBean(QxRela.class,"rela");
		Ret ret = srv.upRela(rela);
		renderJson(ret);
	}
	
	/**
	 * 删除关系信息
	 */
	public void delRela(){
		Integer id = getParaToInt("id");
		Ret ret = srv.delRela(id);
		renderJson(ret);
	}
}
