<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="org.apache.commons.fileupload.FileItem" %>
 
<%@ page import="nation.web.tool.Upload" %>
<%@ page import="nation.web.tool.Tool" %> 
 
<% 
request.setCharacterEncoding("utf-8"); 
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
 
<DIV style='text-align: center; margin: 20px auto;'>
<%
// System.out.println("title: " + request.getParameter("title"));
 
// 파일 업로드 관련 코드 시작
String tempDir = application.getRealPath("/file/temp"); // WebContent 기준
// out.println("tempDir: " + tempDir + "<br>");
String upDir = application.getRealPath("/file/storage");
// out.println("upDir: " + upDir + "<br>");
 
// request: 내부 객체
// -1: 메모리에 저장할 최대 크기, Byte, 무제한 사용
// -1: 업로드할 최대 파일 크기, Byte, 무제한 사용
// tempDir: 파일 업로드중에 임시로 저장할 폴더
Upload upload = new Upload(request, -1, -1, tempDir);
 
String title = upload.toKor(upload.getParameter("title"));
// System.out.println("title: " + upload.toKor(title));
 
// <input type='file' name='file1' style='width: 100%;'>
FileItem fileItem = upload.getFileItem("file1");
// System.out.println("fileItem: " + fileItem);
long filesize = fileItem.getSize();
System.out.println("filesize: " + filesize);
String filename = "";
%>
촬영지: <%=title %><br>
<%
if (filesize > 0) {
  if (filesize < 10485760) { // 1 ~ 10485760 byte
    filename = upload.saveFile(fileItem, upDir); // Tomcat이 전송받은 파일을 서버에 저장
%>
    파일명: <%=filename %> / 파일 사이즈: <%=Tool.unit(filesize) %><br>
    <IMG src='./storage/<%=filename%>'>
<%
  } else {
%>
    전송 파일의 크기는 10 MB를 넘을 수 없습니다. 다시 시도해주세요.
<%    
  }
} else {
%>
  전송하려는 파일이 없습니다. 글만 등록합니다.
<%  
}
%>
 
  <br><br>
  <button type='button' onclick="location.href='./create_form.jsp'">계속 등록</button>
  <button type='button' onclick="location.href='./file_list.jsp'">파일 목록</button>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>