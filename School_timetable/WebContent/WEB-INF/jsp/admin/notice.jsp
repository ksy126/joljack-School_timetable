<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	  <style>
	  /* Note: Try to remove the following lines to see the effect of CSS positioning */
	  .affix {
	      top: 0;
	      width: 100%;
	  }
	
	  .affix + .container-fluid {
	      padding-top: 70px;
	  }
	  </style>
	  
	<script type="text/javascript">
	$(document).ready(function(){
		
	});//end document
	
  	function move_menu(data){
  		if(data == '01'){
  			location.href="<%=cp%>/admin/main.do";
  		} else if (data == '02'){
  			location.href="<%=cp%>/admin/notice.do";
  		} else if (data == '03'){
  			location.href="<%=cp%>/admin/member.do";
  		} else if (data == '04'){
  			location.href="<%=cp%>/admin/img_orgaization.do";
  		} else if (data == '05'){
  			location.href="<%=cp%>/admin/img_schedule.do";
  		} else if (data == '06'){
  			location.href="<%=cp%>/admin/notice_list.do";
  		}
  	}
  	
  	function insert_notice(){
  		var category = $("#category").val();
  		var title = $("#title").val();
  		var content = $("#content").val();
  		
  		if(title == 'null' || title == ''){
  			alert("제목을 입력하세요.");
  			return false;
  		}
  		if(content == 'null' || content == ''){
  			alert("공지 내용을 입력하세요.");
  			return false;
  		}
  		
  		var params = "category="+category+"&title="+title+"&content="+content;
  		
  	    $.ajax({
  	        type        : "POST" 
  	      , async       : true
  	      , url         : "/admin/insert_notice.do"
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
  	
  	function call_back(){
  		history.go(-1);
  	}
  	
  	function notice_list(){
  		
  		var params = "";
  		
  	    $.ajax({
  	        type        : "POST" 
  	      , async       : true
  	      , url         : "/admin/select_noticeList.do"
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

  	    		  html += "<div class='ui-grid-a' style='border: 2px solid #cccccc; background-color: #fff; margin-bottom: 0.3em;' onclick='details("+list.notice_no+")'>";
  	    		  html += "<div class='ui-block-a'>";
  	    		  html += list.title;
  	    		  html += "</div>";
  	    		  html += "<div align='right' class='ui-block-b'>";
  	    		  html += list.insertDate.substring(0,10);
  	    		  html += "</div>";
  	    		  html += "<div align='center'>";
  	    		  html += "<input class='btn btn-danger' type='button' value='삭제' onclick='delete_notice("+list.notice_no+")'>";
  	    		  html += "</div>";
  	    		  html += "</div>";
  	    		  
  	    	  });
  	    	  
  	    	  $( "#notice_list").html(html).trigger("create");
  	    	      	  
  	      }
  		});
  	}
  	
  	function delete_notice(notice_no){
  		var params = "notice_no="+notice_no;
  		
  	    $.ajax({
  	        type        : "POST" 
  	      , async       : true
  	      , url         : "/admin/delete_notice.do"
  	      , data        : params
  	      , dataType    : "json"
  	      , timeout     : 30000  
  	      , cache       : false    
  	      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
  	      , error       : function(request, status, error) {
  	         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
  	      }
  	      , success     : function(data) {
  	    	 alert("삭제 완료");
  	    	notice_list();
  	      }
  		});
  	}
	</script>
</head>
<body>

<div class="container-fluid" style="background-color:#23429c;color:#fff;height:100px;">
  <h1>관리자</h1>
</div>

<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
  <ul class="nav navbar-nav">
    <li onclick="move_menu(01)"><a href="#">Main</a></li>
    <li class="active" onclick="move_menu(02)"><a href="#">학교 공지 등록</a></li>
    <li onclick="move_menu(06)"><a href="#">학교 공지 수정/삭제</a></li>
    <li onclick="move_menu(03)"><a href="#">회원 관리</a></li>
    <li onclick="move_menu(04)"><a href="#">학생회 조직도 관리</a></li>
    <li onclick="move_menu(05)"><a href="#">학사 일정 관리</a></li>
  </ul>
</nav>

<div class="container-fluid" style="background-color: #fff;">
	<div align="center">
		<h3>공지사항 등록</h3>
	</div>
	
	<div  style="margin-left: 7em; margin-right: 7em;">
		<div class="form-group">
		  <label for="sel1">공지사항 카테고리</label>
		  <select class="form-control" id="category">
		    <option value="01">학교소식</option>
		    <option value="02">학사공지</option>
		    <option value="03">장학공지</option>
		    <option value="04">입찰/채용</option>
		  </select>
		</div>
		<div class="form-group">
		  <label for="usr">제목을 입력하세요.</label>
		  <input type="text" class="form-control" id="title">
		</div>
		<div class="form-group">
		  <label for="comment">공지 내용을 입력하세요.</label>
		  <textarea class="form-control" rows="8" id="content"></textarea>
		</div>
		<div align="right">
			<input class="btn btn-primary" type="button" value="등록" onclick="insert_notice()">
			<input class="btn btn-default" type="button" value="취소" onclick="call_back()">
		</div>
	</div>
	
	<div style="margin-top:2em; margin-left: 7em; margin-right: 7em;" id="notice_list"></div>
</div>

</body>
</html>
