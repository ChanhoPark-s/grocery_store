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

public class CategoryDao2 {
	PreparedStatement ps = null;
	Connection conn = null;
	ResultSet rs =null;
	private static CategoryDao2 instance;

	public static CategoryDao2 getinstance() { //싱글톤패턴!

		if (instance == null) {
			instance = new CategoryDao2();
		}

		return instance;
	}

	private CategoryDao2() {
		
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

public ArrayList<CategoryBean2> getAllCategory(){
		
		ArrayList<CategoryBean2> lists = new ArrayList<CategoryBean2>();
		CategoryBean2 cb = null;
		
		try {
			
			String sql = "select * from mycategory2 ";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				cb =rsCategoryBean(rs);
				
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
		System.out.println("CategoryBean2Dao : lists size() :"+lists.size());
		return lists;
		
	}
//=======(code가 CategoryBean의 code1에 해당하는 레코드 다 가져오기)=====================================================
	
	public ArrayList<CategoryBean2> getAllCategory(String code1){
		
		ArrayList<CategoryBean2> lists = new ArrayList<CategoryBean2>();
		CategoryBean2 cb = null;
		
		System.out.println("가져온 code1 :"+code1);
		try {
		
			String sql = "select * from mycategory2 where code1=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, code1);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				cb =rsCategoryBean(rs);
				
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
		System.out.println("CategoryBean2Dao : lists size() :"+lists.size());
		return lists;
		
		}
//========(code1에 해당하는  레코드 삭제)=======================================================	
	public int deleteBycnum(String cnum) {
		
		int result = -1;
		System.out.println("cnum:"+cnum);
		
		String sql = "delete mycategory2 where cnum="+cnum;
		
		try {
			ps=conn.prepareStatement(sql);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Category2 deleteBycnum sql error");
		}finally {
			try {
			if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				System.out.println("Category2 deleteBycnum close error");
			}
		}
		System.out.println("Category2 deleteBycnum result :"+result);
		return result;
	}
//========(code1에 해당하는  레코드 삭제)=======================================================	
	public int deleteByCode1(String code1) {
		
		int result = -1;
		System.out.println("code1:"+code1);
		try {
		
		String sql = "delete mycategory2 where code1=?";
		
			ps=conn.prepareStatement(sql);
			ps.setString(1, code1);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Category2 deleteByCode1 sql error");
		}finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("Category2 deleteByCode1 close error");
			}
		}
		System.out.println("Category2 deleteByCode1 result :"+result);
		return result;
	}
	
	//========(cnum에 맞는 레코드 수정)================================================
	public int updateBycnum(String originCode1,String code1) {
		
		int cnt = -1;
		
		try {
		String sql = "update mycategory2 set code1=? where code1=?";
		
			ps=conn.prepareStatement(sql);
			
			ps.setString(1, code1);
			ps.setString(2, originCode1);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("Category2 updateBycnum sql error");
		}finally {
			if(ps!=null)
				try {
					ps.close();
				} catch (SQLException e) {
					System.out.println("Category2 updateBycnum close error");
				}
		}
		System.out.println("Category2 cnt :"+cnt);
		return cnt;
	}	
	
//========(cnum에 맞는 레코드 가져오기)================================================
	public CategoryBean2 getCateByCnum(String cnum) {
		
		CategoryBean2 cb =null;
		
		String sql = "select * from mycategory2 where cnum="+cnum;
		
		try {
			ps=conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				cb = rsCategoryBean(rs);
			}
		} catch (SQLException e) {
			System.out.println("Category2 getCateByCnum sql error");
		}finally {
			try {
			if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				System.out.println("Category2 getCateByCnum close error");
			}
		}
		return cb;
	}
	
	//========(cnum에 맞는 레코드 수정)================================================
public int updateBycnum(CategoryBean2 cb2) {
		System.out.println("name :"+cb2.getCname());
		System.out.println("code1 :"+cb2.getCode1());
		System.out.println("code2 :"+cb2.getCode2());
		System.out.println("cnum :"+cb2.getCnum());
		int result = -1;
		
		String sql = "update mycategory2 set cname=? , code1=?,code2=? where cnum=?";
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setString(1, cb2.getCname());
			ps.setString(2, cb2.getCode1());
			ps.setString(3, cb2.getCode2());
			ps.setInt(4, cb2.getCnum());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("Category2 updateBycnum sql error");
		}finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("Category2 updateBycnum close error");
			}
		}
		System.out.println("Category2 result :"+result);
		return result;
	}	
//====(insert Cate2)=====================================================================	
public int insertInCate(CategoryBean2 cb2) {
	
	int result = -1;
	
	String sql = "insert into mycategory2 values(mycategoryseq2.nextval,?,?,?)";
	
	try {
		ps=conn.prepareStatement(sql);
		
		ps.setString(1, cb2.getCode1());
		ps.setString(2, cb2.getCode2());
		ps.setString(3, cb2.getCname());
		
		result = ps.executeUpdate();
		
	} catch (SQLException e) {
		System.out.println("Category2 insertInCate sql error");
	}finally {
		try {
			if(ps!=null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("Category2 insertInCate close error");
		}
	}
	System.out.println("Category2 result :"+result);
	return result;
}
//========(code1 code2 맞는 레코드 가져오기)================================================
	public CategoryBean2 getCateByCode1Code2(String code1,String code2) {
		
		CategoryBean2 cb =null;
		
		String sql = "select * from mycategory2 where code1=? and code2=?";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, code1);
			ps.setString(2, code2);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				cb = rsCategoryBean(rs);
			}
		} catch (SQLException e) {
			System.out.println("Category2 getCateByCode1Code2 sql error");
		}finally {
			try {
			if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				System.out.println("Category2 getCateByCode1Code2 close error");
			}
		}
		return cb;
	}
	

//============(rs 다 넣어주는 코드)==========================
public CategoryBean2 rsCategoryBean(ResultSet rs) throws SQLException {
			
			CategoryBean2 cb = new CategoryBean2();
			
			cb.setCnum(rs.getInt("cnum"));
			cb.setCode1(rs.getString("code1"));
			cb.setCode2(rs.getString("code2"));
			cb.setCname(rs.getString("cname"));
			
			return cb;
		}
}
