package my.member;

import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDao {

	PreparedStatement ps = null;
	Connection conn = null;
	ResultSet rs = null;
	private static MemberDao instance;

	public static MemberDao getinstance() {

		if (instance == null) {
			instance = new MemberDao();
		}

		return instance;
	}

	private MemberDao() {
		// dao �� �����ϴ°��� ������ �ؿ� �޼��� ó���Ҷ� conn ������ ������ �ȵȴ�.
	}// MemberDao

	private void getConnection() { // dbcp //�ٸ������� �� ���� ��� private
		/* Context.xml�� ������� ������ �о�� */
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

	}// getConnection()

//(���δ� ��������)	

	public ArrayList<MemberBean> getAllMember() {
		ArrayList<MemberBean> lists = new ArrayList<MemberBean>();

		String sql = "select * from members";
		try {
			// 3. SQL �ۻ� �� �м�
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				MemberBean mb = getMemberBean(rs);

				lists.add(mb);
			}

			// 4. SQL�� ����

		} catch (SQLException e) {
			System.out.println("SQL�� ������ ���� �߻�");
		} finally {
			try {
				// �̷��� null �񱳸� ���ְ� ��� ��ȯ�ϸ� �� �Ϻ��ϴٰ� �Ͻ�
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}
		return lists;

	}

//=====(ȸ������)=============================================================
	public int insertMember(MemberBean mb) {
		// 2.
		System.out.println("mb :" + mb);

		getConnection();
		PreparedStatement ps = null;

		int cnt = -1;

		try {
			// 3. SQL �ۻ� �� �м�
			String sql = "insert into members values(memberseq.nextval,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);

			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPassword());
			ps.setString(3, mb.getName());
			ps.setString(4, mb.getEmail());
			ps.setString(5, mb.getPhone());
			ps.setString(6, mb.getPostcode());
			ps.setString(7, mb.getAddress());
			ps.setString(8, mb.getDetailaddress());
			ps.setString(9, mb.getGender());
			ps.setString(10, mb.getBirth());
			ps.setString(11, "sysdate");
			ps.setInt(12, mb.getPoint());

			// 4. SQL�� ����
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println("SQL�� ������ ���� �߻�");
		} finally {
			try {
				// �̷��� null �񱳸� ���ְ� ��� ��ȯ�ϸ� �� �Ϻ��ϴٰ� �Ͻ�
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}
		return cnt;
	}

//==========(id check)============================================================
	public boolean idcheck(String id) {

		boolean flag = false;
		System.out.println("�ֱ��� id :" + id);

		getConnection();

		String sql = "select id from members where id=?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);

			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
			}

		} catch (SQLException e) {
			System.out.println("idcheck sql error");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}

		System.out.println("flag :" + flag);
		return flag;

	}
//=======(login Ȯ��)=================================================================================================

	public int login(String id, String password) {
		int result = -1;

		getConnection();

		String sql = "select * from members where id=? and password=?";

		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, password);

			rs = ps.executeQuery();

			while (rs.next()) {
				result = 1;
			}
		} catch (SQLException e) {
			System.out.println("login sql error/conn error");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}

		System.out.println("login result :" + result);
		return result;
	}
//=====(id �� ���� �� ��������)====================================================================================================

	public MemberBean getMemberById(String id) {
		MemberBean mb = null;

		getConnection();

		String sql = "select * from members where id=?";

		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, id);

			rs = ps.executeQuery();

			if (rs.next()) {
				mb = getMemberBean(rs);
			}

		} catch (SQLException e) {
			System.out.println("getMemberById eql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}
		System.out.println("mb : " + mb);
		return mb;
	}

	// ==========(id ����
	// ��������)============================================================

	public MemberBean searchId(String name, String rrn1, String rrn2) {

		MemberBean mb = null;

		getConnection();
		try {

			String sql = "select * from members where name=? and rrn1=? and rrn2=?";

			ps = conn.prepareStatement(sql);

			ps.setString(1, name);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);

			rs = ps.executeQuery();

			if (rs.next()) {
				mb = getMemberBean(rs);
			}

		} catch (SQLException e) {
			System.out.println("getMemberByRrn sql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}

		return mb;
	}// getMemberByRrn

	public MemberBean getMEmberPw(String id, String name, String rrn1, String rrn2) {

		MemberBean mb = null;

		getConnection();

		try {

			String sql = "select * from members where id=? and rrn1=? and rrn2=?";

			ps = conn.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);

			rs = ps.executeQuery();

			if (rs.next()) {
				mb = getMemberBean(rs);
			}

		} catch (SQLException e) {
			System.out.println("getMEmberPw sql error");
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}

		return mb;

	}// getMEmberPw public MemberBean getMemberBean(ResultSet rs) throws

	// =====(id �� ���� ��
	// ��������)====================================================================================================

	public MemberBean getMemberByNo(String no) {
		MemberBean mb = null;

		getConnection();

		String sql = "select * from members where no=?";

		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, no);

			rs = ps.executeQuery();

			if (rs.next()) {
				mb = getMemberBean(rs);
			}

		} catch (SQLException e) {
			System.out.println("getMemberByNo eql error");
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}
		System.out.println("mb : " + mb);
		return mb;
	}

//=======(������Ʈ)===================================================================

	public int updateMember(MemberBean mb) {
		int result = -1;
		
		System.out.println("mb.getNo :"+ mb.getNo());
		String sql = "update members set id=?,password=?,name=?,email=?,phone=?,postcode=?,address=?,detailaddress=?,gender=?,birth=? where no=?";
		try {
			ps = conn.prepareStatement(sql);
		
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPassword());
			ps.setString(3, mb.getName());
			ps.setString(4, mb.getEmail());
			ps.setString(5, mb.getPhone());
			ps.setString(6, mb.getPostcode());
			ps.setString(7, mb.getAddress());
			ps.setString(8, mb.getDetailaddress());
			ps.setString(9, mb.getGender());
			ps.setString(10, mb.getBirth());
			ps.setInt(11, mb.getNo());
			
			result = ps.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println("updateMember sql error");
		}finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}
		System.out.println("updateMember result :"+result);
		return result;
	}
//========ȸ�� ����=============================================================
	
	public int deleteMember(String no) {
		int result = -1;

		getConnection();

		String sql = "delete members where no=?";

		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, no);

			result = ps.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println("deleteMember sql error/conn error");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("���� ���� ����");
			}
		}

		System.out.println("deleteMember result :" + result);
		return result;
	}
	
	public MemberBean getMemberBean(ResultSet rs) throws SQLException { // SQLException { // ȣ���� �ʿ��� ����ó���ϵ����Ѵ�. throws

		MemberBean mb = new MemberBean();

		mb.setNo(rs.getInt("no"));
		mb.setId(rs.getString("id"));
		mb.setPassword(rs.getString("password"));
		mb.setName(rs.getString("name"));
		mb.setEmail(rs.getString("email"));
		mb.setPhone(rs.getString("phone"));
		mb.setPostcode(rs.getString("postcode"));
		mb.setAddress(rs.getString("address"));
		mb.setDetailaddress(rs.getString("detailaddress"));
		mb.setGender(rs.getString("gender"));
		mb.setBirth(rs.getString("birth"));
		mb.setJoindate(rs.getString("joindate"));
		mb.setPoint(rs.getInt("point"));

		return mb;

	}// getMemberBean
}// MemberDao
