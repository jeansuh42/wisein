        function validCheck() {
            let result = true;
             if(document.querySelector("#subject").value == ''){
                alert('제목을 입력하세요✍')
                document.querySelector("#subject").focus();
                result = false;
             }else if(editor.getMarkdown() == ''){
                alert('내용을 입력하세요✍')
                editor.focus();
                result = false;
             }
             return result;
        };

        function reg(){
            let category = document.querySelector("#category").value;
            let subject = document.querySelector("#subject").value;
            let content = editor.getHTML();
            let data = {category: category, subject: subject, content: content, brdNum: brdNum};

            if(validCheck()){
                fetch('/tipBoard',{
                    method: 'POST',
                    cache : 'no-cache',
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(data)
                })
                .then(response => response.text())
                .catch(error => console.error('Error:', error))
                .then(response => window.location.href = "/tipList")
            }
        };

        function udp(){
            let num = document.location.search.replace(/[^0-9]/g,"");
            let category = document.querySelector("#category").value;
            let subject = document.querySelector("#subject").value;
            let content = editor.getHTML();
            let data = {num: num, category: category, subject: subject, content: content};

            if(validCheck()){
                  fetch('/updTip',{
                        method: 'POST',
                        cache : 'no-cache',
                        headers: {"Content-Type": "application/json"},
                        body:JSON.stringify(data)
                  })
                  .then(response => response.text())
                  .catch(error => console.error('Error:', error))
                  .then(response => window.location.href = "/tipDetail?num="+num)
            }
        };

        function cancel(){
            if(confirm('진짜 취소하실꺼에여?🥺') == true){
                window.history.back()
            }
        };