package zhrk.missing;
import com.jfinal.core.Controller;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import zhrk.common.model.QxMissing;
import zhrk.common.model.QxUserLibrary;
import zhrk.send.SendService;
import zhrk.utils.CountUtils;
import zhrk.utils.baidu.FaceMatch;

public class MissingController extends Controller{

	MissingService srv = MissingService.me;
	SendService seSrv = SendService.me;
	
	/**
	 * 失踪人员管理
	 */
	public void index(){
		Page<Record> missingList = srv.paginate(getParaToInt("p", 1));
		setAttr("missingList", missingList);
		render("list.jsp");
	}
	/**
	 * 已找到 管理
	 */
	public void doneindex(){
		Record user = getSessionAttr("user");
		String userId = "";
		String roleCode = "";
		if(user != null) {
			userId = user.getStr("ID");
			roleCode = user.getStr("ROLECODE");
		}
		Page<Record> missingList = srv.donepaginate(getParaToInt("p", 1),userId,roleCode);
		setAttr("missingList", missingList);
		render("donelist.jsp");
	}
	/**
	 * 搜寻中 管理
	 */
	public void doingindex(){
		Page<Record> missingList = srv.doingpaginate(getParaToInt("p", 1));
		setAttr("missingList", missingList);
		render("doinglist.jsp");
	}
	/**
	 * 公示信息
	 */
	public void publicindex(){
		Page<Record> missingList = srv.doingpaginate(getParaToInt("p", 1));
		setAttr("missingList", missingList);
		render("publiclist.jsp");
	}
	
	/**
	 * 登记失踪人员表单
	 */
	public void form(){
		Integer id = getParaToInt(0);
		List<QxMissing> missingList = srv.findMissingList();
		setAttr("missingList", missingList);
		setAttr("missingSize", missingList.size());
		if(id != null){
			QxMissing missing = srv.findModelById(id);
			setAttr("missing", missing);
		}
		render("form.jsp");
	}
	
	/**
	 * 登记失踪人口信息 
	 * 
	 * 2018年7月23日 下午5:11:53
	 */
	public void regiMiss() {
		render("userMp.jsp");
	}
	
	/**
	 * 图片上传
	 */
	public void imageUpload() {
		UploadFile uploadFile = getFile();//在磁盘上保存文件
		if(uploadFile == null) {
			renderJson(Ret.fail("msg", "请选择需要上传的文件。"));
		}else {
			String uploadPath = uploadFile.getUploadPath();//获取保存文件的文件夹
	        String fileName = uploadFile.getFileName();//获取保存文件的文件名
	        String filePath = uploadPath+"\\"+fileName;//保存文件的路径
	        Ret ret = srv.uploadImg(filePath,fileName,"/upload/");
	        renderJson(ret); 
		}
    }
	
	/**
	 * 志愿者上传图片进行对比
	 * 
	 * 2018年8月7日 上午11:36:53
	 */
	public void tempLoad() {
		UploadFile uploadFile = getFile("imageName", "\\temp\\");//在磁盘上保存文件
        String uploadPath = uploadFile.getUploadPath();//获取保存文件的文件夹
        String fileName = uploadFile.getFileName();//获取保存文件的文件名
        String filePath = uploadPath+fileName;//保存文件的路径
        Ret ret = srv.uploadImg(filePath,fileName,"/upload/temp/");
        renderJson(ret); 
	}

	/**
	 * 更新失踪人员信息
	 */
	public void upMissing(){
		QxMissing missing = getBean(QxMissing.class,"missing");
		Ret ret = srv.upMissing(missing);
		renderJson(ret);
	}
	
	/**
	 * 删除失踪人员信息
	 */
	public void delMissing(){
		Integer id = getParaToInt("id");
		QxMissing missing = srv.findModelById(id);
		Ret ret = srv.delMissing(missing);
		renderJson(ret);
	}
	
	public void findBycardId() {
		String cardId = getPara("cardId");
		QxUserLibrary data = srv.findBycardId(cardId);
		renderJson(data);
	}
	
	/**
	 * 登记失踪信息
	 * 
	 * 2018年8月11日 下午5:47:02
	 */
	public void missSub() {
		QxMissing mis = getBean(QxMissing.class,"mis");
		String misdate = getPara("misdate");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");//注意格式化的表达式
		try {
			Date d = format.parse(misdate);
			mis.setMisdate(d);
		} catch (ParseException e) {
			mis.setMisdate(new Date());
		}
		mis.setUserstate("失踪");//失踪，搜寻中，已找回
		mis.setInfstate("待审核未通过");
		Ret ret = srv.save(mis);
		renderJson(ret);
	}
	
	public void findById() {
		Integer id = getParaToInt("id");
		Record data = srv.findRecordById(id);
		renderJson(data);
	}
	
	/**
	 * 对失踪信息进行审核，审核通过，并将失踪人的状态变更为搜寻中
	 * 2018年7月25日 上午11:50:42
	 */
	public void finfs() {
		Integer id = getParaToInt("misId");
		String status = getPara("status");
		QxMissing missing = srv.findModelById(id);
		missing.setInfstate(status);
		if(("审核通过").equals(status)) {
			missing.setUserstate("搜寻中");
		}else {
			missing.setUserstate("信息作废");
		}
		Ret ret = srv.upMissing(missing);
		renderJson(ret);
	}
	
	/**
	 * 删除失踪信息
	 * 2018年7月25日 下午5:51:00
	 */
	public void delMis() {
		Integer id = getParaToInt("id");
		Ret ret = srv.delMis(id);
		renderJson(ret);
	}
	
	/**
	 * 失踪人口信息
	 * 2018年7月31日 下午4:04:31
	 */
	public void findMisById() {
		Integer mid = getParaToInt("id");
		QxMissing data = srv.findModelById(mid);
		renderJson(data);
	}
	
	/**
	 * 分析数据，调用不同的弹出框
	 * 2018年8月1日 下午3:04:07
	 */
	public void ansMis() {
		Integer id = getParaToInt("id");
		boolean flag = CountUtils.getCount();
		if(flag) {
			renderJson(Ret.ok("msg", "成功找到").set("misId", id));
		}else {
			renderJson(Ret.fail("msg", "未找到，上传平台").set("misId", id));
		}
	}
	
	/**
	 * 上传至公视平台
	 * 2018年8月1日 下午4:31:33
	 */
	public void upTopub() {
		Integer misId = getParaToInt("misId");
		QxMissing data = srv.findModelById(misId);
		data.setInfstate("上传公视平台");
		Ret ret = srv.upMissing(data);
		srv.toRePer(data,"失踪人员暂时未找到，已上传至公视平台，请留意推送信息",0);//上传公视平台时候，推送信息
		renderJson(ret);
	}
	
	/**
	 * 推送信息
	 * 
	 * 2018年8月1日 下午5:32:24
	 */
	public void toRePer() {
		Integer misId = getParaToInt("misId");
		String addr = getPara("addr");
		QxMissing data = srv.findModelById(misId);
		data.setInfstate("信息已推送");
		//data.setUserstate("已找到");
		Ret ret = srv.upMissing(data);
		srv.toRePer(data,"失踪人员已经找到，发现地点在" + addr,1);
		renderJson(ret);
	}
	
	/**
	 * 对上传照片进行分析
	 * 2018年8月8日 上午8:45:54
	 */
	public void ansPhoto(){
		String phoPath = getPara("phoPath");
		String newPath = getPara("newPath");
		Ret ret = FaceMatch.match("src/main/webapp"+phoPath, "src/main/webapp"+ newPath);
		renderJson(ret);
	}
	
	/**
	 * 对比上的照片数据进行提交保存
	 * 
	 * 2018年8月9日 下午5:24:50
	 */
	public void ansSub(){
		String newPath = getPara("newPath");
		Integer misId = getParaToInt("misId");
		String addr = getPara("addr");
		Integer score = getParaToInt("score");
		Integer reuser = getParaToInt("reuser");
		QxMissing data = srv.findModelById(misId);
		if(!data.getUserstate().equals("发现失踪者")) {
			data.setUserstate("发现失踪者");
			srv.upMissing(data);
		}
		Ret ret = srv.ansSub(newPath,misId,addr,reuser,score);
		renderJson(ret);
	}
	
	/**
	 * 根据失踪id对发现失踪者的信息显示轨迹
	 * 
	 * 2018年8月11日 下午5:01:10
	 */
	public void route() {
		Integer misId = getParaToInt("misId");
		List<Record> data = seSrv.getAreaList(misId);
		renderJson(data);
	}
	
	/**
	 * 变更失踪信息状态
	 * 
	 * 2018年8月11日 下午5:32:41
	 */
	public void toseState() {
		Integer misId = getParaToInt("misId");
		QxMissing missing = srv.findModelById(misId);
		missing.setUserstate("已找到");
		missing.setInfstate("已找到");
		Ret ret = srv.upMissing(missing);
		renderJson(ret);
	}

	/**
	 * 对照片数据进行分析
	 * 
	 * 2018年8月17日 上午11:12:05
	 */
	public void contrast() {
		Integer misId =  getParaToInt("misId");
		String[] addrs = getPara("addrs").split(">");
		String path = srv.getPicpath(misId);
		List<String> paths = srv.getImgPaths();	
		List<Record> data = srv.contrast(paths,path,misId,addrs[0]);
		renderJson(data);
	}
	
	/**
	 * 对视频进行分析，找出含有人物头像的视频截图
	 * 
	 * 2018年9月19日 下午12:01:28
	 */
	public void anasView() {
		String[] paths = getParaValues("path[]");
		if(paths == null || paths.length == 0) {
			renderJson(Ret.fail("msg", "视频未找到"));
			return;
		}
		List<Record> list = srv.getVideo(paths);
		Ret ret = srv.getImages(list);
		/*List<String> data = new ArrayList<>();
		if(ret.isOk()) {
			Integer count = ret.getInt("msg");
			data = srv.getPaths(count,data);
		}*/
		renderJson(ret);
	}
}
