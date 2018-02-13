<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../admin4/auth.jsp" %> 
<%@ include file="./ssi.jsp" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <form name='frm' action='./create_proc.jsp' method='POST'>
    <fieldset class='fieldset_basic'>
      <legend class='legend_basic'>카테고리 등록(*: 필수)</legend>
      <div style='text-align: center;'>
      <ul>
        <li class='li_none'>
          <input type='text' name='title' id='title' value='' style='width: 25%;' placeholder="게시판 제목">*
           순서 <input type='number' name='seqno' id='seqno' value='<%=categoryProc.getMaxSeqno() %>' min='1' max='1000' step='1' style='width: 5%;'>
           View 
          <label>
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
            <input type='text' name='ids' id='ids' value='admin'  style='width: 20%;' placeholder="접근 계정">*
                     
          <%
          if (Tool.isMaster(request) || Tool.isAdmin(request)) {
          %>
            <DIV class='bottom_menu'>
            <button type='submit'>등록</button>
            <button type='reset'>취소</button>
          </DIV>
        <%
        }
        %>
        </li>
      </ul>
      </div>
    </fieldset>
    
  </form>
 
  <TABLE class='table_basic'>
    <colgroup>
      <col style='width: 5%;' />   <!-- 출력 순서 -->
      <col style='width: 40%;' /> <!-- 제목 -->
      <col style='width: 25%;' /> <!-- 접근 계정 -->
      <col style='width: 5%;' /> <!-- 출력 선택 -->
      <col style='width: 10%;' /> <!-- 등록된 자료수 -->
      <col style='width: 15%;' /> <!-- 기타 -->
    </colgroup>
    <TR>
      <TH class='th_basic'>순서</TH>
      <TH class='th_basic'>제목</TH>
      <TH class='th_basic'>계정</TH>
      <TH class='th_basic'>출력</TH>      
      <TH class='th_basic'>자료수</TH>
      <TH class='th_basic'>기타</TH>
    </TR>
<%
ArrayList<CategoryVO> list = categoryProc.list();
for (int index=0; index < list.size(); index++) {
  CategoryVO categoryVO = list.get(index);
  
  int categoryno = categoryVO.getCategoryno();
  String visible = categoryVO.getVisible();
%>
    <TR>
      <TD class='td_basic'><%=categoryVO.getSeqno() %></TD>
      <TD class='td_basic' style='text-align: left;'>
        <A href='../pds4/list_category_grid1.jsp?categoryno=<%=categoryno %>&category_title=<%=categoryVO.getTitle() %>'><%=categoryVO.getTitle() %></A>
      </TD>
      <TD class='td_basic'><%=categoryVO.getIds() %></TD>
      <TD class='td_basic'><A href="./show_hide.jsp?categoryno=<%=categoryno %>&visible=<%=visible%>"><%=visible %></A></TD>
      <TD class='td_basic'><%=categoryVO.getCnt() %></TD>
      <TD class='td_basic'>
        <A href='../pds4/create_form.jsp?categoryno=<%=categoryno %>'><IMG src='./images/create.png' style='width: 12px;' title="카테고리에 해당하는 글 등록"></A>
        <A href='./high.jsp?categoryno=<%=categoryno %>'><IMG src='./images/arrow_up.png' style='width: 12px;'></A>
        <A href='./low.jsp?categoryno=<%=categoryno %>'><IMG src='./images/arrow_down.png' style='width: 12px;'></A>
        <A href='./update_form.jsp?categoryno=<%=categoryno %>'><IMG src='./images/update.png' style='width: 12px;'></A>
        <A href='./delete_form.jsp?categoryno=<%=categoryno %>'><IMG src='./images/delete.png' style='width: 12px;'></A>
    </TR>
<%  
}
%>
  </TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>