<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="project.vpet.board.ReviewBoard" %>
<%@ page import="project.vpet.board.ReviewBoardCatDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="project.vpet.comment.CatCommentDAO" %>
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

.pagination {
display: block;
text-align: center;
}

.pagination > li > a{
	float: none;
}

#WriteButton {
	float: right;
	
}
</style>

<title>Vpet</title>
</head>
<body>
<%
	String userID = null;
	String url = null;
	String keyword = "none";
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	int pageNum = 1;
	if(request.getParameter("pageNum")!= null) {
		pageNum = Integer.parseInt(request.getParameter("pageNum"));		
	}
	
	if(request.getParameter("url") != null) {
		url = request.getParameter("url");
	}
	
	if(request.getParameter("keyword") != null) {
		keyword = request.getParameter("keyword");
	}
		
	CatCommentDAO catCommentDAO = new CatCommentDAO();
	ReviewBoardCatDAO boardDAO = new ReviewBoardCatDAO();
	//페이지 네이션 시작
	int countList = 10; // 한 페이지에 몇개의 글을 출력
	int countPage = 10; // 한번에 최대 몇 페이지
	int totalCount = boardDAO.totalCount(); // DB에 있는 총 글의 수
	int totalPage = totalCount / countList; // 출력 할 페이지의 수
		
	if(totalCount % countList > 0) {
		totalPage++;
	}
		
	if(totalPage<pageNum) {
		pageNum = totalPage;
	}
		
	int startPage = ((pageNum - 1) / 10) * 10 +1; // 시작페이지
	int endPage = startPage +countPage -1;		  // 끝 페이지	
	if(endPage > totalPage) {					  // 끝 페이지 보정
		endPage = totalPage;
	}
		
	System.out.println("start:"+startPage);
	System.out.println("page:"+pageNum);
	System.out.println("end:"+endPage);
	//페이지 네이션 끝


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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="reviewBoard_Dog.jsp?pageNum=1&url=dog">후기 게시판</a></li>
				<li><a href="counselBoard.jsp">상담 게시판</a></li>
				<li><a href="infoBoard.jsp">동물병원정보</a></li>
			</ul>
		</div>
	</div>
</nav>
<!--네비게이션 바 끝-->
<!-- 메인 상단 끝 -->
<!--게시판 탭 -->
<ul class="nav nav-tabs">
	<li role = "presentation" ><a href="reviewBoard_Dog.jsp?pageNum=1&url=dog">강아지</a></li>
	<li role = "presentation" class ="active" ><a href="reviewBoard_Cat.jsp?pageNum=1&url=cat">고양이</a></li>
	<li role = "presentation" ><a href="reviewBoard_Others.jsp?pageNum=1&url=others">그 외</a></li>
	<!-- 글쓰기 버튼 -->
	<li id="WriteButton"> <button class="btn btn-primary " role ="button" onclick="location.href='review_write.jsp?url=cat'">글쓰기</button></li>
	<!-- 글쓰기 버튼 끝 -->
</ul>
<!-- 게시판 탭 끝 -->

<!--테이블 시작-->
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
		ArrayList<ReviewBoard> list = boardDAO.getList(pageNum, keyword);
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
		%>
		
	</tbody>
	
</table>
<!--테이블 끝-->
<!--검색 폼 시작-->
<div class="row">
	<div class="col-lg-6">
	<form method="GET" action="reviewBoard_Cat.jsp?pageNum=1&url=dog" >
    	<div class="input-group">
      	<input type="text" class="form-control" placeholder="Search for..." name = "keyword">
      		<span class="input-group-btn">
        	<button class="btn btn-default" type="submit">검색</button>
      	</span>
    </div><!-- /input-group -->
    </form>
  </div><!-- /.col-lg-6 -->
</div><!-- /.row -->
 <!--검색 폼 끝-->
<!--페이지 시작-->
<nav>
  <ul class="pagination">
    <li class="abled">
      <a href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <%
    	for(int i = startPage; i <= endPage; i++) {
    %>
    
    <li><a class="active" href="reviewBoard_Cat.jsp?pageNum=<%=i%>&url=cat"> <%=i %><span class="sr-only"></span></a></li>
    <%
    	}
    %>
    
    <li class="abled">
      <a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>

<!--페이지 끝-->
</div>
</body>
</html>