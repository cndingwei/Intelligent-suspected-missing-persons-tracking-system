package zhrk.video;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import zhrk.common.model.QxCamarea;


public class CamareaController extends Controller{

	CamareaService srv = CamareaService.me;
	
	/**
	 * 视频信息列表
	 */
	public void index(){
		Page<Record> camaList = srv.paginate(getParaToInt("p", 1));
		setAttr("camaList", camaList);
		render("list.jsp");
	}
	
	/**
	 * 新增监控信息
	 */
	public void addCama(){
		QxCamarea cama = getBean(QxCamarea.class,"cama");
		Ret ret = srv.addCama(cama);
		renderJson(ret);
	}
	/**
	 * 更新
	 */
	public void upCama(){
		QxCamarea cama = getBean(QxCamarea.class,"cama");
		Ret ret = srv.upCama(cama);
		renderJson(ret);
	}
	
	/**
	 * 删除
	 */
	public void delCama(){
		Integer id = getParaToInt("id");
		QxCamarea cama = srv.findModelById(id);
		Ret ret = srv.delCama(cama);
		renderJson(ret);
	}
	
	/**
	 * 根据id获得实体信息
	 * 
	 * 2018年9月5日 下午5:44:55
	 */
	public void findById() {
		Integer id = getParaToInt("id");
		QxCamarea data = srv.findModelById(id);
		renderJson(data);
	}
	
	/**
	 * 获取所有监控地点
	 * 
	 * 2018年9月6日 上午10:04:54
	 */
	public void findAll() {
		List<QxCamarea> data = srv.findAll();
		renderJson(data);
	}
	
	/**
	 * 获得系统记录的地点信息
	 * 
	 * 2018年9月6日 下午3:30:00
	 */
	public void findAddress() {
		List<Record> data = srv.findAddress();
		renderJson(data);
	}
}
