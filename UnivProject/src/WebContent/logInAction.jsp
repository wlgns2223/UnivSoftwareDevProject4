<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "project.vpet.user.UserDAO "%>
<%@page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="user" class="project.vpet.user.User" scope="page"/>
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


	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	
	if(result == 1) { // 로그인 성공
		session.setAttribute("userID",user.getUserID()); // 세션에 유저 아이디
		pageContext.forward("main.jsp");
		
	} else if(result == 0 ) {
		
		script.println("<script>");
		script.println("alert('틀린 비밀번호입니다')");
		script.println("history.back()");
		script.println("</script>");
	} else if(result == -1 ) {
		
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		
		script.println("<script>");
		script.println("alert('데이터베이스 오류')");
		script.println("history.back()");
		script.println("</script>");		
	}



%>
</body>
</html>