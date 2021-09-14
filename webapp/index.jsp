<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function(){
	console.log(document.cookie);
})
</script>
</head>
<body>
<h3>미니홈피</h3>
<form action="main.home">
	id: <input name="memid" value="worldchoi"><button>login</button>
</form>
</body>
</html>