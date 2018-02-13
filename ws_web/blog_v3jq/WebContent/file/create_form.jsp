<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>파일 전송</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <form name='frm' action='./create_proc.jsp' method='POST' 
           enctype="multipart/form-data">
    <TABLE class='table_basic' style='width: 60%;'>
      <TR>
        <TH class='th_basic'>촬영 장소</TH>
        <TD class='td_basic'>
          <input type='text' name='title' value='성삼재 휴계소' style='width: 100%;'>
        </TD>
      </TR>
 
      <TR>
        <TH class='th_basic'>이미지 파일</TH>
        <TD class='td_basic'>
          <input type='file' name='file1' style='width: 100%;'>
        </TD>
      </TR>
    </TABLE>
    
    <DIV class='bottom_menu'>
      <button type='submit'>파일 업로드</button>
      <button type='button' onclick="history.back();">취소</button>
    </DIV>   
  </form>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>