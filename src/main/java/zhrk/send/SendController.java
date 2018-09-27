package zhrk.send;
import com.jfinal.core.Controller;
import java.util.List;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import zhrk.common.model.QxSend;

public class SendController extends Controller{

	SendService srv = SendService.me;
	
	/**
	 * 所有消息列表
	 */
	public void index(){
		Page<Record> sendList = srv.paginate(getParaToInt("p", 1));
		setAttr("sendList", sendList);
		render("list.jsp");
	}
	
	/**
	 * 所有消息列表
	 */
	public void abc(){
		Record user = getSessionAttr("user");
		String userId = "";
		if(user != null) {
			userId = user.getStr("ID");
		}
		Page<Record> sendList = srv.sendpaginate(getParaToInt("p", 1),userId);
		setAttr("sendList", sendList);
		if(sendList.getList().size()>0) {
			Record record = sendList.getList().get(0);
			Integer msid = record.getInt("MSID");
			List<Record> areaList = srv.getAreaList(msid);
			setAttr("areaList", areaList);
		}
		srv.updateByUserId(userId);
		render("newmessage.jsp");
	}
	
	/**
	 * 登记消息表单
	 */
	public void form(){
		Integer id = getParaToInt(0);
		List<QxSend> messageList = srv.findMessageList();
		setAttr("messageList", messageList);
		setAttr("messageList", messageList.size());
		if(id != null){
			QxSend message = srv.findModelById(id);
			setAttr("message", message);
		}
		render("form.jsp");
	}

	/**
	 * 更新失踪人员信息
	 */
	public void upMessage(){
		QxSend message = getBean(QxSend.class,"message");
		Ret ret = srv.upMessage(message);
		renderJson(ret);
	}
	
	/**
	 * 删除失踪人员信息
	 */
	public void delMessage(){
		Integer id = getParaToInt("id");
		QxSend message = srv.findModelById(id);
		Ret ret = srv.delMessage(message);
		renderJson(ret);
	}
	
	
}
