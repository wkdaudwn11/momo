create sequence member_seq;

create table member(
	mnum		num(5)			constraint	member_mnum_pk	primary key,
	name		varchar2(10)	not null,
	id			varchar2(12)	constraint	member_mid_uk	unique	not null,
	pwd			varchar2(12)	not null,
	pwd2		varchar2(12)	not null,
	gender		varchar2(4)		not null,
	tel			varchar2(12)	not null,
	birth		varchar2(8)		not null,
	email		varchar2(30)	not null,
	question	varchar2(50)	not null,
	answer		varchar2(50)	not null,
	post1		varchar2(3)		not null,
	post2		varchar2(3)		not null,
	addr1		varchar2(500)	not null,
	addr2		varchar2(500)	not null,
	joindate	date			default sysdate	not null
);

insert into member values(member_seq.nextval, 'admin', 'admin', 'admin', 'admin',
                            '남자', '01080107913', '19921028', 'wkdaudwn11@naver.com',
                            '학원 이름은?', '에이콘아카데미', '123', '123', '123', '123', sysdate);