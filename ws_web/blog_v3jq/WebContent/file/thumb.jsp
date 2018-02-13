<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.File" %>
 
<%@ page import="nation.web.tool.Tool" %>
 
<% 
request.setCharacterEncoding("utf-8"); 
 
//DecimalFormat df = new DecimalFormat((char)65510 + " #,###,### " + (char)50896);
//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//String date = sdf.format(new Date());
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
String thumb = Tool.preview(upDir, "Paris_Musee_Orsay.jpg", 200, 150);
out.println("생성된 thumb 파일: "+thumb);
%>
 
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>