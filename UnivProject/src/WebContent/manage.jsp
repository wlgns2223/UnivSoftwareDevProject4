<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@ page import="project.vpet.board.ReviewBoard" %>
<%@ page import="project.vpet.board.ReviewBoardDogDAO" %>
<%@ page import="project.vpet.board.ReviewBoardCatDAO" %>
<%@ page import="project.vpet.board.ReviewBoardOthersDAO" %>
<%@ page import="project.vpet.comment.DogCommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, inital-scale=1, shrink-to-fit=no">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">

<style type="text/css">
.stylish-input-group .input-group-addon{
    background: white !important; 
}
.stylish-input-group .form-control{
	border-right:0; 
	box-shadow:0 0 0; 
	border-color:#ccc;
}
.stylish-input-group button{
    border:0;
    background:transparent;
}

</style>
<title>Insert title here</title>
</head>
<body>
<%
	
	PrintWriter script = response.getWriter();
	String userID = null;
	DogCommentDAO dogCommentDAO = new DogCommentDAO();
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	System.out.println("user ID: "+userID);
	
	int pageNum = 1;
	if(request.getParameter("pageNumber")!= null)
		pageNum = Integer.parseInt(request.getParameter("pageNumber"));
	String admin = "admin";
%>

<!-- 메인 상단 -->
<!-- 점보트론 -->
<div class="container">
	<div class="jumbotron">
		<h1>Vpet</h1>
	</div>

<!-- 점보트론 끝 -->
<!--네비게이션 바 -->
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="navbar_header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false"
						aria-controls="navbar">
					<span class="sr-only">toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active" ><a href="main.jsp">메인</a></li>
					<li><a href="reviewBoard_Dog.jsp?pageNum=1&url=dog">후기 게시판</a></li>
					<li><a href="counselBoard.jsp">상담 게시판</a></li>
					<li><a href="infoBoard.jsp">동물병원정보</a></li>
				</ul>
			</div>
		</div>
	</nav>
<!--네비게이션 바 끝-->
<!-- 메인 상단 끝 -->
<!-- 관리자 메뉴 -->
<div class="container">
	<div class="jumbotron">
		<h1>관리자 페이지</h1>
	</div>
</div>
<!-- 관리자 메뉴끝 -->
<!--로그인 및 회원가입 -->
<%
	if(userID == null) {

%>
	<div class="container">
		<button type="button" class="btn btn-default"><a href="signIn.jsp">회원가입</a></button>
		<button type="button" class="btn btn-default"><a href="logIn.jsp">로그인</a></button>
	</div>

<%
	} else {
		
		
%>
	<div class="container">
		<button type="button" class="btn btn-default"><a href="logOutAction.jsp">로그아웃</a></button>
	<%
		if(userID.equals(admin)) 
		{
	%>
		<button type="button" class="btn btn-default"><a href="#">관리</a></button>
	<%
		}
	%>
	</div>
<%
	}
%>
</div>
</body>
</html>