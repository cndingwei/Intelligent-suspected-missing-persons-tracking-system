package zhrk.video;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import zhrk.common.model.QxVideoLibrary;
import zhrk.utils.FileUtil;
import zhrk.utils.MapUtils;

public class VideoService {

	public static final VideoService me = new VideoService();
	private QxVideoLibrary dao = new QxVideoLibrary().dao();
	
	/**
	 * 分页获得部门列表信息
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select ca.address,ca.camname,vl.* ",
				"from qx_video_library vl,qx_camarea ca where vl.camid = ca.id order by vl.createtime desc");
	}

	/**
	 * 校验
	 * @return
	 */
	public boolean valid(Date start,Date end,Integer camid) {
		StringBuffer sql = new StringBuffer("select * from qx_video_library where 1=1 ");
		List<Object> li = new ArrayList<Object>();
		if(start != null){
			sql.append(" and starttime = ?");
			li.add(start);
		}
		if(end != null){
			sql.append(" and endtime = ?");
			li.add(end);
		}
		if(camid != null) {
			sql.append(" and camid = ? ");
			li.add(camid);
		}
		List<QxVideoLibrary> list = dao.find(sql.toString(), li.toArray());
		if (list.size() == 0)
			return true;
		else {
			return false;
		}
	}

	/**
	 * 添加
	 * @param Depart
	 * @return
	 */
	public Ret addVideo(QxVideoLibrary video) {
		Integer camId = video.getCamid();
		Date start = video.getStarttime();
		if(start == null) {
			deleteVideo(video.getVideopath());
			return Ret.fail("msg", "视频开始时间必填");
		}
		Date end = video.getEndtime();
		if(end == null) {
			deleteVideo(video.getVideopath());
			return Ret.fail("msg", "视频结束时间必填");
		}
		if(FileUtil.compareDate(start, end) != 1) {
			deleteVideo(video.getVideopath());
			return Ret.fail("msg", "结束时间应晚于开始时间");
		}
		boolean vaflag = valid(start,end,camId);
		if(!vaflag) {
			return Ret.fail("msg", "该监控对应的该时间已上传有视频");
		}
		video.setCreatetime(new Date());
		Map<String,Object> videomap = MapUtils.java2Map(video);
		boolean flag = video.save(videomap);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}
	
	
	private void deleteVideo(String path) {
		File file = new File("src/main/webapp"+path);
		if(file.exists()) {
			file.delete();
		}
	}

	/**
	 * 删除
	 * @param user
	 * @return
	 */
	public Ret delVideo(QxVideoLibrary video) {
		deleteVideo(video.getVideopath());
		Boolean flag = video.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
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

	public QxVideoLibrary findModelById(Integer id) {
		return dao.findById(id);
	}

}
