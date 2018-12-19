<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="project.vpet.infoBoard.InfoBoard" %>
<%@ page import="project.vpet.infoBoard.InfoBoardDAO" %>
<jsp:useBean id="info" class="project.vpet.infoBoard.InfoBoard" scope="page"/>
<jsp:setProperty name="info" property="keyword" />
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
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

InfoBoardDAO boardDAO = new InfoBoardDAO();


if(info.getKeyword() == null) {
	info.setKeyword("none");
}

int pageNum = 1;
if(request.getParameter("pageNum")!= null) {
	pageNum = Integer.parseInt(request.getParameter("pageNum"));		
}

//페이지 네이션 시작
int countList = 5; // 한 페이지에 몇개의 글을 출력
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
System.out.println("keyword:"+info.getKeyword());
//페이지 네이션 끝
%>
<div class="container">
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
				<li><a href="main.jsp">메인</a></li>
				<li ><a href="reviewBoard_Dog.jsp">후기 게시판</a></li>
				<li><a href="counselBoard.jsp">상담 게시판</a></li>
				<li class="active" ><a href="infoBoard.jsp">동물병원정보</a></li>
			</ul>
		</div>
	</div>
</nav>
<!--네비게이션 바 끝-->
<!--검색 폼 시작-->
<div class="row">
	<div class="col-sm-6">
	<form mehtod = "GET" action = "infoBoard.jsp">
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
<!--테이블 시작-->
<table class="table">
	<thead>
		<tr>
			<th>Name</th>
			<th>Address</th>
			<th>Phone</th>
		</tr>
	</thead>
	<tbody>
		<%
			
			ArrayList<InfoBoard> list = boardDAO.getList(pageNum, info.getKeyword());
		
			for(int i =0; i<list.size(); i++) {
		%>
		<tr>
			<td><%=list.get(i).getName() %> </td>
			<td> <%=list.get(i).getAddress() %></td>
			<td><%=list.get(i).getPhone()%></td>
		</tr>
		
		<%
			}
		%>
	</tbody>
	
</table>

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
    
    <li><a class="active" href="infoBoard.jsp?pageNum=<%=i%>&url=info"> <%=i %><span class="sr-only"></span></a></li>
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