--회원 테이블
create table member(
	mnum		  number(5)		constraint	member_mnum_pk	primary key,		--회원번호
	name		  varchar2(10)	not null,		--이름
	id			  varchar2(12)	constraint	member_mid_uk	unique	not null,	--아이디
	pwd			  varchar2(12)	not null,		--비밀번호
	pwd2		  varchar2(12)	not null,		--비밀번호확인
	gender	  varchar2(4)		not null,		--성별
	tel			  varchar2(12)	not null,		--전화번호
	question  varchar2(50)		not null,		--질문
	answer		varchar2(50)	not null,		--질문
	post1		  varchar2(3)	not null,		--우편번호1
	post2		  varchar2(3)	not null,		--우편번호2
	addr1		  varchar2(500)	not null,		--주소1
	addr2		  varchar2(500)	not null,		--주소2
  	joindate	date			default sysdate	--가입날짜
);
create sequence member_seq minvalue 0;

insert into member values(member_seq.nextval, 'admin', 'admin', 'admin', 'admin',
                            '남자', 'admin', 'admin', 'admin',
                            'admin?', 'admin', '123', '123', '123', '123', sysdate);

-- 문의 게시판
create table question
( ref number(4) constraint question_ref_fk foreign key(ref) references question(qnum);
 qnum number(4) constraint question_qunm_pk primary key,
 reple char(1) ,
 id		varchar2(15) not null,
 password varchar2(15),
 category varchar2(10) not null,
 title varchar2(50) not null,
 content varchar2(4000) not null,
 author varchar2(20) not null,
 writeday date default sysdate,
 readCnt number(5) default 0); 
                            
--자유게시판 테이블
Create table freeBoard(
 fnum 	  number(4)		    constraint freeBoard_fnum_pk primary key,--게시판번호
 author 	varchar2(15)	not null,		--작성자
 title	  varchar2(50)	  	not null,		--제목
 content	varchar2(4000)	not null,		--내용
 writeday	date		    default sysdate,--작성일
 readcnt	number(4)		default 0,		--조회
 goodcnt	number(4)		default 0		--추천수
);

create sequence freeBoard_seq minvalue 0;

insert into freeboard values(freeBoard_seq.nextval, 'qwe', '장명주', '캬캬', sysdate, 10, 10);


--자유게시판 댓글 테이블 (댓글의 댓글 추가)
Create table freeBoardReple(  
 relevel	number(4) 		default 0,		-- 댓글의 깊이 
 ref 		number(4)		not null, 		-- 그룹  
 step 		number(4) 		default 0,      -- 출력 순서
 pfrnum 	number(4)  		not null , 		-- 부모의 고유넘버
 frnum 	  	number(4)		constraint freeBoardReple_frnum_pk primary key,	--댓글번호, 댓글의 고유번호 ref
 fnum     	number(4)       not null,       --게시판번호 (fk)
 author 	varchar2(15)	not null,		--작성자
 content	varchar2(4000)  not null,	    --내용
 writeday	date            default sysdate --작성일
);

create sequence freeBoardReple_seq minvalue 0;

--게시물이 삭제되면 댓글도 같이 삭제 (foreign key, cascade)
alter table freeBoardReple add constraint freeBoardReple_fnum_fk foreign key(fnum)
references freeBoard(fnum) on delete cascade;

alter table freeBoardReple add constraint freeBoardReple_pfrnum_fk foreign key(pfrnum)
references freeBoardReple(frnum) on delete cascade;

alter table freeBoardReple add constraint freeBoardReple_ref_fk foreign key(ref)
references freeBoardReple(frnum) on delete cascade;

-- 자유게시판 추천 기록 테이블  --
create table recommendRecord(
 id varchar2(15) not null,	--회원 아이디
 fnum number(4) not null,	--게시판 번호
 constraint recommendRecord_fnum_fk foreign key(fnum) references freeBoard(fnum) on delete cascade,
 constraint recommendRecord_id_fk foreign key(id) references Member(id) on delete cascade
);

--침실가구 테이블
create table bedroom(
  bnum      number(4)       constraint bedroom_bnum_pk primary key,  --상품번호
  category  varchar2(2)     not null,     --상품분류
  name      varchar2(50)    not null,     --상품명
  content   varchar2(4000)  not null,     --상품상세내용
  price     number(9)       not null,     --상품가격
  discount  number(3)       not null,     --할인율
  buycount  number(3)       default 0,    --판매횟수
  image1    varchar2(100)   default null, --상품사진1
  image2    varchar2(100)   default null  --상품사진2
);

create sequence bedroom_seq minvalue 0;

-- LivingRoom  테이블 
create table livingroom(
  lnum      number(4)       constraint livingroom_lnum_pk primary key,  --상품번호
  category  varchar2(2)     not null,     --상품분류
  name      varchar2(50)    not null,     --상품명
  content   varchar2(4000)  not null,     --상품상세내용
  price     number(9)       not null,     --상품가격
  discount  number(3)       not null,     --할인율
  buycount  number(3)       default 0,    --판매횟수
  image1    varchar2(100)   default null, --상품사진1
  image2    varchar2(100)   default null  --상품사진2
);

create sequence livingroom_seq minvalue 0;

-- Kitchen  테이블 
create table Kitchen(
  knum      number(4)       constraint kitchen_knum_pk primary key,  --상품번호
  category  varchar2(2)     not null,     --상품분류
  name      varchar2(50)    not null,     --상품명
  content   varchar2(4000)  not null,     --상품상세내용
  price     number(9)       not null,     --상품가격
  discount  number(3)       not null,     --할인율
  buycount  number(3)       default 0,    --판매횟수
  image1    varchar2(100)   default null, --상품사진1
  image2    varchar2(100)   default null  --상품사진2
);

create sequence kitchen_seq minvalue 0;

-- ChildrenRoom  테이블 
create table ChildrenRoom(
  cnum      number(4)       constraint childrenRoom_cnum_pk primary key,  --상품번호
  category  varchar2(2)     not null,     --상품분류
  name      varchar2(50)    not null,     --상품명
  content   varchar2(4000)  not null,     --상품상세내용
  price     number(9)       not null,     --상품가격
  discount  number(3)       not null,     --할인율
  buycount  number(3)       default 0,    --판매횟수
  image1    varchar2(100)   default null, --상품사진1
  image2    varchar2(100)   default null  --상품사진2
);

create sequence childrenRoom_seq minvalue 0;

--장바구니 테이블
create table cart(
  cnum      number(4)       constraint cart_cnum_pk primary key,  --카트번호
  pnum      number(4)       not null,       --상품번호
  category  varchar2(20)    not null,       --해당 상품의 테이블명
  id        varchar2(12)    not null,       --회원아이디
  name      varchar2(50)    not null,       --상품명
  count     number(4)       not null,       --상품갯수
  price     number(9)       not null,       --상품가격
  discount  number(3)       not null,       --할인율
  cartdate  date            default sysdate,--카트에 넣은 날짜
  image1    varchar2(100)   default null    --상품사진1
);
create sequence cart_seq minvalue 0;

--회원이 삭제(탈퇴)되면 장바구니 목록도 같이 삭제
alter table cart add constraint cart_id_fk foreign key(id)
references member(id) on delete cascade;

--주문조회 테이블
create table orderInfo(
 onum          	number(4)     	constraint	order_onum_pk	primary key,  --주문번호
 groupnum       number(4)     	not null,           --그룹번호
 id            	varchar2(16)  	not null,           --회원아이디
 pnum          	number(4)     	not null,           --상품번호
 category      	varchar2(20)  	not null,           --해당 상품의 테이블명
 pname         	varchar2(50)  	not null,           --상품명
 count         	number(4)     	not null,           --주문갯수
 price         	number(9)     	not null,           --주문가격
 discount      	number(3)     	not null,           --할인율
 orderdate     	date          	default sysdate,    --주문 날짜
 image1        	varchar2(100) 	default null,       --상품사진1
 orderMessage	varchar2(200),                     	--주문메세지
 orderstate    	varchar2(20)	default '입금대기중'	--주문상태
);
create sequence orderInfo_seq minvalue 0;
create sequence orderInfo_groupseq;

alter table orderInfo add constraint orderInfo_id_fk foreign key(id)
references member(id) on delete cascade;

commit;