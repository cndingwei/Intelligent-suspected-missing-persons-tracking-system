package zhrk.common;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;

import zhrk.common.model._MappingKit;
import zhrk.disaster.DisasterController;
import zhrk.index.IndexController;
import zhrk.menu.MenuController;
import zhrk.message.MessageController;
import zhrk.missing.MissingController;
import zhrk.person.RelaController;
import zhrk.person.StaffController;
import zhrk.role.RoleController;
import zhrk.send.SendController;
import zhrk.user.UserController;
import zhrk.userLibrary.UserLibraryController;
import zhrk.utils.Db2Dialect;
import zhrk.video.CamareaController;
import zhrk.video.VideoController;


public class TestConfig extends JFinalConfig {

	public static void main(String[] args) {
		JFinal.start("src/main/webapp", 80, "/", 5);
	}

	/**
	 * 配置数据库文件
	 */
	@Override
	public void configConstant(Constants me) {
		PropKit.use("zhrk.txt");
		me.setViewType(ViewType.JSP);
		me.setEncoding("utf-8");
		me.setDevMode(true);
		me.setMaxPostSize(104857600);
	}

	/**
	 * 加载controller
	 */
	@Override
	public void configRoute(Routes me) {
		me.setBaseViewPath("/WEB-INF/jsps");
		me.add("/",IndexController.class,"/index");
		me.add("/role",RoleController.class,"/role");
		me.add("/user",UserController.class,"/user");
		me.add("/rela",RelaController.class,"/rela");
		me.add("/staff",StaffController.class,"/staff");
		me.add("/menu",MenuController.class,"/menu");
		me.add("/missing",MissingController.class,"/missing");
		me.add("/disaster",DisasterController.class,"/disaster");
		me.add("/userLibrary",UserLibraryController.class,"/userLibrary");
		me.add("/message",MessageController.class,"/message");
		me.add("/video",VideoController.class);
		me.add("/cama",CamareaController.class);
		me.add("/send",SendController.class,"/send");
	}

	@Override
	public void configEngine(Engine me) {
		
	}

	@Override
	public void configPlugin(Plugins me) {
		DruidPlugin dp = createDruidPlugin();
		me.add(dp);
		
		ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
		arp.setDialect(new Db2Dialect()); 
		_MappingKit.mapping(arp);
		me.add(arp);
		me.add(new EhCachePlugin());
	}

	@Override
	public void configInterceptor(Interceptors me) {
		
	}

	@Override
	public void configHandler(Handlers me) {
		
	}

	public static DruidPlugin createDruidPlugin() {
		return new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim(),PropKit.get("driverClass"));
	}


}
