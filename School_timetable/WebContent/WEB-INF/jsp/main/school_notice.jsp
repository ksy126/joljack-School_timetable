<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%  
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

<script type="text/javascript">
$(document).ready(function(){
	notice_list('01');
});//end document

function details(notice_no){
	location.href="<%=cp%>/cmd/notice_details.do?notice_no="+notice_no;
}

function notice_list(category){
	
	var params = "category="+category;
	
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/select_noticeList.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  var html = "";
    	  
    	  $.each(data.list, function (index, list) {

    		  html += "<div class='ui-grid-a' style='background-color: #fff; margin-bottom: 0.3em;' onclick='details("+list.notice_no+")'>";
    		  html += "<div width='70%' class='ui-block-a'>";
    		  html += list.title;
    		  html += "</div>";
    		  html += "<div width='20%' align='right' class='ui-block-b'>";
    		  html += list.insertDate.substring(0,10);
    		  html += "</div>";
    		  html += "</div>";
    		  
    	  });
    	  
    	  $( "#notice_list").html(html).trigger("create");
    	      	  
      }
	});
}

function call_back(){
	history.go(-1);
}

</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>학교 공지</h3>
	</div>	

	<div data-role="main" class="ui-content">
	
		<div class="ui-grid-c" style="color: #556cae; margin-bottom: 1em;">
			<div class="ui-block-a" onclick="notice_list('01')">학교소식&nbsp;&nbsp;|</div>
			<div class="ui-block-b" onclick="notice_list('02')">학사공지&nbsp;&nbsp;|</div>
			<div class="ui-block-c" onclick="notice_list('03')">장학공지&nbsp;&nbsp;|</div>
			<div class="ui-block-d" onclick="notice_list('04')">입찰/채용</div>
		</div>
		
		<div id="notice_list" style="color: #b0b1b3; font-size: 18px;"></div>
			
	</div> 
</div>
</body>
</html>