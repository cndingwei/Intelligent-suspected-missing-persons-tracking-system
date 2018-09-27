package zhrk.userLibrary;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.Ret;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;
import zhrk.common.model.QxUserLibrary;
import zhrk.utils.FileUtil;
import zhrk.utils.MapUtils;

public class UserLibraryService {

	public static final UserLibraryService me = new UserLibraryService();
	private QxUserLibrary dao = new QxUserLibrary().dao();
	
	/**
	 * 分页获得人员列表信息
	 * @param pager
	 * @return
	 */
	public Page<QxUserLibrary> paginate(Integer pageNum) {
		return dao.paginate(pageNum, 10, "select *", "from qx_user_library  order by id desc");
	}

	/**
	 * 校验用户名称
	 * @param name
	 * @param id
	 * @return
	 */
	public boolean valid(String name,String code, Integer id) {
		StringBuffer sql = new StringBuffer("select * from qx_user_library where 1=1  ");
		List<Object> li = new ArrayList<Object>();
		if(!StrKit.isBlank(name)){
			sql.append("and name = ?");
			li.add(name);
		}
		if(!StrKit.isBlank(code)){
			sql.append("and usercode = ?");
			li.add(code);
		}
		List<QxUserLibrary> list = dao.find(sql.toString(), li.toArray());
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
	 * 人员信息添加
	 * @param role
	 * @return
	 */
	public Ret addUserLibrary(QxUserLibrary userLibrary) {
		String name = userLibrary.getName();
		String usercode = userLibrary.getUsercode();
		if(StrKit.isBlank(name))
			return Ret.fail("msg", "人员名称不能为空");
		if(StrKit.isBlank(usercode))
			return Ret.fail("msg", "人员身份证号不能为空");
		boolean nameValid = valid(name, "", null);
		if(!nameValid)
			return Ret.fail("msg", "该人员名称已存在");
		boolean codeValid = valid("",usercode,null);
		if(!codeValid)
			return Ret.fail("msg", "该角色编码已存在");
		Map<String,Object> map = MapUtils.java2Map(userLibrary);
		Boolean flag = userLibrary.save(map);
		if(flag)
			return Ret.ok("msg", "添加成功");
		return Ret.fail("msg", "添加失败");
	}

	/**
	 * 根据id查找人员
	 * @param id
	 * @return
	 */
	public QxUserLibrary findById(Integer id) {
		return dao.findById(id);
	}

	/**
	 * 人员信息更新
	 * @param role
	 * @return
	 */
	public Ret upUserLibrary(QxUserLibrary userLibrary) {
		String name = userLibrary.getName();
		String usercode = userLibrary.getUsercode();
				
		if(StrKit.isBlank(name))
			return Ret.fail("msg", "人员名称不能为空");
		if(StrKit.isBlank(usercode))
			return Ret.fail("msg", "人员身份证号不能为空");
		boolean nameValid = valid(name, "", userLibrary.getId());
		if(!nameValid)
			return Ret.fail("msg", "人员名称已存在");
		boolean codeValid = valid("",usercode,userLibrary.getId());
		if(!codeValid)
			return Ret.fail("msg", "人员身份证号已存在");
		Boolean flag = userLibrary.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	
	/**
	 * 删除人员
	 * @param id
	 * @return
	 */
	public Ret delUserLibrary(Integer id) {
		Boolean flag = dao.deleteById(id);
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	/**
	 * 变更上传的图片名称
	 * @param filePath
	 * @param fileName
	 * @param string
	 * @return
	 * 2018年8月10日 上午11:36:32
	 */
	public Ret editPicPath(String filePath, String fileName, String path) {
		String extension = fileName.substring(fileName.lastIndexOf("."));
        if (".png".equals(extension) || ".jpg".equals(extension)
                || ".gif".equals(extension) || ".jpeg".equals(extension)
                || ".bmp".equals(extension)){
        	String resultFileName = FileUtil.instance.changeFileName(filePath,extension);//为了避免相同文件上传冲突，使用工具类重新命名
        	String src = path + resultFileName;
        	Ret ret = Ret.ok("msg", src);
        	return ret;
        }else{
        	File source = new File(filePath);
        	source.delete();
        	Ret ret = Ret.fail("msg", "只允许上传png,jpg,jpeg,gif,bmp类型的图片文件");
        	return ret;
        }
	}

	/**
	 * 根据身份照查询关系人信息
	 * @param code
	 * @return
	 * 2018年8月15日 上午11:09:27
	 */
	public QxUserLibrary findByCode(String code) {
		return dao.findFirst("select * from qx_user_library where usercode = ? ", code);
	}
}
