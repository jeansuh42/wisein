<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<% String url =  request.getServerName().toString(); %>

<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>WISEIN</title>

        <link rel="stylesheet" href="${url}/resources/css/main.css">
        <link rel="stylesheet" href="${url}/resources/css/common.css">
        <link rel="stylesheet" href="${url}/resources/css/tipBoard.css">
        <link rel="stylesheet" href="${url}/resources/css/foodDetail.css">
        <link rel="stylesheet" href="${url}/resources/css/totalSearch.css">
        <link rel="stylesheet" href="${url}/resources/css/foodList.css">
        <link rel="stylesheet" href="${url}/resources/css/tipDetail.css">
        <link rel="stylesheet" href="${url}/resources/css/tipList.css?ver=1">
        <link rel="stylesheet" href="${url}/resources/css/qaDetail.css">

        <link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css">
        <link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css">
        <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
        <link rel="stylesheet" href="${url}/resources/iconfont/material-icons.css">
        <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css'/>

        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31a7b466aaed9176525d555ca8a9644e"></script>
        <script src="https://ucarecdn.com/libs/widget/3.x/uploadcare.full.min.js"></script>
		<script src="${url}/resources/js/common/main.js"></script>
	</head>
	<body>
        <div id="dim-wrapper" style="display: none">
            <div id="dim"></div>
            <img id="loading-img" src="${url}/resources/image/loading.png" class="w100">
        </div>
		<div class="all-wrapper">
			<head>
				<tiles:insertAttribute name="header"/>
			</head>
			<!--nav-->
			<div >
				<tiles:insertAttribute name="nav"/>
			</div>
			<!--/nav-->
			<c:if test="${side_gubun eq 'Y'}">
				<div>
					<tiles:insertAttribute name="leftSide"/>
				</div>
			</c:if>
			<div class="container">
				<tiles:insertAttribute name="contents"/>
			</div>
			<!--footer-->
			<div>
				<tiles:insertAttribute name="footer"/>
			</div>
			<!--/footer-->
		</div>
	</body>

    <script src="${url}/resources/js/common/util.js"></script>
    <script src="${url}/resources/js/common/event.js"></script>
    <script src="${url}/resources/js/common/login.js"></script>
    <script src="${url}/resources/js/tipDetail.js"></script>
    <script src="${url}/resources/js/qaDetail.js"></script>
    <script src="${url}/resources/js/totalSearch.js"></script>
    <script src="${url}/resources/js/imgUpload.js"></script>

	<script>
	<c:if test="${empty member}">
	    $dim();
	    document.querySelector('#joinBox').classList.remove('none');
        let loadingMsg = document.querySelector("#lg_fail_msg").innerText;
        if (loadingMsg != '') { commonPopup.alertPopup(loadingMsg, false); }
	</c:if>
	</script>
</html>