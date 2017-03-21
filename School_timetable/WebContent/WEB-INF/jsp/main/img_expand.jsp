<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=5.0, minimum-scale=1.0, user-scalable=yes">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
function call_back(){
	history.go(-1);
	
}
</script>
</head>
<body>
<div data-role="page" style=" background-color:#000 !important;">
	<div data-role="content" style="padding:0;">
        <div class="img_vertical">
			<p style="margin:0; text-align:right; padding:0 .3em; width: 100%; position: absolute; top: 0; right: 0;">
				<a href="#" onclick="call_back()" data-ajax="false" style="font-size:36px; float:right; color:#666; text-decoration:none;">×</a>
			</p>			
			<img src="${img_src}" width="100%"/>
        </div>
	</div>
</div>
</body>
</html>