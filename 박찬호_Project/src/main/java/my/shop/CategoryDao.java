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

	public static CategoryDao getinstance() { //싱글톤패턴!

		if (instance == null) {
			instance = new CategoryDao();
		}

		return instance;
	}

	private CategoryDao() {
		
		try {
			Context initContext;
			initContext = new InitialContext();
			/* 내가 설정한 Context.xml 정보가 comp/env 이런 폴더안에 저장됨 */
			Context envContext = (Context) initContext.lookup("java:comp/env"); // java:comp/env 에 설정 정보가 저장되는건 내가 임의로
			// 수정할 수 없음.
			/* 위 폴더가서 jbdc/OracleDb 이름으로 설정한 것을가져와라 */
			DataSource ds = (DataSource) envContext.lookup("jdbc/OracleDB");
			
			// 사용자가 사이트에 접속하면 컨넥션 객체를 얻음. 그리고 이 컨넥션 객체를 가지고 로그인을 하고 자시고 하는거임. 등등의 DB작업
			
			conn = ds.getConnection();
			
			System.out.println("conn :" + conn);
		} catch (SQLException e) {
			System.out.println("연결에러");
			
		} catch (NamingException e) {
			System.out.println("연결에러");
		}
		
	}// CategoryDao jspid에 접속을 하는데 한 번만 접속하면 됨 객체 한 번만 만들어서 굳이 할 때마다 getconnection 안해도됨.
// 대신 conn.close() 하면 안됨. 절대! 로그아웃할때만 conn.close()!!!!!!!
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
//========(숫자받아서 삭제)================================================================================
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
//========(cnum에 맞는 레코드 가져오기)================================================
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
//========(cnum에 맞는 레코드 수정)================================================
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
//====(대분류 insert)============================================================

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
//=======(cname에 해당하는 code1을 가져옴 ajax활용.=======================

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

//========(code1 맞는 레코드 가져오기)================================================
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



//============(rs 다 넣어주는 코드)==========================
	public CategoryBean rsCategoryBean(ResultSet rs) throws SQLException {
		
		CategoryBean cb = new CategoryBean();
		
		cb.setCnum(rs.getInt("cnum"));
		cb.setCode1(rs.getString("code1"));
		cb.setCname(rs.getString("cname"));
		
		return cb;
	}
	
	
}//CategoryDao
