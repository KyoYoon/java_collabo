<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../admin4/auth.jsp" %>   
<%@ include file = "./ssi.jsp"  %>
 
<%

out.println("listFile:" + listFile);
out.println();
out.println("nowPage: " + nowPage);

int categoryno = Integer.parseInt(request.getParameter("categoryno"));
CategoryVO categoryVO = categoryProc.read(categoryno);
String category_title = categoryVO.getTitle();
 
int pdsno = Integer.parseInt(request.getParameter("pdsno"));
Pds4VO pds4VO = pds4Proc.read(pdsno); // 조회
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>  
 
<DIV class='aside_menu'>
  <ASIDE style='float: left;'><A href='../category4/list.jsp'>게시판</A>＞<A href='./list_category_grid1.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>'><%=category_title %></A>＞수정</ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list_category_grid1.jsp?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp'>펼쳐보기</A>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
<FORM name='frm' method='POST' action='./update_proc.jsp'>
  <input type='hidden' name='categoryno' value='<%=categoryno %>'>
  <input type='hidden' name='pdsno' value='<%=pdsno %>'>
  <input type='hidden' name='col' value='<%=col %>'>
  <input type='hidden' name='word' value='<%=word %>'>  
  <input type='hidden' name='nowPage' value='<%=nowPage %>'>
  <input type='hidden' name='recordPerPage' value='<%=recordPerPage %>'>
    
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label for='title'>제목: </label>
        <input class='input_basic' type='text' name='title' id='title' size='50' value='<%=pds4VO.getTitle() %>'>
      </li>
      <li class='li_none'>
        <label for='content'>내용: </label><br>
        <textarea name='content' id='content' rows='5' style='width: 100%;'><%=pds4VO.getContent() %></textarea>
      </li>  
      <li class='li_none'>
        <label for='web'>WEB URL: </label>
        <input class='input_basic'  type="text" name='web' id='web' size='50' value='<%=pds4VO.getWeb()%>'>
      </li>
      <li class='li_none'>
        <label for='rname'>성명: </label>
        <input class='input_basic'  type='text' name='rname' id='rname' value='왕눈이' size='10'>
 
        <label for='email'>이메일: </label>
        <input class='input_basic'  type='email' name='email' id='email' value='mail1@mail.com' size='25'>
 
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd' value='123' size='5'>
      
        <button type="submit">변경된 내용 저장</button>
        <button type="button" onclick="location.href='./<%=listFile %>?categoryno=<%=categoryno %>&category_title=<%=category_title %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>&listFile=<%=listFile %>'">수정 취소</button>
      </li>      
      <li class='li_none'>
        <HR class='hr_dotted'>
        <br>
        추가 컨텐츠 변경
        <HR class='hr_dotted'>
      </li>        
 
      <li class='li_center'>
       <label for='file1'>참고 파일: </label>
        
        <%
        boolean fileExists = false;
        ServletContext context = request.getSession().getServletContext();
        
        
        String realPath = context.getRealPath("/pds4/storage/"+pds4VO.getFstor1());
        fileExists = new File(realPath).exists();
        
        if (pds4VO.getSize1() > 0) { // 파일이 존재하는 경우
          if (Tool.isImage(pds4VO.getFstor1())) { // 이미지 일경우
          %>
            <IMG src='./storage/<%=pds4VO.getFstor1() %>' style='width: 200px;'>
          <%  
          } else { // 이미지가 아닐 경우
            out.println(pds4VO.getFile1());              
          }
        %>
          <A href="./replace_file1_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/update.png'></A>
          <A href="./delete_file1_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/delete.png'></A>   
        <%
        } else { // 파일이 없는 경우
        %>
          <A class='button' style='text-decoration: none; ' href='./create_file1_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>새로운 파일 등록</A>
        <%  
        }
        %>        
      </li>

      <li class='li_center'>
       
        
        <%
        //boolean fileExists = false;
        //ServletContext context = request.getSession().getServletContext();
        
        
        realPath = context.getRealPath("/pds4/storage/"+pds4VO.getMp3());
        //fileExists = new File(realPath).exists();
        
        if (pds4VO.getSize2() > 0) { // mp3 파일이 존재하는 경우
         
        %>
        
        <DIV style='width:620px; margin: 0px auto;'>
        <label for='mp3'>등록된 mp3 파일: <%=pds4VO.getMp3() %></label>
          <DIV style='width:570px; margin: 0px auto; float: left;'>
            
            <AUDIO controls autoplay="autoplay">
              <source src="./storage/<%=pds4VO.getMp3() %>" type="audio/mp3">
            </AUDIO>
            
          </DIV>
          <DIV style='width:50px; margin: 0px auto; float: left'>
              <A href="./replace_mp3_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/update.png' title="음악 변경"></A>
              <A href="./delete_mp3_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/delete.png' title="음악 삭제"></A>   
          </DIV>        
        </DIV>   
        <%
        } else { // 파일이 없는 경우
        %>
          <A class='button' style='text-decoration: none; ' href='./create_mp3_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>새로운 mp3 파일 등록</A>
        <%  
        }
        %>        
      </li>

      <li class='li_center'>
       
        
        <%
        //boolean fileExists = false;
        //ServletContext context = request.getSession().getServletContext();
        
        
        realPath = context.getRealPath("/pds4/storage/"+pds4VO.getMp4());
        //fileExists = new File(realPath).exists();
        
        if (pds4VO.getSize3() > 0) { // mp4 파일이 존재하는 경우
        %>
        
        
        <DIV style='width:620px; margin: 0px auto;'>
        <label for='mp4'>등록된 mp4 파일: <%=pds4VO.getMp4() %></label>
          <DIV style='width:570px; margin: 0px auto; float: left;'>
            
            <VIDEO controls src='./storage/<%=pds4VO.getMp4() %>' style='width: 80%;'></VIDEO>
            
          </DIV>
          <DIV style='width:50px; margin: 0px auto; float: left'>
              <A href="./replace_mp4_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/update.png' title="음악 변경"></A>
              <A href="./delete_mp4_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/delete.png' title="음악 삭제"></A>   
          </DIV>        
        </DIV>   
        <%
        } else { // 파일이 없는 경우
        %>
          <A class='button' style='text-decoration: none; ' href='./create_mp4_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>새로운 mp4 파일 등록</A>
        <%  
        }
        %>        
      </li>
      
      <li class='li_center'>
       <HR class='hr_dotted'>
        
        <%
        // -------------------------- Youtube -------------------------- 
        String youtube = pds4VO.getYoutube();
        if (youtube == null) { // checkNull 메소드로 변경 예정
          youtube = "";
        }
        if (youtube.trim().length() > 0) { // Youtube 가 있는 경우만 출력
        %>
        <DIV style='width:900px; margin: 0px auto;'>
          <DIV style='width:854px;'>
            <%=pds4VO.getYoutube() %> 
          </DIV>
          <DIV style='margin: 0px auto;'>
            <A href="./replace_youtube_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/update.png' title="지도 변경"></A>
            <A href="./delete_youtube_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/delete.png' title="지도 삭제"></A>   
          </DIV>
        </DIV>
        
        <%
        } else {
        %>
          <A class='button' style='text-decoration: none; ' href='./create_youtube_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>새로운 Youtube 영상 등록</A>
        <%  
        }
        %>
              
      </li>
      
      <li class="li_center"> 
        <HR class='hr_dotted'>
                    
        <%
        // -------------------------- Map -------------------------- 
        String map = Tool.checkNull(pds4VO.getMap()); // null 인 경우 ""를 리턴 
        
        if (map.trim().length() > 0) { // 지도가 있는 경우만 출력
        %>
        <DIV style='width:570px; margin: 0px auto;'>
          <DIV style='width:520px; float: left'>
            <%=pds4VO.getMap() %> 
          </DIV>
          <DIV style='width:50px; margin: 0px auto; float: left'> <!-- 아래 두 개의 버튼들이 위로 가서 붙음 -->
            <A href="./replace_map_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/update.png' title="지도 변경"></A>
            <A href="./delete_map_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>"><IMG src='./images/delete.png' title="지도 삭제"></A>   
          </DIV>
        </DIV>
        
        <%
        } else {
        %>
          <A class='button' style='text-decoration: none; ' href='./create_map_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>새로운 지도 등록</A>
        <%  
        }
        %>        
        
      </li>    
    </ul>
  </fieldset>
 
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 