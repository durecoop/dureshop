<%--
================================================================================
  파일명: cart.jsp
  버전: v2.0.0
  수정일: 2026-01-29
  수정자: 이지원
  설명: 장바구니 페이지 (오아시스마켓 스타일 리뉴얼)
================================================================================
--%>
<!-- PAGE_VERSION: v2.0.0 | 2026-01-29 | cart.jsp -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/include/${mobile}/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/cart.css?v=6.2.0">
<jsp:include page="/include/comm/cartComm.jsp" />

<c:if test="${addr.deliveryGb eq '2'}">
   <c:set var="v_text" value="출고일"/>
</c:if>
<c:if test="${addr.deliveryGb eq '1'}">
   <c:set var="v_text" value="배송일"/>
</c:if>

<style>
/* 장바구니 리뉴얼 스타일 v2.0 */
:root {
	--cart-primary: #3D6041;
	--cart-primary-light: #F3F6F4;
	--cart-danger: #FE0605;
	--cart-text: #1D271E;
	--cart-text-gray: #828284;
	--cart-border: #E5E5E5;
	--cart-bg: #F8F8F8;
}

/* 페이지 타이틀 */
.cart_wrap .cart_title {
	font-size: 26px;
	font-weight: 600;
	color: var(--cart-text);
	margin-bottom: 24px;
}

/* 탭 스타일 개선 */
.cart_tab_wrap {
	display: flex;
	gap: 0;
	border-bottom: 2px solid var(--cart-border);
	margin-bottom: 24px;
}

.cart_tab_wrap li {
	flex: 1;
	text-align: center;
}

.cart_tab_wrap li a {
	display: block;
	padding: 16px 0;
	font-size: 18px;
	font-weight: 500;
	color: var(--cart-text-gray);
	border-bottom: 3px solid transparent;
	margin-bottom: -2px;
	transition: all 0.2s;
}

.cart_tab_wrap li.on a,
.cart_tab_wrap li a:hover {
	color: var(--cart-primary);
	border-bottom-color: var(--cart-primary);
	font-weight: 600;
}

/* 배송 정보 카드 */
.address_wrap {
	background: var(--cart-primary-light);
	border: 1px solid var(--cart-primary);
	border-radius: 8px;
	padding: 16px 20px;
	margin-bottom: 20px;
}

.address_wrap table {
	width: 100%;
}

.address_wrap th {
	font-size: 14px;
	font-weight: 600;
	color: var(--cart-primary);
	width: 70px;
	padding: 6px 0;
	vertical-align: top;
}

.address_wrap td {
	font-size: 14px;
	color: var(--cart-text);
	padding: 6px 0;
}

.address_wrap .btn_modify {
	display: inline-block;
	margin-left: 10px;
	padding: 4px 12px;
	font-size: 12px;
	color: var(--cart-primary);
	border: 1px solid var(--cart-primary);
	border-radius: 4px;
	background: #fff;
	transition: all 0.2s;
}

.address_wrap .btn_modify:hover {
	background: var(--cart-primary);
	color: #fff;
}

/* 상품 체크/삭제 영역 */
.prod_chk_wrap {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 16px;
	background: var(--cart-bg);
	border-radius: 6px;
	margin-bottom: 16px;
}

.prod_chk_wrap .check_wrap {
	display: flex;
	align-items: center;
	gap: 8px;
}

.prod_chk_wrap .check_wrap input[type="checkbox"] {
	width: 18px;
	height: 18px;
	accent-color: var(--cart-primary);
}

.prod_chk_wrap .check_wrap label {
	font-size: 14px;
	font-weight: 500;
	color: var(--cart-text);
	cursor: pointer;
}

.prod_chk_wrap .delete_box {
	display: flex;
	align-items: center;
	gap: 12px;
}

.prod_chk_wrap .delete_box a {
	font-size: 13px;
	color: var(--cart-text-gray);
	transition: color 0.2s;
}

.prod_chk_wrap .delete_box a:hover {
	color: var(--cart-danger);
}

.prod_chk_wrap .delete_box .line {
	width: 1px;
	height: 12px;
	background: var(--cart-border);
}

/* 배송비 진행 바 */
.percent_wrap {
	background: linear-gradient(135deg, #E8F5E9, #C8E6C9);
	border-radius: 8px;
	padding: 16px 20px;
	margin-bottom: 20px;
}

.percent_wrap .txt {
	font-size: 14px;
	font-weight: 500;
	color: var(--cart-primary);
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.percent_wrap .bar_wrap {
	position: relative;
	height: 8px;
	background: rgba(255,255,255,0.8);
	border-radius: 4px;
	overflow: hidden;
}

.percent_wrap .bar_wrap .in {
	position: absolute;
	left: 0;
	top: 0;
	height: 100%;
	background: linear-gradient(90deg, var(--cart-primary), #5a8648);
	border-radius: 4px;
	transition: width 0.3s ease;
}

/* 결제 박스 */
.order_payment_box {
	position: sticky;
	top: 100px;
}

.price_box {
	background: #fff;
	border: 1px solid var(--cart-border);
	border-radius: 12px;
	padding: 24px;
	box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.price_box table {
	width: 100%;
	border-collapse: collapse;
}

.price_box th {
	font-size: 15px;
	font-weight: 400;
	color: var(--cart-text-gray);
	text-align: left;
	padding: 8px 0;
}

.price_box td {
	font-size: 15px;
	font-weight: 500;
	color: var(--cart-text);
	text-align: right;
	padding: 8px 0;
}

.price_box tr.total {
	border-top: 1px dashed var(--cart-border);
	margin-top: 12px;
}

.price_box tr.total th,
.price_box tr.total td {
	padding-top: 16px;
	font-size: 17px;
	font-weight: 600;
	color: var(--cart-text);
}

.price_box tr.total td {
	color: var(--cart-primary);
	font-size: 20px;
}

/* 주문 버튼 */
.price_box .btn_wrap {
	margin-top: 20px;
}

.price_box .btn_green {
	display: block;
	width: 100%;
	height: 52px;
	background: var(--cart-primary);
	color: #fff;
	font-size: 17px;
	font-weight: 600;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background 0.2s;
}

.price_box .btn_green:hover {
	background: #2d4830;
}

/* 정보 바 */
.cart-info-bar {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 16px;
	padding: 14px 20px;
	background: var(--cart-bg);
	border-radius: 8px;
	margin-top: 24px;
}

.cart-info-bar .info-item {
	font-size: 13px;
	color: var(--cart-text-gray);
}

.cart-info-bar .info-item strong {
	color: var(--cart-text);
	font-weight: 600;
}

.cart-info-bar .info-divider {
	color: var(--cart-border);
}

/* 택배 경고 메시지 */
.delivery-warning {
	font-size: 13px;
	color: var(--cart-danger);
	background: #FFF5F5;
	padding: 10px 14px;
	border-radius: 6px;
	margin-top: 8px;
	line-height: 1.5;
}

/* 페이지 버전 정보 */
.page-version {
	text-align: center;
	padding: 12px 0;
	margin-top: 16px;
	font-size: 11px;
	color: #999;
}
</style>

<div class="cart_wrap">
	<div class="inner">
		<h3 class="cart_title">장바구니</h3>

		<!-- 탭 메뉴 -->
		<ul class="cart_tab_wrap">
			<li class="on"><a href="javascript:void(0);" onclick="FnCartTabClick(0);">일반 <span id="id_cartQty_0">0</span></a></li>
			<li><a href="javascript:void(0);" onclick="FnCartTabClick(1);">예약 <span id="id_cartQty_1">0</span></a></li>
			<li><a href="javascript:void(0);" onclick="FnCartTabClick(2);">산지 <span id="id_cartQty_2">0</span></a></li>
			<li><a href="javascript:void(0);" onclick="FnCartTabClick(3);">택배예약 <span id="id_cartQty_3">0</span></a></li>
		</ul>

		<div class="content_area">
			<!-- 좌측: 상품 목록 -->
			<div class="left">
				<div class="content_wrap">
					<!-- 일반 탭 -->
					<div class="content_body content1">
						<div class="address_wrap">
							<table>
								<tr>
									<th>${v_text}</th>
									<td class="date">
										<span class="roboto" id="id_cart_delivertDate_0"></span>
										<a href="javascript:void(0);" class="btn_modify" onclick="FnDeliveryDateOpen();">변경</a>
									</td>
								</tr>
								<tr>
									<th>배송지</th>
									<td>
										<span id="id_cart_delivertAddr_0"></span>
										<a href="javascript:void(0);" class="btn_modify" onclick="FnDeliveryDateOpen();">변경</a>
									</td>
								</tr>
								<%-- 택배 배송 안내 메시지 (필요시 주석 해제)
								<c:if test="${addr.deliveryGb eq '2'}">
								<tr>
									<td colspan="2">
										<div class="delivery-warning">
											해당 배송지는 자사배송이 어려운 지역으로 출고일에 택배 발송되며, 택배사 사정에 따라 지연 도착할 수 있습니다.
										</div>
									</td>
								</tr>
								</c:if>
								--%>
							</table>
						</div>

						<div class="prod_list">
							<div class="prod_chk_wrap">
								<div class="check_wrap">
									<input type="checkbox" class="check_box" name="id_cartChkAll_0" id="id_cartChkAll_0" onclick="FnCartChkAll(0);" checked>
									<label for="id_cartChkAll_0">전체선택</label>
								</div>
								<div class="delete_box">
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('dis', 0, 0);">구매불가 삭제</a>
									<i class="line"></i>
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('all', 0, 0);">선택삭제</a>
								</div>
							</div>

							<div class="content_list">
								<div class="percent_wrap">
									<p class="txt"><i class="icon">🚚</i><span id="id_cart_progressDesc_0">무료배송까지 얼마 남지 않았어요!</span></p>
									<div class="bar_wrap">
										<div class="back"></div>
										<i class="in" id="id_cart_progressWidth_0" style="width:0%"></i>
									</div>
								</div>
								<div id="id_cartList_0"></div>
							</div>
						</div>
					</div>

					<!-- 예약 탭 -->
					<div class="content_body" style="display:none;">
						<div class="address_wrap">
							<table>
								<tr>
									<th>배송지</th>
									<td>
										<span id="id_cart_delivertAddr_1"></span>
										<a href="javascript:void(0);" class="btn_modify" onclick="FnDeliveryDateOpen();">변경</a>
									</td>
								</tr>
							</table>
						</div>
						<div class="prod_list">
							<div class="prod_chk_wrap">
								<div class="check_wrap">
									<input type="checkbox" class="check_box" name="id_cartChkAll_1" id="id_cartChkAll_1" onclick="FnCartChkAll(1);" checked>
									<label for="id_cartChkAll_1">전체선택</label>
								</div>
								<div class="delete_box">
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('dis', 1, 0);">구매불가 삭제</a>
									<i class="line"></i>
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('all', 1, 0);">선택삭제</a>
								</div>
							</div>
							<div class="content_list">
								<div id="id_cartList_1"></div>
							</div>
						</div>
					</div>

					<!-- 산지 탭 -->
					<div class="content_body" style="display:none;">
						<div class="address_wrap">
							<table>
								<tr>
									<th>${v_text}</th>
									<td class="date">
										<span class="roboto" id="id_cart_delivertDate_2"></span>
										<a href="javascript:void(0);" class="btn_modify" onclick="FnDeliveryDateOpen();">변경</a>
									</td>
								</tr>
								<tr>
									<th>배송지</th>
									<td>
										<span id="id_cart_delivertAddr_2"></span>
										<a href="javascript:void(0);" class="btn_modify" onclick="FnDeliveryDateOpen();">변경</a>
									</td>
								</tr>
							</table>
						</div>
						<div class="prod_list">
							<div class="prod_chk_wrap">
								<div class="check_wrap">
									<input type="checkbox" class="check_box" name="id_cartChkAll_2" id="id_cartChkAll_2" onclick="FnCartChkAll(2);" checked>
									<label for="id_cartChkAll_2">전체선택</label>
								</div>
								<div class="delete_box">
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('dis', 2, 0);">구매불가 삭제</a>
									<i class="line"></i>
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('all', 2, 0);">선택삭제</a>
								</div>
							</div>
							<div class="content_list">
								<div id="id_cartList_2"></div>
							</div>
						</div>
					</div>

					<!-- 택배예약 탭 -->
					<div class="content_body" style="display:none;">
						<div class="address_wrap">
							<table>
								<tr>
									<th>배송지</th>
									<td>
										<span id="id_cart_delivertAddr_3"></span>
										<a href="javascript:void(0);" class="btn_modify" onclick="FnDeliveryDateOpen();">변경</a>
									</td>
								</tr>
							</table>
						</div>
						<div class="prod_list">
							<div class="prod_chk_wrap">
								<div class="check_wrap">
									<input type="checkbox" class="check_box" name="id_cartChkAll_3" id="id_cartChkAll_3" onclick="FnCartChkAll(3);" checked>
									<label for="id_cartChkAll_3">전체선택</label>
								</div>
								<div class="delete_box">
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('dis', 3, 0);">구매불가 삭제</a>
									<i class="line"></i>
									<a href="javascript:void(0);" onclick="FnCartDeleteChk('all', 3, 0);">선택삭제</a>
								</div>
							</div>
							<div class="content_list">
								<div id="id_cartList_3"></div>
							</div>
						</div>
					</div>
				</div>

				<!-- 안내 정보 바 -->
				<div class="cart-info-bar">
					<span class="info-item"><strong>배송비</strong> 3만원 미만 2,000원</span>
					<span class="info-divider">|</span>
					<span class="info-item"><strong>출자금</strong> 주1회 1,000원</span>
					<span class="info-divider">|</span>
					<span class="info-item"><strong>주문마감</strong> 공급 1일 전 오전 11:30</span>
				</div>

				<!-- 버전 정보 -->
				<div class="page-version">v2.0.0</div>
			</div>

			<!-- 우측: 결제 박스 -->
			<div class="right">
				<div class="order_payment_box">
					<!-- 일반 결제 박스 -->
					<div class="price_box" id="id_cartTotal_0">
						<table>
							<tr>
								<th>생활재금액</th>
								<td><span class="roboto" id="id_pickGoodsAmt_0">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>적립쿠폰</th>
								<td><span class="roboto" id="id_couponAmtS_0">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>할인쿠폰</th>
								<td><span class="roboto" id="id_couponAmtD_0">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>결제쿠폰</th>
								<td><span class="roboto" id="id_couponAmtP_0">0</span> 원</td>
							</tr>
							<tr>
								<th>출자금</th>
								<td><span class="roboto" id="id_investAmt_0">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>배송비</th>
								<td><span class="roboto" id="id_deliveryAmt_0">0</span> 원</td>
							</tr>
							<tr class="total">
								<th>결제 예정 (<span id="id_pickCnt_0">0</span>종)</th>
								<td><span class="roboto" id="id_totalAmt_0">0</span> 원</td>
							</tr>
						</table>
						<div class="btn_wrap">
							<button class="btn_green" onclick="FnBasketNext(0);">주문하기</button>
						</div>
					</div>

					<!-- 예약 결제 박스 -->
					<div class="price_box" id="id_cartTotal_1" style="display:none;">
						<table>
							<tr>
								<th>생활재금액</th>
								<td><span class="roboto" id="id_pickGoodsAmt_1">0</span> 원</td>
							</tr>
							<tr>
								<th>출자금</th>
								<td><span class="roboto" id="id_investAmt_1">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>배송비</th>
								<td><span class="roboto" id="id_deliveryAmt_1">0</span> 원</td>
							</tr>
							<tr class="total">
								<th>결제 예정 (<span id="id_pickCnt_1">0</span>종)</th>
								<td><span class="roboto" id="id_totalAmt_1">0</span> 원</td>
							</tr>
						</table>
						<div class="btn_wrap">
							<button class="btn_green" onclick="FnBasketNext(1);">주문하기</button>
						</div>
					</div>

					<!-- 산지 결제 박스 -->
					<div class="price_box" id="id_cartTotal_2" style="display:none;">
						<table>
							<tr>
								<th>생활재금액</th>
								<td><span class="roboto" id="id_pickGoodsAmt_2">0</span> 원</td>
							</tr>
							<tr>
								<th>출자금</th>
								<td><span class="roboto" id="id_investAmt_2">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>배송비</th>
								<td><span class="roboto" id="id_deliveryAmt_2">0</span> 원</td>
							</tr>
							<tr class="total">
								<th>결제 예정 (<span id="id_pickCnt_2">0</span>종)</th>
								<td><span class="roboto" id="id_totalAmt_2">0</span> 원</td>
							</tr>
						</table>
						<div class="btn_wrap">
							<button class="btn_green" onclick="FnBasketNext(2);">주문하기</button>
						</div>
					</div>

					<!-- 택배예약 결제 박스 -->
					<div class="price_box" id="id_cartTotal_3" style="display:none;">
						<table>
							<tr>
								<th>생활재금액</th>
								<td><span class="roboto" id="id_pickGoodsAmt_3">0</span> 원</td>
							</tr>
							<tr>
								<th>출자금</th>
								<td><span class="roboto" id="id_investAmt_3">0</span> 원</td>
							</tr>
							<tr style="display:none;">
								<th>배송비</th>
								<td><span class="roboto" id="id_deliveryAmt_3">0</span> 원</td>
							</tr>
							<tr class="total">
								<th>결제 예정 (<span id="id_pickCnt_3">0</span>종)</th>
								<td><span class="roboto" id="id_totalAmt_3">0</span> 원</td>
							</tr>
						</table>
						<div class="btn_wrap">
							<button class="btn_green" onclick="FnBasketNext(3);">주문하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 하단 서브 메뉴 -->
<jsp:include page="/include/shop/footer.jsp" />

<!-- 배송일 선택 팝업 -->
<div class="mark_shadow"></div>
<div class="delivery_date_modify_wrap">
	<div id="id_layerDeliveryDateList"></div>
</div>

<!-- 쿠폰 팝업 -->
<div class="coupon_pop_wrap">
	<a href="javascript:coupon_off();" class="btn_close"><img src="<c:url value='/images/${mobile}/icon_alert_delete.jpg' />" alt="닫기"></a>
	<div class="coupon_list" id="id_layerCouponList"></div>
</div>

<script>
function date_modify_on(){
	$('.mark_shadow').show();
	$('.delivery_date_modify_wrap').show();
}

function date_modify_off(){
	$('.mark_shadow').hide();
	$('.delivery_date_modify_wrap').hide();
}

function coupon_on(){
	$('.mark_shadow').show();
	$('.coupon_pop_wrap').show();
}

function coupon_off(){
	$('.mark_shadow').hide();
	$('.coupon_pop_wrap').hide();
}

// 탭 클릭 시 스타일 적용
$(document).ready(function(){
	$('.cart_tab_wrap li a').on('click', function(){
		$('.cart_tab_wrap li').removeClass('on');
		$(this).parent('li').addClass('on');
	});
});
</script>
