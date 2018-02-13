package nation.web.notice3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nation.web.tool.DBOpen;
import nation.web.tool.DBClose;

public class NoticeDAO {
  Connection con = null;              // DBMS 연결   
  PreparedStatement pstmt = null; // SQL 실행
  ResultSet rs = null;                   // SELECT 결과를 저장
  StringBuffer sql = null;              // SQL 저장

  DBOpen dbopen = null;
  DBClose dbclose = null;
 
  public NoticeDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
   
  }
  
  public int create(NoticeVO noticeVO) {
    
    int count = 0; // 처리된 레코드의 갯수
    
    try {
       
      con = dbopen.getConnection();
      
      sql = new StringBuffer();
      sql.append(" INSERT INTO notice(title, rname, rdate)");
      sql.append(" VALUES(?, ?, now())");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1, noticeVO.getTitle());
      pstmt.setString(2, noticeVO.getRname());

      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE
      
      
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
       
  } 
  
  // ArrayList<NoticeVO>: ArrayList의 값으로 NoticeVO 클래스의 객체만 가능함.
  public ArrayList<NoticeVO> list() {
    ArrayList<NoticeVO> list = null; // 지역 변수
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM notice");
      sql.append(" ORDER BY noticeno DESC");
 
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      rs = pstmt.executeQuery(); // SELECT SQL 실행
 
      list = new ArrayList<NoticeVO>();
      while(rs.next()) { // 레코드 이동
        NoticeVO noticeVO = new NoticeVO(); // 레코드에 대응할 객체 생성 
        // DBMS 컬럼의 값 -> JAVA 변수의 값으로 대입합니다. 
        noticeVO.setNoticeno(rs.getInt("noticeno"));
        noticeVO.setTitle(rs.getString("title"));
        noticeVO.setRname(rs.getString("rname"));
        noticeVO.setRdate(rs.getString("rdate").substring(0, 10));
        
        list.add(noticeVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    
    return list;
    
  }
  
  // NoticeVO 가 리턴타입이 됨 => 수정사항 등록할 때 기존 내용 보여줄 때 사용 
  public NoticeVO read(int noticeno) {
    
    NoticeVO noticeVO = null;
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM notice");
      sql.append(" WHERE noticeno=?");
  
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, noticeno);
      rs = pstmt.executeQuery(); // SELECT SQL 실행
  
      if(rs.next()) { // 첫번째 레코드부터 마지막까지 레코드까지 이동
       
        noticeVO = new NoticeVO();
        noticeVO.setNoticeno(rs.getInt("noticeno"));
        noticeVO.setTitle(rs.getString("title"));
        noticeVO.setRname(rs.getString("rname"));
        noticeVO.setRdate(rs.getString("rdate").substring(0, 10));
        
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    
    return noticeVO;
    
  }
  
  // update 함수 - NoticeVO 받아서 해당 레코드 수정 
  public int update(NoticeVO noticeVO) {
    
    int count = 0; // 처리된 레코드의 갯수

    try {
      
      con = dbopen.getConnection();
      
      sql = new StringBuffer();
      sql.append(" UPDATE notice");
      sql.append(" SET title=?, rname=?, rdate=now()");
      sql.append(" WHERE noticeno=?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1, noticeVO.getTitle());
      pstmt.setString(2, noticeVO.getRname());
      pstmt.setInt(3, noticeVO.getNoticeno());
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE
      
      
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }   
    
    return count;
    
  }
  
  
  // delete 함수 - noticeno 받아서 해당 레코드 삭제 
  public int delete(int noticeno) {
    
    int count = 0; // 처리된 레코드의 갯수
    
    try {
      
      con = dbopen.getConnection();
      
      sql = new StringBuffer();
      sql.append(" DELETE FROM notice");
      sql.append(" WHERE noticeno=?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, noticeno);
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE
      
      
    } catch (SQLException e) {
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
  public ArrayList<NoticeVO> list_home(int count) {
    ArrayList<NoticeVO> list = null; // 지역 변수
    
    try {
      con = new DBOpen().getConnection();
      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM notice");
      sql.append(" ORDER BY noticeno DESC");
      sql.append(" LIMIT ?");
 
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, count);
      rs = pstmt.executeQuery(); // SELECT SQL 실행
 
      list = new ArrayList<NoticeVO>();
      while(rs.next()) { // 레코드 이동
        NoticeVO noticeVO = new NoticeVO(); // 레코드에 대응할 객체 생성
        // DBMS 컬럼의 값 -> JAVA 변수의 값으로 대입합니다.
        noticeVO.setNoticeno(rs.getInt("noticeno")); 
        noticeVO.setTitle(rs.getString("title"));
        noticeVO.setRname(rs.getString("rname"));
        noticeVO.setRdate(rs.getString("rdate").substring(0, 10));
        
        list.add(noticeVO);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt, rs);
    }
    
    return list;
    
  }  
  
}
