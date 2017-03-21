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
	notice_list("01");
});//end document

function move_write(){
	document.getElementById("write_form").style.display='';
}

function write_close(){
	document.getElementById("write_form").style.display='none';
	$("#title").val("");
	$("#content").val("");
}
function call_back(){
	history.go(-1);
}
	
	function board_write(){
		var category = $("#category").val();
		var title = $("#title").val();
		var content = $("#content").val();
		var member_no = $("#member_no").val();
		
		if(title == 'null' || title == ''){
			alert("제목을 입력하세요.");
			return false;
		}
		if(content == 'null' || content == ''){
			alert("공지 내용을 입력하세요.");
			return false;
		}
		
		var params = "category="+category+"&title="+title+"&content="+content+"&member_no="+member_no;
		
	    $.ajax({
	        type        : "POST" 
	      , async       : true
	      , url         : "/cmd/insert_notice.do"
	      , data        : params
	      , dataType    : "json"
	      , timeout     : 30000  
	      , cache       : false    
	      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
	      }
	      , success     : function(data) {
	    	  location.reload();
	    	  alert("등록완료!");
	      }
		});
	}
	
	function notice_list(category){
		
		var params = "category="+category;
		
	    $.ajax({
	        type        : "POST" 
	      , async       : true
	      , url         : "/cmd/select_notice_department_List.do"
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
	    		  html += "<div width='70%' align='left' class='ui-block-a'>";
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
	
	function details(notice_no){
		location.href="<%=cp%>/cmd/notice_department_details.do?notice_no="+notice_no;
	}

</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>학과 공지</h3>
		<i class="fa fa-pencil" style="position: absolute; font-size:26px; color: #fff; margin-left:0.5em; margin-top: 0.3em; right: .5em; top: 0em;" onclick="move_write()"></i>
	</div>	

	<div data-role="main" class="ui-content" align="center">
		<div class="ui-grid-a" style="color: #556cae; margin-bottom: 1em;">
			<div class="ui-block-a" style="border-right: 1px solid #556cae;" onclick="notice_list('01')">전체공지</div>
			<div class="ui-block-b" onclick="notice_list('02')">학년별공지</div>
		</div>
		
		<div id="write_form" style="display: none;">
			<div class="form-group">
			  <select class="form-control" id="category">
			    <option value="01">전체공지</option>
			    <option value="02">학년별공지</option>
			  </select>
			</div>
			<input type="text" value="" id="title" placeholder="공지 제목을 입력 하세요.">
			<textarea rows="" cols="" id="content" placeholder="공지내용을 입력 하세요." style="resize: none;"></textarea>
						
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input type="button" value="등록" onclick="board_write()">
				</div>
				<div class="ui-block-b">
					<input type="button" value="취소" onclick="write_close()">
				</div>
			</div>
		</div>
		
		<div id="notice_list" style="color: #b0b1b3; font-size: 18px;"></div>
	</div> 
</div>
</body>
</html>