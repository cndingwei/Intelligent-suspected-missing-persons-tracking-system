package zhrk.disaster;
import com.jfinal.core.Controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import zhrk.common.model.QxDisaster;
import zhrk.utils.EncryptUtil;

public class DisasterController extends Controller{

	DisasterService srv = DisasterService.me;
	
	/**
	 * 所有消息列表
	 */
	public void index(){
		Page<Record> disasterList = srv.paginate(getParaToInt("p", 1));
		setAttr("disasterList", disasterList);
		render("list.jsp");
	}
	
	/**
	 * 登记灾难信息
	 */
	public void addDisaster(){
		Integer opFlag = getParaToInt("opFlag",0);
		String address = "";
		if(opFlag == 0) {
			address = getPara("seleAddr");
		}else {
			address = getPara("address");
		}
		QxDisaster disaster = getBean(QxDisaster.class,"disaster");
		disaster.setAddress(address);
		disaster.setCode(EncryptUtil.getCode());
		if(disaster.getOpentime() == null) {
			disaster.setOpentime(new Date());
		}
		Ret ret = srv.addDisaster(disaster);
		renderJson(ret);
	}
	/**
	 * 根据id获取实体类信息
	 * 
	 * 2018年9月22日 下午12:22:13
	 */
	public void findById() {
		Integer id = getParaToInt("id");
		QxDisaster data = srv.findById(id);
		renderJson(data);
	}
	
	/**
	 * 更新灾难信息
	 */
	public void upDisaster(){
		QxDisaster disaster = getBean(QxDisaster.class,"disaster");
		Ret ret = srv.upDisaster(disaster);
		renderJson(ret);
	}
	
	/**
	 * 删除灾难信息
	 */
	public void delDisaster(){
		Integer id = getParaToInt("id");
		QxDisaster disaster = srv.findModelById(id);
		Ret ret = srv.delDisaster(disaster,id);
		renderJson(ret);
	}
	
	/**
	 * 对上传视频进行图片截取
	 * 
	 * 2018年8月16日 下午6:16:40
	 */
	public void anasView() {
		String[] paths = getParaValues("path[]");
		if(paths == null || paths.length == 0) {
			renderJson(Ret.fail("msg", "视频未找到"));
			return;
		}
		Ret ret = srv.getImages(paths);
		List<String> data = new ArrayList<>();
		if(ret.isOk()) {
			Integer count = ret.getInt("msg");
			data = srv.getPaths(count,data);
		}
		renderJson(data);
	}
	/**
	 * 对选中的视频id进行视频人像分析
	 * 
	 * 2018年9月24日 下午10:19:45
	 */
	public void anasViewByPath() {
		Integer viewId = getParaToInt("path");
		String path = srv.getPathById(viewId);
		if(path == null) {
			renderJson(Ret.fail("msg", "视频未找到"));
			return;
		}
		setSessionAttr("viewId", viewId);
		String[] paths = new String[]{path};
		Ret ret = srv.getImages(paths);
		List<String> data = new ArrayList<>();
		if(ret.isOk()) {
			Integer count = ret.getInt("msg");
			data = srv.getPaths(count,data);
		}
		renderJson(data);
	}
	/**
	 * 对照片数据进行分析
	 * 
	 * 2018年8月17日 上午11:12:05
	 */
	public void contrast() {
		Integer flag = getSessionAttr("flag");
		Integer disId =  getParaToInt("misId");
		Integer viewId = null;
		Integer ansFlag = getParaToInt("flag");
		if(ansFlag == 1) {
			viewId = getSessionAttr("viewId");
		}
		List<String> paths = srv.getImgPaths(flag);	
		//调用接口，对照片进行对比，有相关人员，则返回新的人员列表
		//List<Record> userList = srv.getUserlist();
		//List<Record> data = srv.contrast(paths,userList);
		List<Record> data = srv.contrastByIbm(paths,disId,viewId);
		if(flag == null) {
			setSessionAttr("flag", 0);
		}else {
			if(flag == 0) {
				setSessionAttr("flag", 1);
			}
			else {
				setSessionAttr("flag", 0);
			}
		}
		renderJson(data);
	}
	
	/**
	 * 上传视频，返回视频路径
	 * 
	 * 2018年8月29日 上午9:58:39
	 */
	public void upload() {
		Integer misId = getParaToInt(0);
		UploadFile uploadFile = getFile("videoName","\\view\\");//在磁盘上保存文件
		Integer count = getParaToInt("discount",0);
		if(uploadFile == null) {
			renderJson(Ret.fail("msg", "请选择上传的视频文件。"));
		}else {
			String uploadPath = uploadFile.getUploadPath();//获取保存文件的文件夹
	        String fileName = uploadFile.getFileName();//获取保存文件的文件名
	        String filePath = uploadPath+fileName;//保存文件的路径
	        Ret pathRet = srv.editPicPath(filePath,fileName,"/upload/view/");
	        srv.updateDis(misId,count);
	        pathRet.set("misId", misId);
	        renderJson(pathRet);
		}
	}
	
	/**
	 * 图表分析
	 * 
	 * 2018年8月31日 上午10:19:57
	 */
	public void findEchartByDisId() {
		Integer disId = getParaToInt(0);
		setAttr("disId", disId);
		render("anaEchart.jsp");
	}
	
	/**
	 * 查看照片的比分
	 * 
	 * 2018年8月31日 上午10:18:50
	 */
	public void anaByUserCode() {
		String code = getPara("code");
		Integer disId = getParaToInt("disId");
		List<Record> data = srv.anaByUserCode(code,disId);
		renderJson(data);
	}
	
	/**
	 * 统计灾难视频中的男女比例
	 * 
	 * 2018年9月1日 下午4:22:21
	 */
	public void statisSex() {
		Integer disId = getParaToInt("disId");
		List<Record> data = srv.statisSex(disId);
		renderJson(data);
	}
	
	/**
	 * 视频中的血型分析
	 * 
	 * 2018年9月3日 上午9:56:05
	 */
	public void statisBlood() {
		Integer disId = getParaToInt("disId");
		Ret ret = srv.statisBlood(disId);
		renderJson(ret);
	}
	
	/**
	 * 年龄段分析
	 * 
	 * 2018年9月23日 上午9:02:11
	 */
	public void statisArea() {
		Integer disId = getParaToInt("disId");
		Ret ret = srv.statisArea(disId);
		renderJson(ret);
	}
	
	/**
	 * 分析受伤情况
	 * 
	 * 2018年9月23日 下午5:57:07
	 */
	public void statisSh() {
		Integer disId = getParaToInt("disId");
		List<Record> data = srv.statisSh(disId);
		renderJson(data);
	}
	
	/**
	 * 根据灾难地点获得视频列表
	 * 
	 * 2018年9月6日 下午5:15:23
	 */
	public void findVideo() {
		String addr = getPara("addr");
		Ret ret = srv.findVideo(addr);
		renderJson(ret);
	}
	
	/**
	 * 分析列表
	 * 
	 * 2018年8月30日 下午6:03:32
	 */
	public void findByDisId() {
		Integer disId = getParaToInt(0);
		Page<Record> resultList = srv.paginateResult(getParaToInt("p", 1),disId);
		setAttr("resultList", resultList);
		render("anaList.jsp");
	}
	
	/**
	 * 根据灾难获得视频的统计信息
	 * 
	 * 2018年9月25日 上午9:41:18
	 */
	public void findAllByVideo() {
		Integer disId = getParaToInt(0);
		Page<Record> resultList = srv.paginateVideoResult(getParaToInt("p", 1),disId);
		setAttr("resultList", resultList);
		Record record = srv.getTotal(disId);
		setAttr("record", record);
		render("anavideoList.jsp");
	}
}
