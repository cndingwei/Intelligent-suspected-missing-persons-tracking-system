package zhrk.send;

import java.util.List;

import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import zhrk.common.model.QxSend;

public class SendService {

	public static final SendService me = new SendService();
	private QxSend dao = new QxSend().dao();
	
	/**
	 * 分页
	 * @param pager
	 * @return
	 */
	public Page<Record> paginate(Integer pageNum) {
		return Db.paginate(pageNum, 10, "select * ", 
				" from qx_message a,qx_send b,qx_user c where a.id = b.mesid and b.userid = c.id order by b.id desc ");
	}
	
	/**
	 * 查找未读信息 分页
	 * @param userId 
	 * @param pager
	 * @return
	 */
	public Page<Record> sendpaginate(Integer pageNum, String userId) {
		return Db.paginate(pageNum, 10, "select a.id,a.msid,a.title,a.content,c.name ", 
				"from qx_message a,qx_send b,qx_user c where a.id = b.mesid and b.userid = c.id and b.isread ='未查看' and b.userid = ? order by a.sendTime desc",userId);
	}	

	/**
	 * 根据失踪人员id查找发送信息
	 * @param id
	 * @return
	 */
	public Record findById(Integer id) {
		Record message = Db.findFirst("SELECT id,ms_id,title,content,addr,send_time FROM qx_message  WHERE user_id = ? ORDER BY sent_time DESC", id);
		return message;
	}

	/**
	 * 更新
	 * @param Depart
	 * @return
	 */
	public Ret upMessage(QxSend message) {
		Boolean flag = message.update();
		if(flag)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

	public List<QxSend> findMessageList() {
		return dao.find("select id,ms_id,title,content,addr,send_time from qx_message order by send_time desc");
	}

	public QxSend findModelById(Integer id) {
		return dao.findById(id);
	}
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public Ret delMessage(QxSend send) {
		Boolean flag = send.delete();
		if(flag)
			return Ret.ok("msg", "删除成功");
		return Ret.fail("msg", "删除失败");
	}

	public List<Record> getAreaList(Integer msid) {
		List<Record> list = Db.find("select * from qx_pic_library where misid = ? order by ctime asc", msid);
		return list;
	}

	/**
	 * 通过userID
	 * @param userId
	 * @return
	 * 2018年8月13日 上午9:58:57
	 */
	public Ret updateByUserId(String userId) {
		List<QxSend> sList = dao.find("select  * from qx_send where userid = ? and isread = '未查看'", userId);
		if(sList.size() == 0)
			return Ret.ok("msg", "更新成功");
		for(QxSend qxSend : sList) {
			qxSend.setIsread("已查看");
		}
		int[] count = Db.batchUpdate(sList, 100);
		if(count.length > 0)
			return Ret.ok("msg", "更新成功");
		return Ret.fail("msg", "更新失败");
	}

}
