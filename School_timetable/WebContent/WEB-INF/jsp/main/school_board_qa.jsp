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
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	board_list();	
});//end document

function move_write(){
	document.getElementById("write_form").style.display='';
}

function write_close(){
	document.getElementById("write_form").style.display='none';
	$("#title").val("");
	$("#content").val("");
}

//글등록
function board_write(){
	var member_no = $("#member_no").val();
	var content = $("#content").val();
	
	if (content == '' || content == null){
		alert("질문을 입력 하세요.")
		return false;
	}
	board_write_go();
}

function board_write_go(){
	var member_no = $("#member_no").val();
	var content = $("#content").val();
	
	var params = "member_no="+member_no+"&content="+content;
	
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/insert_board_qa.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  write_close();
      }
	});
}

//댓글 등록
function board_replay_write(qa_no){
	var member_no = $("#member_no").val();
	var content = $("#re_content_"+qa_no).val();
	if (content == '' || content == null){
		alert("내용을 입력 하세요.")
		return false;
	}
	var params = "member_no="+member_no+"&qa_no="+qa_no+"&content="+content;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/insert_board_qa_replay.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  write_close();
      }
	});
}
//리스트 가져오기
function board_list(){
	var params = "";
	
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/select_boardList_qa.do"
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
    	  var member_no = $("#member_no").val();
    	  
    	  $.each(data.list, function (index, list) {

    		  html += "<div style='background-color: #fff; margin-bottom: 2em;'>";
    		  html += "<p style='border-bottom: 0.5px solid #ececec; color: #386994; font-weight: bold !important; margin-left: 0.5em;'>"+list.content+"</p>";
    		  html += "<p style='color: #a5a5a5; margin-left: 0.5em; font-size: 12px;'>"+list.member_name;
    		  html += " | "+list.insertDate+"</p>";
    		  
    		  
    		  if(member_no == list.member_no){
        		  html += "<div class='ui-grid-a'>";
        		  
        		  html += "<div class='ui-block-a'>";
        		  html += "<input type='hidden' value='"+list.title+"' id='title_"+list.qa_no+"'>";
        		  html += "<input type='hidden' value='"+list.content+"' id='content_"+list.qa_no+"'>";
        		  html += "<input type='button' value='수정' onclick='update_board("+list.qa_no+")'>";
        		  html += "</div>";
        		  html += "<div class='ui-block-b'>";
        		  html += "<input type='button' value='삭제' onclick='delete_board("+list.qa_no+")'>";
        		  html += "</div>";
        		  
        		  html += "</div>";
    		  }
    		  
    		  
    		  
    		  html += "<div style='background-color: #e5e8ed;'>";
    		  html += "<div class='ui-grid-b'>";
    		  html += "<div class='ui-block-a' style='width: 3%;'></div>";
    		  html += "<div class='ui-block-b' style='width: 65%;'>";
    		  html += "<input type='text' placeholder='댓글을 입력 하세요.' id='re_content_"+list.qa_no+"'>"
    		  html += "</div>";
    		  html += "<div class='ui-block-c' style='width: 30%;'>";
    		  html += "<input type='button' value='등록' onclick='board_replay_write("+list.qa_no+")'>";
    		  html += "</div>";
    		  html += "</div>";
    		  html += "</div>";    		  
    		  
    		  $.each(data.replay_list, function (index, replay_list) {
    			  if(list.qa_no == replay_list.qa_no){
    				  html += "<div style='background-color: #e5e8ed; font-size: 14px; margin-bottom: 0.1em;'>";
    				  html += "&nbsp&nbsp"+replay_list.member_name+"&nbsp:&nbsp"+replay_list.content;
    				  
    	    		  if(member_no == replay_list.member_no){
    	        		  html += "<div class='ui-grid-a' style='background-color: #e5e8ed;'>";
    	        		  
    	        		  html += "<div align='center' class='ui-block-a'>";
    	        		  html += "<input type='hidden' value='"+replay_list.content+"' id='re_content_"+replay_list.replay_no+"'>";
    	        		  html += "<a href='#' class='ui-btn ui-btn-inline ui-mini' onclick='update_replay("+replay_list.replay_no+")' style='width: 60%;'>수정</a>";
    	        		  html += "</div>";
    	        		  html += "<div class='ui-block-b'>";
    	        		  html += "<a href='#' class='ui-btn ui-btn-inline ui-mini' onclick='delete_replay("+replay_list.replay_no+")' style='width: 60%;'>삭제</a>";
    	        		  html += "</div>";
    	        		  
    	        		  html += "</div>";
    	    		  }
    				  
    				  html += "</div>";
    			  }    			  
    		  });    		  
    		  
    		  html += "</div>";
    		  html += "</div>";
    		  
    	  });
    	  
    	  $( "#board_list").html(html).trigger("create");
    	      	  
      }
	});
}



function update_replay(replay_no){
	var content = $("#re_content_"+replay_no).val();
	$("#modify_re_content").val(content);
	$("#modify_replay_no").val(replay_no);
	
	$("#popupModify_re").popup("open");
}

function update_board(qa_no){
	var content = $("#content_"+qa_no).val();
	
	$("#modify_content").val(content);
	$("#modify_qa_no").val(qa_no);
	
	$("#popupModify").popup("open");
}

function delete_board(qa_no){
	var params = "qa_no="+qa_no;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/delete_qa_board.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
      }
	});
}

function delete_replay(replay_no){
	var params = "replay_no="+replay_no;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/delete_qa_replay.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
      }
	});
}

function popupConfirm(){
	var qa_no = $("#modify_qa_no").val();
	var content = $("#modify_content").val();
	
	var params = "qa_no="+qa_no+"&content="+content;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/update_qa_board.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  popupClose();
      }
	});
}

function popupConfirm2(){
	var replay_no = $("#modify_replay_no").val();
	var content = $("#modify_re_content").val();
	
	var params = "replay_no="+replay_no+"&content="+content;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/update_qa_replay.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  popupClose2();
      }
	});
}

function popupClose(){
	$("#popupModify").popup("close");
}

function popupClose2(){
	$("#popupModify_re").popup("close");
}





function call_back(){
	history.go(-1);
}
function move_free(){
	location.href="<%=cp%>/cmd/school_board.do";
}
function move_qa(){
	location.href="<%=cp%>/cmd/school_board_qa.do";
}
</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>게시판</h3>
		<i class="fa fa-pencil" style="position: absolute; font-size:26px; color: #fff; margin-left:0.5em; margin-top: 0.3em; right: .5em; top: 0em;" onclick="move_write()"></i>
	</div>	

	<div data-role="main" class="ui-content">
		
		<div align="center" class="ui-grid-a" style="border-top: 1px solid #6d92c6; border-bottom: 1px solid #6d92c6; margin-bottom: 1em; background-color: #fff;">
			<div class="ui-block-a" style="border-right: 2px solid #6d92c6;" onclick="move_free()"><h4>자유 게시판</h4></div>
			<div class="ui-block-b" style="background-color: #e5e8ed;" onclick="move_qa()"><h4>질문/답변 게시판</h4></div>
		</div>
	
		<div id="write_form" style="display: none;">
			<textarea rows="" cols="" id="content" placeholder="질문을 입력 하세요." style="resize: none;"></textarea>
					
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input type="button" value="등록" onclick="board_write()">
				</div>
				<div class="ui-block-b">
					<input type="button" value="취소" onclick="write_close()">
				</div>
			</div>
		</div>
	
		<div id="board_list"></div>
	</div> 
	
	<!--팝업 -->
	<div id="popupModify" data-overlay-theme="a" style="max-width: 400px; background-color: #dddfe2;" data-role="popup" data-dismissible="false">
	    <div role="main">
	    	<div>
	    		<input type="hidden" value="" id="modify_qa_no">
				<textarea id="modify_content" style="resize: none;"></textarea>
	    	</div>
	  	</div>
  		<div class="ui-grid-a">
			<div class="ui-block-a">
				<input type="button" value="수정" onclick="popupConfirm()">
			</div>
			<div class="ui-block-b">
				<input type="button" value="취소" onclick="popupClose()">
			</div>
		</div>	  	
	 </div>
	 
	 <!--팝업 -->
	<div id="popupModify_re" data-overlay-theme="a" style="max-width: 400px; background-color: #dddfe2;" data-role="popup" data-dismissible="false">
	    <div role="main" align="center">
	    	<p>댓글 수정</p>
	    	<div>
	    		<input type="hidden" value="" id="modify_replay_no">
				<textarea id="modify_re_content" style="resize: none;"></textarea>
	    	</div>
	  	</div>
  		<div class="ui-grid-a">
			<div class="ui-block-a">
				<input type="button" value="수정" onclick="popupConfirm2()">
			</div>
			<div class="ui-block-b">
				<input type="button" value="취소" onclick="popupClose2()">
			</div>
		</div>	  	
	 </div>
	
	
	
</div>
</body>
</html>