<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

.aa {
width:100px;
}
.tt{
height: 60px;
}

</style>

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
	
	<table border="1" style="display: inline-block">
	
	<tr>
	<td class="tt" rowspan='2'>결재</td>
	<td class="aa">${ sessionScope.member.member_rank }</td>
	<td id="authRank1" class="aa"></td>
	<td id="authRank2" class="aa"></td>
	<td id="authRank3" class="aa"></td>
	</tr>
	
	<tr>
	
	<td>${ sessionScope.member.member_name }</td>
	<td id="authName1"></td>
	<td id="authName2"></td>
	<td id="authName3"></td>
	
	</tr>
	
	</table>
	
	<input type="hidden" id="authDept1">
	<input type="hidden" id="authDept2">
	<input type="hidden" id="authDept3">

	<input type="hidden" id="authId1">
	<input type="hidden" id="authId2">
	<input type="hidden" id="authId3">
	
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