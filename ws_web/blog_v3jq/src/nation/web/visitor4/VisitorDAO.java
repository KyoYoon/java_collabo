package nation.web.visitor4;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.notice3.NoticeVO;
import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;
 
public class VisitorDAO {
  private Connection con = null;              // DBMS 연결   
  private PreparedStatement pstmt = null; // SQL 실행
  private ResultSet rs = null;                   // SELECT 결과를 저장
  private StringBuffer sql = null;              // SQL 저장
  
  private DBOpen dbopen = null;
  private DBClose dbclose = null;
  
  public VisitorDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }
  
  public int insert(VisitorVO visitorVO) { // Call By Reference
    int count = 0; // 처리된 레코드 갯수
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" INSERT INTO visitor(content, rname, passwd, home, email, rdate)");
      sql.append(" VALUES(?, ?, ?, ?, ?, now())");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1,  visitorVO.getContent());
      pstmt.setString(2,  visitorVO.getRname());
      pstmt.setString(3,  visitorVO.getPasswd());
      pstmt.setString(4,  visitorVO.getHome());
      pstmt.setString(5,  visitorVO.getEmail());
      
      count = pstmt.executeUpdate();  // INSERT, UPDATE, DELETE SQL 실행
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }  
  
  // ArrayList<VisitorVO>: ArrayList의 값으로 VisitorVO 클래스의 객체만 가능함.
  public ArrayList<VisitorVO> list() {
    ArrayList<VisitorVO> list = null; // 지역 변수
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT visitorno, content, rname, passwd, home, email, substring(rdate, 1, 10) as rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM visitor");
      sql.append(" ORDER BY visitorno DESC");
 
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      rs = pstmt.executeQuery(); // SELECT SQL 실행
 
      list = new ArrayList<VisitorVO>();
      while(rs.next()) { // 레코드 이동
        VisitorVO visitorVO = new VisitorVO(); // 레코드에 대응할 객체 생성
        // DBMS 컬럼의 값 -> JAVA 변수의 값으로 대입합니다.
        visitorVO.setVisitorno(rs.getInt("visitorno"));
        visitorVO.setContent(rs.getString("content"));
        visitorVO.setRname(rs.getString("rname"));
        visitorVO.setPasswd(rs.getString("passwd"));
        visitorVO.setHome(rs.getString("home"));
        visitorVO.setEmail(rs.getString("email"));
        visitorVO.setRdate(rs.getString("rdate"));
        
        list.add(visitorVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt, rs);
    }
    
    return list;
  }  
   
  /***
   * 한 건의 레코드 조회 
   * @param visitorno 번호 
   * @return VisitorVO 
   */
  public VisitorVO read(int visitorno) {
    
    VisitorVO visitorVO = null;
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT visitorno, content, rname, passwd, home, email, substring(rdate, 1, 10) as rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM visitor");
      sql.append(" WHERE visitorno=?");
  
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, visitorno);
      rs = pstmt.executeQuery(); // SELECT SQL 실행
  
      if(rs.next()) { // 첫번째 레코드부터 마지막까지 레코드까지 이동
       
        visitorVO = new VisitorVO();
        visitorVO.setVisitorno(rs.getInt("visitorno"));
        visitorVO.setContent(rs.getString("content"));
        visitorVO.setRname(rs.getString("rname"));
        visitorVO.setPasswd(rs.getString("passwd"));
        visitorVO.setHome(rs.getString("home"));
        visitorVO.setEmail(rs.getString("email"));
        visitorVO.setRdate(rs.getString("rdate"));
        
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    
    return visitorVO;
    
  }  
  
  /**
   * 레코드의 번호와 사용자가 입력한 패스워드가 실제 DB에 존재하는지 체크하여 있으면 1 없으면 0을 리턴 
   * @param visitorno
   * @param passwd
   * @return 
   */
  public int passwordCheck(int visitorno, String passwd) {
    
    int count = 0;
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT COUNT(*) as cnt"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM visitor");
      sql.append(" WHERE visitorno=? AND passwd=?");
  
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, visitorno);
      pstmt.setString(2, passwd);
      rs = pstmt.executeQuery(); // SELECT SQL 실행
  
      if(rs.next()) { // 첫번째 레코드부터 마지막까지 레코드까지 이동
       
        count = rs.getInt("cnt");
        
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }    
    
    return count;
    
  }

  /**
   * 한 건의 레코드에 담긴기존에 입력한 내용을 수정 처리하는 함수 
   * @param visitorVO (사용자가 수정한 레코드 내용을 담은 객체)
   * @return 0: 불일치 or 1: 일치 
   */
  public int update(VisitorVO visitorVO) { // Call By Reference
    int count = 0; // 처리된 레코드 갯수
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE visitor");
      sql.append(" SET content = ?, rname = ?, home=?, email=? ");
      sql.append(" WHERE visitorno = ? ");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1,  visitorVO.getContent());
      pstmt.setString(2,  visitorVO.getRname());
      pstmt.setString(3,  visitorVO.getHome());
      pstmt.setString(4,  visitorVO.getEmail());
      pstmt.setInt(5,  visitorVO.getVisitorno());
      
      count = pstmt.executeUpdate();  // INSERT, UPDATE, DELETE SQL 실행
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }    
  
  /**
   * 레코드 한 건 삭제 
   * @param visitorno
   * @return 0: 삭제 실패 or 1: 삭제 성공 
   */
  public int delete(int visitorno) { // Call By Reference
    int count = 0; // 처리된 레코드 갯수
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM visitor");
      sql.append(" WHERE visitorno = ? ");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1,  visitorno);
      
      count = pstmt.executeUpdate();  // INSERT, UPDATE, DELETE SQL 실행
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  
  /**
   * 보여줄 레코드 개수를 전달받아 레코드로 구성된 ArrayList를 리턴
   * @param count 갯수 
   * @return
   */  
  public ArrayList<VisitorVO> list_home(int count) {
    ArrayList<VisitorVO> list = null; // 지역 변수
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT visitorno, content, rname, passwd, home, email, substring(rdate, 1, 10) as rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM visitor");
      sql.append(" ORDER BY visitorno DESC");
      sql.append(" LIMIT ?");
 
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, count);
      rs = pstmt.executeQuery(); // SELECT SQL 실행
 
      list = new ArrayList<VisitorVO>();
      while(rs.next()) { // 레코드 이동
        VisitorVO visitorVO = new VisitorVO(); // 레코드에 대응할 객체 생성
        // DBMS 컬럼의 값 -> JAVA 변수의 값으로 대입합니다.
        visitorVO.setVisitorno(rs.getInt("visitorno"));
        visitorVO.setContent(rs.getString("content"));
        visitorVO.setRname(rs.getString("rname"));
        visitorVO.setPasswd(rs.getString("passwd"));
        visitorVO.setHome(rs.getString("home"));
        visitorVO.setEmail(rs.getString("email"));
        visitorVO.setRdate(rs.getString("rdate"));
        
        list.add(visitorVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt, rs);
    }
    
    return list;
  }    
  
  
}