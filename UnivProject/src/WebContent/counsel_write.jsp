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


</style>

<title>Insert title here</title>
</head>
<body>
<!-- 점보트론 -->
<div class="jumbotron">
<h1>Hello world</h1>

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
				<li class="active" ><a href="counsel.jsp">상담 게시판</a></li>
				<li><a href="infoBoard.jsp">동물병원정보</a></li>
			</ul>
		</div>
	</div>
</nav>
<!--네비게이션 바 끝-->
<!-- 글쓰기 페이지 시작 -->
<div class="container">
	<form method="post" action="BoardAction.jsp">
		<label class="col-sm-2 control-label">Title</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="title" placeholder="title">
		    </div>
		    
		    <label  class="col-sm-2 control-label">Content</label>
		    <div class="col-sm-10">
		      <textarea class="form-control" name="content" rows="7" cols=""></textarea>
		    </div>
		    
		    <button type="submit" class="btn btn-primary form-control">글쓰기</button>
	</form>
</div>
<!-- 글쓰기 끝 -->
</body>
</html>