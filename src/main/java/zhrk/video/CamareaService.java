package zhrk.video;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxCamarea;
import zhrk.utils.MapUtils;

public class CamareaService {

	public static final CamareaService me = new CamareaService();
	private QxCamarea dao = new QxCamarea().dao();
	
	/**
	 * 分页获得部门列表信息
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select * ","from qx_camarea order by id desc");
	}

	/**
	 * 校验监控信息是否已经添加过
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String addr,String caName,Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_camarea where 1=1 ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(addr)){
			sql.append("and address = ? ");
			li.add(addr);
		}
		if(!StrKit.isBlank(caName)){
			sql.append("and camname = ? ");
			li.add(caName);
		}
		List<QxCamarea> list = dao.find(sql.toString(), li.toArray());
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
	 * 添加监控信息
	 * @param Depart
	 * @return
	 */
	public Ret addCama(QxCamarea cama) {
		String addr = cama.getAddress();
		if(StrKit.isBlank(addr))
			return Ret.fail("msg", "监控地址不能为空");
		String caName = cama.getCamname();
		if(StrKit.isBlank(caName))
			return Ret.fail("msg", "监控名称不能为空");
		boolean valFlag = valid(addr, caName, null);
		if(!valFlag)
			return Ret.fail("msg", "该监控名称已经存在");
		Map<String,Object> usermap = MapUtils.java2Map(cama);
		boolean flag = cama.save(usermap);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}
	
	/**
	 * @return
	 */
	public Ret upCama(QxCamarea cama) {
		String addr = cama.getAddress();
		if(StrKit.isBlank(addr))
			return Ret.fail("msg", "监控地址不能为空");
		String caName = cama.getCamname();
		if(StrKit.isBlank(caName))
			return Ret.fail("msg", "监控名称不能为空");
		boolean valFlag = valid(addr, caName, cama.getId());
		if(!valFlag)
			return Ret.fail("msg", "该监控名称已经存在");
		Boolean flag = cama.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public QxCamarea findModelById(Integer id) {
		return dao.findById(id);
	}
	
	/**
	 * 删除
	 * @return
	 */
	public Ret delCama(QxCamarea cama) {
		Integer camaId = cama.getId();
		List<Record> list = Db.find("select * from qx_video_library where camId = ? ", camaId);
		if(list == null || list.size() == 0)
			return Ret.fail("msg", "该监控下存有视频，无法删除");
		Boolean flag = cama.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	/**
	 * 查询所有
	 * @return
	 * 2018年9月6日 上午9:50:34
	 */
	public List<QxCamarea> findAll() {
		return dao.find("select id,address || '--' || camname as addr from qx_camarea order by address asc");
	}

	/**
	 * 查询系统里的地点信息
	 * @return
	 * 2018年9月6日 下午3:31:24
	 */
	public List<Record> findAddress() {
		List<Record> list = Db.find("select distinct address as address from qx_camarea ");
		return list;
	}

}
