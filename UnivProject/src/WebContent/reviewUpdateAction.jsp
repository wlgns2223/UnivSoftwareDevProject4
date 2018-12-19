<%@page import="project.vpet.board.ReviewBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "project.vpet.board.ReviewBoardDogDAO "%>
<%@page import = "project.vpet.board.ReviewBoardCatDAO "%>
<%@page import = "project.vpet.board.ReviewBoardOthersDAO "%>
<%@page import = "project.vpet.board.ReviewBoard"%>
<%@page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	System.out.println("review write enter");
	PrintWriter script = response.getWriter();
	String userID = null;
	String dog = "dog";
	String cat = "cat";
	String others = "others";
	int num = 0;
	String url = null;
	
	
	if(session.getAttribute("userID") != null) 
	{
		userID = (String)session.getAttribute("userID");
	}
	
	if(request.getParameter("num") != null) 
	{
		num = Integer.parseInt(request.getParameter("num"));
	}
	
	if(request.getParameter("url")!= null) {
		url = request.getParameter("url");
	}
	
	
	
	if(userID == null) 
	{	//로그인을 안 했을 경우
		script.println("<script>");
		script.println("alert('로그인을 하시기 바랍니다')");
		script.println("location.href='logIn.jsp'");
		script.println("</script>");
		
	} 
	
	if(num == 0) 
	{
		script.println("<script>");
		script.println("alert('유효하지 않은 글 번호입니다.')");
		script.println("history.back()'");
		script.println("</script>");
	}
	
	ReviewBoard board = null;
	if(url.equals(dog)) 
	{
		board = new ReviewBoardDogDAO().getBoard(num);		
	}
	else if(url.equals(cat))
	{
		board = new ReviewBoardCatDAO().getBoard(num);
	}
	else if(url.equals(others))
	{
		board = new ReviewBoardOthersDAO().getBoard(num);
	}
	else
	{
		script.println("<script>");
		script.println("alert('게시판 인스턴스 생성오류')");
		script.println("history.back()'");
		script.println("</script>");
		
	}
	
	if(!userID.equals(board.getUserID())) 
	{
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()'");
		script.println("</script>");
	}
	
	else 
	{
		if(request.getParameter("title") == null || request.getParameter("content") == null 
				|| request.getParameter("title").equals("") || request.getParameter("content").equals(""))
		{
			script.println("<script>");
			script.println("alert('입력이 안된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		}
		else {
			
			 if(url.equals(dog)) 
			 {
				 ReviewBoardDogDAO boardDAO = new ReviewBoardDogDAO();
				 int result = boardDAO.update(num, request.getParameter("title"), request.getParameter("content"));
				 if(result == -1 ) 
				 {
						script.println("<script>");
						script.println("alert('글 수정에 실패 했습니다.')");
						script.println("history.back()");
						script.println("</script>");
						 
				 } 
				 
				 else 
				 {
						script.println("<script>");
						script.println("location.href='reviewBoard_Dog.jsp'");
						script.println("</script>");
						 
				 }
				//고양이 게시판
			 } 
			 else if(url.equals(cat)) 
			 {
				 ReviewBoardCatDAO boardDAO = new ReviewBoardCatDAO();
				 int result = boardDAO.update(num, request.getParameter("title"), request.getParameter("content"));
				 if(result == -1 ) {
						script.println("<script>");
						script.println("alert('데이터 베이스 오류가 발생했습니다. 잠시 후 다시 시도해주세요')");
						script.println("history.back()");
						script.println("</script>");
						 
					 } else {
						script.println("<script>");
						script.println("location.href='reviewBoard_Cat.jsp'");
						script.println("</script>");
						 
					 }
				 //그외 게시판
			 } 
			 else if(url.equals(others))
			 {
				 ReviewBoardOthersDAO boardDAO = new ReviewBoardOthersDAO();
				 int result = boardDAO.update(num, request.getParameter("title"), request.getParameter("content"));
				 if(result == -1 ) {
						script.println("<script>");
						script.println("alert('데이터 베이스 오류가 발생했습니다. 잠시 후 다시 시도해주세요')");
						script.println("history.back()");
						script.println("</script>");
						 
					 } else {
						script.println("<script>");
						script.println("location.href='reviewBoard_Others.jsp'");
						script.println("</script>");
						 
					 }
			 } 
			 else 
			 {
				script.println("<script>");
				script.println("alert('session url 오류')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
				 
			 }
		 }
	}
%>
</body>
</html>