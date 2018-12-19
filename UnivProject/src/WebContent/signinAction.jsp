<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="project.vpet.user.UserDAO" %>
<%@page import="project.vpet.user.User" %>
<%@page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="project.vpet.user.User"/>
<jsp:setProperty name="user" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

 <%
	 PrintWriter script = response.getWriter();
	 String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID != null) { // 이미 로그인 한 경우
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
			
		}
	 
	 UserDAO userDao = new UserDAO();
	 int result = userDao.signin(user.getUserID(), user.getUserPassword(), user.getUserName(), user.getUserEmail());
	 
	 if(result == 1) {
		session.setAttribute("userID",user.getUserID());
		pageContext.forward("main.jsp");
	 } else {
		 script.println("<script>");
		 script.println("alert('이미 존재하는 아이디 입니다')");
		 script.println("history.back()");
		 script.println("</script>");
	 }
 %>
 
</body>
</html>