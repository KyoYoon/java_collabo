<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
CategoryVO categoryVO = categoryProc.read(categoryno);
String category_title = categoryVO.getTitle();
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
 
        <SELECT name='col' onchange="total_list(this.form);">
          <OPTION value='none'>전체 목록</OPTION>
          <OPTION value='rname'>이름</OPTION>
          <OPTION value='title'>제목</OPTION>
          <OPTION value='content'>내용</OPTION>
          <OPTION value='title_content'>제목+내용</OPTION>
        </SELECT>
        <INPUT type='text' name='word' value='' placeholder="검색어">
        <BUTTON type='submit'>검색</BUTTON>
      </FORM> 
    </ASIDE>
    
    <!--  <DIV style='clear: both;'> -->
    
    <ASIDE style='float: left;'>게시판＞<%=category_title %>＞목록</ASIDE> 
    <ASIDE style='float: right;'>
      <A href='./list_category_table2.jsp?categoryno=<%=categoryno %>'>목록형</A> <span class='menu_divide'> |</span> 
      <A href='./list.jsp?categoryno=<%=categoryno %>'>앨범형</A> <span class='menu_divide'> |</span>
      <A href='./list_read.jsp'>펼쳐보기</A>
       
    </ASIDE>
 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
  
<%
ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno, col, word);
%>
 
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
    int pdsno = pds4VO.getPdsno();
%> 
  <TR>
    <TD class='td_basic'><%=pdsno %></TD>
    <TD class='td_img'>
      <%
      if (pds4VO.getSize1() > 0) {
        if (Tool.isImage(pds4VO.getFstor1())) {
        %>
          <A href='./read.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>'><IMG src='./storage/<%=pds4VO.getThumb() %>' style='width: 100%; display: block;'></A>    
        <%  
        } else {
        %>
          <A href='<%=root%>/download2?dir=/pds4/storage&filename=<%=pds4VO.getFstor1() %>&downname=<%=pds4VO.getFile1() %>'><%=pds4VO.getFile1() %></A>
          (<%=Tool.unit(pds4VO.getSize1()) %>)
        <%  
        }
      }
      %>
    </TD>
    <TD class='td_basic'>
    <%
    if (Tool.checkNull(pds4VO.getMap()).trim().length() > 0) {
    %>
      <IMG src='./images/map.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic'>
    <%
    if (Tool.checkNull(pds4VO.getYoutube()).trim().length() > 0) {
    %>
      <IMG src='./images/youtube.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic'>
    <%
    // System.out.println("Tool.checkNull(pds4VO.getMp3()): " + Tool.checkNull(pds4VO.getMp3()));
    if (Tool.checkNull(pds4VO.getMp3()).trim().length() > 0) {
    %>
      <IMG src='./images/mp3.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic'>
    <%
    if (Tool.checkNull(pds4VO.getMp4()).trim().length() > 0) {
    %>
      <IMG src='./images/mp4.png'>
    <%  
    }
    %>
    </TD>
    <TD class='td_basic' style='text-align: left;'>
      <A href='./read.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>'><%=pds4VO.getTitle() %></A></TD>
    <TD class='td_basic'><%=pds4VO.getRname() %></TD>
    <TD class='td_basic'><%=pds4VO.getCnt() %></TD>
    <TD class='td_basic'><%=pds4VO.getRdate() %></TD>
    <TD class='td_basic'>
      <%
      if (pds4VO.getVisible().equals("Y")) {
      %>
        <A href='./show_hide.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&visible=<%=pds4VO.getVisible()%>'><IMG src='./images/show.png' title='출력'></A>
      <%  
      } else {
      %>
        <A href='./show_hide.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&visible=<%=pds4VO.getVisible()%>'><IMG src='./images/hide.png' title='숨기기'></A>
      <%  
      }
      %>
      <A href='./update_form.jsp?pdsno=<%=pdsno %>'><IMG src='./images/update.png' title='수정'></A>
      <A href='./delete_form.jsp?pdsno=<%=pdsno %>'><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
    
  </TR>
<%
  }
%>
  </tbody>
  <tfoot>
  </tfoot>
</TABLE>
 
<DIV class='bottom_menu'>
  <button type='button' 
             onclick="location.href='./create_form.jsp?categoryno=<%=categoryno %>'">등록</button>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 