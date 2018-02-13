<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../admin4/auth.jsp" %>   
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
int pdsno = Integer.parseInt(request.getParameter("pdsno"));
String visible = request.getParameter("visible");
String category_title = request.getParameter("category_title");
 
pds4Proc.show_hide(pdsno, visible);
 
response.sendRedirect("./list_category_table2.jsp?categoryno=" + categoryno + "&category_title=" + category_title);

%>