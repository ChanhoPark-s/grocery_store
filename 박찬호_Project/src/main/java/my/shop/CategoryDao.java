package my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class CategoryDao {

	PreparedStatement ps = null;
	Connection conn = null;
	ResultSet rs =null;
	private static CategoryDao instance;

	public static CategoryDao getinstance() { //�̱�������!

		if (instance == null) {
			instance = new CategoryDao();
		}

		return instance;
	}

	private CategoryDao() {
		
		try {
			Context initContext;
			initContext = new InitialContext();
			/* ���� ������ Context.xml ������ comp/env �̷� �����ȿ� ����� */
			Context envContext = (Context) initContext.lookup("java:comp/env"); // java:comp/env �� ���� ������ ����Ǵ°� ���� ���Ƿ�
			// ������ �� ����.
			/* �� �������� jbdc/OracleDb �̸����� ������ ���������Ͷ� */
			DataSource ds = (DataSource) envContext.lookup("jdbc/OracleDB");
			
			// ����ڰ� ����Ʈ�� �����ϸ� ���ؼ� ��ü�� ����. �׸��� �� ���ؼ� ��ü�� ������ �α����� �ϰ� �ڽð� �ϴ°���. ����� DB�۾�
			
			conn = ds.getConnection();
			
			System.out.println("conn :" + conn);
		} catch (SQLException e) {
			System.out.println("���ῡ��");
			
		} catch (NamingException e) {
			System.out.println("���ῡ��");
		}
		
	}// CategoryDao jspid�� ������ �ϴµ� �� ���� �����ϸ� �� ��ü �� ���� ���� ���� �� ������ getconnection ���ص���.
// ��� conn.close() �ϸ� �ȵ�. ����! �α׾ƿ��Ҷ��� conn.close()!!!!!!!
public ArrayList<CategoryBean> getAllCategory(){
	
	ArrayList<CategoryBean> lists = new ArrayList<CategoryBean>();
	
	String sql = "select * from mycategory";
	
	try {
		ps = conn.prepareStatement(sql);
		
		rs = ps.executeQuery();
		
		while(rs.next()) {
			CategoryBean cb =rsCategoryBean(rs);
			
			lists.add(cb);
		}
		
	} catch (SQLException e) {
		System.out.println("getAllCategory sql error");
	}finally {
		try {
		if(rs!=null)
				rs.close();
		if(ps!=null)
			ps.close();
		} catch (SQLException e) {
			System.out.println("getAllCategory close error");
		}
	}
	return lists;
}
//========(���ڹ޾Ƽ� ����)================================================================================
public int deleteBycnum(String cnum) {
	int result = -1;
	
	String sql = "delete mycategory where cnum="+cnum;
	
	try {
		ps=conn.prepareStatement(sql);
		
		result = ps.executeUpdate();
	} catch (SQLException e) {
		System.out.println("Category1 deleteBycnum sql error");
	}finally {
		try {
		if(ps!=null)
			ps.close();
		} catch (SQLException e) {
			System.out.println("Category1 deleteBycnum close error");
		}
	}
	System.out.println("result:"+result);
	return result;
}
//========(cnum�� �´� ���ڵ� ��������)================================================
public CategoryBean getCateByCnum(String cnum) {
	
	CategoryBean cb =null;
	
	String sql = "select * from mycategory where cnum="+cnum;
	
	try {
		ps=conn.prepareStatement(sql);
		
		rs = ps.executeQuery();
		
		if(rs.next()) {
			cb = rsCategoryBean(rs);
		}
	} catch (SQLException e) {
		System.out.println("Category1 getCateByCnum sql error");
	}finally {
		try {
		if(ps!=null)
			ps.close();
		} catch (SQLException e) {
			System.out.println("Category1 getCateByCnum close error");
		}
	}
	return cb;
}
//========(cnum�� �´� ���ڵ� ����)================================================
public int updateBycnum(String cnum,String cname,String code1) {
	
	int result = -1;
	
	String sql = "update mycategory set cname=? , code1=? where cnum=?";
	
	try {
		ps=conn.prepareStatement(sql);
		
		ps.setString(1, cname);
		ps.setString(2, code1);
		ps.setString(3, cnum);
		
		result = ps.executeUpdate();
		
	} catch (SQLException e) {
		System.out.println("Category1 updateBycnum sql error");
	}finally {
		try {
			if(ps!=null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("Category1 updateBycnum close error");
		}
	}
	System.out.println("Category1 result :"+result);
	return result;
}
//====(��з� insert)============================================================

public int insertInCate(CategoryBean cb) {
	
	int result = -1;
	
	String sql = "insert into mycategory values(mycategoryseq.nextval,?,?)";
	
	try {
		ps=conn.prepareStatement(sql);
		
		ps.setString(1, cb.getCode1());
		ps.setString(2, cb.getCname());
		
		result = ps.executeUpdate();
		
	} catch (SQLException e) {
		System.out.println("Category insertInCate sql error");
	}finally {
		try {
			if(ps!=null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("Category insertInCate close error");
		}
	}
	System.out.println("Category result :"+result);
	return result;
}
//=======(cname�� �ش��ϴ� code1�� ������ ajaxȰ��.=======================

public String getCateCode1(String cname) {
	String code1 = null;
	
	String sql = "select code1 from mycategory where cname=?";
	
	try {
		ps=conn.prepareStatement(sql);
		
		ps.setString(1, cname);
		
		rs = ps.executeQuery();
		
		if(rs.next()) {
			code1=rs.getString("code1");
		}
		
	} catch (SQLException e) {
		System.out.println("Category insertInCate sql error");
	}finally {
		try {
			if(ps!=null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("Category insertInCate close error");
		}
	}
	
	return code1;
}

//========(code1 �´� ���ڵ� ��������)================================================
public CategoryBean getCateByCode1(String code1) {
	
	CategoryBean cb =null;
	
	String sql = "select * from mycategory where code1=?";
	
	try {
		ps=conn.prepareStatement(sql);
		ps.setString(1, code1);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			cb = rsCategoryBean(rs);
		}
	} catch (SQLException e) {
		System.out.println("Category1 getCateByCode1 sql error");
	}finally {
		try {
		if(ps!=null)
			ps.close();
		} catch (SQLException e) {
			System.out.println("Category1 getCateByCode1 close error");
		}
	}
	return cb;
}



//============(rs �� �־��ִ� �ڵ�)==========================
	public CategoryBean rsCategoryBean(ResultSet rs) throws SQLException {
		
		CategoryBean cb = new CategoryBean();
		
		cb.setCnum(rs.getInt("cnum"));
		cb.setCode1(rs.getString("code1"));
		cb.setCname(rs.getString("cname"));
		
		return cb;
	}
	
	
}//CategoryDao
