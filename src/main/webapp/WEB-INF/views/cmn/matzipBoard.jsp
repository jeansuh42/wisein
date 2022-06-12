<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <link rel="stylesheet" href="resources/css/tipBoard.css">
    <link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<body>
    <div class="content-wrap">

        <p><input type="text" size="210" id='writer' placeholder="아이디입니다" required></p>
        <p><input type="text" size="210" id='subject' placeholder="제목을 입력하세요" required></p>

        <p><select name="star" id='star'>
             <option value="1">☆☆☆☆☆</option>
             <option value="2">★☆☆☆☆</option>
             <option value="3">★★★☆☆</option>
             <option value="4">★★★★☆</option>
             <option value="5">★★★★★</option>
        </select></p>

         <p><select name="category" id='category'>
             <option value="인덕원">인덕원</option>
             <option value="회현">회현</option>
             <option value="을지로">을지로</option>
         </select></p>

        <p><input type="text" size="210" id='matzip_data' placeholder="맛집데이터" required></p>

        <div>내용</div>
        <div id="contents">
            <div id="editor"></div>
            <div id="viewer"></div>
        </div>

        <div class="button-wrap">
            <input type="button" value="등록" onclick="submit()">
            <input type="button" value="취소" onclick="cancel()">
       </div>

    </div>
    <script src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
    <script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>
    <script>
        const { Editor } = toastui;
        const { colorSyntax } = Editor.plugin;

        const editor = new Editor({
                 el: document.querySelector('#editor'),
                 height: '749px',
                 initialEditType: 'markdown',
                 previewStyle: 'vertical',
                 placeholder: '📌욕설이나 비방, 모욕, 선정성이 존재하는 사진이나 게시글은 업로드하지 말아주세요📌',
                 plugins: [colorSyntax]
            });

         document.getElementById('matzip_data').value =
         `{
            "documents": [
              {
                "address_name": "서울 중구 회현동1가 206",
                "category_group_code": "FD6",
                "category_group_name": "음식점",
                "category_name": "음식점 > 아시아음식 > 동남아음식 > 베트남음식",
                "distance": "",
                "id": "1710196369",
                "phone": "02-318-7768",
                "place_name": "홍대쌀국수 회현점",
                "place_url": "http://place.map.kakao.com/1710196369",
                "road_address_name": "서울 중구 퇴계로 72",
                "x": "126.980640745963",
                "y": "37.5591237285706"
              }
            ],
            "meta": {
              "is_end": true,
              "pageable_count": 1,
              "same_name": {
                "keyword": "홍대쌀국수 회현점",
                "region": [],
                "selected_region": ""
              },
              "total_count": 1
            }
          }`
    </script>
    <script>
            function submit(){
                const writer = document.getElementById('writer').value;
                const subject = document.getElementById('subject').value;
                const content = editor.getHTML();
                const star = document.getElementById('star').value;

                const matzip_data = document.getElementById('matzip_data').value;
                const matzip_obj = JSON.parse(matzip_data);
                debugger;
                const matzip_id = matzip_obj.documents[0].id;

                debugger;

                $.ajax({
                    data:{ "writer": writer, "subject":subject,"content":content, "star":star, "matzipData": matzip_data, "matzipId": matzip_id},
                    type:"GET",
                    url:"/regMatzip",
                    success:function(data) {
                        alert("성공");
                        window.location.href = "/matzipList"
                    },
                    error:function(request, status, error) {
                        alert("실패");
                    }
                })
            }
        </script>
</body>
</html>