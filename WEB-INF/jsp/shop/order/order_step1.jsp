<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/include/${mobile}/header.jsp" />
<jsp:include page="/include/comm/orderStepComm1.jsp" />

<link rel="stylesheet" href="/css/shop/order.css">

<div class="order_wrap order_step1_wrap">
	<div class="inner">
		<!-- 페이지 타이틀 -->
		<div class="order_title">쿠폰/포인트 사용</div>

		<div class="order_content_wrap">
			<!-- 좌측: 쿠폰/포인트 선택 영역 -->
			<div class="order_coupon_wrap">

				<!-- 안내 메시지 카드 -->
				<div class="order-card" style="background: var(--order-color-primary-light); border-color: var(--order-color-primary);">
					<ul class="txt_list_box" style="margin: 0; color: var(--order-color-text);">
						<li>주문 이후 쿠폰 혜택 및 복구가 불가능합니다.</li>
						<li>결품시 적용된 쿠폰 혜택의 차이가 발생할 수 있습니다.</li>
						<li class="order-text-danger" style="font-weight: 600;">사용 가능한 쿠폰 중 할인금액이 가장 큰 쿠폰을 기본 적용합니다.</li>
					</ul>
				</div>

				<!-- 쿠폰 선택 카드 -->
				<div class="order-card">
					<div class="order-card-header">
						<span class="order-card-title">쿠폰 선택</span>
					</div>

					<!-- 장바구니 쿠폰 -->
					<div class="order_coupon_select_wrap">
						<div class="coupon-label-row" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
							<h3 class="title" style="margin: 0; font-size: 15px;">장바구니 쿠폰</h3>
							<span id="id_availableOrderCoupon" class="order-text-danger" style="font-size: 13px;"></span>
						</div>
						<div class="select_wrap">
							<input type="text" class="view" id="id_couponDesc" placeholder="쿠폰을 선택하세요" readonly>
							<ul class="select_list order-scroll-y" id="id_couponList">
							</ul>
						</div>
					</div>

					<!-- 배송비 쿠폰 -->
					<div class="order_coupon_select_wrap" id="id_deliveryCoupon" style="margin-top: 20px;">
						<div class="coupon-label-row" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
							<h3 class="title" style="margin: 0; font-size: 15px;">배송비 쿠폰</h3>
							<span id="id_availableDeliveryCoupon" class="order-text-danger" style="font-size: 13px;"></span>
						</div>
						<div class="select_wrap">
							<input type="text" class="view" id="id_deliveryCouponDesc" placeholder="쿠폰을 선택하세요" readonly>
							<ul class="select_list order-scroll-y" id="id_deliveryCouponList">
							</ul>
						</div>
					</div>
				</div>

				<c:if test="${returnCartTab == 0}">
				<!-- 포인트/충전금 카드 -->
				<div class="order-card">
					<div class="order-card-header">
						<span class="order-card-title">포인트 / 충전금</span>
					</div>

					<!-- 포인트 -->
					<div class="order_point_use_wrap" id="id_div_point" style="margin-top: 0;">
						<div class="point-row" style="display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--order-color-bg-gray);">
							<div class="point-info">
								<span class="point-label" style="font-size: 15px; font-weight: 500;">포인트</span>
								<span class="point-balance" style="margin-left: 12px; color: var(--order-color-primary); font-weight: 700;">
									<span class="roboto" id="id_pointBalance"><fmt:formatNumber value="${pointMap.pointBalanceSp}" pattern="#,###" /></span>원 보유
								</span>
							</div>
							<div class="point-btns">
								<button type="button" class="btn_w" style="display:none;" id="btn_usePoint" onclick="FnUsePointAll()">모두사용</button>
								<button type="button" class="btn_w order-btn-w-90" style="display:none;" id="btn_canPoint" onclick="FnCanPointAll()">취소</button>
							</div>
						</div>
						<div class="point-input-row" style="display: flex; align-items: center; gap: 10px; padding: 12px 0;">
							<span style="font-size: 14px; color: var(--order-color-text-gray); min-width: 70px;">사용 포인트</span>
							<input type="text" class="input" id="txt_usingpoint" value="0"
								style="flex: 1; max-width: 200px; text-align: right;"
								onfocus="jscript:this.select();" onblur="FnPointMaxChk(this);">
							<span style="font-size: 14px;">원</span>
						</div>
					</div>

					<!-- 충전금 -->
					<div class="order_point_use_wrap" id="id_div_deposit" style="margin-top: 16px; padding-top: 16px; border-top: 1px solid var(--order-color-border);">
						<div class="point-row" style="display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--order-color-bg-gray);">
							<div class="point-info">
								<span class="point-label" style="font-size: 15px; font-weight: 500;">장보기 충전금</span>
								<span class="point-balance" style="margin-left: 12px; color: var(--order-color-primary); font-weight: 700;">
									<span class="roboto" id="id_depositBalance"><fmt:formatNumber value="${depositBalance}" pattern="#,###" /></span>원 보유
								</span>
							</div>
							<div class="point-btns" style="display: flex; gap: 6px;">
								<button type="button" class="btn_w" onclick="FnChargeReq()" style="background: var(--order-color-primary); color: #fff; border-color: var(--order-color-primary);">충전</button>
								<button type="button" class="btn_w" onclick="getDeposit()">조회</button>
								<button type="button" class="btn_w" style="display:none;" id="btn_useDeposit" onclick="FnUseDepositAll()">모두사용</button>
								<button type="button" class="btn_w order-btn-w-90" style="display:none;" id="btn_canDeposit" onclick="FnCanDepositAll()">취소</button>
							</div>
						</div>
						<div class="point-input-row" style="display: flex; align-items: center; gap: 10px; padding: 12px 0;">
							<span style="font-size: 14px; color: var(--order-color-text-gray); min-width: 70px;">사용 충전금</span>
							<input type="text" class="input" id="txt_usingdeposit" value="0"
								style="flex: 1; max-width: 200px; text-align: right;"
								onfocus="jscript:this.select();" onblur="FnDepositMaxChk(this);">
							<span style="font-size: 14px;">원</span>
						</div>
					</div>
				</div>
				</c:if>

				<!-- 이전 버튼 -->
				<button type="button" class="btn_back" onclick="goPageSubmit('Y', 'cart/cart.do');">
					<span style="margin-right: 6px;">←</span> 장바구니로 돌아가기
				</button>
			</div>

			<!-- 우측: 결제금액 요약 (Sticky) -->
			<div class="order_payment_amount_wrap">
				<div class="order_payment_box">
					<!-- 결제 상세 -->
					<div class="table_wrap">
						<table>
							<colgroup>
								<col style="width: 55%;">
								<col style="width: 45%;">
							</colgroup>
							<tbody>
								<tr>
									<th>생활재금액</th>
									<td><span class="roboto" id="id_pickGoodsNorAmt"><fmt:formatNumber value="${pickGoodsNorAmt}" pattern="#,###" /></span> 원</td>
								</tr>
								<tr>
									<th>기본 할인</th>
									<td class="order-text-danger"><span class="roboto" id="id_pickGoodsRateAmt"><fmt:formatNumber value="${pickGoodsRateAmt*(-1)}" pattern="#,###" /></span> 원</td>
								</tr>
								<tr class="order-d-none">
									<th>생활재금액</th>
									<td><span class="roboto" id="id_goodsAmt"><fmt:formatNumber value="${pickGoodsAmt}" pattern="#,###" /></span> 원</td>
								</tr>
							</tbody>
						</table>

						<!-- 쿠폰 할인 섹션 -->
						<div style="margin-top: 12px; padding-top: 12px; border-top: 1px dashed var(--order-color-border);">
							<table>
								<colgroup>
									<col style="width: 55%;">
									<col style="width: 45%;">
								</colgroup>
								<tbody>
									<tr>
										<th>적립쿠폰</th>
										<td><span class="roboto" id="id_couponAmtS">0</span> 원</td>
									</tr>
									<tr>
										<th>할인쿠폰</th>
										<td class="order-text-danger"><span class="roboto" id="id_couponAmtD">0</span> 원</td>
									</tr>
									<tr>
										<th>결제쿠폰</th>
										<td class="order-text-danger"><span class="roboto" id="id_couponAmtP">0</span> 원</td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- 포인트/충전금 섹션 -->
						<div style="margin-top: 12px; padding-top: 12px; border-top: 1px dashed var(--order-color-border);">
							<table>
								<colgroup>
									<col style="width: 55%;">
									<col style="width: 45%;">
								</colgroup>
								<tbody>
									<tr id="tr_tot_display1">
										<th>포인트 사용</th>
										<td class="order-text-danger"><span class="roboto" id="id_pointAmt">0</span> 원</td>
									</tr>
									<tr id="tr_tot_display2">
										<th>충전금 사용</th>
										<td class="order-text-danger"><span class="roboto" id="id_depositAmt">0</span> 원</td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- 기타 섹션 -->
						<div style="margin-top: 12px; padding-top: 12px; border-top: 1px dashed var(--order-color-border);">
							<table>
								<colgroup>
									<col style="width: 55%;">
									<col style="width: 45%;">
								</colgroup>
								<tbody>
									<tr id="tr_tot_display3">
										<th>이용출자금</th>
										<td><span class="roboto" id="id_investAmt"><fmt:formatNumber value="${invest.useinvAmt}" pattern="#,###" /></span> 원</td>
									</tr>
									<tr id="tr_tot_display4">
										<th>이용회비</th>
										<td><span class="roboto" id="id_useAmt"><fmt:formatNumber value="${invest.useAmt}" pattern="#,###" /></span> 원</td>
									</tr>
									<tr>
										<th>배송비</th>
										<td><span class="roboto" id="id_deliveryAmt"><fmt:formatNumber value="${deliveryAmt}" pattern="#,###" /></span> 원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<!-- 최종 결제금액 -->
					<div class="total_wrap">
						<span class="tt">최종 결제금액</span>
						<span class="price"><span class="roboto" id="id_totalAmt">0</span> 원</span>
					</div>

					<!-- 주문 버튼 -->
					<div class="btn_wrap">
						<button type="button" class="btn_green" onclick="FnOrderNext();">주문하기</button>
					</div>

					<!-- 할인 요약 -->
					<div class="discount-summary" style="padding: 12px 17px; background: var(--order-color-bg-gray); border: 1px solid var(--order-color-border); border-top: 0; border-radius: 0 0 6px 6px;">
						<p style="font-size: 13px; color: var(--order-color-text-gray); text-align: center; margin: 0;">
							총 <span class="order-text-danger" style="font-weight: 700;" id="id_totalDiscount">0</span>원 할인 받았어요!
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	// 쿠폰 드롭다운 토글
	$('.select_wrap').click(function (e) {
		e.stopPropagation();
		var $this = $(this);
		var $list = $this.find("ul");
		var $view = $this.find('.view');

		if($list.is(":visible")){
			$list.slideUp(200);
			$view.removeClass('on');
		} else {
			$(".select_wrap .select_list").slideUp(200);
			$(".select_wrap .view").removeClass('on');
			$list.slideDown(200);
			$view.addClass('on');
		}
	});

	// 외부 클릭시 드롭다운 닫기
	$(document).click(function() {
		$(".select_wrap .select_list").slideUp(200);
		$(".select_wrap .view").removeClass('on');
	});

	// 숫자 입력 포맷팅
	$('#txt_usingpoint, #txt_usingdeposit').on('input', function() {
		var value = $(this).val().replace(/[^0-9]/g, '');
		$(this).val(value);
	});
});

// 총 할인금액 계산
function updateTotalDiscount() {
	var couponD = parseInt($('#id_couponAmtD').text().replace(/,/g, '')) || 0;
	var couponP = parseInt($('#id_couponAmtP').text().replace(/,/g, '')) || 0;
	var point = parseInt($('#id_pointAmt').text().replace(/,/g, '')) || 0;
	var deposit = parseInt($('#id_depositAmt').text().replace(/,/g, '')) || 0;
	var rateAmt = parseInt($('#id_pickGoodsRateAmt').text().replace(/,/g, '')) || 0;

	var total = Math.abs(couponD) + Math.abs(couponP) + Math.abs(point) + Math.abs(deposit) + Math.abs(rateAmt);
	$('#id_totalDiscount').text(total.toLocaleString());
}
</script>

<jsp:include page="/include/comm/depositLayerComm.jsp" />
