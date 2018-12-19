<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.vpet.board.ReviewBoard" %>
<%@ page import="project.vpet.board.ReviewBoardDogDAO" %>
<%@ page import="project.vpet.board.ReviewBoardCatDAO" %>
<%@ page import="project.vpet.board.ReviewBoardOthersDAO" %>
<%@page import = "java.io.PrintWriter" %>
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

<title>Vpet</title>
</head>
<body>

<%
	
	
	String userID = null;
	String url = null;
	int num = 0;
	String dog = "dog";
	String cat = "cat";
	String others = "others";
	
	if(session.getAttribute("userID") != null){
		userID =(String)session.getAttribute("userID");
	}
	
	if(request.getParameter("url")!= null) {
		url = request.getParameter("url");
	}
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하시기 바랍니다')");
		script.println("location.href='logIn.jsp'");
		script.println("</script>");
	}
	if(request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	
	if(num == 0) {
		
		PrintWriter script = response.getWriter();
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
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시판 인스턴스 생성오류')");
		script.println("history.back()'");
		script.println("</script>");
		
	}
	
	if(!userID.equals(board.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()'");
		script.println("</script>");
	}
%>
<!-- 점보트론 -->
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
				<li><a href="#">메인</a></li>
				<li ><a href="#">후기 게시판</a></li>
				<li class="active" ><a href="#">상담 게시판</a></li>
				<li><a href="#">동물병원정보</a></li>
			</ul>
		</div>
	</div>
</nav>
<!--네비게이션 바 끝-->
<!-- 글쓰기 페이지 시작 -->
<div class="container">
	<form method="post" action="reviewUpdateAction.jsp?num=<%=num%>&url=<%=url%>">
		<table class="table table-striped" style="text-align: center; border: 1px slid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #eeeeee; text-align: center;">글 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50" value="<%=board.getTitle() %>"></td>
				</tr>
				<tr>
					<td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height: 350px;" ><%=board.getContent() %></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="btn btn-primary pull-right" value="수정">
		<%
			if(url.equals(dog)) {
		%>
			<a href="reviewBoard_Dog.jsp?pageNum=1&url=dog" class="btn btn-primary">목록</a>
		<%
			} else if(url.equals(cat)) {
		%>
			<a href="reviewBoard_Cat.jsp?pageNum=1&url=cat" class="btn btn-primary">목록</a>
		<%
			} else if(url.equals(others)) {
		%>
			<a href="reviewBoard_Others.jsp?pageNum=1&url=others" class="btn btn-primary">목록</a>
		<%
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('잘못된 url입니다')");
				script.println("history.back()");
				script.println("</script>");		
			}
		%>
	</form>
</div>
<!-- 글쓰기 끝 -->
</body>
</html>