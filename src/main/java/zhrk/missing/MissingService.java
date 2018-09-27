package zhrk.missing;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;
import org.opencv.core.Point;
import org.opencv.core.Rect;
import org.opencv.core.Scalar;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.videoio.VideoCapture;

import com.googlecode.javacv.cpp.opencv_highgui;
import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxMessage;
import zhrk.common.model.QxMissing;
import zhrk.common.model.QxPicLibrary;
import zhrk.common.model.QxSend;
import zhrk.common.model.QxUserLibrary;
import zhrk.utils.FileUtil;
import zhrk.utils.MapUtils;
import zhrk.utils.baidu.FaceMatch;
import zhrk.utils.waston.VideoToImgUtils;

public class MissingService {

	public static final MissingService me = new MissingService();
	private QxMissing dao = new QxMissing().dao();
	private QxUserLibrary ulDao = new QxUserLibrary().dao();
	private QxMessage mDao = new QxMessage().dao();
	private QxPicLibrary plDao = new QxPicLibrary().dao();
	
	/**
	 * 分页
	 * @param pager
	 * select a.id,b.name as re_user,c.name as mi_user,a.content,a.user_state,a.mis_date,a.reg_date,a.type,a.inf_state from qx_missing a,qx_user b,qx_user c where a.re_user = b.id and a.mi_user = c.id ORDER BY id DESC
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select a.id,b.name as reuser,b.tel,c.name as miuser,a.content,case when a.picpath is null then c.picpath else a.picpath end as picpath,a.userstate,to_char(a.misdate,'YYYY-MM-DD HH24:MI:SS') as misdate,a.regdate,a.type,a.infstate,c.usercode,c.tel as sztel,a.address,c.sex,a.userstate,a.infstate ", 
				"from qx_missing a,qx_user b,qx_user_library c where a.reuser = b.id and a.miuser = c.id ORDER BY a.id DESC");
	}
	/**
	 * 已找到的，历史记录分页
	 * @param roleCode 
	 * @param userId 
	 * @param pager
	 * select a.id,b.name as re_user,c.name as mi_user,a.content,a.user_state,a.mis_date,a.reg_date,a.type,a.inf_state from qx_missing a,qx_user b,qx_user c where a.re_user = b.id and a.mi_user = c.id ORDER BY id DESC
	 * @return
	 */
	public Page<Record> donepaginate(Integer pageNum, String userId, String roleCode) {
		String select = "select a.id,b.name as reuser,b.tel,c.name as miuser,a.content,case when a.picpath is null then c.picpath else a.picpath end as picpath,a.userstate,a.misdate,a.regdate,a.type,a.infstate,c.usercode,c.tel as sztel,a.address,c.sex,a.userstate,a.infstate ";
		StringBuffer from = new StringBuffer("from qx_missing a,qx_user b,qx_user_library c where a.reuser = b.id and a.miuser = c.id and a.userstate='已找到' ");
		if(roleCode.equals("volun")) {
			from.append(" and a.reuser = ? ");
			from.append(" ORDER BY a.id DESC");
			return Db.paginate(pageNum, 10, select, from.toString(), userId);
		}
		from.append(" ORDER BY a.id DESC");
		return Db.paginate(pageNum, 10, select, from.toString());
	}
	/**
	 * 搜寻中的，历史记录分页
	 * @param pager
	 * select a.id,b.name as re_user,c.name as mi_user,a.content,a.user_state,a.mis_date,a.reg_date,a.type,a.inf_state from qx_missing a,qx_user b,qx_user c where a.re_user = b.id and a.mi_user = c.id ORDER BY id DESC
	 * @return
	 */
	public Page<Record> doingpaginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select a.id,b.name as reuser,b.tel,c.name as miuser,a.content,case when a.picpath is null then c.picpath else a.picpath end as picpath,a.userstate,a.misdate,a.regdate,a.type,a.infstate,c.usercode,c.tel as sztel,a.address,c.sex,a.userstate,a.infstate  ", 
				"from qx_missing a,qx_user b,qx_user_library c where a.reuser = b.id and a.miuser = c.id and a.infstate='上传公视平台' ORDER BY a.id DESC");
	}
	/**
	 * 根据id查找失踪人员信息
	 * @param id
	 * @return
	 */
	public Record findById(Integer id) {
		Record user = Db.findFirst("SELECT id,re_user,mi_user,content,user_state,mis_date,reg_date,type,inf_state FROM qx_missing  WHERE id = ? ORDER BY id DESC", id);
		return user;
	}

	/**
	 * 更新
	 * @param Depart
	 * @return
	 */
	public Ret upMissing(QxMissing missing) {
		Boolean flag = missing.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public List<QxMissing> findMissingList() {
		return dao.find("select id,re_user,mi_user,content,user_state,mis_date,reg_date,type,inf_state from qx_missing order by id desc");
	}

	public QxMissing findModelById(Integer id) {
		return dao.findById(id);
	}
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public Ret delMissing(QxMissing menu) {
		Boolean flag = menu.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	/**
	 * @param cardId
	 * @return
	 * 2018年7月24日 上午10:49:55
	 */
	public QxUserLibrary findBycardId(String cardId) {
		return ulDao.findFirst("select * from qx_user_library where usercode = ?", cardId);
	}

	/**
	 * 失踪人口信息保存
	 * @param mis
	 * @return
	 * 2018年7月24日 上午11:58:04
	 */
	public Ret save(QxMissing mis) {
		Integer userId = mis.getMiuser();
		if(userId == null)
			return Ret.fail("msg", "失踪人身份证号不能为空");
		String addr = mis.getAddress();
		if(StrKit.isBlank(addr))
			return Ret.fail("msg", "失踪地点不能为空");
		Map<String,Object> map = MapUtils.java2Map(mis);
		boolean flag = mis.save(map);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	public Record findRecordById(Integer id) {
		return Db.findFirst("select a.id,b.name as reuser,b.tel,c.name as miuser,a.content,case when a.picpath is null then c.picpath else a.picpath end as picpath,a.userstate,a.misdate,a.regdate,a.type,a.infstate,c.usercode,c.tel as sztel,a.address,c.sex,a.userstate,a.infstate from qx_missing a,qx_user b,qx_user_library c where a.reuser = b.id and a.miuser = c.id and a.id = ? ", id);
	}

	public Ret delMis(Integer id) {
		Boolean flag = dao.deleteById(id);
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}
	
	/**
	 * 保存推送消息
	 * @param data
	 * @param msg 
	 * @param flag 
	 * @return
	 * 2018年8月1日 下午6:12:10
	 */
	public Ret toRePer(QxMissing data, String msg, Integer flag) {
		Integer misId = data.getId();
		Integer userId = data.getReuser();//接收信息人id
		QxMessage message = new QxMessage();
		String title = "推送消息提醒:";
		if(flag == 0) {
			title = title + "未找到，查看详情。";
		}else{
			title = title + "已找到，查看轨迹";
		}
		message.setTitle(title);
		message.setContent(msg);
		message.setMsid(misId);
		message.setSendtime(new Date());
		Map<String,Object> msgmap = MapUtils.java2Map(message);
		boolean re = message.save(msgmap);
		boolean sre = true;
		if(re) {
			QxMessage olm = mDao.findFirst("select * from qx_message order by id desc");
			QxSend send = new QxSend();
			send.setMesid(olm.getId());
			send.setUserid(userId);
			send.setRectime(new Date());
			send.setIsread("未查看");
			Map<String,Object> sendmap = MapUtils.java2Map(send);
			sre = send.save(sendmap);
		}
		if(re && sre)
			return Ret.ok("msg", "推送成功");
		return Ret.fail("msg", "推送失败");
	}
	
	/**
	 * 上传图片，上传至不同的文件夹里
	 * @param filePath
	 * @param fileName
	 * @param path 
	 * @return
	 * 2018年8月7日 上午11:33:47
	 */
	public Ret uploadImg(String filePath, String fileName, String path) {
		String extension = fileName.substring(fileName.lastIndexOf("."));
        if (".png".equals(extension) || ".jpg".equals(extension)
                || ".gif".equals(extension) || ".jpeg".equals(extension)
                || ".bmp".equals(extension)){
        	String resultFileName = FileUtil.instance.changeFileName(filePath,extension);//为了避免相同文件上传冲突，使用工具类重新命名
        	String src = path + resultFileName;
        	Ret ret = Ret.ok("src", src);
        	return ret;
        }else{
        	File source = new File(filePath);
        	source.delete();
        	Ret ret = Ret.fail("src", "只允许上传png,jpg,jpeg,gif,bmp类型的图片文件");
        	return ret;
        }
	}
	
	public Ret ansSub(String newPath, Integer misId, String addr, Integer reuser, Integer score) {
		if(misId == null)
			return Ret.fail("msg", "保存失败，失踪信息不存在。");
		QxPicLibrary picl = new QxPicLibrary();
		picl.setAddress(addr);
		picl.setMisid(misId);
		picl.setPicpath(newPath);
		picl.setCtime(new Date());
		picl.setUserid(reuser);
		Map<String,Object> piclmap = MapUtils.java2Map(picl);
		boolean flag = picl.save(piclmap);
		
		QxMessage message = new QxMessage();
		String title = "推送消息提醒:已发现疑似人员，对比相似度为："+score + "%";
		message.setTitle(title);
		message.setContent("在"+ addr + "附近发现失踪人");
		message.setMsid(misId);
		message.setSendtime(new Date());
		Map<String,Object> msgmap = MapUtils.java2Map(message);
		boolean re = message.save(msgmap);
		if(re) {
			QxMessage olm = mDao.findFirst("select * from qx_message order by id desc");
			QxMissing missing = findModelById(misId);
			QxSend send = new QxSend();
			send.setMesid(olm.getId());
			send.setUserid(missing.getReuser());
			send.setRectime(new Date());
			send.setIsread("未查看");
			Map<String,Object> sendmap = MapUtils.java2Map(send);
			send.save(sendmap);
		}
		if(flag)
			return Ret.ok("msg","信息上传成功");
		return Ret.fail("msg", "信息上传失败。");
	}
	
	/**
	 * 获取对视频截取的图片列表
	 * 
	 * @return 2018年8月17日 上午11:22:04
	 */
	public List<String> getImgPaths() {
		File file = new File("src/main/webapp/viewImg/img");
		if (!file.exists()) {
			return null;
		}
		String[] content = file.list();
		List<String> list = new ArrayList<>();
		for (String name : content) {
			list.add("src/main/webapp/viewImg/img/" + name);
		}
		return list;
	}
	
	/**
	 * 获取基础信息中的所有带照片的人物信息
	 * 
	 * @return 2018年8月17日 上午11:29:39
	 */
	public List<Record> getUserlist() {
		return Db.find("select *,0 as flag from qx_user_library where picpath is not null");
	}

	/**
	 * 调用接口对人物照片信息进行对比
	 * 
	 * @param paths
	 * @param addrs 
	 * @param misId 
	 * @param userList
	 * @return 2018年8月17日 上午11:36:45
	 */
	public List<Record> contrast(List<String> paths,String picPath, Integer misId, String addr) {
		if (paths.size() == 0)
			return null;
		List<Record> data = new ArrayList<>();
		for (String path : paths) {
			Ret ret = FaceMatch.match(path, "src/main/webapp" + picPath);
			if (ret.isOk()) {
				Integer score = ret.getInt("score");
				if (score > 50) {
					QxPicLibrary pl = plDao.findFirst("select * from qx_pic_library where misid = ? and address = ? ", misId,addr);
					if(pl == null) {
						pl = new QxPicLibrary();
						pl.setAddress(addr);
						pl.setCtime(new Date());
						pl.setMisid(misId);
						pl.setPicpath("/viewImg/reimg/" + FileUtil.instance.changepicName(path, ".jpg"));
						Map<String,Object> plmap = MapUtils.java2Map(pl);
						pl.save(plmap);
					}
					Record userLibrary = new Record();
					userLibrary.set("FLAG", 1);
					userLibrary.set("SCORE", score);
					userLibrary.set("PICPATH", path.replace("src/main/webapp", ""));
					data.add(userLibrary);
				}
			}
		}
		data.add(0, new Record().set("addr", addr));
		return data;
	}
	
	/**
	 * 根据失踪id获得失踪信息的图片路径，如果没有相关的上传图片，就取人物信息库的图片信息
	 * @param misId
	 * @return
	 * 2018年9月12日 下午3:31:26
	 */
	public String getPicpath(Integer misId) {
		QxMissing missing = findModelById(misId);
		if(missing == null)
			return null;
		String path = missing.getPicpath();
		if(path != null)
			return path;
		QxUserLibrary ul = ulDao.findById(missing.getMiuser());
		return ul.getPicpath();
	}
	/**
	 * 根据视频id获取详细视频信息
	 * @param paths
	 * @return
	 * 2018年9月17日 下午3:04:28
	 */
	public List<Record> getVideo(String[] paths) {
		List<Record> list = new ArrayList<>();
		for(String pathId : paths) {
			Record record = Db.findFirst("select vl.id,ca.id as addrId,ca.address || '--' || ca.camname as address,vl.videopath from qx_video_library vl,qx_camarea ca where vl.camid = ca.id and vl.id = ? ", pathId);
			list.add(record);
		}
		return list;
	}


	public Ret getImages(List<Record> list) {
		Integer count = 0;
		System.out.println("开始分析图片");
		deleteDir("src/main/webapp/viewImg/img");
		List<Record> data = new ArrayList<>();
		for (Record video : list) {
			Record record = new Record();
			record.set("address", video.getStr("ADDRESS"));
			record.set("id", video.getStr("ID"));
			record.set("addrId", video.getStr("ADDRID"));
			String path = "src/main/webapp" + video.getStr("VIDEOPATH");
			System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
			// 读取视频文件
			VideoCapture cap = new VideoCapture(path);
			// 判断视频是否打开
			if (cap.isOpened()) {
				double frameCount = cap.get(opencv_highgui.CV_CAP_PROP_FRAME_COUNT);
				double fps = cap.get(opencv_highgui.CV_CAP_PROP_FPS);
				double len = frameCount / fps;
				Double d_s = new Double(len);
				Mat frame = new Mat();
				List<String> paths = new ArrayList<>();
				for (int i = 0; i < d_s.intValue(); i++) {
					cap.set(opencv_highgui.CV_CAP_PROP_POS_MSEC, i * 3000);
					if (cap.read(frame)) {
						count++;
						String fileName = "src/main/webapp/viewImg/img/" + count + ".jpg";
						Imgcodecs.imwrite(fileName, frame);
						Mat image = Imgcodecs.imread(new File(fileName).getAbsolutePath());
						MatOfRect faceDetections = new MatOfRect();
						String xmlPath = VideoToImgUtils.class.getClassLoader()
								.getResource("haarcascade_frontalface_alt.xml").getPath().substring(1);
						CascadeClassifier faceDetector = new CascadeClassifier(xmlPath);
						faceDetector.detectMultiScale(image, faceDetections);
						if (faceDetections.toArray().length == 0) {
							File file = new File(fileName);
							file.delete();
						} else {
							for (Rect rect : faceDetections.toArray()) {
								Imgproc.rectangle(image, new Point(rect.x, rect.y),
										new Point(rect.x + rect.width, rect.y + rect.height), new Scalar(0, 0, 255), 2);
							}
							Imgcodecs.imwrite(fileName, image);
							paths.add(fileName.replace("src/main/webapp", ""));
						}//
					}
				}//for end
				 record.set("paths", paths);
				cap.release();
			}
			data.add(record);
		}
		if (count == 0)
			return Ret.fail("msg", "视频未读取到");
		return Ret.ok("msg", data);
	}

	/**
	 * 清空文件夹中的内容
	 * 
	 * @param path
	 * @return 2018年8月17日 上午10:46:05
	 */
	public static boolean deleteDir(String path) {
		File file = new File(path);
		if (!file.exists()) {// 判断是否待删除目录是否存在
			System.err.println("The dir are not exists!");
			return false;
		}

		String[] content = file.list();// 取得当前目录下所有文件和文件夹
		for (String name : content) {
			File temp = new File(path, name);
			if (temp.isDirectory()) {// 判断是否是目录
				deleteDir(temp.getAbsolutePath());// 递归调用，删除目录里的内容
			} else {
				if (!temp.delete()) {// 直接删除文件
					System.err.println("Failed to delete " + name);
				}
			}
		}
		return true;
	}

}
