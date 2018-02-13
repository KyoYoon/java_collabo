<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
 
categoryProc.low(categoryno); // 우선순위 낮춤 
 
response.sendRedirect("./list.jsp");
%>