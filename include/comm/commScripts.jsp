<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- <c:out value='${mobile}' /> --%>

<%-- GA4 (Google Analytics 4) 추적 코드 --%>
<%@ include file="/include/comm/ga4Analytics.jsp" %>

<!--
<link rel="stylesheet" href="<c:url value='/css/${mobile}/jquery-ui.css'/>">
<link rel="stylesheet" href="<c:url value='/css/${mobile}/swiper.css'/>">
<link rel="stylesheet" href="<c:url value='/css/${mobile}/default.css'/>">
-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/swiper.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/_variables.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/default.css">

<%-- <c:choose>
	<c:when test="${mobile eq 'shop'}">
		<link rel="stylesheet" href="<c:url value='/css/${mobile}/style_v2.css?v=1.1'/>">
	</c:when>
	<c:otherwise>
		<link rel="stylesheet" href="<c:url value='/css/${mobile}/style.css?v=1.1'/>">
	</c:otherwise>
</c:choose> --%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/style_v2.css?v=3.0.0">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/swiper.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm/pineComm.js?v=1.3"></script>
<%-- <link rel="stylesheet" href="<c:url value='/css/comm/commStyle.css?v=1.1'/>"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/layerPop.css?v=1.3">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/fineStyle.css?v=1.3">

<%-- 결제 페이지 전용 CSS (order_step1, order_step2, order_end) --%>
<c:if test="${fn:indexOf(sysCurrentUrl, 'orderStep') > -1 or fn:indexOf(sysCurrentUrl, 'orderEnd') > -1}">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/order.css?v=1.0.3">
</c:if>

<%-- 장바구니 페이지 전용 CSS --%>
<c:if test="${fn:indexOf(sysCurrentUrl, 'cart/cart') > -1}">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/cart.css?v=4.0.0">
</c:if>

<!--
<link rel="stylesheet" href="<c:url value='/css/${mobile}/style_v2.css?v=1.2'/>">
<script type="text/javascript" src="<c:url value='/js/${mobile}/jquery-2.2.4.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/${mobile}/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/${mobile}/jquery.mousewheel.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/${mobile}/swiper.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/comm/pineComm.js'/>"></script>
<%-- <link rel="stylesheet" href="<c:url value='/css/comm/commStyle.css?v=1.1'/>"> --%>
<link rel="stylesheet" href="<c:url value='/css/${mobile}/layerPop.css?v=1.1'/>">
<link rel="stylesheet" href="<c:url value='/css/${mobile}/fineStyle.css?v=1.2'/>">
 -->
<c:if test = "${mobile eq 'shop'}">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm/jquery.cookie.js"></script>
</c:if>

<style type="text/css">
	input:focus::-webkit-input-placeholder{color:transparent;}
</style>

<script>
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();

// 비조합원 가격 숨김
$(document).ready(function(){
    $('dl.price dt:contains("비조합원")').closest('dl.price').hide();
    $('li.target:contains("비조합원")').hide();
});
</script>
