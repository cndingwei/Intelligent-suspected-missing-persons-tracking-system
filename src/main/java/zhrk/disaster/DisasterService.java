package zhrk.disaster;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

import zhrk.common.model.QxCamarea;
import zhrk.common.model.QxDisResult;
import zhrk.common.model.QxDisUser;
import zhrk.common.model.QxDisaster;
import zhrk.utils.CountUtils;
import zhrk.utils.FileUtil;
import zhrk.utils.MapUtils;
import zhrk.utils.baidu.FaceMatch;
import zhrk.utils.waston.AnalytisPicUtil;
import zhrk.utils.waston.ClassScorePo;
import zhrk.utils.waston.VideoToImgUtils;

public class DisasterService {

	public static final DisasterService me = new DisasterService();
	private QxDisaster dao = new QxDisaster().dao();
	private QxCamarea caDao = new QxCamarea().dao();

	/**
	 * 分页
	 * 
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select id,dname,code,address,content,opentime ",
				"from qx_disaster ORDER BY id DESC");
	}

	/**
	 * 根据id查找灾难信息
	 * 
	 * @param id
	 * @return
	 */
	public QxDisaster findById(Integer id) {
		return dao.findById(id);
	}

	/**
	 * public Record findById(Integer id) { Record disasters = Db.findFirst("select
	 * id,dname,code,content,opentime from qx_disaster WHERE id = ? ORDER BY id
	 * DESC", id); return disasters; }
	 */

	/**
	 * 查找所有灾难信息
	 * 
	 * @return
	 */

	public List<QxDisaster> findDisasterList() {
		return dao.find("select id,dname,content,open_time from qx_disaster order by id desc");
	}

	public QxDisaster findModelById(Integer id) {
		return dao.findById(id);
	}

	/**
	 * 创建灾难
	 * 
	 * @param role
	 * @return
	 */
	public Ret addDisaster(QxDisaster disaster) {
		String name = disaster.getDname();
		if (StrKit.isBlank(name))
			return Ret.fail("msg", "灾难名称不能为空");
		if (StrKit.isBlank(disaster.getAddress()))
			return Ret.fail("msg", "请填写或者选择发生地点");
		Map<String, Object> map = MapUtils.java2Map(disaster);
		Boolean flag = disaster.save(map);
		if (flag)
			return Ret.ok("msg", "创建成功");
		return Ret.fail("msg", "创建失败");
	}

	/**
	 * 更新灾难信息
	 * 
	 * @param Depart
	 * @return
	 */
	public Ret upDisaster(QxDisaster disaster) {
		Boolean flag = disaster.update();
		if (flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	/**
	 * 删除灾难
	 * @param id 
	 * 
	 * @param user
	 * @return
	 */
	public Ret delDisaster(QxDisaster disaster, Integer id) {
		Boolean flag = disaster.delete();
		Db.delete("delete from qx_dis_user where disid = ? ", id);
		Db.delete("delete from qx_dis_result where disid = ? ", id);
		if (flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	public List<String> getPaths(Integer count, List<String> data) {
		if (count > 0) {
			for (int i = 0; i < count; i++) {
				String path = "/viewImg/img/" + i + ".jpg";
				File file = new File("src/main/webapp" + path);
				if (!file.exists())
					continue;
				data.add(path);
			}
		}
		return data;
	}

	/**
	 * 获取对视频截取的图片列表
	 * @param flag 
	 * 
	 * @return 2018年8月17日 上午11:22:04
	 */
	public List<String> getImgPaths(Integer flag) {
		String path = "";
		if(flag == null  || flag == 0) {
			path = "src/main/webapp/viewImg/img";
		}else {
			path = "src/main/webapp/viewImg/10";
		}
		File file = new File(path);
		if (!file.exists()) {
			return null;
		}
		String[] content = file.list();
		List<String> list = new ArrayList<>();
		for (String name : content) {
			list.add(path + "/" + name);
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
	 * @param userList
	 * @return 2018年8月17日 上午11:36:45
	 */
	public List<Record> contrast(List<String> paths, List<Record> userList) {
		if (paths.size() == 0 || userList.size() == 0)
			return null;
		List<Record> data = new ArrayList<>();
		for (String path : paths) {
			for (Record userLibrary : userList) {
				Integer flag = userLibrary.getInt("FLAG");
				if (flag == 1)
					continue;
				String picPath = "src/main/webapp" + userLibrary.getStr("PICPATH");

				Ret ret = FaceMatch.match(path, picPath);
				if (ret.isOk()) {
					Integer score = ret.getInt("score");
					if (score > 50) {
						userLibrary.set("FLAG", 1);
						data.add(userLibrary);
					}
				}
			}
		}
		return data;
	}

	/**
	 * IBM图片对比比较
	 * 
	 * @param paths
	 * @param disId
	 * @param viewId 
	 * @return 2018年8月27日 下午6:28:17
	 */
	public List<Record> contrastByIbm(List<String> paths, Integer disId, Integer viewId) {
		if (paths.size() == 0)
			return null;
		Set<String> set = new HashSet<String>();
		List<QxDisResult> reList = new ArrayList<>();
		for (String path : paths) {
			/*
			 * boolean flag = AnalytisPicUtil.faceAnalytis(path); if(!flag) continue;
			 */
			System.out.println("开始时间 ："+ new Date());
			List<ClassScorePo> classList = AnalytisPicUtil.getClassScore(path);
			System.out.println("结束时间：" + new Date());
			if (classList == null || classList.size() == 0)
				continue;
			String userCode = classList.get(0).getClassName();
			String score = classList.get(0).getScore();
			String resultFileName = FileUtil.instance.changepicName(path, ".jpg");
			QxDisResult po = new QxDisResult();
			po.setUsercode(userCode);
			po.setPicture("/viewImg/reimg/" + resultFileName);
			po.setScore(score);
			po.setDisid(disId);
			reList.add(po);
			set.add(userCode);
		}
		if (set.size() == 0)
			return null;
		List<Record> list = new ArrayList<>();
		for (String code : set) {
			Record record = Db.findFirst("select * from  qx_user_library where usercode = ? ", code);
			if (record == null)
				continue;
			Integer userId = record.getInt("ID");
			StringBuffer sql = new StringBuffer("select * from qx_dis_user where userId = ? and disid = ? ");
			List<Object> li = new ArrayList<Object>();
			li.add(userId);
			li.add(disId);
			if(viewId != null) {
				sql.append(" and videoid = ? ");
				li.add(viewId);
			}
			Record du = Db.findFirst(sql.toString(),li.toArray());
			if (du != null)
				continue;
			QxDisUser disUser = new QxDisUser();
			disUser.setUserid(userId);
			disUser.setDisid(disId);
			if(viewId != null) {
				disUser.setVideoid(viewId);
			}
			disUser.setStatus(CountUtils.getForInte());
			Map<String, Object> map = MapUtils.java2Map(disUser);
			disUser.save(map);
			list.add(record);
		}
		if (reList.size() == 0)
			return list;
		for (QxDisResult disResult : reList) {
			Map<String, Object> map = MapUtils.java2Map(disResult);
			disResult.save(map);
		}
		return list;
	}

	public Ret editPicPath(String filePath, String fileName, String path) {
		String extension = fileName.substring(fileName.lastIndexOf("."));
		if (".mp4".equals(extension) || ".avi".equals(extension) || ".rmvb".equals(extension)
				|| ".rm".equals(extension)) {
			String resultFileName = FileUtil.instance.changeFileName(filePath, extension);// 为了避免相同文件上传冲突，使用工具类重新命名
			String src = path + resultFileName;
			Ret ret = Ret.ok("msg", src);
			return ret;
		} else {
			File source = new File(filePath);
			source.delete();
			Ret ret = Ret.fail("msg", "只允许上传mp4,rmvb,rm,avi类型的图片文件");
			return ret;
		}
	}

	public Page<Record> paginateResult(Integer paraToInt, Integer disId) {
		return Db.paginate(paraToInt, 20, "select ul.*,du.disid,ca.address || ca.camname as videoname ",
				"from qx_user_library ul,qx_dis_user du,qx_video_library vl,qx_camarea ca where ul.id =du.userid and du.videoid = vl.id and vl.camid = ca.id and du.disid = ? ", disId);
	}

	/**
	 * 根据身份证号查询比对结果
	 * 
	 * @param code
	 * @param disId
	 * @return 2018年8月31日 上午8:42:14
	 */
	public List<Record> anaByUserCode(String code, Integer disId) {
		List<Record> list = Db.find("select * from qx_dis_result where usercode = ? and disid = ? order by score desc",
				code, disId);
		return list;
	}

	public Ret getImages(String[] paths) {
		Integer count = 0;
		for (String path : paths) {
			path = "src/main/webapp" + path;
			System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
			// 读取视频文件
			VideoCapture cap = new VideoCapture(path);
			// 判断视频是否打开
			if (cap.isOpened()) {
				// 总帧数
				double frameCount = cap.get(opencv_highgui.CV_CAP_PROP_FRAME_COUNT);
				// 帧率
				double fps = cap.get(opencv_highgui.CV_CAP_PROP_FPS);
				// 时间长度
				double len = frameCount / fps;
				Double d_s = new Double(len);
				Mat frame = new Mat();
				deleteDir("src/main/webapp/viewImg/img");
				for (int i = 0; i < d_s.intValue(); i++) {
					// 设置视频的位置(单位:毫秒)
					cap.set(opencv_highgui.CV_CAP_PROP_POS_MSEC, i * 1000);
					// 读取下一帧画面
					if (cap.read(frame)) {
						count++;
						// 保存画面到本地目录
						String fileName = "src/main/webapp/viewImg/img/" + count + ".jpg";
						Imgcodecs.imwrite(fileName, frame);
						Mat image = Imgcodecs.imread(new File(fileName).getAbsolutePath());
						// 初始化人脸识别类
						MatOfRect faceDetections = new MatOfRect();
						// 添加识别模型
						String xmlPath = VideoToImgUtils.class.getClassLoader()
								.getResource("haarcascade_frontalface_alt.xml").getPath().substring(1);
						CascadeClassifier faceDetector = new CascadeClassifier(xmlPath);
						// 识别脸
						faceDetector.detectMultiScale(image, faceDetections);
						if (faceDetections.toArray().length == 0) {
							File file = new File(fileName);
							file.delete();
						} else {
							// 画出脸的位置
							for (Rect rect : faceDetections.toArray()) {
								Imgproc.rectangle(image, new Point(rect.x, rect.y),
										new Point(rect.x + rect.width, rect.y + rect.height), new Scalar(0, 0, 255), 2);
							}
							Imgcodecs.imwrite(fileName, image);
						}
					}
				}
				// 关闭视频文件
				cap.release();
			}
		}
		if (count == 0)
			return Ret.fail("msg", "视频未读取到");
		return Ret.ok("msg", count);
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

	public List<Record> statisSex(Integer disId) {
		List<Record> list = Db.find(
				"SELECT Q.name, Q.value FROM (select sum(case when ul.sex = 'male' then 1 else 0 end) as male,sum(case when ul.sex = 'female' then 1 else 0 end) as female,du.disid from (select distinct userid,disid from qx_dis_user) du,qx_user_library ul where du.userid = ul.id and du.disid = ? group by du.disid) AS S,TABLE (VALUES('male', S.male),('female', S.female)) AS Q(name, value)",
				disId);
		if (list.size() == 0)
			return null;
		List<Record> lowList = new ArrayList<>();
		for (Record record : list) {
			Record re = new Record();
			re.set("name", record.get("NAME"));
			re.set("value", record.get("VALUE"));
			lowList.add(re);
		}
		return lowList;
	}

	public Ret statisBlood(Integer disId) {
		List<Record> bloodList = Db.find(
				"SELECT Q.name, Q.value FROM (select sum(case when ul.blood = 'A' then 1 else 0 end) as A,sum(case when ul.blood = 'B' then 1 else 0 end) as B,sum(case when ul.blood = 'AB' then 1 else 0 end) as AB,sum(case when ul.blood = 'O' then 1 else 0 end) as O,du.disid from (select distinct userid,disid from qx_dis_user) du,qx_user_library ul where du.userid = ul.id and du.disid = ? group by du.disid) AS S,TABLE (VALUES('A', S.A),('B', S.B),('AB', S.AB),('O', S.O)) AS Q(name, value)",
				disId);
		if (bloodList.size() == 0)
			return Ret.fail("msg", "，没有数据");
		List<String> nameList = new ArrayList<>();
		List<Integer> valueList = new ArrayList<>();
		for (Record record : bloodList) {
			String name = record.get("NAME");
			Integer value = record.getInt("VALUE");
			nameList.add(name);
			valueList.add(value);
		}
		return Ret.ok().set("name", nameList).set("value", valueList);
	}

	/**
	 * 根据灾难地点获取视频列表
	 * 
	 * @param addr
	 * @return 2018年9月6日 下午5:18:39
	 */
	public Ret findVideo(String addr) {
		if (StrKit.isBlank(addr))
			return Ret.fail("msg", "未找到视频信息");
		List<QxCamarea> caList = caDao.find("select id,camname,address from qx_camarea where address = ? ", addr);
		if (caList == null || caList.size() == 0)
			return Ret.fail("msg", "未找到视频信息");
		Integer flag = 0;
		List<Record> list = new ArrayList<>();
		for (QxCamarea cam : caList) {
			List<Record> videoList = Db.find("select id,videopath from qx_video_library where camid = ? ", cam.getId());
			if (videoList == null || videoList.size() == 0)
				continue;
			Record record = new Record();
			record.set("CAMNAME", cam.getCamname());
			record.set("VIDEOS", videoList);
			list.add(record);
			flag++;
		}
		if (flag == 0)
			return Ret.fail("msg", "未找到视频信息");
		return Ret.ok("msg", list);
	}

	/**
	 * 统计年龄段
	 * @param disId
	 * @return
	 * 2018年9月23日 上午9:48:43
	 */
	public Ret statisArea(Integer disId) {
		List<Record> list = Db.find("select ul.id,ul.birty from (select distinct userid,disid from qx_dis_user) du,qx_user_library ul where du.disid = ? and du.userid = ul.id", disId);
		if(list.size() == 0)
			return Ret.fail("msg", "没有数据");
		List<String> names = CountUtils.getAreas();
		Map<String,Integer> map = new HashMap<>();
		for(Record record :list) {
			Date birty = record.getDate("BIRTY");
			if(birty == null)
				continue;
			String arName = CountUtils.getAgeName(birty);
			if(!map.containsKey(arName)) {
				map.put(arName, 1);
			}else {
				Integer count = map.get(arName);
				map.put(arName, count+1);
			}
		}
		List<Integer> values = new ArrayList<>();
		for(String name:names) {
			if(map.containsKey(name)) {
				values.add(map.get(name));
			}else {
				values.add(0);
			}
		}
		return Ret.ok().set("name", names).set("value", values);
	}

	/**
	 * 更新灾难的受伤人数
	 * @param misId
	 * @param count
	 * 2018年9月23日 下午5:28:22
	 */
	public void updateDis(Integer misId, Integer count) {
		QxDisaster disaster = dao.findById(misId);
		if(disaster != null) {
			Integer discount = disaster.getCount();
			if(discount == null) {
				disaster.setCount(count);
			}else {
				disaster.setCount(discount + count);
			}
			disaster.update();
		}
	}

	/**
	 * 分析受伤情况
	 * @param disId
	 * @return
	 * 2018年9月23日 下午5:57:43
	 */
	public List<Record> statisSh(Integer disId) {
		QxDisaster disaster = dao.findById(disId);
		if(disaster == null)
			return null;
		Integer count = disaster.getCount();
		List<Record> list = new ArrayList<>();
		Record disuser = Db.findFirst("select count(du.userid) as count from (select distinct userid,disid from qx_dis_user) du where du.disid = ? ", disId);
		if(count == null) {
			list.add(new Record().set("name", "Injured").set("value", 0));
			list.add(new Record().set("name","Not injured").set("value", disuser.getInt("COUNT")));
		}else {
			Integer total = disuser.getInt("COUNT");
			if(count > total) {
				list.add(new Record().set("name","Injured").set("value", total));
				list.add(new Record().set("name","Not injured").set("value", 0));
			}else {
				list.add(new Record().set("name","Injured").set("value", count));
				list.add(new Record().set("name","Not injured").set("value", total - count));
			}
		}
		return list;
	}

	/**
	 * 通过视频id 查找视频路径
	 * @param viewId
	 * @return
	 * 2018年9月24日 下午10:25:33
	 */
	public String getPathById(Integer viewId) {
		Record record = Db.findFirst("select * from QX_VIDEO_LIBRARY where id = ? ", viewId);
		if(record == null)
			return null;
		return record.getStr("VIDEOPATH");
	}

	/**
	 * 查看各个视频统计数据
	 * @param paraToInt
	 * @param disId
	 * @return
	 * 2018年9月25日 上午10:30:56
	 */
	public Page<Record> paginateVideoResult(Integer paraToInt, Integer disId) {
		String select = "select c.id, c.disid,c.videoname,c.count,case when b.mcount is null then 0 else b.mcount end as mcount,case when d.count is null then 0 else d.count end as wmcount,case when e.count is null then 0 else e.count end as acount,case when f.count is null then 0 else f.count end as bcount,case when g.count is null then 0 else g.count end as abcount,case when h.count is null then 0 else h.count end as ocount,"
				+ "case when k.count is null then 0 else k.count end as shcount,case when m.count is null then 0 else m.count end as qscount,case when n.count is null then 0 else n.count end as zscount,case when o.count is null then 0 else o.count end as alrcount,case when p.count is null then 0 else p.count end as diecount ";
		return Db.paginate(paraToInt, 10, select, 
				" from (" + 
				" select a.id,a.disid,a.videoname,count(a.id) as count from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id and du.disid = ? and du.userid = u.id and du.videoid = vl.id)a group by a.id,a.disid,a.videoname" + 
				" )c left join (select a.id,a.sex,count(a.id) as  mcount from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id " + 
				" and du.disid = ? and du.userid = u.id and du.videoid = vl.id and u.sex = 'male')a group by a.id,a.sex)b " + 
				" on c.id = b.id " + 
				" left join (select a.id,a.sex,count(a.id) as count from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id " + 
				" and du.disid = ? and du.userid = u.id and du.videoid = vl.id and u.sex = 'female')a group by a.id,a.sex)d " + 
				" on c.id = d.id " + 
				" left join (select a.id,count(a.id) as count from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id " + 
				" and du.disid = ? and du.userid = u.id and du.videoid = vl.id and u.blood = 'A')a group by a.id)e " + 
				" on c.id = e.id " + 
				" left join (select a.id,count(a.id) as count from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id " + 
				" and du.disid = ? and du.userid = u.id and du.videoid = vl.id and u.blood = 'B')a group by a.id)f " + 
				" on c.id = f.id " + 
				" left join (select a.id,count(a.id) as count from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id " + 
				" and du.disid = ? and du.userid = u.id and du.videoid = vl.id and u.blood = 'AB')a group by a.id)g" + 
				" on c.id = g.id " + 
				" left join (select a.id,count(a.id) as count from (" + 
				" select vl.id,du.disid,ca.address || ca.camname as videoname,u.name,u.sex,u.birty,u.blood " + 
				" from qx_dis_user du,qx_user_library u,qx_video_library vl,qx_camarea ca where vl.camid = ca.id " + 
				" and du.disid = ? and du.userid = u.id and du.videoid = vl.id and u.blood = 'O')a group by a.id)h " + 
				" on c.id = h.id "
				+ " left join (select videoid as id,count(id) as count from qx_dis_user where disid = ? and status != 0 group by videoid)k"
				+ " on c.id = k.id" + 
				" left join (select videoid as id,count(id) as count from qx_dis_user where disid = ? and status = 1 group by videoid)m" 
				+ " on c.id = m.id" +
				" left join (select videoid as id,count(id) as count from qx_dis_user where disid = ? and status = 2 group by videoid)n" 
				+ " on c.id = n.id" +
				" left join (select videoid as id,count(id) as count from qx_dis_user where disid = ? and status = 3 group by videoid)o"
				+ " on c.id = o.id" +  
				" left join (select videoid as id,count(id) as count from qx_dis_user where disid = ? and status = 4 group by videoid)p"
				+ " on c.id = p.id", disId, disId, disId, disId, disId, disId, disId, disId, disId, disId, disId, disId);
	}

	/**
	 * 统计该次灾难的数据
	 * @param disId
	 * @return
	 * 2018年9月25日 下午2:33:45
	 */
	public Record getTotal(Integer disId) {
		return Db.findFirst("select id,dname,(select count(du.id) as tcount from qx_dis_user du where du.disid = ? and du.videoid is not null) as count," + 
				" (select count(ul.id) as mcount from qx_dis_user du,qx_user_library ul where du.disid = ? and du.userid = ul.id and ul.sex = 'male' and du.videoid is not null) as mcount," + 
				" (select count(ul.id) from qx_dis_user du,qx_user_library ul where du.disid = ? and du.userid = ul.id and ul.sex = 'female' and du.videoid is not null) as wmcount," + 
				" (select count(ul.id) from qx_dis_user du,qx_user_library ul where du.disid = ? and du.userid = ul.id and ul.blood = 'A' and du.videoid is not null) as acount," + 
				" (select count(ul.id) from qx_dis_user du,qx_user_library ul where du.disid = ? and du.userid = ul.id and ul.blood = 'B' and du.videoid is not null) as bcount," + 
				" (select count(ul.id) from qx_dis_user du,qx_user_library ul where du.disid = ? and du.userid = ul.id and ul.blood = 'AB' and du.videoid is not null) as abcount," + 
				" (select count(ul.id) from qx_dis_user du,qx_user_library ul where du.disid = ? and du.userid = ul.id and ul.blood = 'O' and du.videoid is not null) as ocount," + 
				" (select count(*) from qx_dis_user where disid = ? and status != 0) as shcount,(select count(*) from qx_dis_user where disid = ? and status = 1) as qscount,(select count(*) from qx_dis_user where disid = ? and status = 2) as zscount,(select count(*) from qx_dis_user where disid = ? and status = 3) as alrcount,(select count(*) from qx_dis_user where disid = ? and status = 4) as diecount,'' as recuname " + 
				" from qx_disaster where id = ? ",disId,disId,disId,disId,disId,disId,disId,disId,disId,disId,disId,disId,disId);
	}

	
}
