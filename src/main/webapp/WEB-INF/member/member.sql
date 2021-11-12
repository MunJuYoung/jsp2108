show tables;

CREATE TABLE member (
	idx int not null auto_increment,     /* 회원 고유번호 */
	mid      varchar(20) not null,       /* 아이디 */
	pwd      varchar(50) not null,       /* 비밀번호(입력시 9자로 제한처리) */
	pwdKey   int not null,               /* 해쉬키 관리하는 키번호 */
	nickName varchar(20) not null,       /* 닉네임(중복불허) */
	name     varchar(20) not null,       /* 이름 */
	gender   varchar(10) default '남자',  /* 성별 */
	birthday datetime default now(),     /* 생일 */ 
	tel      varchar(15),                /* 연락처 */
	address  varchar(50),                /* 주소 */
	email    varchar(50) not null,       /* 이메일(아이디/비번찾기용) */
	homePage varchar(50),                /* 홈페이지주소 */
	job      varchar(20),                /* 직업 */
	hobby    varchar(60),                /* 취미 */
	photo    varchar(100) default 'noimage.jpg', /* 프로필사진 */
	content  text,                        /* 자기소개 */
	userInfor char(6) default '공개',      /* 정보공개*/
	userDel  	char(2) default 'NO',       /* 회원탈퇴신청여부(OK:탈퇴신청한 회원 -> 한달간 동일한 아이디 생성금지 */
	point     int default 100,            /* 포인트(최초가입:100, 한번 방문시마다 10 */
	level     int default 1,              /* 1:준회원, 2:정회원, 3:우수회원, 4:운영자, 0:관리자 */
	visitCnt  int default 0,              /* 방문횟수 */
	startDate datetime default now(),     /* 최초 가입일 */
	lastDate datetime default now(),      /* 마지막 접속일 */
	primary key(idx,mid)                  /* 기본키 : 고유번호, 아이디 */ 
);

desc member;
INSERT INTO member VALUES (default,'admin','1234',1,'관리맨','관리자',default,default,
'010-3423-2704','경기도 안성시','cjsk1126@naver.com',
'blog.daum.net/cjsk1126','프리랜서','등산/바둑',default,'관리자입니다.',
 default,default,default,default,default,default,default);
 
 SELECT * FROM member;
