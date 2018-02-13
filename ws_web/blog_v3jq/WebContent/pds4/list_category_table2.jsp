<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
String category_title = request.getParameter("category_title");

//-----------------------------------------------------------------
//페이징 관련 코드 시작
//-----------------------------------------------------------------
int recordCount = pds4Proc.count(categoryno, col, word);

listFile = "list_category_table2.jsp";   

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
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>  

<DIV class='aside_menu'>
    <ASIDE style='float: right;'>
      <FORM name='frm' method='GET' action='./list_category_table2.jsp'>
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

    <ASIDE style='float: left;'><A href='../category4/list.jsp'>게시판</A>＞<A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>'><%=category_title %></A></ASIDE> 
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
 
<%

%>
  <%-- 
  <DIV class='title_box'><%=category_title %></DIV>
  --%>
 
<TABLE class='table_basic'>
  <colgroup>
    <col style='width: 10%;' />
    <col style='width: 10%;' />
    <col style='width: 10%;' />
    <col style='width: 10%;' />
    <col style='width: 5%;' />
    <col style='width: 5%;' />
    <col style='width: 10%;' />
    <col style='width: 10%;' />
    <col style='width: 6%;' />
    <col style='width: 14%;' />
    <col style='width: 10%;' />
  </colgroup>
  <thead>
    <TR>
      <TH class='th_basic'>번호</TH>
      <TH class='th_basic'>파일</TH>
      <TH class='th_basic'>지도</TH>
      <TH class='th_basic'>Youtube</TH>
      <TH class='th_basic'>MP3</TH>
      <TH class='th_basic'>MP4</TH>
      <TH class='th_basic'>제목</TH>
      <TH class='th_basic'>성명</TH>
      <TH class='th_basic'>조회</TH>
      <TH class='th_basic'>등록일</TH>
      <TH class='th_basic'>기타</TH>
    </TR>
  </thead>
  <tbody>
<%
  for(int index=0; index < list.size(); index++){
    Pds4VO pds4VO = list.get(index);
    String file1 = pds4VO.getFile1();
    String fstor1 = pds4VO.getFstor1();
    String thumb = pds4VO.getThumb();
    
    ServletContext context = request.getSession().getServletContext();
    
    String realPath = context.getRealPath("/pds4/storage/"+fstor1);
    boolean fileExists = new File(realPath).exists();
%> 
  <TR>
    <TD class='td_basic'><%=pds4VO.getPdsno() %></TD> <!-- 번호 -->
    <TD class='td_img' style='padding: 2px'> <!-- 파일 -->
    <%
    
    if (pds4VO.getSize1() > 0) { // 서버에 파일이 존재하면
       if (thumb != null) { // 이미지
    %>
      <A href='./read.jsp?pdsno=<%=pds4VO.getPdsno() %>&categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>&listFile=<%=listFile %>''><IMG src='./storage/<%=pds4VO.getThumb() %>' style='width: 100%; display: block;'></A>
    <%
       } else { // 일반 파일이면 다운로드 링크 추가
    %>
      <DIV class='div_grid_text' style="height: 100%; width: 98%">
        <DIV class='div_grid_text_content' >
        <A href='<%=request.getContextPath()%>/download?dir=/pds4/storage&filename=<%=fstor1 %>'><%=file1 %></A>
          
        </DIV>
      </DIV>
    <%
       }
    } else { // 서버에 파일이 존재하지 않는다면 
    %>
       <IMG src='./images/none1.jpg' style='width: 100%; height: 150px;'>
    <%
    } 
    %>
    </TD>
    <TD class='td_basic'> <!-- 지도 -->
    <%
    if (Tool.checkNull(pds4VO.getMap()).trim().length() > 0) {
    %>
      <IMG src='./images/map.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic'> <!-- Youtube -->
    <%
    if (Tool.checkNull(pds4VO.getYoutube()).trim().length() > 0) {
    %>
      <IMG src='./images/youtube.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic'><!-- mp3 -->
    <%
    // System.out.println("Tool.checkNull(pds4VO.getMp3()): " + Tool.checkNull(pds4VO.getMp3()));
    if (Tool.checkNull(pds4VO.getMp3()).trim().length() > 0) {
    %>
      <IMG src='./images/mp3.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic'> <!-- mp4 -->
    <%
    if (Tool.checkNull(pds4VO.getMp4()).trim().length() > 0) {
    %>
      <IMG src='./images/mp4.png'>
    <%  
    }
    %>
    </TD>            
    <TD class='td_basic'> <!-- 제목 -->
      <A href='./read.jsp?pdsno=<%=pds4VO.getPdsno() %>&categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>&listFile=<%=listFile %>''><%=pds4VO.getTitle() %></A></TD>
    <TD class='td_basic'><%=pds4VO.getRname() %></TD>
    <TD class='td_basic'><%=pds4VO.getCnt() %></TD>
    <TD class='td_basic'><%=pds4VO.getRdate() %></TD>
    <TD class='td_basic'>
    <%
    if (pds4VO.getVisible().equals("Y")) {
      %> 
      <A href="./show_hide.jsp?pdsno=<%=pds4VO.getPdsno() %>&visible=<%=pds4VO.getVisible() %>&categoryno=<%=categoryno %>&category_title=<%=category_title %>"><IMG src='./images/show.png' title='출력'> </A>
      <%
    } else {
    %>
      <A href="./show_hide.jsp?pdsno=<%=pds4VO.getPdsno() %>&visible=<%=pds4VO.getVisible() %>&categoryno=<%=categoryno %>&category_title=<%=category_title %>"><IMG src='./images/hide.png' title='숨기기'> </A>
    <%
    }
    %>
      <A href='./update_form.jsp?pdsno=<%=pds4VO.getPdsno() %>'><IMG src='./images/update.png' title='수정'></A>
      <A href='./delete_form.jsp?pdsno=<%=pds4VO.getPdsno() %>'><IMG src='./images/delete.png' title='삭제'></A>
      
    </TD>
    
  </TR>
<%
  }
%>
  </tbody>
  <tfoot>
  </tfoot>
</TABLE>
   
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