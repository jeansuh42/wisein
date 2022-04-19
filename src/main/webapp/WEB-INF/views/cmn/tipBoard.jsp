<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <link rel="stylesheet" href="resources/css/tipBoard.css">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<body>
    <div class="content-wrap">

        <div>제목</div>
        <p><input type="text" size="210" placeholder="제목을 입력하세요" required></p>

        <div>내용</div>
        <div id="editor"></div>
        <div id="contents"></div>

        <div class="button-wrap">
            <input type="button" value="등록" onclick="submit()">
            <input type="button" value="취소" onclick="cancel()">
       </div>

    </div>

    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
    <script>
        const editor = new toastui.Editor({
                 el: document.querySelector('#editor'),
                 height: '749px',
                 initialEditType: 'markdown',
                 previewStyle: 'vertical',
                 initialValue: '📌욕설이나 비방, 모욕, 선정성이 존재하는 사진이나 게시글은 업로드하지 말아주세요📌'
            });
    </script>

    <script>
        function submit(){
            console.log(editor.getHTML());
        }
    </script>

    <script>
        function cancel(){
            if(confirm('진짜 취소하실꺼에여?🥺') == true){
                console.log('뒤로가기되찌롱');
                window.history.back()
            }
        }
    </script>
</body>
</html>