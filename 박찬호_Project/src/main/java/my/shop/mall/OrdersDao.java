package my.shop.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import my.member.MemberBean;
import my.member.MemberDao;
import my.shop.ProductBean;
import my.shop.ProductDao;

public class OrdersDao {

	PreparedStatement ps = null;
	Connection conn = null;
	ResultSet rs = null;
	private static OrdersDao instance;

	public static OrdersDao getinstance() { // �̱�������!

		if (instance == null) {
			instance = new OrdersDao();
		}

		return instance;
	}

	private OrdersDao() {

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

	}// ������


	public int insertCart(String id) {
		int result = -1;
		
		try {
		MemberDao mdao =MemberDao.getinstance();
		cartListDao cdao = cartListDao.getinstance();
		ProductDao pdao = ProductDao.getinstance();
		
		MemberBean mb = mdao.getMemberById(id);
		ArrayList<cartListBean>lists = cdao.getCartById(id);
	
		for(cartListBean cb : lists) {
		
		String sql = "insert into myorders values(myorderseq.nextval,?,?,?,?,?,sysdate)";

		ps = conn.prepareStatement(sql);
			
			ps.setString(1, id); 
			ps.setString(2, cb.getCnum());
			ps.setString(3, mb.getAddress());
			ps.setInt(4, cb.getCqty());
			
			ProductBean pb =pdao.getProductByPnum(cb.getCnum());
			int Total = pb.getPrice()*cb.getCqty();
			ps.setInt(5, Total);
			
			
			result = ps.executeUpdate();
		}
		
		} catch (SQLException e) {
			System.out.println("insertCart sql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("close error");
			}
		}
		System.out.println("result :"+result);
		return result;
	}
	
//============================================================================
	public ArrayList<OrdersBean> getAllOrder(){
		ArrayList<OrdersBean> lists = new ArrayList<OrdersBean>();
		
		String sql = "select * from myorders";
		
		try {
			ps=conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				OrdersBean ob = new OrdersBean();
				
				ob.setOnum(rs.getInt("onum"));
				ob.setMid(rs.getString("mid"));
				ob.setPnum(rs.getInt("pnum"));
				ob.setAddress(rs.getString("address"));
				ob.setQty(rs.getInt("qty"));
				ob.setAmount(rs.getInt("amount"));
				ob.setOrderDate(String.valueOf(rs.getDate("orderDate")));
				
				lists.add(ob);
			}
		} catch (SQLException e) {
			System.out.println("getAllOrder sql error");
		}finally {
			try {
				if(rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("close error");
			}
		}
		System.out.println("listssize :"+lists.size());
		return lists;
	}
	
//============���̵𺰷� ��������==========================================================
public ArrayList<OrdersBean> getOrderById(String id){
	ArrayList<OrdersBean> lists = new ArrayList<OrdersBean>();
	
	String sql = "select * from myorders where mid=?";
	
	try {
		ps=conn.prepareStatement(sql);
	
		ps.setString(1, id);
	
		rs = ps.executeQuery();
		
		while(rs.next()) {
			
			OrdersBean ob = new OrdersBean();
			
			ob.setOnum(rs.getInt("onum"));
			ob.setMid(rs.getString("mid"));
			ob.setPnum(rs.getInt("pnum"));
			ob.setAddress(rs.getString("address"));
			ob.setQty(rs.getInt("qty"));
			ob.setAmount(rs.getInt("amount"));
			ob.setOrderDate(String.valueOf(rs.getDate("orderDate")));
		
			lists.add(ob);
		}
	} catch (SQLException e) {
		System.out.println("getOrderById sql error");
	}finally {
		try {
			if(rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("close error");
		}
	}
	System.out.println("listssize :"+lists.size());
	return lists;
}
//============================================================================
public OrdersBean getOderByOnumPnum(String onum,String pnum) {
	OrdersBean ob = null;
	
	String sql = "select * from myorders where onum=? and pnum=?";
	
	try {
		ps=conn.prepareStatement(sql);
		
		ps.setString(1, onum);
		ps.setString(2, pnum);
		
		rs = ps.executeQuery();
		
		if(rs.next()) {
			
			ob = new OrdersBean();
			
			ob.setOnum(rs.getInt("onum"));
			ob.setMid(rs.getString("mid"));
			ob.setPnum(rs.getInt("pnum"));
			ob.setAddress(rs.getString("address"));
			ob.setQty(rs.getInt("qty"));
			ob.setAmount(rs.getInt("amount"));
			ob.setOrderDate(String.valueOf(rs.getDate("orderDate")));
		}
	} catch (SQLException e) {
		System.out.println("getOderByOnumPnum sql error");
	}finally {
		try {
			if(rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("close error");
		}
	}
	
	
	return ob;
}
// �ֹ����� ����======================================================================================
public int updateOrder(String onum,String pnum,String address,String pqty,String price) {
	int result = -1;
	
	String sql = "update myorders set address=?,qty=? ,amount=? where onum=? and pnum=?";
	
	try {
		ps= conn.prepareStatement(sql);
		
		ps.setString(1, address);
		ps.setString(2, pqty);
		ps.setString(3, price);
		ps.setString(4, onum);
		ps.setString(5, pnum);
		
		result = ps.executeUpdate();
	} catch (SQLException e) {
		System.out.println("updateOrder eql error");
	}finally {
		try {
			if (ps != null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("close error");
		}
	}
	System.out.println("result:"+result);
	return result;
}
//==============deleteOrder===============================
public int deleteOrder(String onum,String pnum) {
	int result = -1;
	
	String sql = "delete myorders where onum=? and pnum=?";
	
	try {
		ps= conn.prepareStatement(sql);
		
		ps.setString(1, onum);
		ps.setString(2, pnum);
		
		result = ps.executeUpdate();
	} catch (SQLException e) {
		System.out.println("deleteOrder eql error");
	}finally {
		try {
			if (ps != null)
				ps.close();
		} catch (SQLException e) {
			System.out.println("close error");
		}
	}
	System.out.println("result:"+result);
	return result;
}
public int insertDirect(String id,String pnum,MemberBean mb,String qty) {
	int result = -1;
	
	String sql = "insert into myorders values(myorderseq.nextval,?,?,?,?,?,sysdate)";
		
	try {
		ps = conn.prepareStatement(sql);
			
			ps.setString(1, id); 
			ps.setString(2, pnum);
			String adress = mb.getAddress()+" "+mb.getDetailaddress();
			ps.setString(3, adress);
			ps.setString(4, qty);
			
			ProductDao pdao = ProductDao.getinstance();
			ProductBean pb =pdao.getProductByPnum(pnum);
			int Total = pb.getPrice()*Integer.parseInt(qty);
			
			ps.setInt(5, Total);
			
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("insertCart sql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("close error");
			}
		}
		System.out.println("result :"+result);
	return result;
}
}//OrdersDao






