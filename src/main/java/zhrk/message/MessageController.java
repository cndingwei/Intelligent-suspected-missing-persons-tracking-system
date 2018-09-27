package zhrk.message;
import com.jfinal.core.Controller;
import java.util.List;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxMessage;

public class MessageController extends Controller{

	MessageService srv = MessageService.me;
	
	/**
	 * 所有消息列表
	 */
	public void index(){
		Record user = getSessionAttr("user");
		String userId = "";
		String roleCode = "";
		if(user != null) {
			userId = user.getStr("ID");
			roleCode = user.getStr("ROLECODE");
		}
		Page<Record> messageList = srv.paginate(getParaToInt("p", 1),userId,roleCode);
		setAttr("messageList", messageList);
		render("list.jsp");
	}
	
	/**
	 * 登记消息表单
	 */
	public void form(){
		Integer id = getParaToInt(0);
		List<QxMessage> messageList = srv.findMessageList();
		setAttr("messageList", messageList);
		setAttr("messageList", messageList.size());
		if(id != null){
			QxMessage message = srv.findModelById(id);
			setAttr("message", message);
		}
		render("form.jsp");
	}
	
	
	

	/**
	 * 更新失踪人员信息
	 */
	public void upMessage(){
		QxMessage message = getBean(QxMessage.class,"message");
		Ret ret = srv.upMessage(message);
		renderJson(ret);
	}
	
	/**
	 * 删除失踪人员信息
	 */
	public void delMessage(){
		Integer id = getParaToInt("id");
		QxMessage message = srv.findModelById(id);
		Ret ret = srv.delMessage(message);
		renderJson(ret);
	}
	
}
