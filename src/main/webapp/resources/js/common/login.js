
window.onload = function() {
    var httpRequest;

    let idChkBool = false;
    let pwChkBool = false;
    let upd_pwChkBool = false;

    let idBox = document.querySelector('#id');
    let pwBox = document.querySelector('#pw');
    let pwChkBox = document.querySelector('#pwChk');

    let updPwBox = document.querySelector('#upd_pw');
    let updPwChkBox = document.querySelector('#upd_pwChk');
    let pwModBtn = document.querySelector('#upd_pwModBtn');

    let idChkBtn = document.querySelector("#idChkBtn");
    let pwChkBtn = document.querySelector("#pwChkBtn");
    let updPwChkBtn = document.querySelector("#upd_pwChkBtn");
    let signupBtn = document.querySelector("#signup_btn");


    // ID 유효성 컨트롤: 회원 가입 여부 체크
    idChkBtn.addEventListener('click', () => {
        var userId = document.querySelector("#id").value;

        if (isEmpty(userId)) {
             alert("아이디를 입력해주세요.");
        } else {

        httpRequest = new XMLHttpRequest();
        httpRequest.onreadystatechange = () => {
            if (httpRequest.readyState === XMLHttpRequest.DONE) {
                  if (httpRequest.status === 200) {
                    var result = httpRequest.response;
                     if (result > 0) {
                      document.querySelector("#idChkAlert > .red").classList.remove('none');
                        // alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
                     } else {
                        document.querySelector("#idChkAlert > .porintColor").classList.remove('none');
                        document.querySelector("#idChkAlert > .red").classList.add('none');
                        // alert("사용 가능한 아이디입니다.");
                        idBox.readOnly = true; // 재수정 불가를 위한 readOnly 활성화
                        idChkBool = true;
                     }
                  } else {
                    alert('Request Error');
                  }
            }
        };
        httpRequest.open('GET', '/idDupChk?' + "userId=" + userId);
        httpRequest.send();
        }
    });

    // 아이디 재설정
    idBox.addEventListener('click', () => {
        if (idChkBool == true) {
            if (confirm("아이디를 재설정하시겠습니까? 아이디 중복 확인을 다시 받으셔야 합니다.")) {
                idChkBool = false;
                document.querySelector("#idChkAlert > .porintColor").classList.add('none');
                idBox.value = "";
                idBox.readOnly = false;
                idBox.focus;
            }
       }
     });

    // PW 유효성 컨트롤: 패스워드 일치 여부 체크
    pwChkBtn.addEventListener('click', () => {
        if ( !pw.value && !pwChk.value ) {
            pwChkBool = false;
            alert("패스워드를 입력하세요.");
        } else if( pw.value === pwChk.value ) {
            pwChkBool = true;
            document.querySelector("#pwChkAlert > .porintColor").classList.remove('none');
            document.querySelector("#pwChkAlert > .red").classList.add('none');
            pwBox.readOnly = true;
            pwChkBox.readOnly = true;
        } else {
          pwChkBool = false;
          document.querySelector("#pwChkAlert > .red").classList.remove('none');
        }
    });

    // 비밀번호 수정 유효성 체크
   upd_pwChkBtn.addEventListener('click', () => {
        if ( !upd_pw.value && !upd_pwChk.value ) {
            upd_pwChkBool = false;
            alert("패스워드를 입력하세요.");
        } else if( upd_pw.value === upd_pwChk.value ) {
            upd_pwChkBool = true;
            document.querySelector("#upd_pwChkAlert > .porintColor").classList.remove('none');
            document.querySelector("#upd_pwChkAlert > .red").classList.add('none');
            updPwBox.readOnly = true;
            updPwChkBox.readOnly = true;
        } else {
          upd_pwChkBool = false;
          document.querySelector("#upd_pwChkAlert > .red").classList.remove('none');
        }
    });


    // 비밀번호 재설정
    updPwBox.addEventListener('click', () => {
        if (upd_pwChkBool == true) {
            if (confirm("비밀번호를 재설정하시겠습니까? 패스워드 확인을 다시 받으셔야 합니다.")) {
                upd_pwChkBool = false;
                updPwBox.value = "";
                updPwBox.readOnly = false;
                updPwChkBox.value = "";
                updPwChkBox.readOnly = false;
                updPwBox.focus;
                document.querySelector("#upd_pwChkAlert > .porintColor").classList.add('none');
            }
       }
     });


    pwModBtn.addEventListener('click', () => {
        updPwBox.disabled = false;
        updPwChkBox.disabled = false;
    })


    // 회원 가입 버튼 유효성 컨트롤: stateHandler
    signupBtn.addEventListener('click', () => {
      if (checkAll()) {
        alert("유효성 테스트 통과");
        emailValid();
      } else {
        alert("유효성 테스트 미통과");
        event.preventDefault();
      }
    });

    // 전체 유효성 체크
    function checkAll() {
        if(idChkBool && pwChkBool) {
           return true;
        }else {
           return false;
        }
    }

    // 이메일 인증
    function emailValid() {
        var email_Id = document.getElementById('id').value;

        $.ajax({
            data:{"email_Id":email_Id},
            type:"GET",
            url:"/authMailSend",
            success:function(data) {
                document.getElementById('reg_form').submit();
            },
            error:function(request, status, error) {
                alert("실패");
            }
        })
    }

}


function login() {
    document.querySelector('#loginBox').classList.remove('none');
    document.querySelector('#joinBox').classList.add('none');
    document.querySelector('#userUpdBox').classList.add('none');
}

function signUp() {
    document.querySelector('#signUpBox').classList.remove('none');
    document.querySelector('#joinBox').classList.add('none');
    document.querySelector('#loginBox').classList.add('none');
    document.querySelector('#userUpdBox').classList.add('none');
}

function userUpd() {
    document.querySelector('#userUpdBox').classList.remove('none');
    document.querySelector('#bar-chk').checked = false;
    $dim();
}

function memPopUpClose() {
    document.querySelector('#signUpBox').classList.add('none');
    document.querySelector('#loginBox').classList.add('none');
    document.querySelector('#userUpdBox').classList.add('none');
    $dim(false);
    location.reload();
}

function userUpdCmn() {
    document.querySelector('#userUpdBox').classList.add('none');
    $dim(false);
    document.getElementById('upd_form').submit();
}

