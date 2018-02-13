<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
 
<%@ page import="nation.web.tool.Tool" %>
<%@ page import="nation.web.tool.Log" %> 
 
<%@ page import="nation.web.admin4.AdminProc" %>
<%@ page import="nation.web.admin4.AdminDAO" %>
<%@ page import="nation.web.admin4.Admin4VO" %>

<%@ page import="javax.mail.*" %> 
<%@ page import="java.util.Properties" %>  
<%@ page import=" javax.mail.internet.MimeMessage" %>  
<%@ page import=" javax.mail.internet.InternetAddress" %>  

 
<% 
String root = request.getContextPath();
request.setCharacterEncoding("utf-8"); 
 
DecimalFormat df = new DecimalFormat((char)65510 + " #,###,### " + (char)50896);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String date = sdf.format(new Date());
%>
 
<%
AdminProc adminProc = new AdminProc();
%>