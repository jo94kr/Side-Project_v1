package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {

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

	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			// 예외가 발생할 명령(디비연동, 외부파일연동, ...

			// 1단계 드라이버 불러오기
			// 2단계 디비연결 jspdb1 jspid jsppass
			con = getConnection();

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성
			String sql = "insert into `member`(id,pass,name,reg_date,email,address,phone,mobile) values(?,?,?,?,?,?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getReg_date());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getPhone());
			pstmt.setString(8, mb.getMobile());
			// 4단계 - 만든 객체 실행 insert,update,delete
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
	}// insertMember()

	// MemberBean리턴 getMember(아이디 받을 변수)
	public MemberBean getMember(String id) {
		MemberBean mb = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외가 발생할 명령(디비연동, 외부파일연동, ...

			// 1단계 드라이버 가져오기
			// 2단계 디비연결
			con = getConnection();

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성 select
			String sql = "select * from `member` where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			// 4단계 - 만든 객체 실행 select => 결과 저장 내장객체
			rs = pstmt.executeQuery();

			// 5단계 - 첫행이동 데이터 있으면 MemberBean객체생성 멤버변수에 값저장
			if (rs.next()) {
				mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}

		}
		catch (Exception e) {
			// 예외를 잡아서 처리
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

		return mb;
	}// getMember()

	// 리턴할형(정수형) userCheck(아이디, 비밀번호)
	public int userCheck(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			// 예외가 발생할 명령(디비연동, 외부파일연동, ...

			// 1단계 드라이버 불러오기
			// 2단계 디비연결 jspdb1 jspid jsppass
			con = getConnection();

			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성 select
			// 디비에 id정보가 있는지 조회(가져오기)
			String sql = "select * from `member` where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 - 만든 객체 실행 select => 결과 저장 내장객체
			rs = pstmt.executeQuery();

			// 5단계 - if 첫행으로 이동 데이터 있으면 true "아이디있음"
			// if 폼 비밀번호 디비비밀번호 비교 맞으면 세션값 생성 main.jsp이동
			// else 틀리면 "비밀번호틀림"
			// else 데이터 없으면 false "아이디없음"
			if (rs.next()) {
				// 아이디있음

				if (pass.equals(rs.getString("pass"))) {
					// System.out.println("비밀번호 맞음");
					check = 1; // 비밀번호 맞음
				}

				else {
					// System.out.println("비밀번호틀림");
					check = 0; // 비밀번호 틀림
				}
			}

			else {
				// System.out.println("아이디 없음");
				check = -1; // 아이디없음
			}
		}
		catch (Exception e) {
			// 예외를 잡아서 처리
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
		return check;
	}

	// idcheck()
	public int idcheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		try {
			con = getConnection();

			String sql = "SELECT * FROM `member` WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				check = 1;
			}
			else {
				check = 0;
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
		return check;
	}// idcheck()

	// updateMember()
	public void updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외가 발생할 명령(디비연동, 외부파일연동,..)
			// 1단계 드라이버 불러오기
			// 2단계 디비연결 jspdb1 jspid jsppass
			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성
			con = getConnection();
			String sql = "update `member` set name = ?, email = ?, address = ?, phone = ?  where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getAddress());
			pstmt.setString(4, mb.getPhone());
			pstmt.setString(5, mb.getId());
			pstmt.executeUpdate();
		}
		catch (Exception e) {
			// 예외를 잡아서 처리
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업 => 사용한 내장객체 기억장소 정리
			if (rs != null)
				try {
					pstmt.close();
				}
				catch (Exception ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				}
				catch (Exception ex) {
				}
			if (con != null)
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
		}
	} // updateMember()

	// updateMember()
	public void updatePassword(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 예외가 발생할 명령(디비연동, 외부파일연동,..)
			// 1단계 드라이버 불러오기
			// 2단계 디비연결 jspdb1 jspid jsppass
			// 3단계 - 연결정보를 이용해서 sql구문을 만들고 실행할 객체생성
			con = getConnection();
			String sql = "update `member` set pass = ? where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getPass());
			pstmt.setString(2, mb.getId());
			pstmt.executeUpdate();
		}
		catch (Exception e) {
			// 예외를 잡아서 처리
			e.printStackTrace();
		}
		finally {
			// 예외상관없이 마무리 작업 => 사용한 내장객체 기억장소 정리
			if (rs != null)
				try {
					pstmt.close();
				}
				catch (Exception ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				}
				catch (Exception ex) {
				}
			if (con != null)
				try {
					con.close();
				}
				catch (SQLException ex) {
				}
		}
	} // updateMember()

}
