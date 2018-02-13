<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>

<% 
request.setCharacterEncoding("utf-8"); 
%>
 
<%
int count = 0;                          // 처리된 레코드 갯수 
%>
 
<%
//삭제할 레코드의 PK (Primary Key) 컬럼의 값을 받음 
int noticeno = Integer.parseInt(request.getParameter("noticeno"));
String title = "";
String rname = "";

NoticeVO noticeVO = null;

noticeVO = noticeDAO.read(noticeno);

title = noticeVO.getTitle();
rname = noticeVO.getRname();
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
 
  <form name='frm' action='./delete_proc.jsp' method='POST'>
    <input type='hidden' name='noticeno' id='noticeno' value='<%=noticeno%>'>
    
    <fieldset style='width: 70%; margin: 10px auto;'>
      <legend class='legend_basic'>공지사항 삭제 3</legend>
      <ul>
        <li class='li_none'>
          내용: <%=title %>
        </li>
        <li class='li_none'>
          성명: <%=rname %>
        </li>
        <li class='li_none' style="margin: 20px auto; text-align: center;">
          <span style='color: #FF0000; font-weight: bold;'>삭제를 진행하면 복구 할 수 없습니다.</span><br>
          삭제하시겠습니까?
        </li>
      </ul>
    </fieldset>
    
    <DIV class='bottom_menu'>
      <button type='submit'>삭제</button>
      <button type='button' onclick="location.href='./list.jsp'">취소</button>
    </DIV>    
  </form>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>