<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>KITWARE-BETA</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  
  <style>
 .timecheck{
  margin-top: 5px;
  }
  .map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:130px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}       
.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
.custom_typecontrol .selected_btn:hover {color:#fff;}   
.custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5;} 
.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}     
.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}             
.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;} 
     
</style>
  
 <script type="text/javascript">
 /* 출석용 시계 */
setInterval('time()', 1000);

function time() {
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/commuting/current_time",
		success:function(data){
			var obj = eval('('+data+')');			
			$("#current_time").html(obj.value);				
		}
	});
}
/* 미결재문서 알림숫자 */
$.ajax({
	type:'POST',
	url: '${ pageContext.request.contextPath }/approval/notAuthApvCount',
	success: function(data){
		//console.log(data);
		$('#apvCount4').text(data);
	}
});
/* 근태관련 */
$(function(){
	$(".board").hover(function(){
		$(this).css("background", "#dddddd");	
	},function(){
		$(this).css("background", "#fdfdfd");
		$(".board:first").css("background", "#dddddd");
	});
	
	$("#allcheck").click(function(){
	    //클릭되었으면
	    if($("#allcheck").prop("checked")){
	        //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	        $("input[name=checkedReply]").prop("checked",true);
	        //클릭이 안되있으면
	    }else{
	        //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
	        $("input[name=checkedReply]").prop("checked",false);
	    }
	});
	
	$("#frm").submit(function(){
		if(!$("input[name=checkedReply]").is(":checked")){
			alert("삭제할 댓글을 선택해 주세요");
			return false;
		}
		return true;
	});
});
$.ajax({
	type:'POST',
	url: '${pageContext.request.contextPath}/mainBoard',
	success: function(data){
		var arr = eval('('+data+')');
		var length = arr.length < 5 ? arr.length : 5;
		str = '<table class="table table-hover text-center">';
		for(i = 0; i < length; i++){
			str += '<tr>';
			str += '<td class="text-left" style="max-width: 100px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">';
			str +=	'<a href="${pageContext.request.contextPath}/boardRead?brdno='+arr[i].brdno+'&brddate='+arr[i].brddate+'&brdhit='+arr[i].brdhit+'">' + arr[i].title + '</a></td>';
			str += '<td width="65px;">' + arr[i].brddate.slice(5) + '</td>';
			str += '</tr>';
		}
		str += "</table>";	
		$('#manin_board').html(str);
	}
});


$(document).ready(function(){
	
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/commuting/getNowStatus",
		success:function(data){
			try{
				var obj = JSON.parse(data);		
			}catch(Exception){
				return;
			}
			
			if(obj.commuting_arrive != null){
				$('#arrTime').val('arrive');
				$('#arrTime').empty();
				$('#arrTime').css('color','yellow').css('font-size','20px').text(obj.commuting_arrive);
			}
			if(obj.commuting_leave != null){
				$('#leavTime').empty();
				$('#leavTime').css('color','DarkBlue').css('font-size','20px').text(obj.commuting_leave);
			}
			
			return;
		}// success end
	});// ajax end
	
	$("#arrive").click(function(){
		$.ajax({
			type:"POST",
			async: false,
			url:"${pageContext.request.contextPath}/commuting/arrive",
			success:function(data){
				//console.log(data);
				try{
					var obj = JSON.parse(data);		
				}catch(Exception){
					alert(data);
					return;
				}
				
				$('#arrTime').val('arrive');
				$('#arrTime').empty();
				$('#arrTime').css('color','yellow').css('font-size','20px').text(obj.commuting_arrive);
				alert('${sessionScope.member.member_name}님 '+obj.commuting_arrive+' 출근처리 되었습니다.');
				
				return;
				
			}
		});
	});	//arrive end
	
$("#leave").click(function(){
		
		if($('#arrTime').val() != 'arrive'){
			alert('출근처리 먼저 해주세요.');
			return;
		}
		if(confirm('정말 퇴근처리 하시겠습니까?')){
		
	 		$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/commuting/leave",
				success:function(data){
					//console.log(data);
					try{
						var obj = JSON.parse(data);		
					}catch(Exception){
						alert(data);
						return;
					}
					
					alert('${sessionScope.member.member_name}님 '+obj.commuting_leave+' 퇴근처리 되었습니다.');
					$('#leavTime').empty();
					$('#leavTime').css('color','DarkBlue').css('font-size','20px').text(obj.commuting_leave);
					
				}
			});//ajax end 
	 		
		}
	}); // leave end
	
})//ready end
</script>

<script type="text/javascript">
$(document).ready(function(){	
	var param = "year=${ year }";
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/commuting/allView",
		data:param,
		success:function(data){
			var arr = JSON.parse(data);
			//console.log(arr);

			google.charts.load("current", {packages:["calendar"]});
			google.charts.setOnLoadCallback(drawChart);
			
			function drawChart() {
			 var dataTable = new google.visualization.DataTable();
			 dataTable.addColumn({ type: 'date', id: 'Date' });
			 dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
			 //dataTable.addColumn({ type: 'string', role:'tooltip' });

			for(var i = 0; i < arr.length; i++){			
				
				//console.log(arr[i].commuting_status);
				var num = parseInt(arr[i].commuting_status_date.substring(0,2));
				var status = 0;
				try{
					var arrive = new Date("2019-02-01 "+arr[i].commuting_arrive.slice(2));
					var leave = new Date("2019-02-01 "+arr[i].commuting_leave.slice(2));
					var ontime = new Date("2019-02-01 09:00:00");
					
					var gap1 = arrive.getTime() - ontime.getTime();
					var gap2 = leave.getTime() - arrive.getTime();
					if (gap1 > 0){
						status = Math.floor(0-gap1/1000/60/60);
					} else if (gap2 > 0){
						status = Math.floor(gap2/1000/60/60);
					}					
				}catch(Exception){}				
				
				dataTable.addRows([
				     [ new Date(${year}, arr[i].month-1, parseInt(arr[i].commuting_status_date.substring(0,2))), status],
				   ]);
				
			}//for end	
			
			var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));
			
			 var options = {
			   title: "근무 현황",
			   height: 200,
			   calendar: {
				   cellSize: 15,
				      underYearSpace: 10, // Bottom padding for the year labels.
				      yearLabel: {
				        fontSize: 28,
				      }
				    }
			 };
			 chart.draw(dataTable, options);
			}
		}
	}); // ajax end
}) // ready end
</script>
<script>
$(document).ready(function(){
	var pay2 = 0, pay3 = 0, pay4 = 0, pay5 = 0, pay6 = 0;
	var type = new Array("교통비", "사무비품", "출장비", "식대", "주유비");	
	    <c:forEach var="pay" items="${title_2}">
	    	pay2 += ${pay.pay_cash};	    		    
	    </c:forEach>    
	    <c:forEach var="pay" items="${title_3}">
	    	pay3 += ${pay.pay_cash};	    		    
	    </c:forEach>    
	    <c:forEach var="pay" items="${title_4}">
	    	pay4 += ${pay.pay_cash};	    		    
	    </c:forEach>    
	    <c:forEach var="pay" items="${title_5}">
	    	pay5 += ${pay.pay_cash};	    		    
	    </c:forEach>
	    <c:forEach var="pay" items="${title_6}">
    	pay6 += ${pay.pay_cash};	    		    
    </c:forEach>
	// Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#858796';

	// Pie Chart Example
	var ctx = document.getElementById("myPieChart");
	var myPieChart = new Chart(ctx, {
	  type: 'doughnut',
	  data: {
	    labels: [type[0], type[1], type[2], type[3], type[4]],
	    datasets: [{
	      data: [pay2, pay3, pay4, pay5, pay6],
	      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#e3aa17', '#e04435'],
	      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf', '#a2790f', '#b0362a'],
	      hoverBorderColor: "rgba(234, 236, 244, 1)",
	    }],
	  },
	  options: {
	    maintainAspectRatio: false,
	    tooltips: {
	      backgroundColor: "rgb(255,255,255)",
	      bodyFontColor: "#858796",
	      borderColor: '#dddfeb',
	      borderWidth: 3,
	      xPadding: 15,
	      yPadding: 15,
	      displayColors: false,
	      caretPadding: 10,
	    },
	    legend: {
	      display: false
	    },
	    cutoutPercentage: 80,
	  },
	});
});
</script>
<!-- fullcalendar ref -->
<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.css' />
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lang/ko.js'></script> 


             <!-- ======================================================================================================================================================================메인캘린더 -->

         <script type="text/javascript">
         
         var events_array = [];
         var temp = []; 
         
         $(document).ready(function(){
            
            
             // We will refer to $calendar in future code
             var $calendar = $("#calendar").fullCalendar({ //start of options
                 //weekends : false, // do not show saturday/sunday
                 header: false,
                 // Make possible to respond to clicks and selections
                 selectable: false,
                 // allow "more" link when too many events
                 eventLimit: true,
                 navLinks: false,
                 // Make events editable, globally
                 editable: false,
                 resizeable: false,
                 defaultView: 'listWeek',
                 height: 245,
                 
               //Drop =================================
                 eventDrop: function(event, delta, revertFunc) {
                    
                 },
                 
                 eventResize: function(event, delta, revertFunc) {
                    
                 },
                 //This is the callback that will be triggered when a selection is made
                 eventRender: function(event, element, view) {
                 
                 },
                 select: function(start, end, jsEvent, view) {
                    
                 }, // End callback eventClick
                 events: events_array
               } //End of options
             
           );// calendar end
            
            
            var member_id = '${sessionScope.member.member_id}';
            $.ajax({
                 type: 'POST',
                 url: "${pageContext.request.contextPath}/calendar/getCalList",
                 data: "member_id="+member_id,
                 success: function(data) {    
                     var list = JSON.parse(data);
                     //console.log(list);
                     for(var i = 0 ; i<list.length; i++){
                        var start = new Date(list[i].start);
                        var end = new Date(list[i].end);
                        
                        var row = printCal(list[i]);
                        
                        if((end-start)%86400000 == 0){
                           row.allDay = true
                        }
                        
                        //console.log(list[i].id)
                        temp.push(list[i].id);
                        
                        $('#calendar').fullCalendar('addEventSource', [{
                             id: list[i].id,
                             title: list[i].title,
                             start: list[i].start,
                             end: list[i].end,
                             content: list[i].content,
                             calendar_cate: list[i].calendar_cate, 
                             calendar_cateSelf: list[i].calendar_cateSelf, 
                             member_id: list[i].member_id,
                             color: list[i].color,
                             allDay: list[i].allDay
                         }]);
                        
                     } //for end
                 }
            })//ajax end
            
         }) //ready end
         
         
         
         function printCal(obj){
              if(obj.allDay == 0){
                 if(obj.calendar_cate != 0){
                     var event = {
                           id: obj.id+"",
                           member_id: obj.calendar_member_id,
                           title: obj.title+"",
                           content: obj.content+"",
                           start: moment(obj.start),
                           end: moment(obj.end),
                           color: obj.color,
                           calendar_cate: obj.calendar_cate
                     };
                  }else{
                     var event = {
                           id: obj.id+"",
                           member_id: obj.calendar_member_id,
                           title: obj.title+"",
                           content: obj.content+"",
                           start: moment(obj.start),
                           end: moment(obj.end),
                           color: obj.color,
                           calendar_cate: obj.calendar_cateSelf
                     };
                  }
            }else{
                 if(obj.calendar_cate != 0){
                      var event = {
                         id: obj.id+"",
                         member_id: obj.calendar_member_id,
                           title: obj.title+"",
                           content: obj.content+"",
                           start: moment(obj.start).format(),
                           end: moment(obj.end).format(),
                           color: obj.color,
                           calendar_cate: obj.calendar_cate,
                          allDay: true
                      };
                    }else{
                      var event = {
                         id: obj.id+"",
                         member_id: obj.calendar_member_id,
                           title: obj.title+"",
                           content: obj.content+"",
                           start: moment(obj.start).format(),
                           end: moment(obj.end).format(),
                           color: obj.color,
                           calendar_cate: obj.calendar_cateSelf,
                          allDay: true
                      };
                    }
                  }
              
              return event;
           }// printCal end
           
           $.ajax({
               type: 'POST',
               url: "${pageContext.request.contextPath}/apv_Vacat/getVacation",
               success: function(data) {
     				//console.log(data);
                   // Call the "updateEvent" method
                   
                   $('#mainleftVacat').text(data);
                   
               }
             });
         
         
           $.ajax({
               type: 'POST',
               url: "${pageContext.request.contextPath}/calendar/calCount",
               success: function(data) {    
                  
                  $('#calCount3').text(data);
                      
                   }
          })//ajax end
           
           
         </script>

             <!-- ======================================================================================================================================================================메인캘린더 -->

</head>

<body id="page-top">

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h2 class="h3 mb-0 text-gray-800">환영합니다 ${sessionScope.member.member_name}님!</h2>
            
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">결재대기중 문서</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">(<span id="apvCount4">0</span>)</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-pen-nib fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">미확인 메일</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">(<span id="main_email_count">0</span>)</div>
                    </div>
                    <div class="col-auto">
                      <!-- <i class="fas fa-dollar-sign fa-2x text-gray-300"></i> -->
                      <i class="fas fa-envelope fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">오늘의 일정</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">(<span id="calCount3"></span>)</div>
                        </div>
                        
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar-alt fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

						
            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">남은 휴가</div>
                    
                      <div class="h5 mb-0 font-weight-bold text-gray-800">(<span id="mainleftVacat">0</span>일)</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-paper-plane fa-2x text-gray-300"></i>
                </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->

          <div class="row">

          
            <!-- 1번카드 공지사항  -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 1번 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">게시판:</div>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/boardList?bgno=2">공지사항으로</a>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/boardList?bgno=1">자유게시판으로</a>
                   
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
         <div id="manin_board" class="card-body">
                                             
                   
                  </div>
                </div>
              </div>
          
          
           <!-- 2번카드 일정관리  -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 1번 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">주간일정</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">일정관리:</div>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/calendar">월간일정확인</a>
                     
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
         <div class="card-body">
                               
                 
                    <!-- The calendar container -->
                  <div id="calendar"></div>
                   
                  </div>
                </div>
              </div>
              
          
            <!-- 3번카드 근태관리 -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 출결버튼 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">출결확인</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">근태 관련:</div>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/commuting/commuting">월간 근태확인</a>
                    
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
         <div class="card-body">
                               
                 <div class="timecheck">
                  <div class="card bg-primary text-white shadow">
                    <div class="card-body">
                      <div align="center" id="current_time"></div>
                      <div class="text-white-50 small" align="center">대한민국 GMT+9</div>
                    </div>
                  </div>
                </div>
                 
                 <input type="hidden" id="commuting_member_id" value="${sessionScope.member.member_id}"/>
                   
                   <div class="timecheck">
                      <div id="arrive" style="width:100%;" class="card bg-info text-white shadow btn-outline-info">
                    <div class="card-body" align="center" style="cursor:pointer;" id="arrTime">
                   		  출근체크
                      <div class="text-white-50 small" align="center" >9시 이전에 체크해주세요!</div>
                    </div>
                  </div>
                </div>
                
               	<div class="timecheck">
                  <div  id="leave" style="width:100%;" class="card bg-warning text-white shadow btn-outline-warning">
                   <div class="card-body" align="center" style="cursor:pointer;" id="leavTime">
               		       퇴근체크
                      <div class="text-white-50 small" align="center">6시 이후에 체크해주세요!</div>
                    </div>
                  </div>
                </div>
                
                   
                  </div>
                </div>
              </div>
            </div>
            
            <div class="row">

       <!-- 근무차트 -->
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <!-- 공지사항으로 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">근무 현황</h6>
                  <div class="dropdown no-arrow">
                   
                    
                  </div>
                </div>
                <!-- 근무차트바디 -->
                <div class="card-body">
                  <div class="chart-area">
                    
                    <div id="calendar_basic"></div>
                  </div>
                  <hr>
                  <code>근무현황을 확인해주세요.</code>
                  
                </div>
              </div>
            </div>
            
            
            
           
              
            <!-- 지출차트 -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 지출차트상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">지출 통계</h6>
                
                </div>
                <!-- 지출차트바디 -->
          <div class="card-body">
                      
                <div class="chart-pie pt-4">
                    <canvas id="myPieChart"></canvas>
                   
                  </div>
                   <div class="mt-4 text-center small">
                    <span class="mr-2">
                      <i class="fas fa-circle text-primary"></i> 교통비
                    </span>
                    <span class="mr-2">
                      <i class="fas fa-circle text-success"></i> 사무비품
                    </span>
                    <span class="mr-2">
                      <i class="fas fa-circle text-info"></i> 출장비
                    </span>
                     <span class="mr-2">
                      <i class="fas fa-circle text-warning"></i> 식대
                    </span>
                     <span class="mr-2">
                      <i class="fas fa-circle text-danger"></i> 주유비
                    </span>
                  </div>
                  <hr> <code>당월 지출통계입니다.</code>
             </div>
                                    
                  </div>
               
              
            </div>
            
            </div>
            
            <!-- 두번째줄 끈 -->
            
              <div class="row">
        
            
            <!-- 지도  -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 1번 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">회사 위치</h6>
                  
                </div>
                <!-- Card Body -->
         <div  class="card-body">
                 <div id="map" style="width:100%;height:280px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4d98026d582115563e15a336ff21a605"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(37.485089, 126.898792), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
  
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

// 마커를 표시할 위치입니다 
var position =  new daum.maps.LatLng(37.485089, 126.898792);

// 마커를 생성합니다
var marker = new daum.maps.Marker({
  position: position,
  clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
});

// 아래 코드는 위의 마커를 생성하는 코드에서 clickable: true 와 같이
// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
// marker.setClickable(true);

// 마커를 지도에 표시합니다.
marker.setMap(map);

// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
var iwContent = '<div style="color:black; padding:5px;">KITWARE KOREA</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwRemoveable = false; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

// 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({
    content : iwContent,
    removable : iwRemoveable
});

// 마커에 클릭이벤트를 등록합니다
daum.maps.event.addListener(marker, 'click', function() {
      // 마커 위에 인포윈도우를 표시합니다
      infowindow.open(map, marker);  
});
</script>                            
                   
                  </div>
                </div>
              </div>
           
           
           <!-- SNS  -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 1번 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">KITWARE의 SNS</h6>
                 
                </div>
                <!-- Card Body -->
         <div class="card-body">
                               
                 <p>KITWARE의 <a href="https://www.facebook.com/GoogleKorea/?brand_redir=104958162837">페이스북</a>을 팔로우하고 사장님의 예쁨을 받으세요!</p>
                  <p class="mb-0">또한 회사의 소개 영상을 보여주는 <a href="https://www.youtube.com/watch?v=ApXoWvfEYVU">유튜브</a>를 응원해주세요.</p>
                   
                  </div>
                </div>
              </div>
              
            <!-- 로고 -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 출결버튼 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">THE KITWARE</h6>
                  
                </div>
                <!-- Card Body -->
         <div class="card-body" style="background-color:#eaf8ff !important">
                            <div align="center">   
                 <img id="file_img" src="${pageContext.request.contextPath}/resources/img/ALPHA.png" alt="사진" height=260>
                </div>
                   
                  </div>
                </div>
              </div>
            </div>
                      
          </div> <!-- 컨텐츠플루이드 -->
          
          
          
        
     
      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>

<%--   <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath}/resources/js/chart-area-demo.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/chart-pie-demo.js"></script>
   --%>
  

</body>

</html>
