<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.File" %>
 
<%@ page import="nation.web.tool.Tool" %>
 
<% 
request.setCharacterEncoding("utf-8"); 
 
DecimalFormat df = new DecimalFormat((char)65510 + " #,###,### " + (char)50896);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String date = sdf.format(new Date());
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
<DIV style='width: 40%; margin: 20px auto;'>
  <DIV style='text-align: center; margin-bottom: 30px;'>
    <button type = 'button' onclick="location.href='./create_form.jsp'">파일 등록</button>
  </DIV>
  
<%
String upDir = application.getRealPath("/file/storage"); // WebContent
File dir = new File(upDir);
 
File[] files = dir.listFiles(); // 파일 목록 추출
for (int index=0; index < files.length; index++) {
  File file = files[index]; // 배열에서 하나의 File 객체 추출
  // System.out.println(file.getName() + "(" + tool.unit(file.length()) + " )");
  
  String unit = Tool.unit(file.length());
  String filename = file.getName();
%>
  <A href='./storage/<%=filename%>'><IMG src='./storage/<%=filename%>' style='width: 120px; height: 80px;'></A>
  <A href='<%=request.getContextPath()%>/download?dir=/file/storage&filename=<%=filename %>'><%=filename %>(<%=unit %>)</A><br>
<%
}
%>
 
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>