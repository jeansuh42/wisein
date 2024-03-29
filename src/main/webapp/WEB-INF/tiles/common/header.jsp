<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% String url =  request.getServerName().toString(); %>
    <header>
        <ul>
            <li class="logo"><a href="/">wiseIN</a></li>
            <li class="search-wrap">
                <div class="select-wrap">
                    <select name="searchType" class="searchType" id="search-list">
	                    <option value="all"   ${searchType eq 'all' ? 'selected':''}>전체검색</option>
						<option value="front" ${searchType eq 'front'?'selected':''}>FRONT</option>
			    		<option value="back"  ${searchType eq 'back'?'selected':''}>BACK</option>
			    		<option value="db"    ${searchType eq 'db'?'selected':''}>DB</option>
	                </select>
                </div>
                <input type="text" id="keywordInput" class="search-bar" placeholder="검색할 제목을 입력하세요" onkeyup="enterKey('PC')" value="${keyword}" />
                <span class="material-icons white">
                    <a onclick="enterKey('PC')">search</a>
                </span>
            </li>
            <li class="bar">
                <label for="bar-chk">
                    <span class="material-icons">
                        menu
                    </span>
                </label>

            </li>
        </ul>
    </header>