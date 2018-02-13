package nation.web.visitor4;

import java.util.ArrayList;

public class VisitorProc {
  private VisitorDAO visitorDAO;
  
  public VisitorProc() {
    visitorDAO = new VisitorDAO();
  }
  
  public int insert(VisitorVO visitorVO) { // Call By Reference
    int count = visitorDAO.insert(visitorVO);
    
    return count;
  }  
  
  /**
   * 게시물 목록을 리턴 (여러 개의 레코드) 목록이 없으면 null을 리턴 
   * @return ArrayList<VisitorVO>
   */
  public ArrayList<VisitorVO> list() {
    ArrayList<VisitorVO> list = visitorDAO.list();
    
    return list;
  }
  
  /***
   * 한 건의 레코드 조회 
   * @param visitorno 번호 
   * @return VisitorVO 
   */
  public VisitorVO read(int visitorno) {
    
    VisitorVO visitorVO = visitorDAO.read(visitorno);
    
    return visitorVO;
    
  }
  
  /**
   * 레코드의 번호와 사용자가 입력한 패스워드가 실제 DB에 존재하는지 체크하여 있으면 1 없으면 0을 리턴 
   * @param visitorno
   * @param passwd
   * @return 
   */
  public int passwordCheck(int visitorno, String passwd) {
    
    int count = visitorDAO.passwordCheck(visitorno, passwd);
    
    return count;
    
  }
  
  /**
   * 한 건의 레코드에 담긴기존에 입력한 내용을 수정 처리하는 함수 
   * @param visitorVO (사용자가 수정한 레코드 내용을 담은 객체)
   * @return
   */
  public int update(VisitorVO visitorVO) {
    int count = visitorDAO.update(visitorVO);
    
    return count;  
    
  }
  
  /**
   * 레코드 한 건 삭제 
   * @param visitorno
   * @return 0: 삭제 실패 or 1: 삭제 성공 
   */
  public int delete(int visitorno) {
    
    int count = visitorDAO.delete(visitorno);
    
    return count;
    
  }
  
  /**
   * 보여줄 레코드 개수를 전달받아 레코드로 구성된 ArrayList를 리턴
   * @param count 갯수 
   * @return
   */  
  public ArrayList<VisitorVO> list_home(int count) {
    ArrayList<VisitorVO> list = visitorDAO.list_home(count);
    
    return list;
    
  }
  
}