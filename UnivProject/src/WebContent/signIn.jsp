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

.container {
padding-right : 10px;
padding-left : 10px;

}

</style>

<title>Vpet</title>
</head>
<body>
	<div class="container">
		<form  method="post" action= "signinAction.jsp" >
		    <label for="id" class="col-sm-2 control-label">ID</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="userID" placeholder="ID">
		    </div>
		    <label for="password" class="col-sm-2 control-label">Password</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" name="userPassword" placeholder="Password">
		    </div>
		    <label for="CheckPassword" class="col-sm-2 control-label">Password Again</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" name="CheckPassword" placeholder="Password Again">
		    </div>
		    
		    <label for="id" class="col-sm-2 control-label">Name</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="userName" placeholder="Name">
		    </div>
		    <label for="id" class="col-sm-2 control-label">Email</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="userEmail" placeholder="E-Mail">
		    </div>
		    
		    <div class="col-sm-offset-2 col-sm-10">
		      <input type="submit" class="btn btn-primary form-control" value="회원가입">
		    </div>
		</form>
	</div>
</body>
</html>