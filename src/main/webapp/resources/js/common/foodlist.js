let x, y, companyLength, localCheck, marker;
let createDiv = document.createElement('div');
let createDivBefore = document.querySelector('.button-wrap');
let pageDiv = document.querySelector('#page');
let name, infoTitle;

let totalCount;
let dataPerPage = 5;
let currentPage;
let startRow;
let endRow;
let pageBlock = 5;
let startPage;
let endPage;
let totalPage;

/*
    맛집 페이지 로드 시 회사 데이터 표시
*/
window.addEventListener('DOMContentLoaded', function(){
    fetch("/companyList")
        .then(response => response.json())
        .catch(error => console.log('Error'))
        .then(companyList => {
            for (let i=0; i<companyList.company.length; i++) {
                createDiv.innerHTML
                    += "<div id='list' class='board-line'>"
                    + "<div style='width:300px;' class='board-cell board-category purple2'>"
                    + companyList.company[i].location+"</div>"
                    + "<div onclick='selectFoodLocal(&quot;" + companyList.company[i].location+ "&quot;,&quot;" + companyList.company[i].companyLoc+ "&quot;,&quot;" + companyList.company[i].id+ "&quot;,&quot;type1&quot;,&quot;" + companyList.company[i].companyName+ "&quot;)' class='board-cell board-title'>"
                    + companyList.company[i].companyName+"</div>"
                    + "<div class='board-cell board-map purple'><span class='material-icons'>map</span>"
                    + companyList.company[i].matzipCount+"</div>"
                    + "<div class='board-cell' style='width:50px;'>" + "<button class='material-icons-outlined purple' onclick='roadView(&quot;" + companyList.company[i].companyLoc + "&quot;)'>visibility</button>" + "<div></div>";
            }
            createDivBefore.insertAdjacentElement('beforebegin', createDiv);
        });
});

/*
    로드뷰 클릭시 지역 좌표 변환
*/
function roadView(local) {
    fetch("/lateChange?"+"local="+local)
        .then(response => response.json())
        .catch(error => console.log('Error'))
        .then(late => {
            let lateRst = JSON.parse(late.local.toString().replace(/&quot;/g, '"'));
            x = lateRst.documents[0].x;
            y = lateRst.documents[0].y;

            setRoadView(x, y);
        })
}

/*
    카테고리 선택
*/
function categorySelect(target) {

    removeAllChild(pageDiv);

    if (target.value != "none") {
        let option = target.options[target.selectedIndex].text;

        fetch("/categorySelect?"+"option="+option)
            .then(response => response.json())
            .catch(error => console.log('Error'))
            .then(categoryList => {
                let changeText = document.getElementById('changeText')
                changeText.innerText = "맛집";

                let companyArray = Array.from(document.querySelectorAll('#list'));
                for (let i=0; i<companyArray.length; i++) {
                    companyArray[i].remove();
                }
                for (let i=0; i<categoryList.company.length; i++) {
                    createDiv.innerHTML
                        += "<div id='list' class='board-line'><div style='width:300px;' class='board-cell board-category purple2'>"
                        + categoryList.company[i].location+"</div>"
                        + "<div onclick='selectFoodLocal(&quot;" + categoryList.company[i].location+ "&quot;,&quot;" + categoryList.company[i].companyLoc+ "&quot;,&quot;" + categoryList.company[i].id+ "&quot;,&quot;type1&quot;,&quot;" + categoryList.company[i].companyName+ "&quot;)' class='board-cell board-title'>"
                        + categoryList.company[i].companyName+"</div>"
                        + "<div class='board-cell board-map purple'><span class='material-icons'>map</span>"
                        + categoryList.company[i].matzipCount+"</div>"
                        + "<div class='board-cell' style='width:50px;'>" + "<button class='material-icons-outlined purple' onclick='roadView(&quot;" + categoryList.company[i].companyLoc + "&quot;)'>visibility</button>" + "<div></div>";
                }
                createDivBefore.insertAdjacentElement('beforebegin', createDiv);

            });
    }
}

/*
    맛집 위치 표시
*/
function matzipLoc(location, currentPage) {

    removeAllChild(pageDiv);

    if (currentPage==null) {
        currentPage=1;
    }

    let companyArray = Array.from(document.querySelectorAll('#list'));
    for (let i=0; i<companyArray.length; i++) {
        companyArray[i].remove();
    }

    setPageRow(currentPage, dataPerPage);

    fetch("/foodList", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            location: location,
            startRow : startRow,
            dataPerPage : dataPerPage,
        })
    })
        .then(response => response.json())
        .catch(error => console.log('Error'))
        .then(matzipList => {
            if (matzipList.matzip.length==0) {
                createDiv.innerHTML
                    += "<div id='list' class='board-line' style='height:50px;justify-content:center;align-items:center;';>"
                    + "등록된 맛집이 없습니다."
                    + "</div>";
            }
            for (let i=0;i<matzipList.matzip.length; i++) {
                createDiv.innerHTML
                    += "<div id='list' class='board-line'><div style='width:300px;' class='board-cell board-category purple2'>"
                    + matzipList.matzip[i].location+"</div>"
                    + "<div onclick='selectFoodLocal(&quot;" + matzipList.matzip[i].location+ "&quot;,&quot;" + matzipList.matzip[i].companyLoc+ "&quot;,&quot;" + matzipList.matzip[i].id+ "&quot;,&quot;type2&quot;,&quot;" + matzipList.matzip[i].companyName+ "&quot;)' class='board-cell board-title'>"
                    + matzipList.matzip[i].companyName+"</div>"
                    + "<div class='board-cell board-map purple'><span class='material-icons'>map</span>"
                    + matzipList.matzip[i].matzipCount+"</div>"
                    + "<div class='board-cell' style='width:50px;'>" + "<button class='material-icons-outlined purple' onclick='roadView(&quot;" + matzipList.matzip[i].companyLoc + "&quot;)'>visibility</button>" + "<div></div>";

            }
            createDivBefore.insertAdjacentElement('beforebegin', createDiv);

            fetch("/dataCount?"+"location="+location)
                .then(response => response.json())
                .catch(error => console.log('Error'))
                .then(totalCount => {
                    setTotalPage(totalCount, dataPerPage);
                    setPageBlock(currentPage, pageBlock)

                    if (endPage<totalPage) {
                        if (startPage!=1) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML = "《";
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, 1);
                            }
                        }

                        if (startPage>1) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML = "〈";
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, startPage-parseInt(1));
                            }
                        }

                        for (let i=startPage; i<=endPage; i++) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML += i;
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, this.innerHTML);
                            }
                        }

                        if (endPage<totalPage) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML = "〉";
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, endPage+parseInt(1));
                            }
                        }
                        if (endPage<totalPage) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML = "》";
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, totalPage);
                            }
                        }
                    } else if (endPage>=totalPage) {
                        if (startPage!=1) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML = "《";
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, 1);
                            }
                        }

                        if (startPage>1) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML = "〈";
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, startPage-parseInt(1));
                            }
                        }

                        for (let i=startPage; i<=totalPage; i++) {
                            creBtn = document.createElement('button');
                            creBtn.innerHTML += i;
                            creBtn.classList.add('btn-wrap');
                            pageDiv.append(creBtn);
                            creBtn.onclick = function() {
                                matzipLoc(location, this.innerHTML);
                            }
                        }
                    }

                })

        })
}

function removeAllChild(pageDiv) {
    while (pageDiv.hasChildNodes()) {
        pageDiv.removeChild(pageDiv.firstChild);
    }
}

function setPageRow(currentPage, dataPerPage) {
    startRow = (Math.floor(currentPage - 1)*dataPerPage) + 1;
    endRow = currentPage * dataPerPage;
}

function setTotalPage(totalCount, dataPerPage) {
    totalPage = Math.floor(totalCount/dataPerPage + (totalCount%dataPerPage==0 ? 0 : 1));
}

function setPageBlock(currentPage, pageBlock) {
    startPage = Math.floor((currentPage-1)/pageBlock) * pageBlock + 1
    endPage = startPage + pageBlock - 1;
}

function selectFoodLocal(location, local, id, type, companyName) {
    name = companyName;
    localExistCheck(id);

    let changeText = document.getElementById('changeText')
    changeText.innerText = "추천수";

    fetch("/lateChange?"+"local="+local)
        .then(response => response.json())
        .catch(error => console.log('Error'))
        .then(late => {
            let lateRst = JSON.parse(late.local.toString().replace(/&quot;/g, '"'));
            x = lateRst.documents[0].x;
            y = lateRst.documents[0].y;

            panTo(lateRst.documents[0].address_name);
        })
    if (type === 'type1') {
        matzipLoc(location, currentPage);
    }
}

var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(37.37947804818484, 127.11415037150388),
        level: 3,
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

/*
    마커 체크
*/
function panTo(loc) {
    var moveLatLon = new kakao.maps.LatLng(y, x);
    map.panTo(moveLatLon);
    localCheckPoint(loc);
}


/*
    상세 맛집 이동
*/
function localCheckPoint(loc) {
    var markerPosition = new kakao.maps.LatLng(y, x);

    marker = new kakao.maps.Marker({
        position: markerPosition,
        clickable: true
    });

    marker.setMap(map);

    kakao.maps.event.addListener(marker, 'click', function() {
        if (localCheck==1) {
            fetch("/matzipDetailId?"+"loc="+loc)
                .then(response => response.json())
                .catch(error => console.log('Error'))
                .then(matzipId => {
                    if (typeof matzipId != 'number') {
                        return;
                    } else {
                        let url = "http://localhost:8080/matzip?id="+matzipId;
                        location.href = url;
                    }
                });
        }
    });

    var iwContent = '<div class="info-title" style="padding:5px;">'+name+'</div>';

    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent
    });

    kakao.maps.event.addListener(marker, 'mouseover', function() {
        marker = new kakao.maps.Marker({
            position: markerPosition,
            clickable: true
        });

        infowindow.open(map, marker);

        infoTitle = document.querySelectorAll('.info-title');
        infoTitle.forEach(function(e) {
            var w = e.offsetWidth + 10;
            var ml = w/2;
            e.parentElement.style.top = "82px";
            e.parentElement.style.left = "50%";
            e.parentElement.style.marginLeft = -ml+"px";
            e.parentElement.style.width = w+"px";
            e.parentElement.previousSibling.style.display = "none";
            e.parentElement.parentElement.style.border = "0px";
            e.parentElement.parentElement.style.background = "unset";
        });
    });

    kakao.maps.event.addListener(marker, 'mouseout', function() {
        infowindow.close();
    });
}

/*
    로드뷰 표시
*/
function setRoadView(x, y) {
    let roadviewContainer = document.getElementById('roadview');
    let roadview = new kakao.maps.Roadview(roadviewContainer);
    let roadviewClient = new kakao.maps.RoadviewClient();

    let position = new kakao.maps.LatLng(y, x);

    roadviewClient.getNearestPanoId(position, 50, function(panoId) {
        if (panoId==null) {
            commonPopup.alertPopup("해당 지역의 로드뷰를 볼 수 없습니다!", false);
        } else {
            let closeBtn = document.querySelector('#road-close-btn');

            document.querySelector('#roadViewPopup').classList.remove('none');
            commonPopup.modalPopupCheck(true);

            closeBtn.addEventListener('click', function() {
                commonPopup.close();
                commonPopup.modalPopupCheck(false);
            });

            roadview.setPanoId(panoId, position);
        }
    });
}

function localExistCheck(id) {
    fetch("/matzipCheck?"+"id="+id)
        .then(response => response.json())
        .catch(error => console.log('Error'))
        .then(existCheck => {
            localCheck = existCheck;
        });
}
















