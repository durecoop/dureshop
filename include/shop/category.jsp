<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
/* =====================================================
   카테고리 메뉴 스타일 - Premium Compact v3.1
   - 1열 컴팩트 레이아웃 (높이 축소)
   - 고급스러운 호버 효과
   ===================================================== */

/* 카테고리 버튼 위치 기준점 */
.li_btn_all_menu {
    position: relative !important;
}

/* 전체 메뉴 컨테이너 */
div.all_menu_wrap {
    display: none;
    position: absolute !important;
    top: 52px !important;
    left: 0 !important;
    background: linear-gradient(180deg, #ffffff 0%, #fafbfa 100%) !important;
    box-shadow: 0 10px 40px rgba(0,0,0,0.12), 0 2px 10px rgba(0,0,0,0.08) !important;
    border-radius: 0 0 16px 16px !important;
    z-index: 999999 !important;
    width: auto !important;
    height: auto !important;
    max-height: none !important;
    overflow: visible !important;
    margin-top: 0 !important;
    border-top: 3px solid #3D6041 !important;
}

/* 메뉴 내부 레이아웃 */
div.all_menu_wrap div.menu_inner {
    display: flex !important;
    flex-direction: row !important;
    position: relative !important;
    padding: 0 !important;
    height: auto !important;
    max-height: none !important;
    overflow: visible !important;
}

/* 첫 번째 열 - 1열 컴팩트 */
div.all_menu_wrap div.menu_area {
    display: block !important;
    padding: 12px 10px !important;
    border-right: 1px solid #eef2ee !important;
    min-width: 190px !important;
    background: transparent !important;
    position: relative !important;
    height: auto !important;
    overflow: visible !important;
}

div.all_menu_wrap div.menu_area:last-child {
    border-right: none !important;
    min-width: 180px !important;
    padding: 12px 10px !important;
    background: linear-gradient(180deg, #f8faf8 0%, #f0f4f0 100%) !important;
    border-radius: 0 0 16px 0 !important;
}

/* 대분류 아이템 래퍼 */
div.all_menu_wrap div.menu_1dep_wrap {
    margin: 0 !important;
    padding: 0 !important;
    position: static !important;
    overflow: visible !important;
}

/* 대분류 그룹 구분선 */
div.all_menu_wrap div.menu_area:first-child div.menu_1dep_wrap:nth-child(5) {
    margin-bottom: 6px !important;
    padding-bottom: 6px !important;
    border-bottom: 1px solid #e8ece8 !important;
}

div.all_menu_wrap div.menu_area:first-child div.menu_1dep_wrap:nth-child(11) {
    margin-bottom: 6px !important;
    padding-bottom: 6px !important;
    border-bottom: 1px solid #e8ece8 !important;
}

div.all_menu_wrap div.menu_area:nth-child(2) div.menu_1dep_wrap:nth-child(4) {
    margin-bottom: 6px !important;
    padding-bottom: 6px !important;
    border-bottom: 1px solid rgba(61, 96, 65, 0.15) !important;
}

/* =====================================================
   대분류 아이템 - 컴팩트 + 고급스러운 디자인
   ===================================================== */
div.all_menu_wrap div.menu_1dep {
    display: flex !important;
    align-items: center !important;
    padding: 9px 12px !important;
    font-family: 'Noto Sans KR', sans-serif !important;
    font-size: 14px !important;
    font-weight: 600 !important;
    color: #2d4a31 !important;
    cursor: pointer !important;
    border-radius: 8px !important;
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
    white-space: nowrap !important;
    line-height: 1.3 !important;
    letter-spacing: -0.02em !important;
    background: transparent !important;
    position: relative !important;
}

div.all_menu_wrap div.menu_1dep:hover,
div.all_menu_wrap div.menu_1dep_wrap.active div.menu_1dep {
    background: linear-gradient(135deg, #e8f2e8 0%, #ddeedd 100%) !important;
    color: #1a3a1d !important;
    box-shadow: 0 3px 10px rgba(61, 96, 65, 0.12) !important;
}

/* 대분류 아이콘 */
div.all_menu_wrap div.menu_1dep img {
    width: 22px !important;
    height: 22px !important;
    margin-right: 9px !important;
    flex-shrink: 0 !important;
    transition: transform 0.2s ease !important;
}

div.all_menu_wrap div.menu_1dep:hover img {
    transform: scale(1.08) !important;
}

/* 화살표 표시 (중분류 있는 항목) */
div.all_menu_wrap div.menu_area:first-child div.menu_1dep::after {
    content: "" !important;
    position: absolute !important;
    right: 10px !important;
    width: 5px !important;
    height: 5px !important;
    border-right: 1.5px solid #9cb89e !important;
    border-bottom: 1.5px solid #9cb89e !important;
    transform: rotate(-45deg) !important;
    transition: all 0.2s ease !important;
    opacity: 0.5 !important;
}

div.all_menu_wrap div.menu_1dep:hover::after,
div.all_menu_wrap div.menu_1dep_wrap.active div.menu_1dep::after {
    border-color: #3D6041 !important;
    opacity: 1 !important;
    right: 8px !important;
}

/* 두 번째 열 (기획전) 스타일 */
div.all_menu_wrap div.menu_area:nth-child(2) div.menu_1dep {
    color: #5a4a32 !important;
    font-size: 13px !important;
    padding: 8px 10px !important;
}

div.all_menu_wrap div.menu_area:nth-child(2) div.menu_1dep::after {
    display: none !important;
}

div.all_menu_wrap div.menu_area:nth-child(2) div.menu_1dep:hover {
    background: linear-gradient(135deg, #f5f0e8 0%, #ebe4d8 100%) !important;
    color: #4a3a22 !important;
    box-shadow: 0 3px 10px rgba(90, 74, 50, 0.1) !important;
}

div.all_menu_wrap div.menu_area:nth-child(2) div.menu_1dep img {
    width: 20px !important;
    height: 20px !important;
}

/* 두 번째 열 헤더 */
div.all_menu_wrap div.menu_area:nth-child(2)::before {
    content: "기획전" !important;
    display: block !important;
    font-family: 'Noto Sans KR', sans-serif !important;
    font-size: 10px !important;
    font-weight: 700 !important;
    color: #3D6041 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.1em !important;
    padding: 0 10px 8px !important;
    margin-bottom: 4px !important;
    border-bottom: 1px solid rgba(61, 96, 65, 0.15) !important;
}

/* =====================================================
   중분류 패널 스타일 - 대분류와 동일한 컴팩트 사이즈
   ===================================================== */
div.all_menu_wrap div.menu_2dep_wrap {
    display: none;
    position: fixed !important;
    background: #ffffff !important;
    border: none !important;
    border-left: 3px solid #3D6041 !important;
    padding: 8px 6px !important;
    min-width: 160px !important;
    z-index: 9999999 !important;
    box-shadow: 6px 6px 20px rgba(0,0,0,0.12), 0 0 0 1px rgba(0,0,0,0.04) !important;
    border-radius: 0 10px 10px 0 !important;
    height: auto !important;
    max-height: none !important;
    overflow: visible !important;
}

/* 중분류 링크 - 대분류와 동일한 크기 */
div.all_menu_wrap div.menu_2dep_wrap > a {
    display: flex !important;
    align-items: center !important;
    min-height: auto !important;
    padding: 7px 10px !important;
    font-family: 'Noto Sans KR', sans-serif !important;
    font-size: 13px !important;
    font-weight: 500 !important;
    line-height: 1.2 !important;
    color: #444 !important;
    background: #fff !important;
    border-radius: 6px !important;
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
    white-space: nowrap !important;
    text-decoration: none !important;
    cursor: pointer !important;
    margin: 0 !important;
    letter-spacing: -0.01em !important;
    gap: 6px !important;
}

/* 중분류 앞 도트 */
div.all_menu_wrap div.menu_2dep_wrap > a::before {
    content: "" !important;
    display: inline-block !important;
    width: 4px !important;
    height: 4px !important;
    background: #3D6041 !important;
    border-radius: 50% !important;
    flex-shrink: 0 !important;
    opacity: 0.4 !important;
    transition: all 0.2s ease !important;
}

div.all_menu_wrap div.menu_2dep_wrap > a:hover {
    background: linear-gradient(135deg, #f0f7ed 0%, #e8f2e4 100%) !important;
    color: #2d4a31 !important;
    padding-left: 12px !important;
}

div.all_menu_wrap div.menu_2dep_wrap > a:hover::before {
    width: 5px !important;
    height: 5px !important;
    opacity: 1 !important;
}

/* 빈 중분류 숨김 */
div.all_menu_wrap div.menu_2dep_wrap > a:empty {
    display: none !important;
}

div.all_menu_wrap div.menu_2dep_wrap > a:empty::before {
    display: none !important;
}
</style>

<div class="all_menu_wrap">
	<div class="menu_inner">
		<div class="menu_area">
			<div class="menu_1dep_wrap" data-category="10">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '10', '쌀/잡곡');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img1.svg' />" alt="쌀/잡곡">쌀/잡곡</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '10'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '10', '쌀/잡곡', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="20">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '20', '채소/과일');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img2.svg' />" alt="채소/과일">채소/과일</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '20'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '20', '채소/과일', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="31">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '31', '정육');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img3.svg' />" alt="정육">정육</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '31'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '31', '정육', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="32">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '32', '계란');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img4.svg' />" alt="계란">계란</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '32'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '32', '계란', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="33">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '33', '수산물');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img5.svg' />" alt="수산물">수산물</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '33'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '33', '수산물', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="41">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '41', '양념/장류/오일');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img6.svg' />" alt="양념/장류/오일">양념/장류/오일</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '41'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '41', '양념/장류/오일', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="42">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '42', '면/건어물/가공식품');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img7.svg' />" alt="면/건어물/가공식품">면/건어물/가공식품</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '42'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '42', '면/건어물/가공식품', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="46">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '46', '냉장/냉동/간편식');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img8.svg' />" alt="냉장/냉동/간편식">냉장/냉동/간편식</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '46'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '46', '냉장/냉동/간편식', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="45">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '45', '건강식품/꿀');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img9.svg' />" alt="건강식품/꿀">건강식품/꿀</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '45'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '45', '건강식품/꿀', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="44">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '44', '음료/차/유제품');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img10.svg' />" alt="음료/차/유제품">음료/차/유제품</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '44'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '44', '음료/차/유제품', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="43">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '43', '간식');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img11.svg' />" alt="간식">간식</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '43'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '43', '간식', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="50">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '50', '생활용품');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img12.svg' />" alt="생활용품">생활용품</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '50'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '50', '생활용품', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="51">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '51', '화장품/바디/헤어');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img13.svg' />" alt="화장품/바디/헤어">화장품/바디/헤어</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '51'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '51', '화장품/바디/헤어', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="70">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '70', '반려동물');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img14.svg' />" alt="반려동물">반려동물</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '70'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '70', '반려동물', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="menu_1dep_wrap" data-category="60">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '60', '공정무역');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img16.svg' />" alt="공정무역">공정무역</div>
				<div class="menu_2dep_wrap">
					<c:if test="${fn:length(mainCategory2) > 0}" >
						<c:forEach var="cateSub" items="${mainCategory2}">
							<c:if test="${cateSub.firstCd eq '60'}">
								<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', '60', '공정무역', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<c:if test="${sessionLoginVO.guestClassCd eq '05'}">
				<div class="menu_1dep_wrap" data-category="A5">
					<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', 'A5', '어린이집');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img15.svg' />" alt="어린이집">어린이집</div>
					<div class="menu_2dep_wrap">
						<c:if test="${fn:length(mainCategory2) > 0}" >
							<c:forEach var="cateSub" items="${mainCategory2}">
								<c:if test="${cateSub.firstCd eq 'A5'}">
									<a href="javascript:void(0);" onclick="goPageLocation('N', 'prod/goodsList.do', 'goods', 'A5', '어린이집', '', '${cateSub.secondCd}');">${cateSub.secondNm}</a>
								</c:if>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</c:if>
		</div>
		<div class="menu_area menu_area_second">
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'curator', '1', '공정무역(민중교역)');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img16.svg' />" alt="공정무역(민중교역)">공정무역(민중교역)</div>
			</div>
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'curator', '2', '채식생활');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img17.svg' />" alt="채식생활">채식생활</div>
			</div>
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'curator', '3', '영유아');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img18.svg' />" alt="영유아">영유아</div>
			</div>
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goPageLocation('N', 'prod/goodsList.do', 'curator', '4', '가정간편식');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img19.svg' />" alt="가정간편식">가정간편식</div>
			</div>
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goLocationPage('/reservation.do');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img20.svg' />" alt="사전예약">사전예약</div>
			</div>
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goLocationPage('/sanjii.do');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img21.svg' />" alt="산지직송">산지직송</div>
			</div>
			<div class="menu_1dep_wrap">
				<div class="menu_1dep" onclick="goLocationPage('/matchan.do');"><img src="<c:url value='/images/${mobile}/icon_all_menu_img21.svg' />" alt="두레 맛찬">두레 맛찬</div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){

	// 전체 메뉴 이탈 시 닫기
	$('.all_menu_wrap').on('mouseleave', function(){
		$('.menu_2dep_wrap').hide();
		$('.menu_1dep_wrap').removeClass('active');
		$(this).hide();
	});

	// 첫 번째 열의 대분류만 중분류 표시 (두 번째 열 제외)
	$('.all_menu_wrap .menu_area:first-child .menu_1dep_wrap').on('mouseenter', function(e){
		e.stopPropagation();

		var $this = $(this);
		var $subMenu = $this.find('.menu_2dep_wrap');

		// 모든 중분류 숨기기 & 활성 상태 제거
		$('.menu_2dep_wrap').hide();
		$('.menu_1dep_wrap').removeClass('active');

		// 중분류에 실제 항목이 있는지 확인
		var hasItems = $subMenu.find('a').filter(function(){
			return $.trim($(this).text()) !== '';
		}).length > 0;

		if(hasItems){
			// 첫 번째 열(menu_area)의 오른쪽에 중분류 표시
			var $menuArea = $this.closest('.menu_area');
			var menuAreaOffset = $menuArea.offset();
			var menuAreaWidth = $menuArea.outerWidth();
			var itemOffset = $this.offset();

			// 중분류를 첫 번째 열 바로 오른쪽에 표시
			$subMenu.css({
				'position': 'fixed',
				'left': (menuAreaOffset.left + menuAreaWidth) + 'px',
				'top': itemOffset.top + 'px',
				'display': 'block',
				'z-index': '9999999'
			});

			$this.addClass('active');
		}
	});
	
	// 대분류에서 마우스 나갈 때
	$('.all_menu_wrap .menu_area:first-child .menu_1dep_wrap').on('mouseleave', function(e){
		var $this = $(this);
		var $subMenu = $this.find('.menu_2dep_wrap');
		var relatedTarget = e.relatedTarget;
		
		// 중분류 패널로 이동하는 경우가 아니면 숨기기
		if(!$(relatedTarget).closest('.menu_2dep_wrap').length){
			setTimeout(function(){
				if(!$subMenu.is(':hover')){
					$subMenu.hide();
					$this.removeClass('active');
				}
			}, 100);
		}
	});
	
	// 중분류에서 마우스 나갈 때
	$('.menu_2dep_wrap').on('mouseleave', function(e){
		var relatedTarget = e.relatedTarget;
		// 대분류로 돌아가는 경우가 아니면 숨기기
		if(!$(relatedTarget).closest('.menu_1dep_wrap').length){
			$(this).hide();
			$('.menu_1dep_wrap').removeClass('active');
		}
	});
	
	// 두 번째 열은 중분류 이벤트 없음 (클릭만 동작)
	$('.menu_area_second .menu_1dep_wrap').off('mouseenter mouseleave');
	
});
</script>
