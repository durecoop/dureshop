# 두레생협 쇼핑몰 리뉴얼 프로젝트

## 프로젝트 개요
- **프로젝트명**: 두레생협 쇼핑몰 UI/UX 리뉴얼
- **원본 사이트**: https://ecoop.or.kr/
- **개발 사이트**: https://dev.ecoop.or.kr/
- **작업 기간**: 2025년 1월 21일 ~ 진행중

## 리뉴얼 목적
- PC/모바일 UI/UX 현대화 및 사용자 경험 개선
- 깔끔하고 직관적인 디자인으로 쇼핑 편의성 향상
- 반응형 디자인 적용으로 다양한 디바이스 지원
- 브랜드 아이덴티티 통일 (녹색 계열 #5a8648)

## 기술 스택
- **Backend**: Java, Spring Framework, eGovFramework
- **Frontend**: JSP, JSTL, JavaScript, jQuery
- **Styling**: CSS3
- **Database**: (기존 시스템 유지)

## 주요 변경사항

### 1. PC 헤더 개선
- 검색창 중앙 배치
- 배송일/장바구니 메뉴바 이동
- 메뉴 호버 시 상단 녹색 밑줄 효과
- 두레추천 오렌지 포인트 추가

### 2. 장바구니 페이지
- 오아시스마켓 스타일 적용
- 상품 행 레이아웃 개선 (table-layout)
- 결제박스 우측 고정 (sticky)
- 반응형 디자인 적용

### 3. 주문/결제 페이지
- 결제 단계별 스타일 통일
- 배송지 선택 UI 개선

### 4. 마이페이지
- 전체 레이아웃 개선
- 주문내역, 쿠폰함 UI 통일

### 5. 게시판/이벤트
- 공지사항, FAQ, 1:1문의 UI 개선
- 이벤트 페이지 디자인 개선

### 6. 모바일
- 메인 페이지 레이아웃 개선
- 푸터 디자인 개선

## 폴더 구조
```
DURE_SHOP/
├── css/
│   ├── shop/
│   │   ├── style_v2.css      # PC 메인 스타일
│   │   ├── header-custom.css # 헤더 커스텀 스타일
│   │   ├── cart.css          # 장바구니 스타일
│   │   └── order.css         # 주문 스타일
│   └── mobile/
│       └── style_v2.css      # 모바일 스타일
├── include/
│   ├── comm/
│   │   ├── commScripts.jsp   # 공통 스크립트
│   │   └── commFunctions.jsp # 공통 함수
│   └── shop/
│       ├── header.jsp        # PC 헤더
│       ├── category.jsp      # 카테고리 메뉴
│       └── delivery_date_v2.jsp # 배송일 팝업
├── WEB-INF/
│   └── jsp/
│       ├── shop/             # PC 페이지
│       └── mobile/           # 모바일 페이지
├── js/
└── images/
```

## 수정 파일 목록 (주요)
- `css/shop/header-custom.css` - 헤더 스타일 (v1.7.0)
- `css/shop/cart.css` - 장바구니 스타일 (v4.0.0)
- `css/shop/order.css` - 주문 스타일
- `include/shop/header.jsp` - PC 헤더
- `WEB-INF/jsp/shop/cart/cart.jsp` - 장바구니 페이지
- 기타 40+ 개 파일

## 배포
FTP를 통해 개발 서버에 배포
- 서버: 100.100.1.54
- 경로: /DURE_SHOP/

## 라이선스
Private - 두레생협 내부 프로젝트
