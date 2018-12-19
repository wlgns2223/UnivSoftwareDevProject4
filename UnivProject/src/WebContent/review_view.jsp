<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="project.vpet.board.ReviewBoard" %>
<%@ page import ="project.vpet.board.ReviewBoardDogDAO" %>
<%@ page import ="project.vpet.board.ReviewBoardCatDAO" %>
<%@ page import ="project.vpet.board.ReviewBoardOthersDAO" %>
<%@ page import ="project.vpet.comment.Comment" %>
<%@ page import ="project.vpet.comment.DogCommentDAO" %>
<%@ page import ="project.vpet.comment.OthersCommentDAO" %>
<%@ page import ="project.vpet.comment.CatCommentDAO" %>
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

	String userID = null;
	String url = null;
	String urlFromMain = null;
	String dog = "dog";
	String cat = "cat";
	String others = "others";
	ReviewBoard board = null;
	ArrayList<Comment> list = null;
	
	int num = 0;
	
	if(session.getAttribute("userID") != null)
		userID = (String)session.getAttribute("userID");
	
	if(request.getParameter("url") != null ){
		url = request.getParameter("url");
	}
			
	if(request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	
	System.out.println("url: "+url);
		
	
	if(num == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	
	if(url.equals(dog)) {
		board = new ReviewBoardDogDAO().getBoard(num);
		ReviewBoardDogDAO boardDAO = new ReviewBoardDogDAO();
		boardDAO.increaseView(board.getNum(), board.getView());
		list = new DogCommentDAO().getList(num);
		
		
	} else if(url.equals(cat)) {
		board = new ReviewBoardCatDAO().getBoard(num);
		ReviewBoardCatDAO boardDAO = new ReviewBoardCatDAO();
		boardDAO.increaseView(board.getNum(), board.getView());
		list = new CatCommentDAO().getList(num);
		
	} else if(url.equals(others)){
		board = new ReviewBoardOthersDAO().getBoard(num);
		ReviewBoardOthersDAO boardDAO = new ReviewBoardOthersDAO();
		boardDAO.increaseView(board.getNum(), board.getView());
		list = new OthersCommentDAO().getList(num);
		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 url입니다')");
		script.println("history.back()");
		script.println("</script>");		
	}
	
	
		
%>
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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="reviewBoard_Dog.jsp">후기 게시판</a></li>
				<li ><a href="CounselBoard.jsp">상담 게시판</a></li>
				<li><a href="infoBoard.jsp">동물병원정보</a></li>
			</ul>
		</div>
	</div>
</nav>
<!--네비게이션 바 끝-->
<!-- 글쓰기 페이지 시작 -->
<div class="container">
		<table class="table table-striped" style="text-align: center; border: 1px slid #dddddd">
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align: center;">글 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;">글 제목</td>
					<td colspan="2"><%=board.getTitle()%></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td colspan="2"><%=board.getDate().substring(0, 10)%></td>
				</tr>
				<tr>
					<td style="width: 20%;">글 내용</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%=board.getContent()%></td>
				</tr>
			</tbody>
		</table>
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
		<%
			if(userID != null && userID.equals(board.getUserID()) && userID.equals("admin")) {
		%>
			<a href="review_update.jsp?num=<%=num %>&url=<%=url %>" class="btn btn-primary">수정</a>
			<a href="reviewDeleteAction.jsp?num=<%=num %>&url=<%=url %>" class="btn btn-primary">삭제</a>
		<%
			}	 
		%>
		<!--댓글쓰기 칸 -->
		<form method="post" action="commentWriteAction.jsp?num=<%=num%>&url=<%=url%>">
			<div class="row">	
			    <div class="col-md-10">
				      <textarea  class="form-control" placeholder="comment" name="comment" rows="2" maxlength = 1000></textarea>
				</div>
				<div class="col-md-1">
					<button type="submit" class="btn btn-primary">댓글쓰기</button>
				</div>
			</div>	    
		</form>
		<!--댓글쓰기 칸 종료-->
		
		<!--댓글 목록 -->
		<div class="container">
			<table class="table table-striped table-bordered" style="text-align: center; border: 1px slid #dddddd">
			<%
			for(int i =0; i<list.size(); i++) 
			{
			%>
					<tr>
						<td ><%=list.get(i).getUserID() %></td>
						<td ><%=list.get(i).getComment() %></td>
						<td ><%=list.get(i).getDate().substring(0, 10) %></td>
					</tr>
			<%
				}
			%>
			</table>
		</div>
		<!--댓글 목록 종료-->
</div>
</div>
<!-- 글쓰기 끝 -->
</body>
</html>