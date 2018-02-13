<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 화면 상단 메뉴 -->
<DIV style='text-align: left;'>
  <!--  Movie Blog ver 0.6<br>  -->
  <!-- /jsp_test/menu/images/... 절대경로  -->
  <!-- ./menu/... 상대경로  -->
  <% // System.out.println("root: "+ request.getContextPath()); %>
  
  <% 
  String root = request.getContextPath();
  %>
  <IMG src='<%=root %>/menu/images/poster1_it_big.jpg' style='width: 100%; height: 400px'> 
  <br>
  <nav>
    <A href='<%=root %>'>HOME</A>
    <A href='<%=root %>/notice1/list.jsp'>공지사항</A>
    <A href='<%=root %>/notice2/list.jsp'>공지사항2</A>
    <A href='<%=root %>/notice3/list.jsp'>공지사항3</A>
    <A href='<%=root %>/visitor4/list.jsp'>방명록4</A>
    <A href='<%=root %>/category4/list.jsp'>카테고리</A>
  </nav>
</DIV>