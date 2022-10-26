package Board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDao {
	//BoardDao ��ü�� �̱����������� �����ϱ�

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id = "jspid";
	String pw = "jsppw";
	Connection conn = null;

	private static BoardDao instance;

	public static BoardDao getInstance(){
		if(instance == null) {
			instance = new BoardDao();
		}
		return instance;
	}

	private BoardDao(){
		System.out.println("BoardDao������");
		try {
			Class.forName(driver);
			System.out.println("����̹� ���� ����");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("����̹� ���� ����");
		}
	}// ������

	public void getConnection(){
		try {
			conn = DriverManager.getConnection(url,id,pw);
		} catch (SQLException e) {
			System.out.println("2");
		}
	}


	public int getArticleCount(){

		getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		int count = 0;
		String sql = "select count(*) as cnt from board";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				count =  rs.getInt("cnt");
			}
		} catch (SQLException e) {
			System.out.println("getArticleCount");
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
				if(conn!=null)
					conn.close();
			} catch (SQLException e) {
				System.out.println("close");
			}
		}
		System.out.println("getArticleCount count:"+count);
		return count;

	}//getArticleCount

	public ArrayList<BoardBean> getArticles(int start, int end){

		getConnection();

		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<BoardBean> lists=new ArrayList<BoardBean>();


		String sql = "select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip " ;		        
		sql += "from (select rownum as rank, num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from (select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from board  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";
		
		


		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs=ps.executeQuery();
			while(rs.next()) {
				BoardBean bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setEmail(rs.getString("email"));
				bb.setSubject(rs.getString("subject"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setIp(rs.getString("ip"));
				lists.add(bb);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn!=null)
					conn.close();
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println();
		return lists;
	}//

	

	// �۾���(����)
	public int insertArticle(BoardBean bb){ // 12 7

		getConnection();
		PreparedStatement ps=null;

		// ��ȸ��(readcount)���� ������
		String sql="insert into board(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) " ;
		sql += " values(board_seq.nextval,?,?,?,?,?,board_seq.currval ,?,?,?,?)";
		//board_seq.currval => ref 
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, bb.getWriter());
			ps.setString(2, bb.getEmail());
			ps.setString(3, bb.getSubject());
			ps.setString(4, bb.getPasswd());
			ps.setTimestamp(5, bb.getReg_date());
			ps.setInt(6, 0); // re_step
			ps.setInt(7, 0); // re_level
			ps.setString(8, bb.getContent());
			ps.setString(9, bb.getIp());

			result =ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println("insertArticle error");
			e.printStackTrace();
		}finally {
			try {
				if(conn != null)
					conn.close();

				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;

	}//

	public BoardBean getArticle(int num) { // �ϳ��� ������. ��ũŸ�� ���볪���� , ��ȸ���� +1
		getConnection();
		String sql2 = "update board set readcount=readcount+1 where num="+num;//
		String sql="select * from Board where num="+num;
		PreparedStatement ps=null;
		ResultSet rs=null;
		BoardBean bb=null;      
		try {

			ps=conn.prepareStatement(sql2);
			ps.executeUpdate();

			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				
				bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setEmail(rs.getString("email"));
				bb.setSubject(rs.getString("subject"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));// ��ȸ��
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setIp(rs.getString("ip"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn!=null)
					conn.close();
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}      
		return bb;
	}//getByNum

//======= ��۴ޱ�===========================================================================
	public int replyArticle(BoardBean bb){ //5(���)+3(�θ�)+2(���) => num,readcountX
		getConnection();
		
		int result=-1;
		PreparedStatement ps = null;
		
		String sql1 = "update board set re_step=re_step+1 where ref=? and re_step>?";
		
		
		String sql = "insert into board(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip)";
			sql	+= " values(board_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql1);
			ps.setInt(1, bb.getRef());
			ps.setInt(2, bb.getRe_step());
			
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sql); 
			ps.setString(1, bb.getWriter());
			ps.setString(2, bb.getEmail());
			ps.setString(3, bb.getSubject());
			ps.setString(4, bb.getPasswd());
			ps.setTimestamp(5, bb.getReg_date());
			ps.setInt(6, bb.getRef()); //ref
			ps.setInt(7, bb.getRe_step() + 1); //re_step
			ps.setInt(8, bb.getRe_level() + 1); //re_level
			
			ps.setString(9, bb.getContent());
			ps.setString(10, bb.getIp());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("replyArticle ����");
		} finally {
			try {
				if(conn!=null)
					conn.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("��¿Ϸ�");
		System.out.println("result3:"+result);
		
		return result;
	}//replyArticle

	
	public BoardBean updateGetArticle(String num) {
		
		BoardBean bb=null;
		PreparedStatement ps = null;
		
		getConnection();
		
		try {
		String sql = "select * from board where num="+num;
		
		ps=conn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			
			bb = new BoardBean();
			
			bb.setNum(rs.getInt("num"));
			bb.setWriter(rs.getString("writer"));
			bb.setEmail(rs.getString("email"));
			bb.setSubject(rs.getString("subject"));
			bb.setPasswd(rs.getString("passwd"));
			bb.setReg_date(rs.getTimestamp("reg_date"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setRef(rs.getInt("ref"));
			bb.setRe_step(rs.getInt("re_step"));
			bb.setRe_level(rs.getInt("re_level"));
			bb.setContent(rs.getString("content"));
			bb.setIp(rs.getString("ip"));
		}//while
		
		} catch (SQLException e) {
			System.out.println("updateGetArticle sql error");
		}finally {
			try {
				if(conn!=null)
					conn.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				System.out.println("updateGetArticle close error");
			}
		}//finally
		
		return bb;
	}//updateGetArticle

// ===========�����Ҷ� ��й�ȣ �´��� ��������=================
	
	public int updateArticle(BoardBean bb) {
		int result = -1;
		PreparedStatement ps = null;
		ResultSet rs = null;
		getConnection();

		System.out.println("�����Ϸ��� �Է��� ��й�ȣ :" + bb.getPasswd());
		try {
			String sql = "select passwd from board where num=?";

			ps = conn.prepareStatement(sql);

			ps.setInt(1, bb.getNum());

			rs = ps.executeQuery();

			if (rs.next()) {

				if (bb.getPasswd().equals(rs.getString("passwd"))) {

					String sql2 = "update board set writer=?, subject=?, email=? , content=? where num=?";

					ps = conn.prepareStatement(sql2);

					ps.setString(1, bb.getWriter());
					ps.setString(2, bb.getSubject());
					ps.setString(3, bb.getEmail());
					ps.setString(4, bb.getContent());
					ps.setInt(5, bb.getNum());

					result = ps.executeUpdate();
				} // ��� ��ġ if
				else {
					result= -2;
				}
			} // ��� �ֳ�? if

		} catch (SQLException e) {
			System.out.println("updateArticle sql error");
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (ps != null)
					ps.close();
				if(rs !=null)
					 rs.close();
			} catch (SQLException e) {
				System.out.println("updateArticle close error");
			}
		} // finally

		return result;
	
	}

	public int deleteBoard(BoardBean bb) {
		int result = -1;
		
		PreparedStatement ps = null;
		ResultSet rs=null;
		getConnection();

		System.out.println("�����Ϸ��� �Է��� ��й�ȣ :" + bb.getPasswd());
		try {
			String sql = "select passwd from board where num=?";

			ps = conn.prepareStatement(sql);

			ps.setInt(1, bb.getNum());

			rs = ps.executeQuery();

			if (rs.next()) {

				if (bb.getPasswd().equals(rs.getString("passwd"))) {
					// �Է��� ��� == DB ���
					String sql2 = "delete board where num=?";

					ps = conn.prepareStatement(sql2);
					
					ps.setInt(1,bb.getNum());
					
					result = ps.executeUpdate();
				} // ��� ��ġ if
				
			} // ��� �ֳ�? if

		} catch (SQLException e) {
			System.out.println("deleteBoard sql error");
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (ps != null)
					ps.close();
				 if(rs !=null)
					 rs.close();
			} catch (SQLException e) {
				System.out.println("deleteBoard close error");
			}
		} // finally

		
		
		
		return result;
	}
	
}//ū��ȣ













