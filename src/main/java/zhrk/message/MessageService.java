package zhrk.message;

import java.util.List;

import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxMessage;

public class MessageService {

	public static final MessageService me = new MessageService();
	private QxMessage dao = new QxMessage().dao();
	
	/**
	 * 分页
	 * @param roleCode 
	 * @param userId 
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum, String userId, String roleCode) {
		String select = "select me.id,ul.name as miuser,u.name as reuser,me.title,me.content,me.sendtime,s.isread ";
		StringBuffer from = new StringBuffer(" from qx_message me,qx_missing ms,qx_user u,qx_user_library ul,qx_send s where me.msid = ms.id and ms.miuser = ul.id and me.id =s.mesid and s.userid = u.id ");
		if(roleCode.equals("volun")) {
			from.append(" and s.userId = ? ");
			from.append(" order by me.sendtime desc");
			return Db.paginate(pageNum, 10, select, from.toString(), userId);
		}
		from.append(" order by me.sendtime desc");
		return Db.paginate(pageNum, 10, select, from.toString());
	}

	

	/**
	 * 根据失踪人员id查找发送信息
	 * @param id
	 * @return
	 */
	public Record findById(Integer id) {
		Record message = Db.findFirst("SELECT id,ms_id,title,content,addr,send_time FROM qx_message  WHERE id = ? ORDER BY sent_time DESC", id);
		return message;
	}

	/**
	 * 更新
	 * @param Depart
	 * @return
	 */
	public Ret upMessage(QxMessage message) {
		Boolean flag = message.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public List<QxMessage> findMessageList() {
		return dao.find("select id,ms_id,title,content,addr,send_time from qx_message order by send_time desc");
	}

	public QxMessage findModelById(Integer id) {
		return dao.findById(id);
	}
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public Ret delMessage(QxMessage message) {
		Boolean flag = message.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

}
