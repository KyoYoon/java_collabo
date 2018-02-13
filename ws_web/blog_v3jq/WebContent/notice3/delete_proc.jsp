<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>

<% 
request.setCharacterEncoding("utf-8"); 
%>

<%
int count = 0;                          // 처리된 레코드 갯수
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 3</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <fieldset style='width: 70%; margin: 10px auto;'>
    <legend class='legend_basic'>공지사항 삭제 3</legend>
      <ul>
      <%
      int noticeno = Integer.parseInt(request.getParameter("noticeno"));
 
       count = noticeDAO.delete(noticeno);
        
        if (count == 1) {
        %>  
          <li class='li_none'>삭제 처리에 성공했습니다.</li>
        <%  
        } else {
        %>  
          <li class='li_none'>공지사항 삭제에 실패했습니다.</li>
          <li class='li_none'>다시한번 시도해주세요.</li>
        <%  
        }
        
 
      %>
      </ul>
  </fieldset>
  
  <DIV class='bottom_menu'>
    <%  
    if (count == 0) {
    %>
    <button type='button' onclick="location.href='./delete_form.jsp?noticeno=<%=noticeno%>'">다시 시도</button> 
    <%
    }
    %>
    <button type='button' onclick="location.href='./list.jsp'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>