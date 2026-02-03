<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* go_shop_wrap 확장 스타일 */
.go_shop_wrap .inner {
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	gap: 20px !important;
	flex-wrap: wrap !important;
}

.go_shop_wrap .txt_box {
	flex-shrink: 0 !important;
}

/* 서비스 버튼 스타일 */
.go_shop_wrap .service-btn {
	display: inline-flex !important;
	align-items: center !important;
	gap: 8px !important;
	padding: 10px 20px !important;
	background: rgba(255,255,255,0.95) !important;
	border: none !important;
	border-radius: 24px !important;
	text-decoration: none !important;
	transition: all 0.2s ease !important;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1) !important;
}

.go_shop_wrap .service-btn:hover {
	background: #fff !important;
	transform: translateY(-2px) !important;
	box-shadow: 0 4px 16px rgba(0,0,0,0.15) !important;
}

.go_shop_wrap .service-btn .icon {
	font-size: 18px !important;
}

.go_shop_wrap .service-btn .text {
	font-size: 14px !important;
	font-weight: 600 !important;
	color: #2d5a27 !important;
}

.go_shop_wrap .service-btn:hover .text {
	color: #1a3d16 !important;
}

/* 기존 매장찾기 버튼 스타일 조정 */
.go_shop_wrap .inner > a:last-of-type img {
	height: 42px !important;
}

/* 바우처 버튼 숨김 (중복 방지) */
.go_shop_wrap .voucher_btn {
	display: none !important;
}

/* 반응형 */
@media (max-width: 768px) {
	.go_shop_wrap .inner {
		flex-direction: column !important;
		gap: 12px !important;
		padding: 20px !important;
	}
	.go_shop_wrap .txt_box {
		text-align: center !important;
	}
	.go_shop_wrap .service-buttons {
		display: flex !important;
		gap: 10px !important;
		flex-wrap: wrap !important;
		justify-content: center !important;
	}
}
</style>

<!-- 요리조리, 두레이야기 버튼 (go_shop_wrap에 삽입) -->
<script>
$(document).ready(function() {
	// go_shop_wrap의 inner에 서비스 버튼 추가
	var serviceButtons = `
		<a href="<c:url value='/recipe.do' />" class="service-btn">
			<span class="icon">🍳</span>
			<span class="text">요리조리</span>
		</a>
		<a href="<c:url value='/story.do' />" class="service-btn">
			<span class="icon">📖</span>
			<span class="text">두레이야기</span>
		</a>
	`;

	// 매장찾기 버튼 앞에 삽입
	var $goShopInner = $('.go_shop_wrap .inner');
	if ($goShopInner.length > 0) {
		$goShopInner.find('.txt_box').after(serviceButtons);
	}
});
</script>
