<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>결재문서 작성</h2>
	<span>결재 문서</span>
	<span>
	
	<input type="radio" name="formList" value="" checked="checked"/>
	<input type="radio" name="formList" value=""/>
	<input type="radio" name="formList" value=""/>
	<input type="radio" name="formList" value=""/>
	
	</span>
	
	<span id="authMem" style="display: inline-block; border: 1px solid black; width: 100px; height: 100px"></span>
	<span id="authMem" style="display: inline-block; border: 1px solid black; width: 100px; height: 100px"></span>
	<span id="authMem" style="display: inline-block; border: 1px solid black; width: 100px; height: 100px"></span>
	<button onclick="selectMem()">결제자</button>


	<script type="text/javascript">
	
	function selectMem(){
		window.open('${pageContext.request.contextPath}/approval/pikAuthMem','결제자선택','width=800 , height=500 ,resizable = no, scrollbars = no');
	}
	
	</script>

</body>
</html>