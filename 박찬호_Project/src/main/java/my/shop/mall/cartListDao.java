package my.shop.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import my.shop.ProductBean;
import my.shop.ProductDao;

public class cartListDao {

	PreparedStatement ps = null;
	Connection conn = null;
	ResultSet rs = null;
	private static cartListDao instance;

	public static cartListDao getinstance() { // �̱�������!

		if (instance == null) {
			instance = new cartListDao();
		}

		return instance;
	}

	private cartListDao() {

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

	}//

	public int insertCart(String pnum, String pqty, String id) {
		int result = -1;

		try {
			String sql = "select * from mycartList where cnum=? and id=?";

			ps = conn.prepareStatement(sql);

			ps.setString(1, pnum);
			ps.setString(2, id);

			rs = ps.executeQuery();

			if (rs.next()) {
				System.out.println("�̹� �����ϴ� ���̵��� ��ǰ");
				sql = "update mycartList set cqty=? where id=? and cnum=?";

				ps = conn.prepareStatement(sql);

				ps.setInt(1, Integer.parseInt(rs.getString("cqty")) + Integer.parseInt(pqty));
				ps.setString(2, id);
				ps.setString(3, pnum);

				result = ps.executeUpdate();
			} else {
				System.out.println("���Ӱ� �߰�");
				sql = "insert into mycartList values(?,?,?)";

				ps = conn.prepareStatement(sql);

				ps.setString(1, id);
				ps.setString(2, pnum);
				ps.setString(3, pqty);

				result = ps.executeUpdate();
			}

		} catch (

		SQLException e) {
			System.out.println("insertCart sql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("insertCart close error");
			}
		}
		return result;
	}

	public ArrayList<cartListBean> getCartById(String id) {

		ArrayList<cartListBean> lists = new ArrayList<cartListBean>();
		try {
			String sql = "select * from mycartList where id=?";

			ps = conn.prepareStatement(sql);

			ps.setString(1, id);

			rs = ps.executeQuery();

			while (rs.next()) {
				cartListBean cb = new cartListBean();

				cb.setId(rs.getString("id"));
				cb.setCnum(rs.getString("cnum"));
				cb.setCqty(rs.getInt("cqty"));

				lists.add(cb);
			}
		} catch (SQLException e) {
			System.out.println("getCartById sql error");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("insertCart close error");
			}
		}
		return lists;
	}

	public int updateCqty(String id, String a, String cnum) {
		int result = -1;

		try {
			System.out.println("id :" + id);
			System.out.println("a :" + a);
			System.out.println("cnum :" + cnum);

			String sql = "select * from mycartlist where id=? and cnum=?";

			ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, cnum);

			rs = ps.executeQuery();

			if (rs.next()) {
				if (a.equals("plus")) {
					sql = "update mycartList set cqty=? where id=? and cnum=?";

					ps = conn.prepareStatement(sql);
					ps.setInt(1, rs.getInt("cqty") + 1);
					ps.setString(2, id);
					ps.setString(3, cnum);

					result = ps.executeUpdate();
				} else if (a.equals("minus")) {
					sql = "update mycartList set cqty=? where id=? and cnum=?";

					ps = conn.prepareStatement(sql);
					ps.setInt(1, rs.getInt("cqty") - 1);
					ps.setString(2, id);
					ps.setString(3, cnum);
					result = ps.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("insertCart close error");
			}
		}
		System.out.println("result:"+result);
		return result;
	}

	public void deleteByIdCnum(String id,String cnum) {
		
		try {
		String sql = "delete mycartList where id=? and cnum=?";
		
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, id);
		ps.setString(2, cnum);
		
		ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("deleteByIdCnum sql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("deleteByIdCnum close error");
			}
		}		
	}
	
	public int deleteByIdCnumArray(String id, String[] cnum) {
		int result = -1;

		try {
			for (int i = 0; i < cnum.length; i++) {
				String sql = "delete mycartList where id=? and cnum=?";

				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, cnum[i]);

				result += ps.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("deleteByIdCnumArray sql error");
		}finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("deleteByIdCnumArray close error");
			}
		}	
		System.out.println("������ result :"+result);
		return result;
	}
}// cartListDao
