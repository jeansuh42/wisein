<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:formatDate  var="hireDate" value="${member.hireDate}" type="DATE" pattern="yyyy-MM-dd"/>

    <div class="sidebar-wrap">
        <input type="checkbox" name="" id="bar-chk" style="display: none;">
        <div class="sidebar">
            <div class="top">
                <div class="info">
                    <c:if test="${not empty member.fileList[0]}">
                    <img src ="../${member.fileList[0].filePath}">
                    </c:if>
                    <c:if test="${empty member.fileList[0]}">
                    <img src ="../resources/image/Conic.png">
                    </c:if>
                    <label for="my-function-chk">반가워요, ${member.name}!<br>${member.site}</label>
                    <input type="checkbox" name="" id="my-function-chk" style="display: none;">
                    <ul class="person-function">
                     <c:if test="${empty member}">
                         <li onclick="login()">로그인 </li>
                         <li onclick="signUp()">회원가입 </li>
                     </c:if>
                     <c:if test="${not empty member}">
                         <li><a href="#">작성 글 모아 보기</a> </li>
                         <li><a href="user/logout">로그아웃</a> </li>
                         <li onclick="userUpd()">정보 수정 </li>
                         <li><a href="user/withdraw">탈퇴</a> </li>
                     </c:if>
                    </ul>
                </div>
                <ul class="menu">
                    <li><a href="/qalist">질문하고 싶어요</a></li>
                    <li><a href="/tiplist">Tech Tip</a></li>
                    <li><a href="/matzipList">사이트 별 맛집 목록</a></li>
                </ul>
                <div class="search-bar">
                    <span class="material-icons">
                        search
                    </span>
                    <input type="text">
                </div>
            </div>
            <div class="bottom">
                <ul class="icon">
                    <li>
                        <span class="material-icons">
                            perm_identity
                        </span>
                    </li>
                    <li>
                        <span class="material-icons">
                            link
                        </span>
                    </li>
                </ul>
            </div>
        </div>
    </div>


<%-- 회원 가입 --%>
<div id="signUpBox" class="popup-wrap page-center none">
    <div class="signUp-popup-wrap" style="min-width: 450px">
    <p class="close" onclick="memPopUpClose()"> </p>
    <form role="form" method="post" autocomplete="off" id="reg_form" action="/register">
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">ID</label>
            <input type="text" class="signUp-input pr30p" id="id" name="id" required="required" placeholder="아이디">
            <div class="email-info">@ wiselab.co.kr</div>
            <p id="idChkBtn" class="signUp-input-label mg0">check</p>
        </div>
        <div id ="idChkAlert" class="signUp-pwassword-info-wrap">
            <p class="porintColor none"> <span class="material-icons chk-alert">check_circle</span> 사용 가능한 아이디입니다.</p>
            <p class="red none"> <span class="material-icons chk-alert"> report_problem </span> 아이디가 존재합니다. 다른 아이디를 입력하세요.</p>
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">이름</label>
            <input type="text" class="signUp-input" id="name" name="name" required="required" placeholder="이름">
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">파견 사이트</label>
            <input type="text" class="signUp-input" id="site" name="site" placeholder="파견 사이트" required="required">
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">PASSWORD</label>
            <input type="password" class="signUp-input" id="pw" name="pw" required="required" placeholder="비밀번호">
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">PWCHECK</label>
            <input type="password" class="signUp-input" id="pwChk" name="pwChk" required="required" placeholder="비밀번호 확인">
            <p id="pwChkBtn" class="signUp-input-label mg0">check</p>
        </div>
        <div id="pwChkAlert" class="signUp-pwassword-info-wrap">
            <p class="porintColor none"> <span class="material-icons chk-alert">check_circle</span> 패스워드가 일치합니다 </p>
            <p class="red none"> <span class="material-icons chk-alert"> report_problem </span> 패스워드가 일치하지 않습니다 </p>
        </div>
        <div class="signUp-confirm-Button-wrap">
            <button type="button" id="signup_btn" name="signup_btn">메일 인증하고 가입하기</button>
        </div>
    </div>
    </form>
</div>


<div id="joinBox" class="popup-wrap page-center none">
    <div class="signUp-popup-wrap form-between">
        <div class="w50p">
            <div>
                <button type="button" name="signUp_btn" onclick="signUp()" class="join-box-btn">SIGN UP</button>
            </div>
        </div>
        <div class="w50p">
            <div>
                <button type="button" name="login_btn" onclick="login()" class="join-box-btn">LOGIN</button>
            </div>
        </div>
    </div>
    <div class="join-box-txt">
       <p>해당 사이트는 와이즈랩 메일 인증 뒤 가입이 가능합니다.</p>
    </div>
</div>


<div id="loginBox" class="popup-wrap page-center none">
<form role="form" method="post" autocomplete="off" id="login_form" action="/login">
    <div class="signUp-popup-wrap form-between">
        <p class="close" onclick="memPopUpClose()"> </p>
        <div class="w70p">
            <div class="signUp-input-wrap">
                <label for="" class="signUp-input-label">ID</label>
                <input type="text" class="login-input" id="login_id" name="id" required="required" />
            </div>
            <div class="signUp-input-wrap">
                <label for="" class="signUp-input-label">PASSWORD</label>
                <input type="password" class="login-input" id="login_pw" name="pw" required="required" />
            </div>
        </div>
        <div class="w30p">
            <div class="login-button-wrap">
                <button type="button" id="login_btn" name="login_btn">로그인</button>
            </div>
        </div>
    </div>
    <%-- <div class="popup-link-wrap">
        <p onclick="signUp()">회원가입</a></p>
        <p><a href="#">아이디 비밀번호 찾기</a></p>
    </div> --%>
</form>
</div>



<%-- 회원 정보 수정 --%>
<div id="userUpdBox" class="popup-wrap page-center none">
    <div class="signUp-popup-wrap" style="min-width: 450px; padding:2.5rem">
     <p class="close" onclick="memPopUpClose()"> </p>
    <form role="form" method="post" id="upd_form" encType = "multipart/form-data" action="/user/update" autocomplete="off">
        <div class="signUp-input-wrap">
            <label for="id" class="signUp-input-label">ID</label>
            <input type="text" class="signUp-input pr30p" id="upd_id" name="id" required="required" value="${member.id}" readonly/>
            <div class="email-info" style="right: 0.5em;">@ wiselab.co.kr</div>
        </div>
        <div class="signUp-input-wrap">
            <label for="name" class="signUp-input-label">이름</label>
            <input type="text" class="signUp-input" id="upd_name" name="name" value="${member.name}" required="required" readonly/>
        </div>
        <div class="signUp-input-wrap">
           <label class="signUp-input-label">프로필 사진</label>
           <input type="file" id="files" name="fileName" />
            <div class="file_list">
                <c:forEach var="list" items="${member.fileList}">
                    <div class="profile_img">
                    <img src ="../${member.fileList[0].filePath}" width="25" height="25">
                    ${list.orgFileName}
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">파견 사이트</label>
            <input type="text" class="signUp-input" id="upd_site" name="site" value="${member.site}" required="required">
        </div>
        <div class="signUp-input-wrap">
            <label for="hireDate" class="signUp-input-label">입사 일자</label>
            <input type="date" class="signUp-input" id="upd_hireDate" name="hireDate" value="${hireDate}" required="required">
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">미트 링크</label>
            <input type="text" class="signUp-input" id="upd_meetLink" name="meetLink" value="${member.meetLink}">
        </div>
        <div class="signUp-input-wrap">
            <label for="" class="signUp-input-label">PASSWORD</label>
            <input type="password" class="signUp-input" id="upd_pw" name="pw" required="required" placeholder="비밀번호" disabled>
            <p id="upd_pwModBtn" class="signUp-input-label" style="position: absolute; right: 0; margin: 0;">변경하기</p>
        </div>
        <div class="signUp-input-wrap">
            <label class="signUp-input-label">PWCHECK</label>
            <input type="password" class="signUp-input" id="upd_pwChk" name="pwChk" required="required" placeholder="비밀번호 확인" disabled>
            <p id="upd_pwChkBtn" class="signUp-input-label" style="position: absolute; right: 0; margin: 0;">check</p>
        </div>
        <div id="upd_pwChkAlert" class="signUp-pwassword-info-wrap">
            <p class="porintColor none"> <span class="material-icons chk-alert">check_circle</span> 패스워드가 일치합니다</p>
            <p class="red none"> <span class="material-icons chk-alert"> report_problem </span> 패스워드가 일치하지 않습니다</p>
        </div>
        <div class="signUp-confirm-Button-wrap">
            <button type="button" id="upd_btn" name="upd_btn" onclick="userUpdCmn()">정보 수정</button>
        </div>
    </div>
    </form>
</div>
