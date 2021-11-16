/* guest.sql (방명록) */ 
CREATE TABLE guest (
   idx int not null auto_increment primary key,    /*고유번호*/
   name varchar(20) not null,          /* 방문자 성명 */
   email varchar(60),                  /*이메일 주소*/
   homepage varchar(60),               /*홈페이지 주소(블로그)*/
   vDate datetime default now(),       /*방문일자*/
   hostIp varchar(50) not null,        /*방문자의 아이피*/
   content text not null               /*방문소감*/
);

desc guest;

insert into guest values (default,'관리자','cjsk1126@naver.com','blog,daum.net/cjsk1126',default,'123.214.231.197','방명록 서비스를 시작합니다.');
insert into guest values (default,'홍길동','hkd1234@naver.com','blog,daum.net/hkd1234',default,'122.213.230.196','우와아 대단해요');

select * FROM guest;

SELECT COUNT(*) FROM guest;

/* 원하는 갯수만 가져오기  : limit '시작인덱스','갯수'  */
SELECT * FROM guest ORDER BY idx DESC limit 0,10;
SELECT * FROM guest ORDER BY idx DESC limit 10,10;
SELECT * FROM guest ORDER BY idx DESC limit 20,10;