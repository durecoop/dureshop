<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<!-- V2 작업  --최상단 배너 -->
	<c:if test="${fn:length(resultBannerA) > 0}">
		<c:forEach var="resultBan" items="${resultBannerA}" varStatus="status">
			<div class="htop_banner">
				<div class="__inner">
                	<a href="javascript:void(0);" onclick="FnBannerLink('${resultBan.bannerUrl}', '${resultBan.bannerType}', ${resultBan.bannerNo});">
                		<img src="<c:url value='${sysErpImageUrl}/bannerM/${resultBan.bannerImg}'/>" alt="">
                	</a>
					<a href="javascript:htop_banner_off();" class="__btn_close"><img src="<c:url value='/images/${mobile}/btn_close_typebox.svg' />" alt=""></a>
				</div>
			</div>
			<script>
				function htop_banner_off() {
					$('.htop_banner').hide();
				};
			</script>
		</c:forEach>
	</c:if>
	<!-- //V2 작업 --최상단 배너 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/header-custom.css?v=1.7.0">
	<div class="header_wrap">
		<div class="gnb_wrap">
			<div class="inner">
				<c:choose>
		      		<c:when test="${sessionLoginVO eq null}">
						<a href="<c:url value='/login/login.do' />">로그인</a><i class="gv_line"></i>
						<a href="<c:url value='/member/joinStep1.do' />">조합원가입</a><i class="gv_line"></i>
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0);" onclick="goLogoutSubmit();">로그아웃</a><i class="gv_line"></i>
						<a href="javascript:void(0);" onclick="goPageSubmit('Y', 'my/myDure.do');"  class="link_mydure">
							<span>마이두레
								<c:if test="${reviewCnt > 0}">
									<em class="tool">후기 쓰기</em>
								</c:if>
							</span>
						</a>
						<i class="gv_line"></i>
					</c:otherwise>
				</c:choose>
				<a href="<c:url value='/guest/guestCenter.do' />">조합원센터</a>
			</div>
		</div>
		<div class="head_visual">
			<div class="inner">
				<a href="<c:url value='/shopMain.do' />" class="home"><img src="<c:url value='/images/${mobile}/logo_w.svg' />" alt="두레생협"></a>
				<!-- 검색창 (중앙) -->
				<div class="header-search">
					<input type="text" id="searchGoodsKeyword2" name="searchGoodsKeyword" placeholder="검색어를 입력해 주세요">
					<button type="button" onclick="goSearchGoodsKeyword2();"><i class="icon_search"></i></button>
				</div>
				<span id="id_basket_top1" style="display:none;">0</span>
			</div>
		</div>
		<div class="head_menu_wrap">
			<div class="inner">
				<ul class="menu_list">
					<!-- <li><a href="javascript:void(0);" class="btn_all_menu"><i class="icon"></i>전체 생활재 보기</a></li> -->
					<li class="li_btn_all_menu">
						<a href="javascript:void(0);" class="btn_all_menu"><i class="icon"></i>전체 생활재 보기</a>
						<jsp:include page="/include/shop/category.jsp" />
					</li>
					<li><a href="<c:url value='/recommend.do' />" class="recommend<c:if test="${fn:indexOf(sysCurrentUrl, 'recommend.do') > -1}"> on</c:if>">두레추천</a></li>
					<li><a href="<c:url value='/benefit.do' />" class="benefit<c:if test="${fn:indexOf(sysCurrentUrl, 'benefit.do') > -1}"> on</c:if>">더큰혜택</a></li>
					<li><a href="<c:url value='/new.do' />" class="new<c:if test="${fn:indexOf(sysCurrentUrl, 'new.do') > -1}"> on</c:if>">신규생활재</a></li>
					<li><a href="<c:url value='/reservation.do' />" class="reservation<c:if test="${fn:indexOf(sysCurrentUrl, 'reservation.do') > -1}"> on</c:if>">사전예약</a></li>
					<li><a href="<c:url value='/recipe.do' />" class="recipe<c:if test="${fn:indexOf(sysCurrentUrl, 'recipe.do') > -1}"> on</c:if>">요리조리</a></li>
					<li><a href="<c:url value='/story.do' />" class="story<c:if test="${fn:indexOf(sysCurrentUrl, 'story.do') > -1}"> on</c:if>">두레이야기</a></li>
				</ul>
				<!-- 배송일 + 장바구니 (메뉴바 우측) -->
				<div class="menu_right_group">
					<c:if test="${fn:indexOf(sysCurrentUrl, 'orderStep1.do') == -1 and fn:indexOf(sysCurrentUrl, 'orderStep2.do') == -1 and fn:indexOf(sysCurrentUrl, 'deliveryPlace.do') == -1}">
						<a href="javascript:void(0);" class="menu-icon-btn menu-delivery-btn" onclick="FnDeliveryDateOpen();">
							<i class="icon icon-calendar"></i>
							<span class="tooltip">배송일을 입력해 주세요</span>
						</a>
					</c:if>
					<a href="javascript:void(0);" class="menu-icon-btn menu-cart-btn" onclick="goPageSubmit('Y', 'cart/cart.do');">
						<i class="icon icon-cart"></i>
						<span class="num" id="id_basket_top2">0</span>
					</a>
				</div>
				<%-- <div class="search_keyword_wrap" style="z-index:5;">
					<div class="key_list_wrap">
						<c:forEach var="mainTag1" items="${mainSearchTag1}" varStatus="status">
							<c:choose>
								<c:when test="${status.index == 0}">
									<h4 class="title_wrap">${mainTag1.codeNm}</h4>
								</c:when>
								<c:otherwise>
									<h4 class="title_wrap" style="margin-top:20px;">${mainTag1.codeNm}</h4>
								</c:otherwise>
							</c:choose>
							<div class="key_list">
								<c:forEach var="mainTag2" items="${mainSearchTag2}">
									<c:if test="${mainTag1.detailCd eq mainTag2.item1}">
										<div class="keys">
											<a href="javascript:void(0);" class="key" onclick="goPageSubmit('N', '${mainTag2.item5}', 'tag', '${mainTag2.detailCd}', '${mainTag2.codeNm}');">${mainTag2.codeNm}</a>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div> --%>
				<div class="search_keyword_wrap" style="z-index:102;">
					<div class="__inner">
						<c:if test="${sessionLoginVO ne null}">
							<div class="__section rank_wrap my_keyword">
								<div class="rank_title">나의 최근 검색어 <a href="javascript:void(0);" class="stxt" onclick="FnMyKeywordDelete();">전체삭제</a></div>
								<ul class="ranking_list" id="id_myKeyword">
								</ul>
							</div>
							<div class="__section rank_wrap age_keyword">
								<div class="rank_title">연령별 검색어<span class="stxt">(최근 일주일)</span></div>
								<ul class="ranking_list" id="id_myAgeKeyword">
									<c:forEach var="list" items="${myAgeKeyword}" varStatus="status">
										<li>
											<dl class="result">
												<dt>${list.rowNo}</dt>
												<dd>
													<a href="javascript:void(0);" onclick="goSearchMainKeyword('${list.shWord}');">${list.shWord}</a>
												</dd>
											</dl>
										</li>
									</c:forEach>
								</ul>
							</div>
						</c:if>
						<div class="__section rank_wrap md_keyword">
							<div class="rank_title">추천 키워드</div>
							<ul class="ranking_list" id="id_recomKeyword">
								<c:forEach var="list" items="${recomKeyword}" varStatus="status">
									<li><a href="javascript:void(0);" onclick="goSearchMainKeyword('${list.shWord}');">${list.shWord}</a></li>
								</c:forEach>
							</ul>
						</div>
						<div class="__section rank_wrap favorit_keyword">
							<div class="rank_title">인기 검색어<span class="stxt">(최근 일주일)</span></div>
							<ul class="ranking_list" id="id_manyKeyword">
								<c:forEach var="list" items="${manyKeyword}" varStatus="status">
									<li>
										<dl class="result">
											<dt>${list.rowNo}</dt>
											<dd>
												<%-- <a href="javascript:void(0);" onclick="goPageSubmit('N', 'prod/goodsSearchList.do', 'searchMain', '', encodeURIComponent('${list.shWord}'));">${list.shWord}</a> --%>
												<a href="javascript:void(0);" onclick="goSearchMainKeyword('${list.shWord}');">${list.shWord}</a>
											</dd>
										</dl>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include/shop/quick_v2.jsp" />
	<!--- 배송일 / 배송지 --->
	<jsp:include page="/include/shop/delivery_date_v2.jsp" />
	<script>
		setTimeout(function(){
			$('.head_visual .tool').fadeOut();
		}, 10000);

		/* 배송일 툴팁 2초 후 사라짐 */
		setTimeout(function(){
			$('.menu-delivery-btn .tooltip').fadeOut();
		}, 2000);

		$('.search_cart_group .search_wrap, .header-search').click(function(){
			$('.search_keyword_wrap').show();
		});

		$('.search_keyword_wrap').mouseleave(function(){
			$('.search_cart_group .search_wrap input, #searchGoodsKeyword2').focusout();
			$('.search_keyword_wrap').hide();
		});

		/* 메뉴바 고정 */
		$(window).scroll(function () {
			var scroll = $(window).scrollTop();
			var h_top = $('.wrapper').offset().top;
			if(scroll < h_top){
				$('.header_wrap').removeClass('move');
			} else if(scroll > h_top){
				$('.header_wrap').addClass('move');
			}
		});

		$('.btn_all_menu').hover(function(){
			$('.all_menu_wrap').show();
		});

		$('.all_menu_wrap').mouseleave(function(){
			$('.all_menu_wrap').hide();
		});

		$(".search_cart_group .search_wrap input").focus(function(){
			$('.tool').addClass("tool_off");
		});

		/* 장바구니 수량 동기화 */
		function syncCartCount() {
			var count = $('#id_basket_top1').text();
			$('#id_basket_top2').text(count);
		}
		
		syncCartCount();
		
		var cartObserver = new MutationObserver(function(mutations) {
			syncCartCount();
		});
		
		var cartTarget = document.getElementById('id_basket_top1');
		if (cartTarget) {
			cartObserver.observe(cartTarget, { childList: true, characterData: true, subtree: true });
		}

		/* 헤더 검색창 기능 */
		function goSearchGoodsKeyword2() {
			var keyword = $('#searchGoodsKeyword2').val();
			if (keyword && keyword.trim() !== '') {
				goPageSubmit('N', 'prod/goodsSearchList.do', 'searchMain', '', encodeURIComponent(keyword));
			}
		}

		$('#searchGoodsKeyword2').keypress(function(e) {
			if (e.which == 13) {
				goSearchGoodsKeyword2();
			}
		});

	</script>
	<div class="wrapper">
