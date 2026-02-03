<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* 푸터 서비스 영역 */
.footer-service {
	background: #fff;
	border-top: 1px solid #eee;
	padding: 32px 20px;
}

.footer-service .inner {
	max-width: 1100px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
	gap: 24px;
}

.footer-service .service-item {
	display: flex;
	align-items: center;
	gap: 14px;
	padding: 16px 28px;
	background: #fafafa;
	border: 1px solid #eee;
	border-radius: 12px;
	text-decoration: none;
	transition: all 0.25s ease;
	min-width: 200px;
}

.footer-service .service-item:hover {
	background: #f8faf7;
	border-color: #5a8648;
	transform: translateY(-3px);
	box-shadow: 0 8px 24px rgba(90, 134, 72, 0.12);
}

.footer-service .service-item .icon-wrap {
	width: 44px;
	height: 44px;
	background: linear-gradient(135deg, #5a8648 0%, #7aa868 100%);
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	flex-shrink: 0;
	box-shadow: 0 4px 12px rgba(90, 134, 72, 0.25);
}

.footer-service .service-item .text-wrap {
	display: flex;
	flex-direction: column;
	gap: 2px;
}

.footer-service .service-item .title {
	font-size: 15px;
	font-weight: 600;
	color: #1a1a1a;
}

.footer-service .service-item .desc {
	font-size: 12px;
	color: #888;
}

.footer-service .service-item:hover .title {
	color: #5a8648;
}

/* 반응형 */
@media (max-width: 600px) {
	.footer-service .inner {
		flex-direction: column;
		gap: 12px;
	}
	.footer-service .service-item {
		min-width: auto;
		width: 100%;
		justify-content: center;
	}
}
</style>

<!-- 푸터 서비스 (요리조리, 두레이야기) -->
<div class="footer-service">
	<div class="inner">
		<a href="<c:url value='/recipe.do' />" class="service-item">
			<span class="icon-wrap">🍳</span>
			<span class="text-wrap">
				<span class="title">요리조리</span>
				<span class="desc">두레생협 레시피</span>
			</span>
		</a>
		<a href="<c:url value='/story.do' />" class="service-item">
			<span class="icon-wrap">📖</span>
			<span class="text-wrap">
				<span class="title">두레이야기</span>
				<span class="desc">생협 소식과 이야기</span>
			</span>
		</a>
	</div>
</div>
