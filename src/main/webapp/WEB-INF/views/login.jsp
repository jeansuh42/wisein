<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="resources/js/jquery-3.5.1.min.js"></script>
<script src="resources/js/common/authCheck.js"></script>

<section id="content">
 <form role="form" method="post" autocomplete="off" id="login_form">
  <div class="input_area">
   <label for="id">아이디 </label>
   <input type="text" id="id" name="id" required="required" />
  </div>

  <div class="input_area">
   <label for="pw">패스워드</label>
   <input type="password" id="pw" name="pw" required="required" />
  </div>

  <button type="button" id="login_btn" name="login_btn">로그인</button>
 </form>
</section>

<div> 로그인 여부: ${not empty member} </div>
<div> 로그인 객체: ${member} </div>

<c:if test="${not empty msg}">
    <p style="color:red;">${msg}</p>
</c:if>

<ul>
 <c:if test="${empty member}">
 <li> <a href="login">로그인</a> </li>
 <li> <a href="register">회원가입</a> </li>
 </c:if>
  <c:if test="${not empty member}">
 <li><a href="logout">로그아웃</a> </li>
 <li><a href="user/update">정보 수정</a> </li>
 <li><a href="user/withdraw">탈퇴</a> </li>
 </c:if>
</ul>