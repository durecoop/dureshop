<%@page import="egovframework.cmmn.service.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- ${sessionLoginVO.orderAllow} --%>

<%--
<%@ page import="duremall.login.service.LoginVO"%>
<%
	LoginVO ssVO = (LoginVO)session.getAttribute("sessionLoginVO");
	if (ssVO == null) {
		Cookie[] cookies = request.getCookies();
		for (Cookie c: cookies) {
			if (c.getName().equals("autoLoginUser")) {
				%>
				<script type="text/javascript">
					location.href = "${pageContext.request.contextPath}/login/ajaxAutoLogin.do?p1=${mobile}&p2=<%=c.getValue()%>";
				</script>
				<%
				break;
			}
		}
	}
	//request.getSession().setAttribute("sessionLoginVO", null);
%>
--%>

<script type="text/javascript">
	var gIntPage = 0;
	var gbAppend = true;
	var gLocationUrl = $(location).attr("pathname");
	var referrerUrl = document.referrer;

	$(document).ready(function() {
		// 모바일 폰트 적용...
		if ("${mobile}" == "mobile") {
			var htmlFontGb = CookieManager.get("htmlFontGb");
			if (htmlFontGb == "Y") {
				$('html').addClass('font_big');
			} else {
				$('html').removeClass('font_big');
			}
		}

		if ("${mobile}" == "mobile") {
			if ("${sessionLoginVO.deliveryDate}" == "") {
				$('.head_def .gnb_r li .tool').show();
			} else {
				$('.head_def .gnb_r li .tool').hide();
			}
		} else if ("${mobile}" == "shop") {
			if ("${sessionLoginVO.deliveryDate}" == "") {
				$('.head_visual .tool').show();
			} else {
				$('.head_visual .tool').hide();
			}
		}

		//#####################################################################
		// 기본 페이지 체크...
		if ("<c:out value='${sessionLoginVO}' />" == "") {
			if ((gLocationUrl.search("/cart/") >= 0) || (gLocationUrl.search("/order/") >= 0) || (gLocationUrl.search("/my/") >= 0)) {
				if("<c:out value='${appCheck}'/>" == ""){
		            layerMsgShow("로그인이 필요한 서비스 입니다.", "확인", "Y", "login");
		            return;
				}else{
		            layerMsgShow("로그인이 필요한 서비스 입니다.", "확인", "L", "/DureShop/login/mobileLogin.do");
	                return;
				}
			}
		} else {
			if (gLocationUrl.search("/login/") >= 0) {
	            layerMsgShow("잘못된 접근입니다.", "확인", "Y", "main");
				return;
			}

			// 약관동의여부 체크
			if (gLocationUrl.search("agreeConfirm.do") == -1 && gLocationUrl.search("addrConfirm.do") == -1 && gLocationUrl.search("deliveryPlace.do") == -1 && gLocationUrl.search("deliveryPlaceAddr.do") == -1) {
				if (("<c:out value='${sessionLoginVO.agreeGb}' />" == "0") || ("<c:out value='${sessionLoginVO.agreeGb}' />" == "1")) {
					layerMsgShow("이용약관에 동의해야 합니다.", "확인", "L", "${sysPcGubunUrl}/member/agreeConfirm.do");
					return;
				}
			}

			//-------------------------------------------------------------
			// 주소정제여부 체크
			if (gLocationUrl.search("addrConfirm.do") == -1 && gLocationUrl.search("agreeConfirm.do") == -1 && gLocationUrl.search("deliveryPlace.do") == -1 && gLocationUrl.search("deliveryPlaceAddr.do") == -1) {
				if ("<c:out value='${sessionLoginVO.addrCheckYn}' />" == "N") {
					layerMsgShow("빠르고 정확한 배송을 위해<br>배송받을 주소를 확인해주세요.", "확인", "L", "${sysPcGubunUrl}/member/addrConfirm.do");
					return;
				}
			}

			// 기본배송지 체크...
			if (gLocationUrl.search("addrConfirm.do") == -1 && gLocationUrl.search("agreeConfirm.do") == -1 && gLocationUrl.search("deliveryPlace.do") == -1 && gLocationUrl.search("deliveryPlaceAddr.do") == -1) {
				if (Number("${deliveryAddrCnt}") == 0) {
					if (gLocationUrl.search("deliveryPlace.do") == -1 && gLocationUrl.search("deliveryPlaceAddr.do") == -1) {
						layerMsgShow("기본배송지 주소가 없습니다.<br>기본배송지를 등록해주세요.", "확인", "L", "${sysPcGubunUrl}/delivery/deliveryPlace.do");
						return;
					}
				}
			}

			// 기본배송지 우편번호체크...
			if (gLocationUrl.search("addrConfirm.do") == -1 && gLocationUrl.search("agreeConfirm.do") == -1 && gLocationUrl.search("deliveryPlace.do") == -1 && gLocationUrl.search("deliveryPlaceAddr.do") == -1) {
				var strReceiverZip = "<c:out value='${deliveryAddrZip}' />";
				if (strReceiverZip.length != 5) {
					if (gLocationUrl.search("deliveryPlace.do") == -1 && gLocationUrl.search("deliveryPlaceAddr.do") == -1) {
						layerMsgShow("기본배송지 우편번호가 잘못되었습니다.<br>기본배송지를 확인해주세요.", "확인", "L", "${sysPcGubunUrl}/delivery/deliveryPlace.do");
						return;
					}
				}
			}
			//-------------------------------------------------------------

		}
		//#####################################################################

		FnBasketCount("${basketCntAll}");

		$("#commonFrm input[name=msinTopIdx]").val("${msinTopIdx}");

		//-------------------------------------------------------------------
		/*
		if ("${mobile}" == "mobile" && gLocationUrl.search("shopMain.do") >= 0) {
			if ("${msinTopIdx}" != "0") {
				if (main_swiper_r.activeIndex != "${msinTopIdx}") {
					if ("${msinTopIdx}" == "4") {
						//$("#commonFrm input[name=returnIndex1]").val("${returnIndex1}");
						$("#commonFrm input[name=returnIndex1]").val("${returnIndex1}");
						$("#commonFrm input[name=returnIndex2]").val("${returnIndex2}");
						$("#commonFrm input[name=returnCategory2]").val("${returnCategory2}");
					} else if ("${msinTopIdx}" == "6") {
						$("#commonFrm input[name=returnIndex1]").val("${returnIndex1}");
						$("#commonFrm input[name=returnIndex2]").val("${returnIndex2}");
						$("#commonFrm input[name=returnCategory1]").val("${returnCategory1}");
						$("#commonFrm input[name=returnCategory2]").val("${returnCategory2}");
					}
				}

				var act = "${msinTopIdx}";
				try {
					_satellite.setVar("clickFlag",true);
				} catch(e){}
				main_swiper_r.slideTo(act, 0);
				$('.gnb_wrap li').removeClass('on');
				$('.gnb_wrap li:eq(' + act + ')').addClass('on');
				event.preventDefault();
			}
		}
		*/
		//-------------------------------------------------------------------

		$("[name='searchGoodsKeyword']").keyup(function(){
			var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
			if (keyCode == 13) {
				if ($('#searchGoodsKeyword').val() != "") {
					goSearchGoodsKeyword($('#searchGoodsKeyword').val());
					$('#searchGoodsKeyword').val("");
				}
				return;
			}
		});

		$("#allCheck").change(function() {
	    	var intLoopCnt = $("#checkTotalCnt").val();
			if (intLoopCnt == "") {
	    		intLoopCnt = 0;
	    	}
	        if ($("#allCheck").is(":checked")) {
				FnCheckBox("#check", "#stopYn", intLoopCnt, true);
	        } else {
				FnCheckBox("#check", "#stopYn", intLoopCnt, false);
	        }
	    });

		// 나의 최근 검색어
		if ("<c:out value='${sessionLoginVO}' />" != "") {
			FnSearchMyKeyword("MY_KEYWORD");
		}

	});

	// 나의 최근 검색어...
	function FnSearchMyKeyword(pType) {
		$("#id_myKeyword").html("");
		var htmlStr = "";
		var dataParam = {};
		dataParam['pDateFrom'] = "${dateMonFrom}";
		dataParam['pDateTo'] = "${sysDbCurrentDate}";
		dataParam['pMaxCnt'] = "${keywordMaxCnt}";
		dataParam['pGuestNo'] = "${sessionLoginVO.guestNo}";
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxMyKeywordList.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				$(data).each(function(index, value){
					if ("${mobile}" == "mobile") {
						htmlStr += '<div class="keys">\n';
						htmlStr += '	<a href="javascript:void(0);" class="key" onclick="goSearchMainKeyword(\''+value.shWord+'\');">'+value.shWord+'</a>\n';
						htmlStr += '	<a href="javascript:void(0);" class="btn_clear" onclick="FnMyKeywordDelete(\''+encodeURIComponent(value.shWord)+'\');"></a>\n';
						htmlStr += '</div>\n';
					} else if ("${mobile}" == "shop") {
						htmlStr += '<li>\n';
						//htmlStr += '	<a href="javascript:void(0);" onclick="goPageSubmit(\'N\', \'prod/goodsSearchList.do\', \'searchMain\', \'\', \''+encodeURIComponent(value.shWord)+'\');">'+value.shWord+'</a> \n';
						htmlStr += '	<a href="javascript:void(0);" onclick="goSearchMainKeyword(\''+value.shWord+'\');">'+value.shWord+'</a> \n';
						htmlStr += '	<a href="javascript:void(0);" class="btn_clear" onclick="FnMyKeywordDelete(\''+encodeURIComponent(value.shWord)+'\');"></a>\n';
						htmlStr += '</li>\n';
					}
				});
				$("#id_myKeyword").empty();
				$('#id_myKeyword').append(htmlStr);
				return;
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	function FnMyKeywordDelete(pWord) {
		var searchKeyword = "";
		if (pWord != undefined) {
			searchKeyword = pWord;
		}

		//dataParam['pMobile'] = "${mobile}";
		var dataParam = {};
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pGuestNo'] = "${sessionLoginVO.guestNo}";
		dataParam['pWord'] = searchKeyword;
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxUpdateMyKeyword.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				if (data == "N") {
					FnSearchMyKeyword("MY_KEYWORD");
				} else {
					console.log(data.errMsg);
					return false;
				}
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	function FnBasketCount(pCnt) {
		if ($('#id_basket_quick').html() != undefined) { $('#id_basket_quick').html(pCnt); }
		if ($('#id_basket_top1').html() != undefined) {	$('#id_basket_top1').html(pCnt); }
		if ($('#id_basket_top2').html() != undefined) {	$('#id_basket_top2').html(pCnt); }
		if ("${mobile}" == "mobile") {
			if ($('#id_basket_top3').html() != undefined) {	$('#id_basket_top3').html(pCnt); }
		}
	}

	function setRadioFalse(pObj, pBool) {
		$('input:radio[name="'+pObj+'"]').each(function() {
			this.checked = pBool;
		});
	}

	/* 검색 키워드 */
	function goSearchMainKeyword(keyword) {
		var searchKeyword = encodeURIComponent(keyword);
		goPageSubmit("N", "prod/goodsSearchList.do", "searchMain", "", searchKeyword);
	}

	function goSearchGoodsKeyword(keyword) {
		var searchKeyword = "";
		if (keyword == undefined) {
			searchKeyword = $('#searchGoodsKeyword').val();
		} else {
			searchKeyword = keyword;
		}
		searchKeyword = cleanQueryTerm(searchKeyword);

		if (searchKeyword == "") {
			layerMsgFocusShow("검색어를 입력해주세요.", "focus", "#searchGoodsKeyword");
			return;
		}
		//if (searchKeyword == '') return false;

		//-------------------------------------------
		// 숫자, 영문, 한글만 가능...2025.03.07
		//var regexPattern = /^[a-z|A-Z|0-9|ㄱ-ㅎ|가-힣]+$/; /^[a-zA-Z0-9ㄱ-ㅎ가-힣]+$/
		var regexPattern = /^[a-zA-Z0-9ㄱ-ㅎ가-힣 ]+$/;
		if (!regexPattern.test(searchKeyword)) {
			$('#searchGoodsKeyword').val("");
			layerMsgFocusShow("검색어에 특수문자는 입력할 수 없습니다.", "focus", "#searchGoodsKeyword");
			return;
		}
		//-------------------------------------------

		if (!isNaN(searchKeyword)) {
			moveProdDetail("01", searchKeyword.trimEnd(), 0);
			return;
		} else {
			// GA4: 검색 이벤트
			if (typeof DureGA4 !== 'undefined') {
				DureGA4.search(searchKeyword);
			}
			goPageSubmit("N", "prod/goodsSearchList.do", "search", "", searchKeyword);
		}
	}

	/* 큐레이터 더보기 */
	function goMoreCurator() {
		var strCode = $("#commonFrm input[name=returnCategory1]").val();
		var strTitle = "";
		if (strCode == "1") {
			strTitle = "공정무역";
		} else if (strCode == "2") {
			strTitle = "채식생활";
		} else if (strCode == "3") {
			strTitle = "영유아";
		} else if (strCode == "4") {
			strTitle = "가정간편식";
		} else if (strCode == "5") {
			strTitle = "농공상기획전";
		} else if (strCode == "6") {
			strTitle = "2023추석";
		} else if (strCode == "7") {
			strTitle = "사회적기업";
		} else if (strCode == "8") {
			strTitle = "경기 소비쿠폰";
		} else {
			return;
		}
		//goPageSubmit("N", "prod/goodsList.do", "curator", strCode, strTitle);
		goPageLocation('N', 'prod/goodsList.do', 'curator', strCode, strTitle)
	}

	/* url페이지 이동 */

	function goFormPageSubmit(pChk, pFrm, pUrl, pParam1, pParam2, pParam3) {
		//------------------------------------
		if (pChk == "Y") {
			// 로그인 체크...
			if (!FnLoginCheck()) {return;}
		}
		//------------------------------------

		//------------------------------------
		// param1 -> 리턴구분...
		var strGubun = "main";
		if (pParam1 != undefined) {
			strGubun = pParam1;
		}
		$(pFrm+" input[name=returnParam1]").val(strGubun);
		//------------------------------------

		if (pParam2 != undefined) {
			$(pFrm+" input[name=returnParam2]").val(pParam2);
		}
		if (pParam3 != undefined) {
			$(pFrm+" input[name=returnParam3]").val(pParam3);
		}

		var strUrl = "<c:out value='${sysPcGubunUrl}'/>/" + pUrl;
		$(pFrm).attr("action", strUrl);
		$(pFrm).submit();
	}

	/* url페이지 이동 */
	//goPageSubmit("N", "plan/planMasterList.do", "plan", "", "두레 기획전", pIdx2);
	//goPageSubmit("N", "/plan/planGiftView.do", "A", "10");
	function goPageSubmit(pChk, pUrl, pGb, pNo, pNm, pIdx, pNo2) {
		//------------------------------------
		if (pChk == "Y") {
			// 로그인 체크...
			if (!FnLoginCheck(pUrl)) {return;}
		}
		//------------------------------------

		if (pGb == "store") {
		} else {
			$("#commonFrm input[name=returnSearchText]").val("");
			$("#commonFrm input[name=returnCategory1]").val("");
			$("#commonFrm input[name=returnIndex1]").val("0");
			if (pGb == "plan") {
				if (pIdx != undefined) {
					$("#commonFrm input[name=returnIndex1]").val(pIdx);
				}
			}
			$("#commonFrm input[name=returnCategory2]").val("");
			$("#commonFrm input[name=returnIndex2]").val("0");
			$("#commonFrm input[name=returnPage]").val("0");
		}

		if (pGb != undefined) {
			$("#commonFrm input[name=returnTypeGb]").val(pGb);
		}
		if (pNo != undefined) {
			if (pGb == "goods" || pGb == "curator" || pGb == "tag") {
				$("#commonFrm input[name=returnCategory1]").val(pNo);
			} else if (pGb == "search" || pGb == "searchMain") {
				$("#commonFrm input[name=returnSearchText]").val(pNm);
			} else if (pGb == "reservation") {
				$("#commonFrm input[name=returnNo]").val(pNo);
			} else {
				$("#commonFrm input[name=returnNo]").val(pNo);
			}
		}
		if (pNm != undefined) {
			$("#commonFrm input[name=returnPageTitle]").val(pNm);
		}
		if (pNo2 != undefined) {
			$("#commonFrm input[name=returnCategory2]").val(pNo2);
		}

		var strUrl = "<c:out value='${sysPcGubunUrl}'/>/" + pUrl;
		$("#commonFrm").attr("action", strUrl);
		$('#commonFrm').submit();
	}

	function goPageLocation(pChk, pUrl, pGb, pNo, pNm, pIdx, pNo2) {
		//------------------------------------
		if (pChk == "Y") {
			// 로그인 체크...
			if (!FnLoginCheck(pUrl)) {return;}
		}
		//------------------------------------

		var strParam = "?returnTypeGb="+pGb;
		strParam += "&returnPageTitle="+encodeURI(encodeURIComponent(pNm));
		strParam += "&returnSearchText=";
		strParam += "&returnCategory1="+pNo;
		if (pNo2 != undefined) {
			strParam += "&returnCategory2="+pNo2;
		}
		//strParam += "&returnNo=";

		var strUrl = "<c:out value='${sysPcGubunUrl}'/>/" + pUrl + strParam;
		location.href = strUrl;
	}

	function goPrePageSubmit(pGubun, pIdx1, pIdx2) {
		//alert(document.commonFrm.returnURL.value+"-"+pGubun+"-"+pIdx1+"-"+pIdx2);
		var returnURL = $("#commonFrm input[name=returnURL]").val();

		if (pGubun == undefined || pGubun == "back") {
			history.back(-1);
		} else {
			if (pGubun == "main") {
				location.href = "<c:out value='${sysPcGubunUrl}/shopMain.do' />";
			} else if (pGubun == "planMaster") {
				history.go(-1);
				//goPageSubmit("N", "plan/planMasterList.do", "plan", "", "두레 기획전", pIdx2);
			} else if (pGubun == "cart") {
				$("#commonFrm input[name=returnCartTab]").val("${returnCartTab}");
				goPageSubmit("Y", "cart/cart.do");
			/* } else if (pGubun == "order_step1") {
				goPageSubmit("Y", "order/orderStep1.do"); */
			} else if (pGubun == "guestCenter") {
				history.back(-1);
			} else if (pGubun == "store") {
				goPageSubmit("N", "store/storeList.do", pGubun);
			} else if (pGubun == "location") {
				if (returnURL == "") {
					location.href = "<c:out value='${sysPcGubunUrl}/shopMain.do' />";
				} else {
					if("<c:out value='${appCheck}'/>" == ""){
						if (returnURL.search("member/") >= 0) {
	                        var strUrl = "<c:out value='${sysPcGubunUrl}'/>/" + returnURL;
	                        $("#frm").attr("action", strUrl);
	                        $('#frm').submit();
	                    } else {
	                        location.href = "<c:out value='${sysPcGubunUrl}/' />" + returnURL;
	                    }
					} else {
						if (returnURL.search("member/") >= 0) {
							location.href = "<c:out value='${sysPcGubunUrl}/shopMain.do' />";
                        } else {
                        	location.href = "<c:out value='${sysPcGubunUrl}/' />" + returnURL;
                        }

					}
				}
			} else {
				if("<c:out value='${appCheck}'/>" == ""){
					goMainTopCategory("N", pIdx1, pIdx2);
				}else{
					history.go(-1);
				}
			}
		}
	}

	/* 전체체크... */
	function FnCheckBox(pId, pStopId, pCnt, boolCH) {
		for (var i=0; i<pCnt; i++) {
			if (pStopId == "") {
				$(pId+"_"+i).prop('checked', boolCH);
			} else {
				if ($(pStopId+"_"+i).val() == "N") {
					$(pId+"_"+i).prop('checked', boolCH);
				}
			}
		}
	}

	/* 페이지이동 GET */
	function goLocationPage(pUrl) {
		location.href = "${sysPcGubunUrl}"+pUrl;
	}

	/* 로그인 */
	function goLoginSubmit() {
		if("<c:out value='${appCheck}'/>" == ""){
			$("#commonFrm input[name=returnURL]").val("");
	        $("#commonFrm").attr("action", "<c:out value='${sysPcGubunUrl}'/>/login/login.do");
	        $("#commonFrm").submit();
		}else{
			location.href = "/DureShop/login/mobileLogin.do";
		}
	}

	// 로그아웃
	function goLogoutSubmit() {
		$("#commonFrm").attr("action", "${sysPcGubunUrl}/login/logout.do");
		$("#commonFrm").submit();
	}

	function goMainTopCategory(pGubun, pIdx1, pIdx2, pIdx3, pCate2) {
		if ("${mobile}" == "mobile") {
			if (pGubun == "Y") {
				cate_off();
			}
		}

		/*var strUrl = "/shopMain.do";
		if ("${mobile}" == "shop") {
			strUrl = "/main/subHome.do";
		}*/

		var strUrl = "";
		if (pIdx1 == 1) {
			strUrl = "/recommend.do";
		} else if (pIdx1 == 2) {
			strUrl = "/benefit.do";
		} else if (pIdx1 == 3) {
			strUrl = "/new.do";
		} else if (pIdx1 == 4) {
			if (pIdx2 == 0) {
				strUrl = "/reservation.do";
			} else if (pIdx2 == 1) {
				strUrl = "/sanjii.do";
			}
		} else if (pIdx1 == 5) {
			strUrl = "/recipe.do";
		} else if (pIdx1 == 6) {
			strUrl = "/story.do";
		}

		$("#commonFrm input[name=msinTopIdx]").val(pIdx1);
		$("#commonFrm input[name=returnIndex1]").val(pIdx2);

		if (pIdx3 != undefined) {
			$("#commonFrm input[name=returnIndex2]").val(pIdx3);
		}
		if (pCate2 != undefined) {
			$("#commonFrm input[name=returnCategory2]").val(pCate2);
		}

		//요리조리 두레이야기
		if (pIdx1 == 5 || pIdx1 == 6) {
			$("#commonFrm input[name=returnCategory1]").val(0);
		}

		var strUrl = "<c:out value='${sysPcGubunUrl}' />" + strUrl;
		$("#commonFrm").attr("action", strUrl);
		$('#commonFrm').submit();

	}

	/*
	[생활재 상세보기]
	pGoodsGb : 생활재구분
	pGoodsNo : 생활재번호
	*/
	function moveProdDetail(pGoodsGb, pGoodsNo, pPlanNo) {
		$("#commonFrm input[name=returnTypeGb]").val(pGoodsGb);
		$("#commonFrm input[name=returnNo]").val(pGoodsNo);

		if (pPlanNo != undefined) {
			$("#commonFrm input[name=returnPlanNo]").val(pPlanNo);
		}

		if (pGoodsGb == "02" || pGoodsGb == "05" || pGoodsGb == "06") {
			message_layer_open("배송일 선택을 위하여<br/>상세페이지로 이동합니다.", "/prod/goodsView.do");
		} else {
			var strUrl = "<c:out value='${sysPcGubunUrl}/prod/goodsView.do'/>";
			$("#commonFrm").attr("action", strUrl);
			$('#commonFrm').submit();
		}
	}

	function FnBasketAddCheck(pGoodsGb, pAdultYn) {
		// 로그인 체크...
		if (!FnLoginCheck()) {return false;}

		//----------------------------------------------------
		// 장바구니 페이지 탭 정의...
		if (pGoodsGb == "05" || pGoodsGb == "06") {
			$("#commonFrm input[name=returnCartTab]").val(3);
		} else if (pGoodsGb == "04") {
			$("#commonFrm input[name=returnCartTab]").val(2);
		} else if (pGoodsGb == "02") {
			$("#commonFrm input[name=returnCartTab]").val(1);
		} else {
			$("#commonFrm input[name=returnCartTab]").val(0);
		}
		//----------------------------------------------------

		// 준조합원 주간생활재만 사용가능, 조합원(CMS,빌링) 체크...
		if (!FnGuestUseAddCheck(pGoodsGb)) {return false;}

		// 성인인증 체크...
		if (!FnAdultCheck(pAdultYn)) {return false;}

		if ("${sessionLoginVO.guestClassCd}" == "10" || "${sessionLoginVO.guestClassCd}" == "11") {
			layerMsgShow("조합원만 쇼핑몰 주문이 가능합니다.", "확인", "N");
			return false;
		}

		if ("${sessionLoginVO.orderAllow}" == "Y") {
			layerMsgShow("외상금 잔액 결제 후 주문이 가능합니다.<br>자세한 내용은 ${sessionLoginVO.propNm}으로 문의바랍니다.<br>(Tel. ${sessionLoginVO.propTel})", "확인", "N");
			return false;
		}

		if (pGoodsGb == "01" || pGoodsGb == "04") {
			var strDeliveryDate = "";
			if ("${mobile}" == "mobile") {
				strDeliveryDate = "${sessionLoginVO.deliveryDate}";
			} else if ("${mobile}" == "shop") {
				strDeliveryDate = $("#deliveryFrm input[name=deliveryDate]").val();
			}
			if (strDeliveryDate == "") {
				layerMsgShow("배송일을 선택하지 않았습니다.", "확인", "N", "deliveryFrm");
				return false;
			}
		} else {
			if ($("#id_view_deliveryDate").val() == "") {
				layerMsgShow("배송일을 선택하지 않았습니다.", "확인", "N");
				return false;
			}
		}

		return true;
	}

	/*
	[장바구니 저장 또는 저장후 바로가기]
	pGoodsGb : 생활재구분(01:일반, 02:사전예약, 04:산지, 05:택배예약(일반), 04:택배예약(산지))
	pGoodsNo : 생활재번호
	pQty : 수량
	pType : 타입(S:저장, M:저장후 바로가기)
	pResNo : 예약키값(예약일경우)
	pPlanNo : 택배예약 기획전번호
	pAdultYn : 성인인증여부
	*/
	function addBasket(pType, pGoodsGb, pGoodsNo, pQty, pResNo, pPlanNo, pAdultYn, pTimeYn) {

		var strChkMessage = "";
		var strLayerTitle = "";
		if (pType == "M") {
			strLayerTitle = "[바로구매]";
		} else {
			strLayerTitle = "[장바구니]";
		}

		// 장바구니 저장시 체크...
		if (!FnBasketAddCheck(pGoodsGb, pAdultYn)) {return;}

		if (pGoodsGb == "01" && pTimeYn == "Y") {
			if (!CountDownTimerCheck('${dataTimeSale.closeDate}', '${dataTimeSale.closeTime}')) {
				layerMsgShow("타임세일이 종료된 생활재입니다.", "확인", "N");
				return;
			}
		}

		// 조합원 CMS,빌링카드 체크...
		if ((pGoodsGb == "02") || (pGoodsGb == "04") || (pGoodsGb == "05") || (pGoodsGb == "06")) {
			var strBillCardCnt = FnBillCardChk();
			//alert("${sessionLoginVO.cmsYn}" +"-"+ strBillCardCnt);
			if ("${sessionLoginVO.cmsYn}" == "N" && strBillCardCnt == 0) {
				layerMsgShow2("billCard", "후불카드(빌링)등록 후 사용가능합니다.<br>카드등록 페이지로 이동하시겠습니까?", '아니오', '예', 'Y');
				return;
			}
		}

		// 공급일자
		var strDlDate = "";
		// 예약생활재 마감일자
		var strResEndDate = "";
		if (pGoodsGb == "01" || pGoodsGb == "04") {
			if ("${mobile}" == "mobile") {
				strDlDate = "${sessionLoginVO.deliveryDate}";
			} else if ("${mobile}" == "shop") {
				strDlDate = $("#deliveryFrm input[name=deliveryDate]").val();
			}
		} else {
			if (pGoodsGb == "02") {
				strResEndDate = $("#id_view_deliveryEndDate").val();
			}
			strDlDate = $("#id_view_deliveryDate").val();
		}

		var dataParam = {};
		dataParam['uPcGubun'] = "${sysPCGubun}";
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pGoodsGb'] = pGoodsGb;
		dataParam['pGoodsNo'] = pGoodsNo;
		dataParam['pQty'] = pQty;
		dataParam['pResNo'] = pResNo;
		dataParam['pPlanNo'] = pPlanNo;
		dataParam['pDlDate'] = strDlDate;
		dataParam['pResEndDate'] = strResEndDate;
		$.ajax({
			url : "${sysPcGubunUrl}/cart/ajaxAddBasket.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				resultAddBasket(data, pType);
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	function addBasketV2(pType, pGoodsGb, pGoodsNo, pQty, pAdultYn, pGubun, pGubunNo) {

		var strChkMessage = "";
		var strLayerTitle = "";
		if (pType == "M") {
			strLayerTitle = "[바로구매]";
		} else {
			strLayerTitle = "[장바구니]";
		}

		// 장바구니 저장시 체크...
		if (!FnBasketAddCheck(pGoodsGb, pAdultYn)) {return;}

		if (pGoodsGb == "01") {
			if (pGubun == "time" && pGubunNo > 0) {
				if (!CountDownTimerCheck('${dataTimeSale.closeDate}', '${dataTimeSale.closeTime}')) {
					layerMsgShow("타임세일이 종료된 생활재입니다.", "확인", "N");
					return;
				}
			}
		}

		// 조합원 CMS,빌링카드 체크...
		/*
		// 이전 사용...
		if ((pGoodsGb == "02") || (pGoodsGb == "04") || (pGoodsGb == "05") || (pGoodsGb == "06")) {
			var strBillCardCnt = FnBillCardChk();
			//alert("${sessionLoginVO.cmsYn}" +"-"+ strBillCardCnt);
			if ("${sessionLoginVO.cmsYn}" == "N" && strBillCardCnt == 0) {
				layerMsgShow2("billCard", "후불카드(빌링)등록 후 사용가능합니다.<br>카드등록 페이지로 이동하시겠습니까?", '아니오', '예', 'Y');
				return;
			}
		}
		*/

		// 공급일자
		var strDlDate = "";
		// 예약생활재 마감일자
		var strResEndDate = "";
		if (pGoodsGb == "01" || pGoodsGb == "04") {
			if ("${mobile}" == "mobile") {
				strDlDate = "${sessionLoginVO.deliveryDate}";
			} else if ("${mobile}" == "shop") {
				strDlDate = $("#deliveryFrm input[name=deliveryDate]").val();
			}
		} else {
			if (pGoodsGb == "02") {
				strResEndDate = $("#id_view_deliveryEndDate").val();
			}
			strDlDate = $("#id_view_deliveryDate").val();
		}

		var dataParam = {};
		dataParam['uPcGubun'] = "${sysPCGubun}";
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pGoodsGb'] = pGoodsGb;
		dataParam['pGoodsNo'] = pGoodsNo;
		dataParam['pQty'] = pQty;
		dataParam['pGubun'] = pGubun;
		dataParam['pGubunNo'] = pGubunNo;
		dataParam['pDlDate'] = strDlDate;
		dataParam['pResEndDate'] = strResEndDate;
		$.ajax({
			url : "${sysPcGubunUrl}/cart/ajaxAddBasketV2.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				// GA4: 장바구니 추가 이벤트 (성공 시)
				if (data.errCode == "N" && typeof DureGA4 !== 'undefined') {
					DureGA4.addToCart({
						goodsNo: pGoodsNo,
						goodsNm: data.goodsNm || '',
						price: data.saleAmt || 0,
						firstCd: data.firstCd || ''
					}, pQty);
				}
				resultAddBasket(data, pType);
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	function resultAddBasket(data, pType) {
		var intBasketCnt = Number(data.basketCnt);
		var strErrCode = data.errCode;
		var strErrMag = data.errMsg;
		//alert(intBasketCnt+"-"+strErrCode+"-"+strErrMag);
		if (strErrCode == "N") {
			if (pType == "M") {
				//location.href = "<c:out value='${sysPcGubunUrl}/cart/cart.do'/>";
				goPageSubmit("Y", "cart/cart.do");
			} else {
				//layerMsgShow("장바구니에 추가 되었습니다.", "확인", "N");
				message_layer_open("장바구니에 추가 되었습니다.");
				FnBasketCount(intBasketCnt);
				return;
			}

			if (gLocationUrl.search("goodsView.do") >= 0) {
				$("#orderCnt").val(1);
			}

		} else if (strErrCode == "L") {
			layerMsgShow("세션이 종료되었습니다.", "확인", "Y", "login");
			return;
		} else if (strErrCode == "D") {
			layerMsgShow2("cart", strErrMag, '아니오', '예', 'Y');
			return;
		} else {
			layerMsgShow(strErrMag, "확인", "N");
			return;
		}
	}

	function addBasketBatch(pCnt) {
		var strGoodsNo = "";
		for (var i=0; i<pCnt; i++) {
			if (document.getElementById("check_"+i).checked) {
				if (document.getElementById("stopYn_"+i).value == "N") {
					strGoodsNo += document.getElementById("goodsNo_"+i).value + ",";
				}
			}
		}

		if (strGoodsNo == "") {
			layerMsgShow("선택한 항목이 없습니다.", "확인", "N");
			return;
		} else {
			strGoodsNo = strGoodsNo.substring(0, strGoodsNo.length-1);
		}

		addBasketBatchSave(strGoodsNo, pCnt);
	}

	function addBasketBatchSave(pGoods, pCnt) {
		// 장바구니 저장시 체크...
		if (!FnBasketAddCheck("01", "N")) {return;}

		$("#commonFrm input[name=returnCartTab]").val(0);

		// 공급일자
		var strDlDate = "";
		if ("${mobile}" == "mobile") {
			strDlDate = "${sessionLoginVO.deliveryDate}";
		} else if ("${mobile}" == "shop") {
			strDlDate = $("#deliveryFrm input[name=deliveryDate]").val();
		}

		var dataParam = {};
		dataParam['uPcGubun'] = "${sysPCGubun}";
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pDlDate'] = strDlDate;
		dataParam['pGoodsNo'] = pGoods;
		$.ajax({
			url : "${sysPcGubunUrl}/cart/ajaxAddBasketBatch.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				resultAddBasket(data, "S");
				if (data.errCode == "N") {
					if (gLocationUrl.search("reOrderList.do") == -1) {
	 					FnCheckBox("#check", "#stopYn", pCnt, false);
	 					$("#allCheck").prop('checked', false);
					}
					return;
				}
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	// 게시판 조회수 저장...
	function FnBoardVisitSave(pGubun, pNo) {
		var strUrl = "";
		if (pGubun == "Q") {
			strUrl = "${sysPcGubunUrl}/board/ajaxQnaBoardVisitSave.do";
		} else if (pGubun == "U") {
			strUrl = "${sysPcGubunUrl}/board/ajaxReviewBoardVisitSave.do";
		} else {
			return;
		}

		var dataParam = {};
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pMobile'] = "${mobile}";
		dataParam['pNo'] = pNo;
		$.ajax({
			url : strUrl,
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				//alert(data.errCode+"-"+data.errMsg);
				if (data.errCode == "N") {
				} else {
					console.log(data.errMsg);
					return false;
				}
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	// 베너클릭 조회수 저장후 페이지 이동...
	function FnBannerLink(pUrl, pType, pNo) {
		// GA4: 배너 클릭 이벤트
		if (typeof DureGA4 !== 'undefined') {
			DureGA4.bannerClick({
				id: pNo,
				name: '배너_' + pType + '_' + pNo,
				position: pType,
				url: pUrl
			});
		}

		var dataParam = {};
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pMobile'] = "${mobile}";
		dataParam['pType'] = pType;
		dataParam['pNo'] = pNo;
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxBannerReadSave.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				if (data == "N") {
					if(pNo == '40'){
						//alert("A");
						goMainTopCategory("N", 4, 0, 3, "06");
					}else{
						location.href = "${sysPcGubunUrl}"+pUrl;
					}
				} else {
					console.log(data.errMsg);
					return false;
				}
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	// 베너클릭 조회수 저장후 페이지 이동...
	function FnDureReadCntUpdate(pType, pNo) {
		var dataParam = {};
		dataParam['pType'] = pType;
		dataParam['pMallCd'] = "${sysMallCd}";
		dataParam['pYear'] = "${sysDeliveryYear}";
		dataParam['pWeek'] = "${sysDeliveryWeek}";
		dataParam['pNo'] = pNo;
		dataParam['pMobile'] = "${mobile}";
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxDureReadCntUpdate.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				console.log(data.errMsg);
			}, error: function(xhr,status,error){
				console.log("오류가 발생했습니다.");
				return false;
			}
		});
	}

	// pType : 두레추천 상세클릭(dureRecom1), 두레추천 장바구니클릭(dureRecom2)
	// pGubun : 생활재구분(iiGubun)
	// pNo : 생활재번호(goodsNo)
	// pAdultchkYn : 성인인증구분
	function FnDureReadCntLink(pType, pNo, pGubun, pGoods, pAdultchkYn) {
		FnDureReadCntUpdate(pType, pNo);
		if (pType == "dureRecom1") {
			moveProdDetail(pGubun, pNo, 0);
		} else if (pType == "dureRecom2") {
			/* if ("<c:out value='${sessionLoginVO}' />" != "") {
				FnDureReadCntUpdate(pType, pNo);
			} */
			addBasketV2('S', pGubun, pGoods, 1, pAdultchkYn, '', 0);
		} else if (pType == "cart") {
			addBasketV2('M', pGubun, pGoods, 1, pAdultchkYn, '', 0);
		}
	}

	function FnPopupLink(pType, pGubun, pNo, pUrl) {
		if (pType == "cart" || pType == "video" || pType == "plan") {
			FnDureReadCntUpdate(pType, pNo);
		}
		location.href = "${sysPcGubunUrl}"+pUrl;
	}
</script>

<script type="text/javascript">
	/* 세션 체크 */
	function FnSessionCheck(pTitle) {
		if ("<c:out value='${sessionLoginVO}' />" == "") {
			layerMsgShow("세션이 종료되었습니다.", "확인", "Y", "login");
            return false;
		} else {
			return true;
		}
	}

	/* 로그인 체크 */
	function FnLoginCheck(pUrl) {
		if ("<c:out value='${sessionLoginVO}' />" == "") {
			var strGubun = "login";
			if ("<c:out value='${appCheck}'/>" == "") {
				/* if (pUrl != undefined) {
					$("#commonFrm input[name=returnURL]").val(pUrl);
					var strUrl = "<c:out value='${sysPcGubunUrl}'/>/login/login.do";
					if (pUrl == "my/myDure.do" || pUrl == "my/myGoods.do") {
						$("#commonFrm").attr("action", strUrl);
						$('#commonFrm').submit();
					} else {
						location.href = "<c:out value='${sysPcGubunUrl}'/>/login/login.do";
					}
				} else {
					layerMsgShow2(strGubun, '로그인이 필요한 서비스입니다.<br>로그인 하시겠습니까?', '아니오', '예', 'Y');
				} */
				if (pUrl != undefined) {
					$("#commonFrm input[name=returnURL]").val(pUrl);
				}
				layerMsgShow2(strGubun, '로그인이 필요한 서비스입니다.<br>로그인 하시겠습니까?', '아니오', '예', 'Y');
			} else {
				location.href = "/DureShop/login/mobileLogin.do";
			}
			return false;
		} else {
			return true;
		}
	}

	/* 성인인증 체크 */
	function FnAdultCheck(pAdultYn) {
		if (pAdultYn == "Y") {
			var strGuestBirth = "${sessionLoginVO.guestBirth}";
			strGuestBirth = strGuestBirth.trim();
			var datetmp = strGuestBirth.replace( /-/gi, '');
			if (datetmp == "") {
				layerMsgShow("해당 생활재는 성인인증 후 주문 가능합니다.", "확인", "N", "adult");
				return false;
			} else {
				if (!isAdultCheck("${sessionLoginVO.guestBirth}")) {
					layerMsgShow("만 19세 이상 성인인증이 필요한 생활재입니다.", "확인", "N");
					return false;
				}
			}
		}
		return true;
	}

	/* 준조합원 만료 체크 */
	function FnActiveNCheck(pTitle) {
		if (("${sessionLoginVO.activeYn}" == "N") && ("${sessionLoginVO.overYn}" == "Y")) {
			if (!confirm("["+pTitle+"]" + "무료체험 기간이 만료되었습니다.\n조합원 전환 후 다시 주문하실 수 있습니다.")) {
				return false;
			} else {
				location.href = "<c:out value='${sysPcGubunUrl}/my/guestPayment.do'/>";
	            return false;
			}
		} else {
			return true;
		}
	}

	/* 조합원상태에 대한 생활재 주문가능 체크 */
	function FnGuestUseAddCheck(pGoodsGb) {
		return true;

		var strChkMessage = "";
		if ("${sessionLoginVO.activeYn}" == "N") {
			if ((pGoodsGb == "02") || (pGoodsGb == "04") || (pGoodsGb == "06")) {
				if (pGoodsGb == "02") {
					strChkMessage = "예약생활재는";
				} else if (pGoodsGb == "04") {
					strChkMessage = "산지택배 생활재는";
				} else if (pGoodsGb == "06") {
					strChkMessage = "택배예약 생활재는";
				}
				layerMsgShow(strChkMessage + " 조합원만 사용가능합니다.", "확인", "N");
				return false;
			} else {
				return true;
			}
		} else {
			return true;
		}
	}

	function FnBillCardChk() {
		var strResult = 0;
		var dataParam = {};
		dataParam['pMallCd'] = "${sysMallCd}";
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxBillCardChk.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(retdata) {
				strResult = retdata;
			}, error: function(xhr,status,error){
			}
		});
		return strResult;
	}

	function FnPageInit(pGubun, pParam) {
		var strUrl = "";
		if (pGubun == "cart") {
			strUrl = "cart/cart.do";
		} else if (pGubun == "join") {
			strUrl = "shopMain.do";
		}

		var dataParam = {};
		dataParam['pGubun'] = pGubun;
		dataParam['pParam'] = pParam;
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxPageInit.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(retdata) {
				if (retdata > 0) {
					if (strUrl != "") {
						goPageSubmit("Y", strUrl);
					}
					return false;
				}
			}, error: function(xhr,status,error){
			}
		});
	}

	/* 세션값 변경 DB */
	function FnSessionChange(pGuestNo){
		var strNo = "${sessionLoginVO.guestNo}";
		if (pGuestNo != undefined) {
			strNo = pGuestNo;
		}
		var dataParam = {};
		dataParam['pFlag1'] = strNo;
		$.ajax({
			url : "${sysPcGubunUrl}/login/ajaxLoginJoin.do",
			type: "post",
			cache : false,
			data : dataParam,
			success : function(retdata) {
				if (pGuestNo != undefined) {
					$("#commonFrm").attr("action", "${sysPcGubunUrl}/shopMain.do");
					$("#commonFrm").submit();
				}
			}, error: function(xhr,status,error){
			}
		});
	}

	function FnGuestSessionChange(pType){
		var dataParam = {};
		dataParam['pType'] = pType;
		$.ajax({
			url : "${sysPcGubunUrl}/guest/ajaxGuestSessionChange.do",
			type: "post",
			cache : false,
			data : dataParam,
			success : function(retdata) {
			}, error: function(xhr,status,error){
			}
		});
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild (el.lastChild);
		}
	}

	function FndownFile(pGubunCd,pKeyCd, pAtName, pAtNo){
		window.open("<c:url value='/util/file/FileDown.do?pMallCd=${sysMallCd}&pGubunCd="+pGubunCd+"&pKeyCd="+pKeyCd+"&pAtName="+pAtName+"&pAtNo="+pAtNo+"'/>");
	}

	var request = null;
	createRequest();
	function createRequest() {
		try {
			request = new XMLHttpRequest();
		} catch(trymicrosoft) {
			try {
				request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (othermicrosoft) {
				try {
					request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch(failed) {
					request = null;
				}
			}
		}
		if(request == null) location.reload();
		//alert (request);
	}
</script>

<!-- 타이머 -->
<script>
	function CountDownTimer(pDate, pHour) {
		var arrTimeDate = pDate.split("-");
		var theyear = arrTimeDate[0];
		var themonth = arrTimeDate[1];
		var theday = arrTimeDate[2];
		//var thhour = pHour;
		var thhour = pHour.substr(0,2);
		var thminute = pHour.substr(2);

		var end = new Date(theyear, themonth-1, theday, thhour, thminute);
		//console.log(end);

		var _second = 1000;
		var _minute = _second * 60;
		var _hour = _minute * 60;
		var _day = _hour * 24;
		var timer;

		function showRemaining() {
			var now = new Date();
			var distance = end - now;
			if (distance < 0) {
				clearInterval(timer);
				$('.timerTop').html("종료");
				return;
			}
			var days = Math.floor(distance / _day);
			var hours = Math.floor((distance % _day) / _hour);
			var minutes = Math.floor((distance % _hour) / _minute);
			var seconds = Math.floor((distance % _minute) / _second);

			var strTimer = "";
			if (days > 0) {
				strTimer = days+"일 "+hours+":"+minutes+":"+seconds;
			} else {
				strTimer = hours+":"+minutes+":"+seconds;
			}

			$('.timer').html(strTimer);
		}
		timer = setInterval(showRemaining, 1000);
	}

	function CountDownTimerCheck(pDate, pHour) {
		var bResult = true;

		var arrTimeDate = pDate.split("-");
		var theyear = arrTimeDate[0];
		var themonth = arrTimeDate[1];
		var theday = arrTimeDate[2];
		//var thhour = pHour;
		var thhour = pHour.substr(0,2);
		var thminute = pHour.substr(2);

		var end = new Date(theyear, themonth-1, theday, thhour, thminute);

		var _second = 1000;
		var _minute = _second * 60;
		var _hour = _minute * 60;
		var _day = _hour * 24;
		var timer;

		var now = new Date();
		var distance = end - now;
		if (distance < 0) {
			bResult = false;
		} else {
			bResult = true;
		}

		return bResult;
	}
</script>
<!-- //타이머 -->

<script type="text/javascript">
	function shareSns(sns, ptitle, pUrl){
        var snsItems = new Array();
        var winOpt = new Array();

        snsItems['facebook'] = "http://www.facebook.com/share.php?t="+encodeURIComponent(ptitle) + "&u=" + encodeURIComponent(pUrl);
        snsItems['blog'] = "http://blog.naver.com/openapi/share?url=" + encodeURIComponent(pUrl) + "&title=" + encodeURIComponent(ptitle);
        snsItems['twitter'] = "https://twitter.com/intent/tweet?text="+encodeURIComponent(ptitle) + "&url=" + encodeURIComponent(pUrl);

        winOpt['facebook'] = "width=500, height=500, resizable=yes";
        winOpt['blog'] = "width=500, height=500, resizable=yes";
        winOpt['twitter'] = "width=500, height=500, resizable=yes";

        var win = window.open(snsItems[sns], sns, winOpt[sns]);
        if (win) {
            win.focus();
        }
    }
</script>

<!-- 카카오공유 -->
<script type="text/javascript">
	function kakaoShare_old(pUrl, pTitle, pDesc, pImg) {
		Kakao.Link.sendDefault({
			objectType: 'feed',
			content: {
				title: pTitle,
        		description: pDesc,
        		imageUrl: pImg,
        		link: {
          			mobileWebUrl: pUrl,
          			webUrl: pUrl,
      			},
      		},
      		buttons: [
        		{
          			title: '웹으로 보기',
          			link: {
            			mobileWebUrl: pUrl,
            			webUrl: pUrl,
          			},
        		},
      		],
      		// 카카오톡 미설치 시 카카오톡 설치 경로이동
      		installTalk: true,
    	})
	}

	function kakaoStoryShare(pUrl, pDesc) {
		Kakao.Story.share({
			url: pUrl,
			text: pDesc,
		})
	}
</script>
<!-- //카카오공유 -->
<!-- 공유하기 -->
<script type="text/javascript">
	//  클립보드 복사하기
	function clipboardShare(pUrl) {
		// 1. 새로운 element 생성
		var tmpTextarea = document.createElement('textarea');

		// 2. 해당 element에 복사하고자 하는 value 저장
		tmpTextarea.value = pUrl;

		// 3. 해당 element를 화면에 안보이는 곳에 위치
		tmpTextarea.setAttribute('readonly', '');
		tmpTextarea.style.position = 'absolute';
		tmpTextarea.style.left = '-9999px';
		document.body.appendChild(tmpTextarea);

		// 4. 해당 element의 value를 시스템 함수를 호출하여 복사
		tmpTextarea.select();
		tmpTextarea.setSelectionRange(0, 9999);  // 셀렉트 범위 설정
		var successChk = document.execCommand('copy');

		// 5. 해당 element 삭제
		document.body.removeChild(tmpTextarea);

		// 클립보드 성공여부 확인
		if(!successChk){
			//alert("클립보드 복사에 실패하였습니다.");
		} else {
			//alert("클립보드에 복사가 완료되었습니다.");
			message_layer_open("클립보드에 복사가<br>완료되었습니다.");
			share_close();
		}
	}

	function linkSns(pSns, pUrl){
		if(pSns == 'kas'){
			//카카오 스토리
			popOpen("https://story.kakao.com/s/login?continue=https://story.kakao.com/share?url=" + encodeURIComponent(pUrl)+'&newPage=true', "winPopupSNS", 950, 570);
		}else if(pSns == 'blog'){
			//블로그
		}else if(pSns == 'facebook'){
			//페이스북
			 //popOpen("https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(pUrl), "winPopupSNS", 650, 450);
			 window.open("https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(pUrl)+'&newPage=true', "winPopupSNS", "width=650,height=450");
		}else if(pSns == 'insta'){
			//인스타
		}else if(pSns == 'twitter'){
			//트위터
			 popOpen("http://twitter.com/share?text=" + encodeURIComponent(document.title) + "&url=" + encodeURIComponent(pUrl)+'&newPage=true', "winPopupSNS", 650, 450);
		}
	}

</script>

<!-- kakao sdk 호출 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('<%=EgovProperties.getProperty("Globals.kakao.appkey")%>');

	// SDK 초기화 여부를 판단합니다.
	//console.log(Kakao.isInitialized());

	function kakaoShare(pUrl, pTitle, pImg, pId) {

        Kakao.Link.sendDefault({
            objectType: 'feed',
                content: {
                title: pTitle,
                description: '추천인 아이디 : '+pId,
                imageUrl: pImg,
                link: {
                    mobileWebUrl: pUrl,
                    webUrl: pUrl,
                },
            },
            buttons: [
                {
                    title: '웹으로 보기',
                    link: {
                    mobileWebUrl: pUrl,
                    webUrl: pUrl,
                    },
                },
            ],
            // 카카오톡 미설치 시 카카오톡 설치 경로이동
            installTalk: true,
        })
    }
</script>
</script>
<!-- //공유하기 -->

<!-- 메시지 레이어 -->
<input type="hidden" id="lyValue" value="" />
<input type="hidden" id="lyValue2" value="" />
<input type="hidden" id="lyValue3" value="" />
<input type="hidden" id="lyValue4" value="" />
<input type="hidden" id="lyGubun" value="" />
<input type="hidden" id="lySubmit" value="" />
<jsp:include page="/include/${mobile}/commLayerPop.jsp" />
<script type="text/javascript">
	var toastTimer = null;

	function message_layer_open(pMsg, pUrl) {
		// PC(shop)에서는 토스트 알림 사용
		if ("${mobile}" == "shop" && $('#toastWrap').length > 0) {
			showToast(pMsg, pUrl);
		} else if ("${mobile}" == "mobile" && $('#cartToastMobile').length > 0 && pMsg.indexOf('장바구니') >= 0) {
			// 모바일에서 장바구니 메시지일 때 토스트 사용
			showCartToastMobile(pMsg);
		} else {
			// 모바일에서는 기존 방식 유지
			$('#lyMessage1').html(pMsg);
			$('.layer_pop_wrap').show();
			if (pUrl != undefined) {
				setTimeout(function() {
					$(".layer_pop_wrap").animate({
						opacity: "hide"
					});
					var strUrl = "<c:out value='${sysPcGubunUrl}'/>" + pUrl;
					$("#commonFrm").attr("action", strUrl);
					$('#commonFrm').submit();
				}, 1000);
			} else {
				setTimeout(function() {
					$(".layer_pop_wrap").animate({
						opacity: "hide"
					});
				}, 1000);
			}
		}
	}

	// 토스트 알림 표시
	function showToast(pMsg, pUrl) {
		if (toastTimer) {
			clearTimeout(toastTimer);
		}

		$('#toastMsg').html(pMsg);
		$('#toastWrap').removeClass('hide').addClass('show');

		// 3초 후 자동 닫기
		toastTimer = setTimeout(function() {
			closeToast();
			if (pUrl != undefined) {
				var strUrl = "<c:out value='${sysPcGubunUrl}'/>" + pUrl;
				$("#commonFrm").attr("action", strUrl);
				$('#commonFrm').submit();
			}
		}, 3000);
	}

	// 토스트 닫기
	function closeToast() {
		if (toastTimer) {
			clearTimeout(toastTimer);
			toastTimer = null;
		}
		$('#toastWrap').removeClass('show').addClass('hide');
	}

	// 모바일 장바구니 토스트 표시 (PC 스타일 - 버튼 + 진행바)
	var cartToastTimer = null;
	var cartToastDuration = 3000; // 3초
	function showCartToastMobile(pMsg) {
		if (cartToastTimer) {
			clearTimeout(cartToastTimer);
		}
		$('#cartToastMsg').html(pMsg || '장바구니에 담았습니다');

		// 진행바 초기화
		$('#cartToastProgress').css({
			'width': '100%',
			'transition': 'none'
		});

		// 오버레이 + 팝업 표시
		$('#cartToastOverlay').addClass('show');
		$('#cartToastMobile').addClass('show');

		// 진행바 애니메이션 시작 (약간의 딜레이 후)
		setTimeout(function() {
			$('#cartToastProgress').css({
				'transition': 'width ' + cartToastDuration + 'ms linear',
				'width': '0%'
			});
		}, 50);

		// 5초 후 자동 닫기
		cartToastTimer = setTimeout(function() {
			closeCartToast();
		}, cartToastDuration);
	}

	// 모바일 장바구니 토스트 닫기
	function closeCartToast() {
		if (cartToastTimer) {
			clearTimeout(cartToastTimer);
			cartToastTimer = null;
		}
		$('#cartToastOverlay').removeClass('show');
		$('#cartToastMobile').removeClass('show');
	}

	function layerMsgFocusShow(pMsg, pGubun, pId) {
		$("#lyGubun").val(pGubun);
		if (pId != undefined) {
			$("#lyValue").val(pId);
		}
		$("#lySubmit").val("N");
		$("#lyMessage").html(pMsg);
		$("#id_lyBtnOk").html("확인");
		$(".layer_popmsg_wrap").show();
	}

	function layerMsgShow(pMsg, pBtnY, pSubmit, pGubun, pParam1) {
		if (pGubun != undefined) {
			$("#lyGubun").val(pGubun);
		}
		if (pParam1 != undefined) {
			$("#lyValue").val(pParam1);
		}
		$("#lySubmit").val(pSubmit);
		$("#lyMessage").html(pMsg);
		$("#id_lyBtnOk").html(pBtnY);
		$(".layer_popmsg_wrap").show();
	}

	function layerMsgShow2(pGubun, pMsg, pBtnN, pBtnY, pSubmit, pParam1, pParam2, pParam3, pParam4) {
		if (pParam1 != undefined) {
			$("#lyValue").val(pParam1);
		}
		if (pParam2 != undefined) {
			$("#lyValue2").val(pParam2);
		}
		if (pParam3 != undefined) {
			$("#lyValue3").val(pParam3);
		}
		if (pParam4 != undefined) {
			$("#lyValue4").val(pParam4);
		}
		$("#lyGubun").val(pGubun);
		$("#lySubmit").val(pSubmit);
		$("#lyMessage2").html(pMsg);
		$("#id_lyBtnCancel2").html(pBtnN);
		$("#id_lyBtnOk2").html(pBtnY);
		$(".layer_popmsg_wrap2").show();
	}

	// 레이어 OK 이동
	function goLayerOkSubmit(){
		var strUrl = "";

		// 포커스...
		if ($("#lyGubun").val() == "focus") {
			var objId = $("#lyValue").val();
			$(objId).focus();
		} else if ($("#lyGubun").val() == "notFocus") {
			return;
		} else {
			// 메인...
			if ($("#lyGubun").val() == "main") {
				strUrl = "<c:url value='/shopMain.do' />";
			// 로그인...
			} else if ($("#lyGubun").val() == "login") {
				$("#commonFrm input[name=returnGuestId]").val($("#lyValue").val());
				strUrl = "${sysPcGubunUrl}/login/login.do";
				// 로그인2...
			} else if ($("#lyGubun").val() == "webview") {
				//strUrl = "${sysPcGubunUrl}/login/mobileLogin.do";
				location.href = "/DureShop/login/mobileLogin.do";
			// 로그아웃...
			} else if ($("#lyGubun").val() == "logout") {
				goLogoutSubmit();
			// 장바구니...
			} else if ($("#lyGubun").val() == "cart") {
				/* if ("${mobile}" == "mobile") {
					strUrl = "${sysPcGubunUrl}/cart/cart.do";
				} else if ("${mobile}" == "shop") {
					if (gLocationUrl.search("cart.do") >= 0) {
						$("#id_cart_delivertDate_0").html($("#lyValue").val());
						$("#id_cart_delivertDate_2").html($("#lyValue").val());
						delivery_date_off();
					} else {
						strUrl = "${sysPcGubunUrl}/cart/cart.do";
					}
				} */
				if ("${mobile}" == "shop") {
					delivery_date_off();
				}
				strUrl = "${sysPcGubunUrl}/cart/cart.do";
			// 마이두레...
			} else if ($("#lyGubun").val() == "myDure") {
				strUrl = "${sysPcGubunUrl}/my/myDure.do";
			// 외상금리스트...
			} else if ($("#lyGubun").val() == "creditList") {
				strUrl = "${sysPcGubunUrl}/my/creditList.do";
			// 외상금결제 및 가입출자금...
			} else if ($("#lyGubun").val() == "creditPayment") {
				strUrl = "${sysPcGubunUrl}/my/creditPayment.do";
			// 가입스켑1...
			} else if ($("#lyGubun").val() == "joinStep1") {
				location.href = "${sysPcGubunUrl}/member/joinStep1.do";
				return;
			// 배송일선택...
			} else if ($("#lyGubun").val() == "deliveryFrm") {
				if ("${mobile}" == "mobile") {
					goFormPageSubmit('N', '#deliveryFrm', 'delivery/deliveryDate.do', 'main');
				} else if ("${mobile}" == "shop") {
					FnDeliveryDateOpen();
				}
				return;
			// 성인인증...
			} else if ($("#lyGubun").val() == "adult") {
				if ("${mobile}" == "mobile") {
					location.href = "${pageContext.request.contextPath}/SCI/sci_dure_request.do";
				} else {
					window.open("${pageContext.request.contextPath}/SCI/sci_dure_request.do",'popadult','width=500,height=630,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no');
				}
			// 임산부...
			} else if ($("#lyGubun").val() == "pwFood") {
				if ("${mobile}" == "shop") {
					location.href = "https://ii.ecoop.or.kr/pwFood/member/login.asp";
				} else {
					location.href = "https://ii.ecoop.or.kr/pwFood/mobile/member/login.asp";
				}
			}

			if ($("#lySubmit").val() == "Y") {
				$("#commonFrm").attr("action", strUrl);
				$("#commonFrm").submit();
			} else if ($("#lySubmit").val() == "L") {
				location.href = $("#lyGubun").val();
			}
		}
	}

	function goLayerOkSubmit2(){
		var strUrl = "";

		// 로그인...
		if ($("#lyGubun").val() == "login") {
			strUrl = "${sysPcGubunUrl}/login/login.do";
		// 로그인2...
		} else if ($("#lyGubun").val() == "webview") {
			//strUrl = "${sysPcGubunUrl}/login/mobileLogin.do";
			location.href = "/DureShop/login/mobileLogin.do";
		// 배송일...
		} else if ($("#lyGubun").val() == "delivery") {
			FnAddrDelete($("#lyValue").val(), $("#lyValue2").val());
		// 장바구니...
		} else if ($("#lyGubun").val() == "cart") {
			strUrl = "${sysPcGubunUrl}/cart/cart.do";
		// 장바구니삭제...
		} else if ($("#lyGubun").val() == "cartDelete") {
			// 삭제타입, TAB번호, ROW번호
			FnCartDelete($("#lyValue").val(), $("#lyValue2").val(), $("#lyValue3").val(), $("#lyValue4").val());
		// 쿠폰삭제...
		} else if ($("#lyGubun").val() == "couponDelete") {
			// 타입(삭제,조회), TAB번호, ROW번호
			FnCartCouponDelete($("#lyValue").val(), $("#lyValue2").val(), $("#lyValue3").val());
		// 관심생활재삭제...
		} else if ($("#lyGubun").val() == "myGoodsDelete") {
			addMyGoodsDelete($("#lyValue").val(), $("#lyValue2").val());
		// 빌링카드등록...
		} else if ($("#lyGubun").val() == "billCard") {
			strUrl = "${sysPcGubunUrl}/my/my_bill_list.do";
		} else {
			strUrl = "<c:url value='/shopMain.do' />";
		}

		if ($("#lySubmit").val() == "Y") {
			$("#commonFrm").attr("action", strUrl);
			$("#commonFrm").submit();
		}
	}

	function FnLoginPageRtnId(pStr) {
		var strUrl = "${sysPcGubunUrl}/login/login.do";
		$("#commonFrm input[name=returnGuestId]").val(pStr);
		$("#commonFrm").attr("action", strUrl);
		$('#commonFrm').submit();
	}
</script>
<script type="text/javascript">
	//푸시자동발송처리
	function orderPushSend(orderDate, orderNo, type){

		var moveUrl = "";

		if(type == 'F'){
			moveUrl = "orderFirstPushSend.do";
		} else {
			moveUrl = "orderPushSend.do";
		}

		var dataParam = {};
		dataParam['pMallCd'] = "SP";
		dataParam['pOrderDate'] = orderDate;
		dataParam['pOrderNo'] = orderNo;
		dataParam['pType'] = type;

		$.ajax({
		    url : '${sysPcGubunUrl}/push/'+moveUrl,
		    type : 'post',
		    data : dataParam,
		    dataType:'json',
		    cache : false,
		    async : false,
		    success : function(data) {
		    	  //console.log(data.returnCode);
		    }, error: function(xhr,status,error){
		        console.log("오류가 발생했습니다.");
		        return false;
		    }
		});
	}
</script>
<!-- //메시지 레이어 -->
<!-- 한정수량 -->
<script type="text/javascript">
	//--------------------------------------------------------------------------
	// 1회 제한수량체크...
	function FnLimitDayCheck(DLDATE, GMSEQ, CHKQTY, GMDESC) {
		var bResult = true;
		var dataParam = {};
		dataParam['pDeliveryDate'] = DLDATE;
		dataParam['pGoodsNo'] = GMSEQ;
		dataParam['pChkQty'] = CHKQTY;
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxOrderLimitDayChk.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				//alert(data.limitYn+"-"+data.limitQty);
				if (data.limitYn == "Y") {
					layerMsgShow("[1회 제한수량초과]<br>생활재 : "+GMDESC+"<br>주문가능수량 : "+data.limitQty, "확인", "N");
					bResult = false;
				}
			}, error: function(xhr,status,error){
				layerMsgShow("오류가 발생했습니다.", "확인", "N");
				bResult = false;
			}
		});
		return bResult;
	}
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	// 한정수량체크...
	function FnLimitCheck(GUBUN, DLDATE, GMSEQ, CHKQTY, OLDQTY, GMDESC) {
		var bResult = true;
		var dataParam = {};
		dataParam['pGubun'] = GUBUN;
		dataParam['pDeliveryDate'] = DLDATE;
		dataParam['pGoodsNo'] = GMSEQ;
		dataParam['pChkQty'] = CHKQTY;
		dataParam['pOldQty'] = OLDQTY;
		$.ajax({
			url : "${sysPcGubunUrl}/ajaxOrderLimitChk.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				//alert(data.limitYn+"-"+data.limitQty);
				if (data.limitYn == "Y") {
					layerMsgShow("[한정수량초과]<br>생활재 : "+GMDESC+"<br>주문가능수량 : "+data.limitQty, "확인", "N");
					bResult = false;
				}
			}, error: function(xhr,status,error){
				layerMsgShow("오류가 발생했습니다.", "확인", "N");
				bResult = false;
			}
		});
		return bResult;
	}
	//--------------------------------------------------------------------------

	/* 수량 keyin */
	function FnQtyNumberChk(pGubun, pObj, pIdx) {
		if (pGubun == "cart") {
			var strCpView = $("#hid_couponView_"+pIdx).val();
			var arrCpView = strCpView.split("@");
			if (arrCpView[0] == "A") {
				layerMsgShow("해당 생활재는 이미 쿠폰이 적용되어있습니다.<br>쿠폰삭제 후 수량 조정이 가능합니다.", "확인", "N");
				return;
			}
		}

		var iQtyTmp = 0;
		if (isNumberChkNew(pObj)) {
			if (Number(pObj.value) < 1) {
				iQtyTmp = 1;
			} else {
				iQtyTmp = pObj.value;
			}
		} else {
			iQtyTmp = 1;
		}

		$("#txt_orderCnt_"+pIdx).val(iQtyTmp);
		if (pGubun == "cart") {
			$("#id_cartChk_"+pIdx).prop('checked', true);
		}

		// 수량수정...
		if (pGubun == "cart") {
			FnCartQtyUpdate(pIdx);
		} else if (pGubun == "my") {
			FnMyOrderQtyUpdate(pIdx);
		}
	}

	/* 수량  plus,minus */
	function FnQtyAuto(pGubun, pMod, pIdx) {
		if (pGubun == "cart") {
			var strCpView = $("#hid_couponView_"+pIdx).val();
			var arrCpView = strCpView.split("@");
			if (arrCpView[0] == "A") {
				layerMsgShow("해당 생활재는 이미 쿠폰이 적용되어있습니다.<br>쿠폰삭제 후 수량 조정이 가능합니다.", "확인", "N");
				return;
			}
		}

		var intQty = $("#txt_orderCnt_"+pIdx).val();
		var iQtyTmp = 0;

		if (pMod == "plus") {
			iQtyTmp = Number(intQty) + 1;
		} else if (pMod == "minus") {
			if (intQty == 1) {
				iQtyTmp = 1;
				return;
			} else {
				iQtyTmp = Number(intQty) - 1;
			}
		} else {
			iQtyTmp = intQty;
		}

		$("#txt_orderCnt_"+pIdx).val(iQtyTmp);
		if (pGubun == "cart") {
			$("#id_cartChk_"+pIdx).prop('checked', true);
		}
		//alert(pTab+"-"+pIdx);

		// 수량수정...
		if (pGubun == "cart") {
			FnCartQtyUpdate(pIdx);
		} else if (pGubun == "my") {
			FnMyOrderQtyUpdate(pIdx);
		}
	}
</script>
<!-- //한정수량 -->

<script>
	function setCookiePopup(name, value, expiredays) {
		var today = new Date();
	    today.setDate(today.getDate() + expiredays);
	    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
	}

	function setCookieTimePopup(name, value, expirehours, expireMinutes) {
		var today = new Date();
	    today.setHours(today.getHours() + expirehours);
	    today.setMinutes(today.getMinutes() + expireMinutes);
	    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
	}

	function getCookiePopup(name) {
	    var cName = name + "=";
	    var x = 0;
	    while ( x <= document.cookie.length )
	    {
	        var y = (x+cName.length);
	        if ( document.cookie.substring( x, y ) == cName )
	        {
	            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
	                endOfCookie = document.cookie.length;
	            return unescape( document.cookie.substring( y, endOfCookie ) );
	        }
	        x = document.cookie.indexOf( " ", x ) + 1;
	        if ( x == 0 )
	            break;
	    }
	    return "";
	}
</script>
