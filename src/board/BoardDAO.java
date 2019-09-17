package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
	// 디비 연결 메서드
	private Connection getConnection() throws Exception {
		Connection con = null;

		// 1단계 드라이버 불러오기
		Class.forName("com.mysql.jdbc.Driver");

		// 2단계 디비연결 jspdb1 jspid jsppass
		String dbUrl = "jdbc:mysql://localhost:3306/jspdb1";
		String dbUser = "jspid";
		String dbPass = "jsppass";
		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		return con;
	}

	// insertBoard()
	public void insertBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 예외가 발생할 명령(디비연동, 외부파일연동, ...

			// 1단계 드라이버 불러오기
			// 2단계 디비연결
			con = getConnection();

			// num 글번호 구하기
			// select max(num) from board;
			int num = 0;
			String sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성 insert
			sql = "insert into board(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,now(),?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);
			pstmt.setString(7, bb.getFile());

			// 4단계 - 만든 객체 실행 insert
			// readcount 0 , date ? 대신에 now() mysql시스템날짜시간
			pstmt.executeUpdate();
		}
		catch (Exception e) {
			// 예외를 잡아서 처리
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업 => 사용한 내장객체 기억장소 정리
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
	}// insertBoard()

	// getBoardList()
	public List getBoardList(int startRow, int pageSize) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List boardList = new ArrayList();
		try {
			// 1단계 드라이버 로더
			// 2단계 디비연결
			con = getConnection();

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성 select
			String sql = "select * from board ORDER BY num DESC limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			// 4단계 - 만든 객체 실행 select => 결과 저장 내장객체
			rs = pstmt.executeQuery();
			// 5단계 rs에 저장된 내용을 => 화면에 출력
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				boardList.add(bb);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
		return boardList;
	} // getBoardList()

	// getBoardList()
	public List getBoardList(int startRow, int pageSize, String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List boardList = new ArrayList();
		try {
			// 1단계 드라이버 로더
			// 2단계 디비연결
			con = getConnection();

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성 select
			String sql = "select * from board where subject like ? ORDER BY num DESC limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			// 4단계 - 만든 객체 실행 select => 결과 저장 내장객체
			rs = pstmt.executeQuery();
			// 5단계 rs에 저장된 내용을 => 화면에 출력
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				boardList.add(bb);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
		return boardList;
	} // getBoardList()

	// updateReadcount()
	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			// 3단계 sql update 수정 readcount=readcount+1 조건 num=?
			String sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			// 4단계 실행
			pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();

		}
		finally {
			if (rs != null)
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
		}
	} // updateReadcount()

	// getBoard()
	public BoardBean getBoard(int num) {
		BoardBean bb = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			updateReadcount(num);

			con = getConnection();

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성 select 조건 num=?
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			// 4단계 - 만든 객체 실행 select => 결과 저장 내장객체
			rs = pstmt.executeQuery();

			// 5단계 - 첫행으로 이동 데이터 있으면 true 첫행, 열 화면출력
			if (rs.next()) {
				bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setDate(rs.getDate("date"));
				bb.setName(rs.getString("name"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
		return bb;
	} // getBoard()

	// checkNum()
	public int checkNum(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			// 1,2
			con = getConnection();
			// 3 sql
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			// 4
			rs = pstmt.executeQuery();
			// 5
			if (rs.next()) {
				if (bb.getPass().equals(rs.getString("pass"))) {
					check = 1;
				}
				else {
					check = 0;
				}
			}
			else {
				check = -1;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (rs != null)
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
		}
		return check;
	}

	// updateBoard()
	public BoardBean updateBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();

			String sql = "UPDATE board SET name=?, subject=?, file=?, content=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getName());
			pstmt.setString(2, bb.getSubject());
			pstmt.setString(3, bb.getFile());
			pstmt.setString(4, bb.getContent());
			pstmt.setInt(5, bb.getNum());
			// 4단계 - 만든 객체 실행 insert,update,delete
			pstmt.executeUpdate();

		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
		return bb;
	} // updateBoard()

	// deleteBoard()
	public void deleteBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();

			String sql = "DELETE FROM board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			// 4단계 - 만든 객체 실행 insert,update,delete
			pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
	} // deleteBoard

	// getBoardCount()
	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}

		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
		return count;
	} // getBoardCount()

	// getBoardCount()
	public int getBoardCount(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			String sql = "select count(*) from board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%"); // setString ''자동 생성
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}

		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업
			if (rs != null) {
				try {
					rs.close();
				}
				catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				}
				catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
			}
		}
		return count;
	} // getBoardCount()
}
