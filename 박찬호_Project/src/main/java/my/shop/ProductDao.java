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

import com.oreilly.servlet.MultipartRequest;

public class ProductDao {
	
	PreparedStatement ps = null;
	Connection conn = null;
	ResultSet rs =null;
	private static ProductDao instance;

	public static ProductDao getinstance() { //싱글톤패턴!

		if (instance == null) {
			instance = new ProductDao();
		}

		return instance;
	}

	private ProductDao() {
		
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
	public ArrayList<ProductBean> getAllProduct() {
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();

		ProductBean pb = null;
		try {
			String sql = "select * from myproduct";

			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();

			while (rs.next()) {
				pb = pb(rs);

				lists.add(pb);
			}
		} catch (SQLException e) {
			System.out.println("getAllProduct sql error");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("getAllProduct close error");
			}
		}

		return lists;
	}
	
	
	public int insertProduct(MultipartRequest mr) {
		int result = -1;
		
			System.out.println("pimage :"+mr.getFilesystemName("pimage"));
			System.out.println("outcategory :"+mr.getParameter("outcategory"));
			System.out.println("incategory :"+mr.getParameter("incategory"));
			System.out.println("pseller :"+mr.getParameter("pseller"));
			System.out.println("pqty :"+mr.getParameter("pqty"));
			System.out.println("price :"+mr.getParameter("price"));
			System.out.println("pspec :"+mr.getParameter("pspec"));
			System.out.println("pcontents :"+mr.getParameter("pcontents"));
			System.out.println("pinputdate :"+mr.getParameter("pinputdate"));
		
		try {
		String sql ="insert into myproduct values(mycatprod.nextval,?,?,?,?,?,?,?,?,?,?)";
		
			ps =conn.prepareStatement(sql);
			ps.setString(1, mr.getFilesystemName("pimage"));
			ps.setString(2, mr.getParameter("pname"));
			
			String category="";
			category += mr.getParameter("outcategory");
			category += mr.getParameter("incategory");
			System.out.println("category :"+category);
			ps.setString(3,	category);
			ps.setString(4, mr.getParameter("pseller"));
			ps.setString(5, mr.getParameter("pqty"));
			ps.setString(6, mr.getParameter("price"));
			ps.setString(7, mr.getParameter("pspec"));
			ps.setString(8, mr.getParameter("pcontents"));
			ps.setString(9, mr.getParameter("plife"));
			ps.setString(10,mr.getParameter("pinputdate"));
			
			result = ps.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println("insertProduct sql error");
		}finally {
			try {
				if(ps!=null)
					ps.close();
				} catch (SQLException e) {
					System.out.println("insertProduct close error");
				}
			}
		
		return result;
	}
	
public ArrayList<ProductBean> getProductByCode2(String code1 ,String code2){
	ArrayList<ProductBean> pblist = new ArrayList<ProductBean>();
	
	try {
		if(code2!="") {
			
			String sql = "select * from myproduct where pcategory_fk like ? and pcategory_fk like ?";
	
			ps = conn.prepareStatement(sql);
		
			ps.setString(1, "%" + code1 + "%");
			ps.setString(2, "%" + code2 + "%");
		
			rs = ps.executeQuery();
		}
		else {
			String sql = "select * from myproduct where pcategory_fk like ?";
			
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, "%" + code1 + "%");
			
			rs = ps.executeQuery();
			
		}
		
		while(rs.next()) {
			ProductBean pb = pb(rs);
			
			pblist.add(pb);
		}
	} catch (SQLException e) {
		System.out.println("getProductByCode2 sql error");
	}finally {
		try {
		if(rs!=null)
			rs.close();
		if(ps!=null)
			ps.close();
		} catch (SQLException e) {
			System.out.println("getProductByCode2 close error");
		}
	}
	
	return pblist;
}

public int deleteByPnum(String pnum) {
	int result = -1; 
	
	String sql = "delete myproduct where pnum=?";
	try {
		ps= conn.prepareStatement(sql);
		
		ps.setString(1, pnum);
		
		result = ps.executeUpdate();
	} catch (SQLException e) {
		System.out.println("deleteByPnum sql error");
	}finally {
		try {
		if(ps!=null)
			ps.close();
		} catch (SQLException e) {
			System.out.println("deleteByPnum close error");
		}
	}
	System.out.println("deleteByPnum result :"+result);
	return result;
}

public ProductBean getProductByPnum(String pnum){
		ProductBean pb=null;
	try {
		String sql = "select * from myproduct where pnum=?";
		
		ps =conn.prepareStatement(sql);
		
		ps.setString(1,pnum);
		
		rs = ps.executeQuery();
		
		while(rs.next()) {
			pb = pb(rs);
			
		}
	} catch (SQLException e) {
		System.out.println("getProductByCode2 sql error");
	}finally {
		try {
			if(rs!=null)
				rs.close();
			if(ps!=null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("getProductByCode2 close error");
		}
	}
	
	return pb;
}

public int updateProduct(MultipartRequest mr, String pimage2) {
	int result = -1;

	System.out.println("pnum :" + mr.getParameter("pnum"));
	System.out.println("mrpimage :" + mr.getFilesystemName("pimage"));
	System.out.println("pimage2 :" + pimage2);
	System.out.println("mrpimage2 :" + mr.getFilesystemName("pimage2"));
	System.out.println("mroutcategory :" + mr.getParameter("outcategory"));
	System.out.println("mrincategory :" + mr.getParameter("incategory"));
	System.out.println("mrpseller :" + mr.getParameter("pseller"));
	System.out.println("mrpqty :" + mr.getParameter("pqty"));
	System.out.println("mrprice :" + mr.getParameter("price"));
	System.out.println("mrpspec :" + mr.getParameter("pspec"));
	System.out.println("mrpcontents :" + mr.getParameter("pcontents"));
	System.out.println("mrpinputdate :" + mr.getParameter("pinputdate"));

	try {
		String sql = "update myproduct set pimage=? ,pname=?,pcategory_fk=?,"
				+ "pseller=?,pqty=?,price=?,pspec=?,pcontents=?,plife=?,pinputdate=? where pnum=?";

		ps = conn.prepareStatement(sql);

		if (mr.getFilesystemName("pimage") == null) {
			ps.setString(1, pimage2);
		} else {
			ps.setString(1, mr.getFilesystemName("pimage"));
		}
		ps.setString(2, mr.getParameter("pname"));

		String category = "";
		category += mr.getParameter("outcategory");
		category += mr.getParameter("incategory");
		System.out.println("category :" + category);
		ps.setString(3, category);
		ps.setString(4, mr.getParameter("pseller"));
		ps.setString(5, mr.getParameter("pqty"));
		ps.setString(6, mr.getParameter("price"));
		ps.setString(7, mr.getParameter("pspec"));
		ps.setString(8, mr.getParameter("pcontents"));
		ps.setString(9, mr.getParameter("plife"));
		ps.setString(10, mr.getParameter("pinputdate"));
		ps.setString(11, mr.getParameter("pnum"));

		result = ps.executeUpdate();

	} catch (SQLException e) {
		System.out.println("updateProduct sql error");
	} finally {
		try {
			if (ps != null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("updateProduct close error");
		}
	}
	System.out.println("result:" + result);
	return result;
}

//==========(spec 에 따라 가져오기)================================

public ArrayList<ProductBean> getProductByPspec(String pspec) {
	ArrayList<ProductBean> lists = new ArrayList<ProductBean>();

	ProductBean pb = null;
	try {
		String sql = "select * from myproduct where pspec=?";

		ps = conn.prepareStatement(sql);

		ps.setString(1, pspec);

		rs = ps.executeQuery();

		while (rs.next()) {
			pb = pb(rs);

			lists.add(pb);
		}
	} catch (SQLException e) {
		System.out.println("getProductByPspec sql error");
	} finally {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("getProductByPspec close error");
		}
	}

	return lists;
}
//============pb에 넣어주기======================================
public ProductBean pb(ResultSet rs) throws SQLException {
	ProductBean pb = new ProductBean();

	pb.setPnum(rs.getInt("pnum"));
	pb.setPimage(rs.getString("pimage"));
	pb.setPname(rs.getString("pname"));
	pb.setPcategory_fk(rs.getString("pcategory_fk"));
	pb.setPseller(rs.getString("pseller"));
	pb.setPqty(rs.getInt("pqty"));
	pb.setPrice(rs.getInt("price"));
	pb.setPspec(rs.getString("pspec"));
	pb.setPcontents(rs.getString("pcontents"));
	pb.setPlife(rs.getString("plife"));
	pb.setPinputdate(rs.getString("pinputdate"));
	return pb;
}

}//ProductDao
