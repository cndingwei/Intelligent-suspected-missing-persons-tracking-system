package zhrk.menu;
import com.jfinal.core.Controller;
import java.util.Date;
import java.util.List;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import zhrk.common.model.QxMenu;

public class MenuController extends Controller{

	MenuService srv = MenuService.me;
	
	/**
	 * 菜单管理
	 */
	public void index(){
		Page<Record> menuList = srv.paginate(getParaToInt("p", 1));
		setAttr("menuList", menuList);
		render("list.jsp");
	}
	
	/**
	 * 新增菜单表单
	 */
	public void form(){
		Integer id = getParaToInt(0);
		List<QxMenu> menuList = srv.findMenuList();
		setAttr("menuList", menuList);
		setAttr("menuSize", menuList.size());
		if(id != null){
			QxMenu menu = srv.findModelById(id);
			setAttr("menu", menu);
		}
		render("form.jsp");
	}
	
	/**
	 * 校验菜单名称
	 */
	public void validCode(){
		Integer id = getParaToInt(0);
		String code = getPara("param");
		boolean l = srv.valid(code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该菜单名称已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 新增菜单
	 */
	public void addMenu(){
		QxMenu menu = getBean(QxMenu.class,"menu");
		if(menu.getIstop() == null || menu.getIstop() == 0) {
			menu.setIstop(0);//0表示顶级菜单，1表示非顶级菜单
			menu.setParid(null);
		}
		menu.setCreatetime(new Date());
		Ret ret = srv.addMenu(menu);
		renderJson(ret);
	}
	/**
	 * 更新菜单信息
	 */
	public void upMenu(){
		QxMenu menu = getBean(QxMenu.class,"menu");
		Ret ret = srv.upMenu(menu);
		renderJson(ret);
	}
	
	/**
	 * 删除菜单
	 */
	public void delMenu(){
		Integer id = getParaToInt("id");
		QxMenu menu = srv.findModelById(id);
		Ret ret = srv.delMenu(menu);
		renderJson(ret);
	}
	
}
