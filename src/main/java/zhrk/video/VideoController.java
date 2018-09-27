package zhrk.video;
import com.jfinal.core.Controller;

import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import zhrk.common.model.QxVideoLibrary;

public class VideoController extends Controller{

	VideoService srv = VideoService.me;
	
	/**
	 * 视频信息列表
	 */
	public void index(){
		Page<Record> videoList = srv.paginate(getParaToInt("p", 1));
		setAttr("videoList", videoList);
		render("list.jsp");
	}
	
	/**
	 * 新增
	 */
	public void addVideo(){
		try {
			UploadFile uploadFile = getFile("videoName", "\\video\\");//在磁盘上保存文件
			if(uploadFile == null) {
				renderJson(Ret.fail("msg", "请选择上传的视频文件。"));
			}else {
				String uploadPath = uploadFile.getUploadPath();//获取保存文件的文件夹
				String fileName = uploadFile.getFileName();//获取保存文件的文件名
				String filePath = uploadPath+fileName;//保存文件的路径
				Ret pathRet = srv.editPicPath(filePath,fileName,"/upload/video/");
				if(pathRet.isOk()) {
					String path = pathRet.getStr("msg");
					QxVideoLibrary video = getBean(QxVideoLibrary.class,"video");
					video.setVideopath(path);
					Ret ret = srv.addVideo(video);
					renderJson(ret);
				}else {
					renderJson(pathRet);
				}
			}
		} catch (Exception e) {
			renderJson(Ret.fail("msg", "上传视频过大，应小于100M."));
		}
	}
	
	/**
	 * 删除
	 */
	public void delVideo(){
		Integer id = getParaToInt("id");
		QxVideoLibrary video = srv.findModelById(id);
		Ret ret = srv.delVideo(video);
		renderJson(ret);
	}
}
