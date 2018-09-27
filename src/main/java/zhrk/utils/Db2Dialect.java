package zhrk.utils;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.jfinal.plugin.activerecord.Table;
import com.jfinal.plugin.activerecord.dialect.AnsiSqlDialect;

public class Db2Dialect extends AnsiSqlDialect{
	
	public String forPaginate(int pageNumber, int pageSize, StringBuilder findSql) {
		int start = (pageNumber - 1) * pageSize;
		int end = pageNumber * pageSize;
		StringBuilder ret = new StringBuilder();
		ret.append("select * from ( select row_.*, rownum rownum_ from (  ");
		ret.append(findSql);
		ret.append(" ) row_ where rownum <= ").append(end).append(") table_alias");
		ret.append(" where table_alias.rownum_ > ").append(start);
		return ret.toString();
	}
	
	public void forModelSave(Table table, Map<String, Object> attrs, StringBuilder sql, List<Object> paras) {
		sql.append("insert into ").append(table.getName()).append('(');
		StringBuilder temp = new StringBuilder(") values(");
		for (Entry<String, Object> e: attrs.entrySet()) {
			String colName = e.getKey();
			if(("ID").equals(colName))
				continue;
			if (table.hasColumnLabel(colName)) {
				if (paras.size() > 0) {
					sql.append(", ");
					temp.append(", ");
				}
				sql.append(colName);
				temp.append('?');
				paras.add(e.getValue());
			}
		}
		sql.append(temp.toString()).append(')');
	}
	
	public void fillStatement(PreparedStatement pst, List<Object> paras) throws SQLException {
		fillStatementHandleDateType(pst, paras);
	}
	
	public void fillStatement(PreparedStatement pst, Object... paras) throws SQLException {
		fillStatementHandleDateType(pst, paras);
	}
	
	public String getDefaultPrimaryKey() {
		return "ID";
	}
}
