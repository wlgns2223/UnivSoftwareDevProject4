<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<title>Insert title here</title>
</head>
<body>


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
				<li class="active" ><a href="counselBoard.jsp">상담 게시판</a></li>
				<li><a href="infoBoard.jsp">동물병원정보</a></li>
			</ul>
		</div>
	</div>
</nav>
<!--네비게이션 바 끝-->
<!-- 글쓰기 버튼 -->
<button id ="WriteButton" class="btn  btn-primary" type="button" onclick="location.href='counsel_write.jsp'">글쓰기</button>
<!-- 글쓰기 버튼 끝-->
<!--테이블 시작-->
<table class="table">
	<tr>
		<th>No</th>
		<th class="dropdown-menu">Category</th>
		<th>Title</th>
		<th>Date</th>
	</tr>
	<tr>
		<td>1</td>
		<td>강아지</td>
		<td>상담좀요~</td>
		<td>2018-11-11</td>
	</tr>
</table>
<!--테이블 끝-->
<!--검색 폼 시작-->
<div class="row">
	<div class="col-lg-6">
    	<div class="input-group">
      	<input type="text" class="form-control" placeholder="Search for...">
      		<span class="input-group-btn">
        	<button class="btn btn-default" type="button">검색</button>
      	</span>
    </div><!-- /input-group -->
  </div><!-- /.col-lg-6 -->
</div><!-- /.row -->
 <!--검색 폼 끝-->
<!--페이지 시작-->
<nav>
  <ul class="pagination">
    <li class="disabled">
      <a href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    
    <li class="active"><a href="#">1<span class="sr-only">(current)</span></a></li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>
    
    <li class="disabled">
      <a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
</div>
<!--페이지 끝-->

</body>
</html>