<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
String category_title = request.getParameter("category_title");

//-----------------------------------------------------------------
//페이징 관련 코드 시작
//-----------------------------------------------------------------
int recordCount = pds4Proc.count(categoryno, col, word);



//listFile 목록 파일명
//recordCount 전체 레코드수 
//nowPage 현재 페이지
//recordPerPage 페이지당 레코드 수 
//col 검색 컬럼 
//word 검색어 
String paging = new Paging().paging4(listFile, recordCount, nowPage, recordPerPage, col, word, categoryno, category_title);  
//-----------------------------------------------------------------

ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno, col, word, nowPage, recordPerPage); 
%>
 
<!DOCTYPE html>  
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>게시판</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<style type="text/css">
  .panel{
    display: table;
    width: 100%;
    height: 150px;
    margin: 0px auto;
  }
  
  .panel_content{
    display: table-cell;
    vertical-align: middle;
    text-align: center;
    background-color: #FFFFF5;
  }
    
</style>
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>  

<DIV class='aside_menu'>
    <ASIDE style='float: right;'>
      <FORM name='frm' method='GET' action='./list_category_grid1.jsp'>
        <input type='hidden' name='categoryno' value='<%=categoryno %>'>
        <input type='hidden' name='category_title' value='<%=category_title %>'>
 
        <SELECT name='col' onchange="total_list(this.form);">
          <OPTION value='none' <%=(col.equals("none"))?"selected='selected'":"" %>>전체 목록</OPTION>
          <OPTION value='rname' <%=(col.equals("rname"))?"selected='selected'":"" %>>이름</OPTION>
          <OPTION value='title' <%=(col.equals("title"))?"selected='selected'":"" %>>제목</OPTION>
          <OPTION value='content' <%=(col.equals("content"))?"selected='selected'":"" %>>내용</OPTION>
          <OPTION value='title_content' <%=(col.equals("title_content"))?"selected='selected'":"" %>>제목+내용</OPTION>
        </SELECT>
        <INPUT type='text' name='word' value='<%=word %>' placeholder="검색어">
        <BUTTON type='submit'>검색</BUTTON>
      </FORM> 
    </ASIDE>

  <ASIDE style='float: left;'><A href='../category4/list.jsp'>게시판</A>＞<A href='./list_category_grid1.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>'><%=category_title %></A></ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list_category_grid1.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>앨범형</A> <span class='menu_divide'> |</span>
      <%
      if (list.size() > 0) {
      %>
      <A href='./list_read.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>&nowPage=1&recordPerPage=1'>펼쳐보기</A> <span class='menu_divide'> |</span>
      <%
      } else {
      %>
      <A href='./list_read_error.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>&nowPage=1&recordPerPage=1'>펼쳐보기</A> <span class='menu_divide'> |</span>
      <%  
      }
      %>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 

  <%-- 
  <DIV class='title_box'><%=category_title %></DIV>
  --%>
  <%
  for(int index=0; index < list.size(); index++){
    Pds4VO pds4VO = list.get(index);
    String thumb = pds4VO.getThumb();
    int pdsno = pds4VO.getPdsno();
    String title = pds4VO.getTitle();
    String rdate = pds4VO.getRdate();
    String rname = pds4VO.getRname();
    String file1 = pds4VO.getFile1();
    String fstor1 = pds4VO.getFstor1();
    int cnt = pds4VO.getCnt();
    long size1 = pds4VO.getSize1();
    
    // 0, 1, 2, 3, 4<div>, 5, 6, 7, 8<div>...
    if (index != 0 && index % 4 == 0) {
    %>
      <HR class='hr_dotted'>
    <%  
    }
  %>
  <!-- 하나의 이미지 출력 -->
  <DIV class='div_grid_img'>
    <%
    
    boolean fileExists = false;
    ServletContext context = request.getSession().getServletContext();
    if (fstor1 != "" || fstor1 != null) {
      String realPath = context.getRealPath("/pds4/storage/"+fstor1);
      fileExists = new File(realPath).exists();
    }
    
    
    //out.println("fileExists: "+fileExists);
    
    if (size1 > 0) { // 파일이 존재하면 
      //File file2 = new File(realPath);
      //String name2 = file2.getName().toLowerCase();
      if (thumb != null) { // 이미지라면 thumb이 생성되므로 thumb이 null이 아님 
    %>
      <A href='./read.jsp?pdsno=<%=pdsno%>&categoryno=<%=categoryno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>&listFile=<%=listFile %>''><IMG src='./storage/<%=thumb %>' style='width: 100%; height: 150px;'></A> 
    <%
      }
      else { // 이미지가 아니라면
        %>
        
      <DIV class='div_grid_text' style="height: 150px; width: 98%">
        <DIV class='div_grid_text_content' >
        <A href='<%=request.getContextPath()%>/download?dir=/pds4/storage&filename=<%=fstor1 %>'><%=file1 %></A>
          
        </DIV>
      </DIV>        
        
        <%
      }
    } else {
      
    %>
      <%--<DIV class='div_grid_text' style="height: 150px; width: 98%">
        <DIV class='div_grid_text_content' >
          등록된 파일 없음
        </DIV>
      </DIV>--%>
      <IMG src='./images/none1.jpg' style='width: 100%; height: 150px;'>
    <%
    }
    %> 
    <br>
    <A href='./read.jsp?pdsno=<%=pdsno%>&categoryno=<%=categoryno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>&listFile=<%=listFile %>'><%=title %> [<%=cnt %>]</A>  
    <br>
    <span style='font-size: 0.8em;'><%=rdate %> (<%=rname %>)</span>
  </DIV>  
  <%
  }
  %>
  
<HR class='hr_dotted'>
                      
<DIV class='bottom_menu'>
 <%
  if (Tool.isMaster(request) || Tool.isAdmin(request)) {
  %>
  <button type='button' 
             onclick="location.href='./create_form.jsp?categoryno=<%=categoryno %>'">등록</button>
  <button type="button" onclick="location.href='../category4/list.jsp'">카테고리</button>
  <%
  }
  %>  
  <HR class='hr_dotted'>
  <%=paging %>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 