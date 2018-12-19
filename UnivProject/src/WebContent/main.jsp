<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@ page import="project.vpet.board.ReviewBoard" %>
<%@ page import="project.vpet.board.ReviewBoardDogDAO" %>
<%@ page import="project.vpet.board.ReviewBoardCatDAO" %>
<%@ page import="project.vpet.board.ReviewBoardOthersDAO" %>
<%@ page import="project.vpet.comment.DogCommentDAO" %>
<%@ page import="project.vpet.comment.CatCommentDAO" %>
<%@ page import="project.vpet.comment.OthersCommentDAO" %>
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
<title>Vpet</title>
</head>
<body>
<%
	
	PrintWriter script = response.getWriter();
	String userID = null;
	String keyword = "none";
	String admin = "admin";
	int pageNum = 1;
	DogCommentDAO dogCommentDAO = new DogCommentDAO();
	CatCommentDAO catCommentDAO = new CatCommentDAO();
	OthersCommentDAO othersCommentDAO = new OthersCommentDAO();
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	System.out.println("user ID: "+userID);
	
	
	if(request.getParameter("pageNumber")!= null)
		pageNum = Integer.parseInt(request.getParameter("pageNumber"));
	
	
	if(request.getParameter("keyword") != null) {
		keyword = request.getParameter("keyword");
	}
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
<!-- 게시판 요약 시작 -->
<div class="panel panel-default">
	<div class="panel-heading">후기 강아지
		<a id="DetailButton" class="btn btn-default" href="reviewBoard_Dog.jsp?pageNum=1&url=dog" role="button">More</a>
	</div>	
		<table class="table">
	<thead>
		<tr>
			<th>No</th>
			<th>Title</th>
			<th>Date</th>
			<th>View</th>
		</tr>
	</thead>
	<tbody>
		<%
			ReviewBoardDogDAO boardDAO = new ReviewBoardDogDAO();
			ArrayList<ReviewBoard> list = boardDAO.getList(1,keyword);
			
			if(list.size() < 5)
			{
				
				for(int i =0; i<list.size(); i++) {
					int j = list.get(i).getNum();
		%>
		
			<tr>
				<td><%=list.get(i).getNum() %></td>
				<td><a href="review_view.jsp?num=<%=list.get(i).getNum()%>&url=dog"> <%=list.get(i).getTitle() %>
																			(<%=dogCommentDAO.commentCount(j) %>)</a></td>
				<td> <%=list.get(i).getDate().substring(0, 10) %></td>
				<td><%=list.get(i).getView() %></td>
			</tr>
			
		<% 
				}
			} else {
				
				for(int i =0; i < 5; i++) {
					int j = list.get(i).getNum();
		%>
			<tr>
				<td><%=list.get(i).getNum() %></td>
				<td><a href="review_view.jsp?num=<%=list.get(i).getNum()%>&url=dog"> <%=list.get(i).getTitle() %>
																				(<%=dogCommentDAO.commentCount(j) %>)</a></td>
				<td> <%=list.get(i).getDate().substring(0, 10) %></td>
				<td><%=list.get(i).getView() %></td>
			</tr>
		<%
				}
				list.clear();
			}
		%>
		
	</tbody>
	
</table>
</div>
<!-- 게시판 요약 끝-->
<!-- 게시판 요약 시작 -->
<div class="panel panel-default">
	<div class="panel-heading">후기 고양이
		<a id="DetailButton" class="btn btn-default" href="reviewBoard_Cat.jsp?pageNum=1&url=cat" role="button">More</a>
	</div>	
	<table class="table">
	<thead>
		<tr>
			<th>No</th>
			<th>Title</th>
			<th>Date</th>
			<th>View</th>
		</tr>
	</thead>
	<tbody>
		<%
			ReviewBoardCatDAO boardCatDAO = new ReviewBoardCatDAO();
			list = boardCatDAO.getList(1,keyword);
			
			if(list.size() < 5)
			{
				
				for(int i =0; i<list.size(); i++) {
					int j = list.get(i).getNum();
		%>
		
			<tr>
				<td><%=list.get(i).getNum() %></td>
				<td><a href="review_view.jsp?num=<%=list.get(i).getNum()%>&url=cat"> <%=list.get(i).getTitle() %>
																				(<%=catCommentDAO.commentCount(j) %>)</a></td>
				<td> <%=list.get(i).getDate().substring(0, 10) %></td>
				<td><%=list.get(i).getView() %></td>
			</tr>
			
		<% 
				}
			} else {
				
				for(int i =0; i < 5; i++) {
					int j = list.get(i).getNum();
		%>
			<tr>
				<td><%=list.get(i).getNum() %></td>
				<td><a href="review_view.jsp?num=<%=list.get(i).getNum()%>&url=cat"> <%=list.get(i).getTitle() %>
																				(<%=catCommentDAO.commentCount(j) %>)</a></td>
				<td> <%=list.get(i).getDate().substring(0, 10) %></td>
				<td><%=list.get(i).getView() %></td>
			</tr>
		<%
				}
				list.clear();
			}
		%>
		
	</tbody>
</table>
</div>
<!-- 게시판 요약 끝-->
<!-- 게시판 요약 시작 -->
<div class="panel panel-default">
	<div class="panel-heading">후기 그 외
		<a id="DetailButton" class="btn btn-default" href="reviewBoard_Others.jsp?pageNum=1&url=others" role="button">More</a>
	</div>	
	<table class="table">
	<thead>
		<tr>
			<th>No</th>
			<th>Title</th>
			<th>Date</th>
			<th>View</th>
		</tr>
	</thead>
	<tbody>
		<%
			ReviewBoardOthersDAO boardOthersDAO = new ReviewBoardOthersDAO();
			list = boardOthersDAO.getList(1,keyword);			
			if(list.size() < 5)
			{
				
				for(int i =0; i<list.size(); i++) {
					int j = list.get(i).getNum();
		%>
		
			<tr>
				<td><%=list.get(i).getNum() %></td>
				<td><a href="review_view.jsp?num=<%=list.get(i).getNum()%>&url=others"> <%=list.get(i).getTitle() %>
																				(<%=othersCommentDAO.commentCount(j) %>)</a></td>
				<td> <%=list.get(i).getDate().substring(0, 10) %></td>
				<td><%=list.get(i).getView() %></td>
			</tr>
			
		<% 
				}
			} else {
				
				for(int i =0; i < 5; i++) {
					int j = list.get(i).getNum();
		%>
			<tr>
				<td><%=list.get(i).getNum() %></td>
				<td><a href="review_view.jsp?num=<%=list.get(i).getNum()%>&url=others"> <%=list.get(i).getTitle() %>
																				(<%=othersCommentDAO.commentCount(j) %>)</a></td>
				<td> <%=list.get(i).getDate().substring(0, 10) %></td>
				<td><%=list.get(i).getView() %></td>
			</tr>
		<%
				}
			}
		%>
		
	</tbody>
</table>
</div>
<!-- 게시판 요약 끝-->
<!-- 게시판 요약 시작 -->
<div class="panel panel-default">
	<div class="panel-heading">상담 게시판
		<a id="DetailButton" class="btn btn-default" href="counselBoard.jsp" role="button">More</a>
	</div>	
		<table class="table">
			<tr>
				<th> no </th>
				<th> title</th>
				<th>category</th>
				<th>date</th>
			</tr>
			<tr>
				<td>1</td>
				<td>상담좀</td>
				<td>강아지</td>
				<td>2018-12-01</td>
			</tr>
		</table>
</div>
<!-- 게시판 요약 끝-->
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
		<button type="button" class="btn btn-default"><a href="manage.jsp">관리</a></button>
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