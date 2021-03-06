<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script> -->

<script>

$(document).ready(function(){
	
	//$('#word').focus();
	
	if(${ map['cate1'] == null }){
		$('#cate1').attr('checked',false);
	}else{
		$('#cate1').attr('checked',true);
	}
	if(${ map['cate2'] == null }){
		$('#cate2').attr('checked',false);
	}else{
		$('#cate2').attr('checked',true);
	}
	if(${ map['cate3'] == null }){
		$('#cate3').attr('checked',false);
	}else{
		$('#cate3').attr('checked',true);
	}
	if(${ map['condition'] != null }){
		$('#condition').val("${ map['condition'] }");
	}
	
	$('#word').val("${ map['word'] }");
	
	
	var arr = $('input[name=length]');
	
	for(var i in arr){
		if(arr[i].value == "${ map['length'] }"){
			arr[i].setAttribute('checked','checked');
		}
	}
	
	
})


function detail(j){
	
	console.log(j)
	
	$('<form></form>').attr('action',"${pageContext.request.contextPath}/approval/myApvDetail").attr('method', 'POST').attr('id','detail').appendTo('#body');
	$('<input></input>').attr('type','hidden').attr('value',j).attr('name','approval_id').appendTo('#detail');
	$('<input></input>').attr('type','hidden').attr('value', ${ auth }).attr('name','auth').appendTo('#detail');
	$('#detail').submit();
	
}

function search(){
	
	var param = "";
	
	console.log($('input[name=length]:checked').val());
	param += "length="+$('input[name=length]:checked').val();
	$('<input></input>').attr('type','hidden').attr('name','length').attr('value',$('input[name=length]:checked').val()).appendTo('#goSearch')
	/* console.log($("input:checkbox[name='cate1']:checked").val());
	console.log($("input:checkbox[name='cate1']:checked").val());
	console.log($("input:checkbox[name='cate1']:checked").val()); */
	if($('#cate1').is(':checked')){
		console.log($('#cate1').val());
		param += "&cate1="+$('#cate1').val();
		$('<input></input>').attr('type','hidden').attr('name','cate1').attr('value',$('#cate1').val()).appendTo('#goSearch')
	}
	if($('#cate2').is(':checked')){
		console.log($('#cate2').val());
		param += "&cate2="+$('#cate2').val();
		$('<input></input>').attr('type','hidden').attr('name','cate2').attr('value',$('#cate2').val()).appendTo('#goSearch')
	}
	if($('#cate3').is(':checked')){
		console.log($('#cate3').val());
		param += "&cate3="+$('#cate3').val();
		$('<input></input>').attr('type','hidden').attr('name','cate3').attr('value',$('#cate3').val()).appendTo('#goSearch')
	}
	
	console.log($('#condition').val())
	param += "&condition="+$('#condition').val();
	$('<input></input>').attr('type','hidden').attr('name','condition').attr('value',$('#condition').val()).appendTo('#goSearch')

	console.log($('#word').val());
	 param += "&word="+$('#word').val();
	$('<input></input>').attr('type','hidden').attr('name','word').attr('value',$('#word').val()).appendTo('#goSearch')

	$('<input></input>').attr('type','hidden').attr('name','page').attr('value',1).appendTo('#goSearch')

	$('<input></input>').attr('type','hidden').attr('name','toSearch').attr('value','${ toSearch }').appendTo('#goSearch')
	
	
	
	$('#goSearch').submit();
	
	/*$.ajax({
        type: 'POST',
        url: "${pageContext.request.contextPath}/apvList/search",
        data: param,
        success: function(data) {
        	var json = JSON.parse(data);
			console.log(json);
            
            return;
        }
      }); */
	
}//search end

function resetSc(){
	$('<input></input>').attr('type','hidden').attr('name','length').attr('value', null).appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','cate1').attr('value',null).appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','cate2').attr('value',null).appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','cate3').attr('value',null).appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','condition').attr('value','writer').appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','word').attr('value',null).appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','page').attr('value',1).appendTo('#goSearch')
	$('<input></input>').attr('type','hidden').attr('name','toSearch').attr('value','${ toSearch }').appendTo('#goSearch')
	
	$('#goSearch').submit();
}//resetSc end

$(function(){
	  $('#word').keypress(function(e) {
	    if(e.which == 13) {
	      $(this).blur();
	      $('#search').focus().click();
	      $('#word').focus();
	    }
	  });
});

</script>

  <!-- 헤드 네비게이션 효과 -->
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body id="body">


	
	<div class="container-fluid">
    							<h2>결재함</h2>
    			
	<table class="table table-hover text-center">
<colgroup>
			<col width='8%' />
			<col width='*%' />
			<col width='15%' />
			<col width='15%' />
			<col width='10%' />
			<col width='10%' />
		</colgroup>
		<thead>
	<tr>
	<th>문서번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>제출일</th>
	<th>문서분류</th>
	<th>상태</th>
	
	</tr>
	</thead>
	
	<c:if test="${ pageInfo.totalCount != 0 }">
	<c:forEach var="item" items="${ apvList }" begin="${ pageInfo.startNum }" end="${ pageInfo.endNum }">
	
		<tr onclick="detail(${item.approval_id})" style="cursor: pointer;">
			<td>${ item.approval_id }</td>
			<td><a >${ item.approval_title }</a></td>
			<td>${ item.member_name } <c:choose><c:when test="${ not empty item.rank_name }">${ item.rank_name }</c:when><c:otherwise>입사대기</c:otherwise></c:choose></td>
			<td><fmt:formatDate value="${ item.approval_indate }"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${ item.apv_cate_name }</td>
			<c:choose>
			
				<c:when test="${ empty item.member_name3 || item.approval_auth3 == 3 || item.approval_auth3 == 4 }">
					<c:choose>
						<c:when test="${ empty item.member_name2 || item.approval_auth2 == 3 || item.approval_auth2 == 4}">
							<td>${ item.apv_auth_name1 }</td>
						</c:when>
						<c:when test="${ item.approval_auth2 == 0 && item.approval_auth1 == 0 }">
							<td>${ item.apv_auth_name1 }</td>
						</c:when>						
						<c:when test="${ item.approval_auth2 == 4 }">
							<td>${ item.apv_auth_name1 }</td>
						</c:when>
						<c:otherwise>
							<td>${ item.apv_auth_name2 }</td>
						</c:otherwise>
					</c:choose>
				</c:when>
				
				<c:when test="${ item.approval_auth2 == 0 }">
					<td>${ item.apv_auth_name1 }</td>
				</c:when>
				<c:when test="${ item.approval_auth2 == 3 && item.approval_auth1 == 0 }">
					<td>${ item.apv_auth_name1 }</td>
				</c:when>
				<c:otherwise>
					<td>${ item.apv_auth_name3 }</td>
				</c:otherwise>
			
			</c:choose>
			
			
		</tr>
	
	</c:forEach>
	</c:if>
	
	</table>
	</div>
	<div>
			
			<ul class="pagination justify-content-center">	
				<c:if test="${pageInfo.page != 1}">	
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=1"><i class="fas fa-angle-double-left"></i></a></li>					
				</c:if>
				<c:if test="${pageInfo.page >= 11}">	
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${pageInfo.page-1}"><i class="fas fa-angle-left"></i></a></li>			
				</c:if>
										
				<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					<c:if test="${i eq pageInfo.page }">
						<li class="page-item active"><a class="page-link" href="#">${i}</a></li>					
					</c:if>					
					<c:if test="${i != pageInfo.page }">					
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${i}">${i}</a></li>					
					</c:if>
				</c:forEach>
			
				<c:if test="${ pageInfo.endPage != pageInfo.totalPage }">					
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${pageInfo.endPage+1}"><i class="fas fa-angle-right"></i></a></li>
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${pageInfo.endPage+1}"><i class="fas fa-angle-double-right"></i></a></li>	
				</c:if>
				
			</ul> <!-- Paging end -->

<div align="center">
	<form id="goSearch" method="POST" action="${ pageContext.request.contextPath }/apvList/search"> </form>
		
		<input type="checkbox" id="cate1" value="1" > 일반결제문서
		<input type="checkbox" id="cate2" value="2" > 휴가결제문서 
		<input type="checkbox" id="cate3" value="3" > 지출결제문서 <br>
		<input type="radio" name="length" value="all" checked="checked"> 전체 
		<input type="radio" name="length" value="today" > 당일
		<input type="radio" name="length" value="week" > 1주일
		<input type="radio" name="length" value="month" > 1개월
		<input type="radio" name="length" value="three" > 3개월
		<input type="radio" name="length" value="half" > 6개월 <br>
		
		
		<div class="group" style="align:center;">
		<select class="btn btn-outline-primary dropdown-toggle" id="condition">
			<option value="title">제목</option>
			<option value="writer">제출자</option>
			<option value="apvNum">문서번호</option>
		</select>
		   
	<input class="btn btn-outline-primary" id="word" type="text" placeholder="검색어 입력" aria-label="Search" aria-describedby="basic-addon2">
	<button class="btn btn-outline-primary" id="search" onclick="search()"><i class="fas fa-search fa-sm"></i></button>
	<!-- <button onclick="resetSc()">검색 초기화</button> --> </div>
	
	
	</div>
	
	</div>

			
	


</body>
</html>