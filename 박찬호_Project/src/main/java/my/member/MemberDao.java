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
		// dao 에 연결하는것이 있으면 밑에 메서드 처리할때 conn 연결을 끊으면 안된다.
	}// MemberDao

	private void getConnection() { // dbcp //다른곳에서 쓸 일이 없어서 private
		/* Context.xml을 살펴봐서 설정을 읽어본다 */
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

	}// getConnection()

//(전부다 가져오기)	

	public ArrayList<MemberBean> getAllMember() {
		ArrayList<MemberBean> lists = new ArrayList<MemberBean>();

		String sql = "select * from members";
		try {
			// 3. SQL 작상 및 분석
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				MemberBean mb = getMemberBean(rs);

				lists.add(mb);
			}

			// 4. SQL문 실행

		} catch (SQLException e) {
			System.out.println("SQL문 실행중 오류 발생");
		} finally {
			try {
				// 이렇게 null 비교를 해주고 모두 반환하면 더 완벽하다고 하심
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return lists;

	}

//=====(회원가입)=============================================================
	public int insertMember(MemberBean mb) {
		// 2.
		System.out.println("mb :" + mb);

		getConnection();
		PreparedStatement ps = null;

		int cnt = -1;

		try {
			// 3. SQL 작상 및 분석
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

			// 4. SQL문 실행
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println("SQL문 실행중 오류 발생");
		} finally {
			try {
				// 이렇게 null 비교를 해주고 모두 반환하면 더 완벽하다고 하심
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("접속 종료 실패");
			}
		}
		return cnt;
	}

//==========(id check)============================================================
	public boolean idcheck(String id) {

		boolean flag = false;
		System.out.println("넣기전 id :" + id);

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
				System.out.println("접속 종료 실패");
			}
		}

		System.out.println("flag :" + flag);
		return flag;

	}
//=======(login 확인)=================================================================================================

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
				System.out.println("접속 종료 실패");
			}
		}

		System.out.println("login result :" + result);
		return result;
	}
//=====(id 를 통한 다 가져오기)====================================================================================================

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
				System.out.println("접속 종료 실패");
			}
		}
		System.out.println("mb : " + mb);
		return mb;
	}

	// ==========(id 통해
	// 가져오기)============================================================

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
				System.out.println("접속 종료 실패");
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
				System.out.println("접속 종료 실패");
			}
		}

		return mb;

	}// getMEmberPw public MemberBean getMemberBean(ResultSet rs) throws

	// =====(id 를 통한 다
	// 가져오기)====================================================================================================

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
				System.out.println("접속 종료 실패");
			}
		}
		System.out.println("mb : " + mb);
		return mb;
	}

//=======(업데이트)===================================================================

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
				System.out.println("접속 종료 실패");
			}
		}
		System.out.println("updateMember result :"+result);
		return result;
	}
//========회원 삭제=============================================================
	
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
				System.out.println("접속 종료 실패");
			}
		}

		System.out.println("deleteMember result :" + result);
		return result;
	}
	
	public MemberBean getMemberBean(ResultSet rs) throws SQLException { // SQLException { // 호출한 쪽에서 예외처리하도록한다. throws

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
