<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
/* 퀵메뉴 토글 버튼 */
.quick_wrap {
	position: fixed !important;
	right: 0 !important;
	top: 50% !important;
	transform: translateY(-50%) !important;
	z-index: 100 !important;
	display: flex !important;
	flex-direction: row !important;
	align-items: stretch !important;
}

.quick_wrap .quick_toggle_btn {
	display: flex !important;
	align-items: center;
	justify-content: center;
	width: 24px;
	min-width: 24px;
	background: #3D6041;
	border: none;
	border-radius: 8px 0 0 8px;
	cursor: pointer;
	padding: 20px 0;
	transition: background 0.2s ease;
	z-index: 101;
	order: -1 !important;
	flex-shrink: 0;
}

.quick_wrap .quick_toggle_btn:hover {
	background: #2d4a31;
}

.quick_wrap .quick_toggle_btn .arrow {
	color: #fff;
	font-size: 14px;
}

/* 기본: 열기 화살표(◀) 표시, 닫기 화살표(▶) 숨김 */
.quick_wrap .quick_toggle_btn .arrow_open {
	display: inline !important;
}
.quick_wrap .quick_toggle_btn .arrow_close {
	display: none !important;
}

/* 확장 시: 열기 화살표 숨김, 닫기 화살표(▶) 표시 */
.quick_wrap.expanded .quick_toggle_btn .arrow_open {
	display: none !important;
}
.quick_wrap.expanded .quick_toggle_btn .arrow_close {
	display: inline !important;
}

/* 기본 상태 - 화살표만 보임 */
.quick_wrap .type1_wrap {
	display: none !important;
	flex-direction: column;
	background: #3D6041;
	border-radius: 0;
	padding: 15px 10px;
	transition: all 0.3s ease;
	order: 1 !important;
}

/* 확장 상태 - 아이콘 메뉴 표시 */
.quick_wrap.expanded .type1_wrap {
	display: flex !important;
}

/* type2는 사용 안함 */
.quick_wrap .type2_wrap {
	display: none !important;
}

/* 기존 버튼 숨김 */
.quick_wrap .btn_quick_on,
.quick_wrap .btn_quick_off {
	display: none !important;
}
</style>

<div class="quick_wrap">
	<!-- 토글 버튼 -->
	<button type="button" class="quick_toggle_btn" onclick="toggleQuickMenu();">
		<span class="arrow arrow_open">◀</span>
		<span class="arrow arrow_close">▶</span>
	</button>

	<!-- 축소 상태 (아이콘만) -->
	<div class="type1_wrap">
		<div class="con_box">
			<c:choose>
	      		<c:when test="${sessionLoginVO eq null}">
					<a href="<c:url value='/login/login.do' />" class="login"><i class="icon"></i><p>로그인</p></a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0);" class="login" onclick="goLogoutSubmit();"><i class="icon"></i><p>로그아웃</p></a>
					<a href="javascript:void(0);" class="cart" onclick="goPageSubmit('Y', 'cart/cart.do');"><i class="icon"><span class="num roboto" id="id_basket_quick">0</span></i><p>장바구니</p></a>
				</c:otherwise>
			</c:choose>
			<a href="javascript:void(0);" class="favorite" onclick="goPageSubmit('Y', 'my/myGoods.do' , 'A');"><i class="icon"></i><p>관심생활재</p></a>
			<c:set var="goodsQuickYn" value="N" />
			<c:choose>
	      		<c:when test="${sessionLoginVO eq null}">
					<c:choose>
			      		<c:when test="${fn:indexOf(sysCurrentUrl, '/prod/goodsView.do') > 0}">
							<c:set var="goodsQuickYn" value="Y" />
							<c:set var="goodsGb" value="${returnTypeGb}" />
							<c:set var="goodsNo" value="${returnNo}" />
							<c:set var="planNo" value="${returnPlanNo}" />
							<c:set var="goodsImg" value="${returnGoodsImg}" />
						</c:when>
			      		<c:otherwise>
							<c:if test="${fn:length(resultCookie) > 0 and (resultCookie ne '[]' or resultCookie ne '')}">
								<c:set var="goodsQuickYn" value="Y" />
								<c:set var="goodsGb" value="${fn:split(resultCookie,'|')[0]}" />
								<c:set var="goodsNo" value="${fn:split(resultCookie,'|')[1]}" />
								<c:set var="planNo" value="${fn:split(resultCookie,'|')[2]}" />
								<c:set var="goodsImg" value="${fn:split(resultCookie,'|')[3]}" />
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${goodsQuickYn eq 'Y'}">
						<a href="javascript:void(0);" class="new" onclick="moveProdDetail('${goodsGb}','${goodsNo}','${planNo}');">
							<img onerror="this.src='<c:url value='/images/comm/GoodsNoImage.jpg' />'" src="${sysErpGoodsUrl}/${goodsImg}" alt="" />
						</a>
						<p>최근 본</p>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${fn:length(goodsQuickList) > 0}">
						<c:forEach var="goodsList" items="${goodsQuickList}" varStatus="status">
							<c:if test="${status.index == 0}">
								<a href="javascript:void(0);" class="new" onclick="moveProdDetail('${goodsList.goodsGb}','${goodsList.goodsNo}','${goodsList.planNo}');">
									<img onerror="this.src='<c:url value='/images/comm/GoodsNoImage.jpg' />'" src="${sysErpGoodsUrl}/${goodsList.goodsImg}" alt="" />
								</a>
								<p>최근 본</p>
							</c:if>
						</c:forEach>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
		<a href="javascript:go_top();" class="btn_top"><img src="<c:url value='/images/${mobile}/icon_quick_top.svg' />" alt=""><p>TOP</p></a>
	</div>

	<!-- 확장 상태 (상세 정보) -->
	<div class="type2_wrap">
		<div class="user">
			<c:choose>
	      		<c:when test="${sessionLoginVO eq null}">
					<a href="<c:url value='/login/login.do' />" class="logout">로그인</a>
				</c:when>
				<c:otherwise>
					<div class="login">안녕하세요.<br/><c:out value="${sessionLoginVO.guestNm}" />님</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="con_box">
			<c:if test="${sessionLoginVO ne null}">
				<div class="login">
					<div class="tt"><i class="icon"></i>배송일</div>
					<div class="g_box">
						<p class="b_txt"><c:out value="${sessionLoginVO.propNm}" /></p>
						<p class="s_txt">
							<c:choose>
					      		<c:when test="${sessionLoginVO.deliveryDate eq '' or sessionLoginVO.deliveryDate eq null}">
									배송일 선택없음
								</c:when>
								<c:otherwise>
									<c:set var="length" value="${fn:length(sessionLoginVO.deliveryDate)}"/>
									<c:out value="${fn:substring(sessionLoginVO.deliveryDate, length -5, length)}" /> 공급
								</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="link_list">
					<a href="javascript:void(0);" onclick="goPageSubmit('Y', 'cart/cart.do');">장바구니</a>
					<a href="javascript:void(0);" onclick="goPageSubmit('Y', 'my/myGoods.do', 'A');">관심 생활재</a>
					<a href="javascript:void(0);" onclick="goPageSubmit('Y', 'my/myDure.do');">마이 두레</a>
				</div>
			</c:if>
			<div class="new_prod">
				<p class="tt">최근 본</p>
				<div class="prod_list">
					<c:if test="${fn:length(goodsQuickList) > 0}">
						<c:forEach var="goodsList" items="${goodsQuickList}" varStatus="status">
							<a href="javascript:void(0);" onclick="moveProdDetail('${goodsList.goodsGb}','${goodsList.goodsNo}','${goodsList.planNo}');">
								<img onerror="this.src='<c:url value='/images/comm/GoodsNoImage.jpg' />'" src="${sysErpGoodsUrl}/${goodsList.goodsImg}" alt="" />
							</a>
						</c:forEach>
					</c:if>
				</div>
				<a href="javascript:void(0);" class="prod_all" onclick="goPageSubmit('Y', 'my/myGoods.do', 'B');">전체보기</a>
			</div>
		</div>
		<a href="javascript:go_top();" class="btn_top"><img src="<c:url value='/images/${mobile}/icon_quick_top.svg' />" alt=""><p>TOP</p></a>
	</div>
</div>

<script>
	function go_top() {
		$('html, body').stop().animate({ scrollTop : 0 });
	}

	function toggleQuickMenu() {
		$('.quick_wrap').toggleClass('expanded');
	}

	function quick_open(){
		$('.quick_wrap').addClass('expanded');
	}

	function quick_close(){
		$('.quick_wrap').removeClass('expanded');
	}
</script>
