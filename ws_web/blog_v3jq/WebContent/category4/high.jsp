<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
 
categoryProc.high(categoryno); // 우선순위 높임 
 
response.sendRedirect("./list.jsp");
%>