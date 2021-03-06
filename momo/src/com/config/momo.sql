
drop table banWord;
drop sequence banWord_seq;
drop table orderinfo;
drop sequence orderinfo_seq;
drop sequence orderInfo_groupseq;
drop table cart;
drop sequence cart_seq;
drop table bedroom;
drop sequence bedroom_seq;
drop table recommendRecord;
drop table freeBoardReple;
drop sequence freeBoardReple_seq;
drop table myhome;
drop sequence myhome_seq;
drop table question;
drop sequence question_seq;
drop table freeBoard;
drop sequence freeBoard_seq;
drop table member;
drop sequence member_seq;

--회원 테이블
create table member(
  mnum		          number(5)			constraint	member_mnum_pk	primary key,  --회원번호
  id			          varchar2(16)	constraint	member_mid_uk	unique	not null, --아이디
	name		          varchar2(10)	not null,         --회원이름   
	pwd			          varchar2(16)	not null,         --비밀번호
	pwd2		          varchar2(16)	not null,         --비밀번호 확인
	gender	          varchar2(10)	not null,         --성별
	tel			          varchar2(12)	not null,         --연락처
  email             varchar2(50)  default 'x',      --이메일
	question          varchar2(50)	not null,         --질문
	answer		        varchar2(50)	not null,         --답변
	post1		          varchar2(3)		not null,         --우편번호1
	post2		          varchar2(3)		not null,         --우편번호2
	addr1		          varchar2(500)	not null,         --신주소
	addr2		          varchar2(500)	not null,         --구주소
  joindate	        date			    default sysdate,  --가입 날짜(SNS유저는 최초 로그인날짜)
  logindate         date          default sysdate,  --로그인 날짜
  orderprice        number(9)     default 0,        --총주문금액
  progressingorder  number(4)     default 0,        --진행중인 주문 갯수
  sns               varchar2(10)  default null      --sns로그인 (null이면 momo유저)
);
create sequence member_seq minvalue 0;

insert into member(mnum, id, name, pwd, pwd2, gender, tel, email, question, answer, post1, post2, addr1, addr2)
values(member_seq.nextval, 'admin', 'admin', 'adimn', 'admin', '남자', '01012341234', 'admin@admin.com',
        '나는 관리자다', '인정', '123', '456', '어드민시 어드민동 어드민구', '123-123');
          
insert into member(mnum, id, name, pwd, pwd2, gender, tel, email, question, answer, post1, post2, addr1, addr2)
values(member_seq.nextval, 'wkdaudwn11', '장명주', 'qjffp0! ', 'qjffp0!', '남자', '01080107913', 'wkdaudwn11@naver.com',
        '내가 다녔던 초등학교는?', '연가초등학교', '123', '456', '인천 계양구 임학동 69-12', '인천 계양구 임학동 69-12');
          

-- 문의 게시판
create table question(
  ref         number(4) ,               --그룹 지을때 쓰는 컬럼
  qlevel      number(1),                --답글인지 구분위해 사용
  qnum        number(4) constraint question_qunm_pk primary key,
  id		      varchar2(15) not null,    --작성자의 아이디
  password    varchar2(15),             --비밀번호
  category    varchar2(10) not null,    --분류
  title       varchar2(50) not null,    --제목
  content     varchar2(4000) not null,  --내용
  author      varchar2(20) not null,    --작성자 이름
  writeday    date default sysdate,     --작성날짜
  readCnt     number(5) default 0,      --조회수
  constraint  question_ref_fk foreign key(ref) references question(qnum) on delete cascade,
  constraint  question_id_fk foreign key(id) references member(id) on delete cascade
);
 create sequence question_seq minvalue 1;

-- 마이홈 테이블
Create table myhome(
 hnum 	  	number(6)		    constraint myhome_hnum_pk primary key,--게시판번호
 id       	varchar2(16),					--작성자의 아이디
 author		  varchar2(16)	  not null,		--작성자 이름
 title	  	varchar2(50)	  not null,		--제목
 img		    varchar2(100),					-- 등록한 이미지
 orderList	varchar2(100),		-- 등록한 주문내역 (미구현)
 content	  varchar2(4000)	not null,		--내용
 writeday	  date		        default sysdate,--작성일
 readcnt	  number(4)		    default 0,		--조회
 goodcnt	  number(4)		    default 0,		--추천수
 replecnt 	number(4)       default 0,      --댓글수
 constraint myhome_id_fk    foreign key(id) references member(id) on delete cascade
);

create sequence myhome_seq minvalue 0;

--자유게시판 테이블
Create table freeBoard(
 fnum 	  number(4)		    constraint freeBoard_fnum_pk primary key,--게시판번호
 id       varchar2(16)    default 'wkdaudwn11',       --작성자의 아이디
 author 	varchar2(15)	  not null,				--작성자 이름
 title	  varchar2(50)	  not null,				--제목
 content	varchar2(4000)	not null,				--내용
 writeday	date		        default sysdate,--작성일
 readcnt	number(4)		    default 0,			--조회
 goodcnt	number(4)		    default 0,			--추천수
 replecnt number(4)       default 0       --댓글수
);
create sequence freeBoard_seq minvalue 0;

--자유게시판 댓글 테이블 (댓글의 댓글 추가)
Create table freeBoardReple(  
 relevel	number(4) 		  default 0,		  -- 댓글의 깊이  현재 달고있는 댓글의 레벨 +1 
 ref 		  number(4)		    not null, 		  -- 그룹  frnum 가져와서 세팅.
 step 		number(4) 		  default 0,      -- 공백 갯수
 pfrnum 	number(4)  		  not null , 		  -- 부모의 고유넘버
 frnum 	  number(4)		    constraint freeBoardReple_frnum_pk primary key,	--댓글번호, 댓글의 고유번호 ref
 fnum     number(4)       not null,       --게시판번호 (fk)
 author 	varchar2(15)	  not null,		    --작성자
 content	varchar2(4000)  not null,	      --내용
 writeday	date            default sysdate, --작성일
 constraint freeBoard_fnum_fk foreign key(fnum) references freeBoard(fnum) on delete cascade
);

alter table freeBoardReple add constraint freeBoardReple_fnum_fk foreign key(fnum)
references freeBoard(fnum) on delete cascade;

alter table freeBoardReple add constraint freeBoardReple_pfrnum_fk foreign key(pfrnum)
references freeBoardReple(frnum) on delete cascade;

alter table freeBoardReple add constraint freeBoardReple_ref_fk foreign key(ref)
references freeBoardReple(frnum) on delete cascade;

create sequence freeBoardReple_seq minvalue 0;

-- 자유게시판 추천 기록 테이블  --
create table recommendRecord(
  id varchar2(15) not null,	--회원 아이디
  fnum number(4) not null,	--게시판 번호
  constraint recommendRecord_fnum_fk foreign key(fnum) references freeBoard(fnum) on delete cascade
);

--침실가구 테이블
create table bedroom(
  bnum      number(4)       constraint bedroom_bnum_pk primary key,  --상품번호
  category  varchar2(2)     not null,       --상품분류
  name      varchar2(50)    not null,       --상품명
  content   varchar2(4000)  not null,       --상품상세내용
  price     number(9)       not null,       --상품가격
  discount  number(3)       not null,       --할인율
  buycount  number(3)       default 0,      --판매횟수
  image1    varchar2(4000)  default null,   --상품사진1
  image2    varchar2(4000)  default null,   --상품사진2
  register  varchar2(2)     default 'x'     --관리자가 상품을 등록했는지 여부
);
create sequence bedroom_seq minvalue 0;

insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '1', '스탠다드 와이드체스트', '내용', 390000, 20, 10, '1-1', '1-1_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '1', '원목 협탁', '내용', 214000, 10, 0, '1-2', '1-2_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '1', '베리S) 사이드 테이블', '내용', 270000, 15, 2, '1-3', '1-3_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '1', '메이플라워) 사이드 테이블', '내용', 250000, 10, 3, '1-4', '1-4_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '1', '아일랜드 테이블SS', '내용', 320000, 10, 7, '1-5', '1-5_detail');

insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '2', '클레오S) 화장대풀세트', '내용', 299000, 40, 12, '2-1', '2-1_detail');

insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '3', '매트S) BE매트리스Q', '내용', 659000, 30, 9, '3-1', '3-1_detail');

insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '라이프) 베드Q', '내용', 2350000, 15, 9, '4-1', '4-1_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '헤링본 베드룸세트', '내용', 3590000, 10, 8, '4-2', '4-2_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '에어룸 베드룸세트', '내용', 4060000, 20, 3, '4-3', '4-3_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '제티 베드SS', '내용', 4140000, 10, 5, '4-4', '4-4_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '코엔 베드룸세트', '내용', 3740000, 10, 6, '4-5', '4-5_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '아일랜드 베드SS', '내용', 4580000, 25, 10, '4-6', '4-6_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '레이크 베드Q', '내용', 2320000, 10, 10, '4-7', '4-7_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '스탠다드 수납침대Q', '내용', 3100000, 15, 1, '4-8', '4-8_detail');
insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '4', '바움S) 원목침대Q', '내용', 2760000, 30, 4, '4-9', '4-9_detail');

insert into bedroom(bnum, category, name, content, price, discount, buycount, image1, image2)
values(bedroom_seq.nextval, '5', '스텔라S) 장롱3000/WA', '내용', 1524000, 40, 15, '5-1', '5-1_detail');

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
  id        varchar2(16)    not null,       --회원아이디
  name      varchar2(50)    not null,       --상품명
  count     number(4)       not null,       --상품갯수
  price     number(9)       not null,       --상품가격
  discount  number(3)       not null,       --할인율
  cartdate  date            default sysdate,--카트에 넣은 날짜
  image1    varchar2(100)   default null,   --상품사진1
  constraint cart_id_fk    foreign key(id) references member(id) on delete cascade
);
create sequence cart_seq minvalue 0;

alter table cart add constraint cart_id_fk foreign key(id)
references member(id) on delete cascade;

--주문조회 테이블
create table orderInfo(
  onum                  number(4)     constraint	order_onum_pk	primary key,  --주문번호
  groupnum              number(4)     not null,          --그룹번호
  id                    varchar2(16)  not null,          --회원아이디
  pnum                  number(4)     not null,          --상품번호
  category              varchar2(20)  not null,          --해당 상품의 테이블명
  pname                 varchar2(50)  not null,          --상품명
  count                 number(4)     not null,          --주문갯수
  price                 number(9)     not null,          --주문가격
  discount              number(3)     not null,          --할인율
  orderdate             date          default sysdate,   --주문 날짜
  image1                varchar2(100) default null,      --상품사진1
  orderMessage          varchar2(200),                   --주문메세지
  orderstate            varchar2(20)  default '입금대기중',--주문상태
  equalGroupCount       number(4)     default 1,         --같은 그룹번호 갯수
  equalGroupTotalPrice  number(9)     default 0,         --같은 그룹번호 상품의 총 구매가격
  equalGroupTotalCount  number(4)     default 0          --같은 그룹번호 상품의 총 구매갯수
);
create sequence orderInfo_seq minvalue 1;
create sequence orderInfo_groupseq minvalue 1;

alter table orderInfo add constraint orderInfo_id_fk foreign key(id)
references member(id) on delete cascade;

create table banWord(
  bwnum number(4)       constraint	banWord_bwnum_pk	primary key, -- 금지어 번호
  word  varchar2(4000)  not null -- 금지어 내용
);
create sequence banWord_seq minvalue 1;

commit;