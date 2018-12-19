<%@page import="project.vpet.board.ReviewBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "project.vpet.board.ReviewBoardDogDAO "%>
<%@page import = "project.vpet.board.ReviewBoardCatDAO "%>
<%@page import = "project.vpet.board.ReviewBoardOthersDAO "%>
<%@page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="board" class="project.vpet.board.ReviewBoard" scope="page"/>
<jsp:setProperty name="board" property="title" />
<jsp:setProperty name="board" property="content" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userID = null;
	String url = null;
	PrintWriter script = response.getWriter();
	
	if(session.getAttribute("userID") != null)
		userID = (String)session.getAttribute("userID");
	
	if(request.getParameter("url") != null ) {
		url = request.getParameter("url");
	}
	
	
	String dog = "dog";
	String cat = "cat";
	String others = "others";
	
	
	if(userID == null) {	
		script.println("<script>");
		script.println("alert('로그인을 하시기 바랍니다')");
		script.println("location.href='logIn.jsp'");
		script.println("</script>");
		//로그인을 안했을 경우
	} else {
		//로그인을 했을 경우
		 if(board.getTitle() == null || board.getContent() == null) {
			script.println("<script>");
			script.println("alert('입력을 완료하여 주세요')");
			script.println("history.back()");
			script.println("</script>");
			//로그인은 했는데 입력을 완료 안한경우
			 
		 } else {
			 //입력을 다 한 경우
			 //개 게시판
			 if(url.equals(dog)) {
				 ReviewBoardDogDAO boardDAO = new ReviewBoardDogDAO();
				 int result = boardDAO.write(board.getTitle(), board.getContent(), userID);
				 if(result == -1 ) {
						script.println("<script>");
						script.println("alert('데이터 베이스 오류가 발생했습니다. 잠시 후 다시 시도해주세요')");
						script.println("history.back()");
						script.println("</script>");
						 
					 } else {
						script.println("<script>");
						script.println("location.href='reviewBoard_Dog.jsp?pageNum=1&url=dog'");
						script.println("</script>");
						 
					 }
				//고양이 게시판
			 } else if(url.equals(cat)) {
				 ReviewBoardCatDAO boardDAO = new ReviewBoardCatDAO();
				 int result = boardDAO.write(board.getTitle(), board.getContent(), userID);
				 if(result == -1 ) {
						script.println("<script>");
						script.println("alert('데이터 베이스 오류가 발생했습니다. 잠시 후 다시 시도해주세요')");
						script.println("history.back()");
						script.println("</script>");
						 
					 } else {
						script.println("<script>");
						script.println("location.href='reviewBoard_Cat.jsp?pageNum=1&url=cat'");
						script.println("</script>");
						 
					 }
				 //그외 게시판
			 } else if(url.equals(others)){
				 ReviewBoardOthersDAO boardDAO = new ReviewBoardOthersDAO();
				 int result = boardDAO.write(board.getTitle(), board.getContent(), userID);
				 if(result == -1 ) {
						script.println("<script>");
						script.println("alert('데이터 베이스 오류가 발생했습니다. 잠시 후 다시 시도해주세요')");
						script.println("history.back()");
						script.println("</script>");
						 
					 } else {
						script.println("<script>");
						script.println("location.href='reviewBoard_Others.jsp?pageNum=1&url=others'");
						script.println("</script>");
						 
					 }
			 } else {
				script.println("<script>");
				script.println("alert('session url 오류')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
				 
			 }
 
			 //ReviewBoardDogDAO boardDAO = new ReviewBoardDogDAO();
			 //int result = boardDAO.write(board.getTitle(), board.getContent(), userID);
			 
			 
		 }
	}
%>
</body>
</html>