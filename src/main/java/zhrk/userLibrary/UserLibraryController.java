package zhrk.userLibrary;

import com.jfinal.core.Controller;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;

import zhrk.common.model.QxUserLibrary;

public class UserLibraryController extends Controller{

	UserLibraryService srv = UserLibraryService.me;
	
	/**
	 * 人员列表
	 */
	public void index(){
		Page<QxUserLibrary> userLibraryList = srv.paginate(getParaToInt("p", 1));
		setAttr("userLibraryList", userLibraryList);
		render("list.jsp");
	}
	
	/**
	 * 新增人员
	 */
	public void form(){
		Integer id = getParaToInt(0);
		if(id != null){
			QxUserLibrary userLibrary = srv.findById(id);
			setAttr("userLibrary", userLibrary);
		}
		render("form.jsp");
	}
	
	
	/**
	 * 校验身份证号
	 */
	public void validCode(){
		Integer id = getParaToInt(0);
		String code = getPara("param");
		String name = "";
		boolean l = srv.valid(name,code,id);
		if (l)
			renderJson("{\"info\":\"\",\"status\":\"y\"}");
		else
			renderJson("{\"info\":\"该人员信息已存在\",\"status\":\"n\"}");
	}
	
	/**
	 * 新增人员
	 */
	public void addUserLibrary(){
		UploadFile uploadFile = getFile("imageName", "\\photo\\");//在磁盘上保存文件
        String uploadPath = uploadFile.getUploadPath();//获取保存文件的文件夹
        String fileName = uploadFile.getFileName();//获取保存文件的文件名
        String filePath = uploadPath+fileName;//保存文件的路径
        Ret pathRet = srv.editPicPath(filePath,fileName,"/upload/photo/");
        if(pathRet.isOk()) {
        	String path = pathRet.getStr("msg");
        	QxUserLibrary userLibrary = getBean(QxUserLibrary.class,"userLibrary");
        	userLibrary.setPicpath(path);
    		Ret ret = srv.addUserLibrary(userLibrary);
    		renderJson(ret);
        }else {
        	renderJson(pathRet);
        }
		
	}
	/**
	 * 更新人员信息
	 */
	public void upUserLibrary(){
		UploadFile uploadFile = getFile("imageName", "\\photo\\");//在磁盘上保存文件
		if(uploadFile == null) {
			QxUserLibrary userLibrary = getBean(QxUserLibrary.class,"userLibrary");
    		Ret ret = srv.upUserLibrary(userLibrary);
    		renderJson(ret);
		}else {
			String uploadPath = uploadFile.getUploadPath();//获取保存文件的文件夹
	        String fileName = uploadFile.getFileName();//获取保存文件的文件名
	        String filePath = uploadPath+fileName;//保存文件的路径
	        Ret pathRet = srv.editPicPath(filePath,fileName,"/upload/photo/");
	        if(pathRet.isOk()) {
	        	String path = pathRet.getStr("msg");        	
	        	QxUserLibrary userLibrary = getBean(QxUserLibrary.class,"userLibrary");
	        	userLibrary.setPicpath(path);
	    		Ret ret = srv.upUserLibrary(userLibrary);
	    		renderJson(ret);
	        }else {
	        	renderJson(pathRet);
	        }
		}
	}
	
	/**
	 * 删除角色
	 */
	public void delUserLibrary(){
		Integer id = getParaToInt("id");
		Ret ret = srv.delUserLibrary(id);
		renderJson(ret);
	}
	
	public void findById() {
		Integer id = getParaToInt("id");
		QxUserLibrary data = srv.findById(id);
		renderJson(data);
	}
	
	/**
	 * 添加给人物的关系属性
	 */
	public void relation() {
		String code = getPara("code");
		QxUserLibrary ret = srv.findByCode(code);
		renderJson(ret);
	}
}
