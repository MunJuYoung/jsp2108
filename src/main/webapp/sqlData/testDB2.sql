/* testDB2 */
/* 책 정보 테이블(books) */
create table books (
	bookId    int not null auto_increment primary key, /* 책 고유번호 */
	bookName  varchar(20) not null,				/* 책 이름 */
	publisher varchar(20) not null,				/* 출판사명 */
	price			int													/* 책가격(정가) */
	/* primary key(bookId, bookName) */
);

insert into books values (1,'축구의 역사','굿스포츠',7000);
insert into books values (2,'축구아는 여자','나무수',13000);
insert into books values (3,'축구의 이해','대한미디어',22000);
insert into books values (4,'골프 바이블','대한미디어',35000);
insert into books values (5,'피겨 교본','굿스포츠',8000);
insert into books values (6,'역도 단계별기술','굿스포츠',6000);
insert into books values (7,'야구의 추억','이상미디어',20000);
insert into books values (8,'야구를 부탁해','이상미디어',13000);
insert into books values (9,'올림픽 이야기','삼성당',7500);
insert into books values (10,'Olympic Champions','Pearson',13000);
insert into books values (11,'자바의 정석','도우출판사',30000);
insert into books values (12,'포토샵 CS6','제우미디어',25000);
insert into books values (13,'노인과 바다','이상미디어',13000);
insert into books values (14,'C#','삼성당',22000);
insert into books values (15,'전산세무2급','제우미디어',15000);
insert into books values (16,'반응형웹','ICOX',28000);
insert into books values (17,'파이썬따라잡기','이상미디어',22000);
insert into books values (18,'이젠나도자바','삼성당',19000);
insert into books values (19,'구기종목 정복','굿스포츠',9900);
insert into books values (20,'컬러리스트길잡이','나무수',31000);

SELECT * FROM books;

/* 갯수를 구하는 함수? count()*/
-- 전체 책의 권수는?
SELECT COUNT(*) FROM books;

-- 전체 책의 권수는? (단, 열이름을 '총권수'로 )
SELECT COUNT(*) as '총권수' FROM books;
SELECT COUNT(*) 총권수 FROM books;

-- 삼성당 출판사의 개수
SELECT COUNT(*) 삼성당출판사수 FROM books WHERE publisher = '삼성당';

-- 전체 책의 가격합계 : sum, 열: 총가격
SELECT sum(price) 총가격 FROM books;
SELECT format(sum(price),0) 총가격 FROM books; -- 숫자에 컴마 (0은 소수점이하 x라는 뜻

-- 삼성당 출판사의 전체 책 평균가 (소수 1자리수까지)
SELECT format(avg(price),1) 삼성당책평균가격 FROM books WHERE publisher='삼성당';

-- 책 가격이 2만원 이상인 책가격의 합계
SELECT format(sum(price),0) FROM books WHERE price >=20000;

-- 가장 비싼책과 가장 싼 책의 가격출력
SELECT max(price) 까짱삐쌈, min(price) 까짱쌈 FROM books;

-- 출판사가 '굿스포츠' 혹은 '대한미디어' (2가지방법)
SELECT bookName FROM books WHERE publisher in('굿스포츠','대한미디어'); 

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 (2가지방법)
SELECT bookName,publisher FROM books WHERE publisher not in('굿스포츠','대한미디어');

-- 이름에 축구가 포함된 도서를 파는 퍼블리셔
SELECT bookName,publisher FROM books WHERE bookName like '%축구%';

-- 도서이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서
SELECT bookName FROM books WHERE bookName like '_구%';

-- '축구'에 관한 도저중에서 가격이 2만이상인 도서만 출력
SELECT bookName FROM books WHERE bookName like '%축구%' and price >=20000

-- 도서를 가격순으로 검색하되, 가격이 같으면 이름순으로 내림차순
SELECT bookName FROM books ORDER BY price,bookName DESC; 

-- 도서테이블에서 모든 출판사를 검색(중복 허용)
SELECT publisher FROM books ;

-- 도서테이블에서 모든 출판사를 검색(중복 X)
SELECT distinct(publisher) FROM books;
SELECT distinct publisher FROM books;



/* 그룹으로 묶어서 작업처리 : GROUP BY ~ HAVING(조건) 
 * GROUP BY 뒤의 검색조건필드를 select절의 필드로 적어준다,
 * 또한, select절에선 group by뒤의 검색조건필드를 집계함수와 함께사용할 수 있다
 * 
 * */
-- 도서테이블에서 모든 출판사를 검색(중복 X : GROUP BY 사용)
SELECT publisher FROM books GROUP by publisher; /* 기본적으로 정렬되어있다(오름차순) */

-- 책을 납품한 출판사의 납품한 책의 총 권수?
SELECT publisher , COUNT(bookName) FROM books GROUP BY publisher; 

-- 출판사별로 책 가격의 전체 합계,평균
SELECT publisher, SUM(price),avg(price) FROM books GROUP BY publisher;


-- 출판사별로 책 가갹중 최고 최저
SELECT publisher, format(MAX(price),0), format(MIN(price),0) FROM books GROUP BY publisher;


-- 책 1권의 가격이 2만원 이상인 책을 납품한 출판사는 (출판사 중복x)
SELECT publisher, bookName, price FROM books GROUP BY publisher HAVING price >=20000;


-- 책을 남품함 횟수가 2회 이상인 출판사와 납품횟수
SELECT publisher, count(publisher) FROM books GROUP BY publisher HAVING count(publisher)
>2;


-- 책을 2번이상 납품한 출판사의 책중, 최고가격인 책과 출판사명
SELECT publisher,MAX(price) FROM books GROUP BY publisher 
	HAVING COUNT(publisher) >=2;

/* 한계치를 적용한 출력? limit 첫인덱스, 개수 */
-- 처음부터 10권의 책을 출력
SELECT bookName FROM books limit 0,10;

-- 2부터 ~5건
SELECT bookName FROM books limit 2,5;

-- 책가격이 가장 높은 순으로 5건
SELECT bookName,price FROM books ORDER BY price DESC limit 0,5;




/* -------------------다중 테이블 활용하기-------------------------------- */

/* 주문자 테이블 : customer */
CREATE TABLE customer (
	custId int not null auto_increment primary key,  /* 고객 고유 아이디*/
	name varchar(20) not null,       /* 고객 이름 */
	address varchar(30) not null,    /* 고객 주소 */
	phone varchar(15) 							 /* 고객 연락처 */
);


-- customer(고객정보 등록)
INSERT INTO customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO customer VALUES (3, '김말숙', '대한민국 강원도', '000-7000-0001');
INSERT INTO customer VALUES (4, '손흥민', '영국 토트넘', '000-8000-0001');
INSERT INTO customer VALUES (5, '박세리', '대한민국 대전',  null);
INSERT INTO customer VALUES (6, '이순신', '대한민국 아산',  '');


/* 주문정보 테이블 : orders */
-- on update cascade : 원본테이블의 변경시 참조테이블이 영향을 받는다.
-- on delete restrict : 원본테이블의 삭제시 참조테이블이 영향을 받는다.(참조 테이블에서 참조를 하고있따면 삭제불가)


CREATE TABLE orders (
	orderId int not null auto_increment,  /* 주문번호 */
	custId int not null ,             /* 고객 고유번호 */
	bookId int not null,              /* 책 고유번호 */
	salePrice int not null,						/* 할인 가격(실제판매가격) */
	orderDate timestamp,              /* 책 주문 날짜(날짜형식) */
	primary key(orderId),             /* 주키 : orderId */
	foreign key(custId) references customer(custId) on update CASCADE ON DELETE RESTRICT, /*  */
	foreign key(bookId) references books(bookId) ON UPDATE CASCADE ON DELETE RESTRICT
);

DROP TABLE orders

-- orders(주문정보) 데이터 생성
INSERT INTO orders VALUES (1, 1, 1, 6000, '2009-07-01'); 
INSERT INTO orders VALUES (2, 1, 3, 21000, '2018-02-03');
INSERT INTO orders VALUES (3, 2, 5, 8000, '2021-05-03'); 
INSERT INTO orders VALUES (4, 3, 6, 6000, '2020-06-04'); 
INSERT INTO orders VALUES (5, 4, 7, 20000, '2019-11-05');
INSERT INTO orders VALUES (6, 1, 2, 12000, '2021-09-07');
INSERT INTO orders VALUES (7, 4, 8, 13000, '2019-03-07');
INSERT INTO orders VALUES (8, 3, 10, 12000, '2018-07-08'); 
INSERT INTO orders VALUES (9, 2, 10, 9000, '2019-05-09'); 
INSERT INTO orders VALUES (10, 3, 11, 27000, '2020-06-15');
INSERT INTO orders VALUES (11, 2, 13, 11000, '2021-06-18');
INSERT INTO orders VALUES (12, 3, 15, 13000, '2021-08-20');
INSERT INTO orders VALUES (13, 6, 18, 19000, '2021-10-10');
INSERT INTO orders VALUES (14, 6, 16, 27000, '2021-11-20');
INSERT INTO orders VALUES (15, 3, 20, 30000, '2021-11-20');
INSERT INTO orders VALUES (16, 4, 16, 26000, '2021-11-25');
INSERT INTO orders VALUES (17, 4, 8, 13000, '2021-06-10');
INSERT INTO orders VALUES (18, 6, 8, 12000, '2021-06-10');
INSERT INTO orders VALUES (19, 2, 15, 13000, '2021-07-12');
INSERT INTO orders VALUES (20, 2, 17, 22000, '2021-10-15');


SELECT * FROM orders;

-- 외래키로 호출이 안된 컬럼은 삭제가 되지만, 호출된건 삭제할 수 없당. 아까 그렇게 옵션줬으니
DELETE FROM books WHERE bookId=4;
DELETE FROM books WHERE bookId=5;

-- 호출되고 있어도 값 변경은 가능하다. 
UPDATE books SET bookId = 21 WHERE bookId = 20; 
UPDATE books SET bookId = 20 WHERE bookId = 21; 

SELECT * FROM customer;

-- customer테이블의 전화번호가 null인 자료?
SELECT * FROM customer WHERE phone is null;

-- 고객별로 주문한 도서의 총수량과 총판매액은? 이때 고객아이디도 ㅊㄹ력
-- SELECT count(custId), sum(price)

SELECT custId, count(*) FROM orders group by custId;

--8천원짜리 이상 도서를 구매한 고객에 대하여 주문도서의 총수량을 구하시오, 단 4권 이상 구매한 사람만.
	--(고객아이디 출력)
SELECT custID,count(bookId) 
FROM orders 
WHERE salePrice >=8000 GROUP BY custId HAVING count(*) >=4;

/* -------------Join(조인) - 다중테이블 응용 -----------------*/
/* 고객 테이블과 주문 테이블을 조건없이 연결하여 출력해보자 */

SELECT * FROM customer, orders;
SELECT * FROM customer cc, orders oo;

--제약조건없이, 고객and주문테이블을 검색하되, 고객아이디는 주문테이블, 성명은 고객테이블에서 출력하라
SELECT oo.custId, cc.name FROM customer cc, orders oo ;

--고객명과 해당고객이 주문한 사항을 모두 출력시키시오
SELECT * FROM customer cc, orders oo WHERE cc.custId = oo.custId; 

-- 고객과 해당 고객이 주문한 정보에 대한 자료를 출력하되, 고객번호순으로 출력
SELECT * FROM customer cc, orders oo WHERE cc.custId = oo.custId ORDER BY cc.custId; 

-- 고객명과 해당고객이 주문한 도서의 판매가격을 검색하시오(출력:고객명, 도서실제판매가격)
SELECT oo.custId 고객명 , oo.salePrice 도서실제판매가격
FROM customer cc, orders oo
WHERE cc.custId = oo.custId ;

-- 고객명과 주문한 도서의 이름을 검색하시오(출력:고객명, 도서명)
SELECT cc.custId 고객명 , bb.bookName 도서명 , oo.salePrice 가격
FROM books bb, customer cc, orders oo
WHERE cc.custId = oo.custId and oo.bookId = bb.bookId;

-- custId = 1인 고객의 주문내용만 보려면.  a=b=1 이렇게는 안나오넹
SELECT cc.custId 고객명 , bb.bookName 도서명 , oo.salePrice 가격
FROM books bb, customer cc, orders oo
WHERE cc.custId =1 and oo.custId = 1 and oo.bookId = bb.bookId;

-- 실제 판매가격이 2만원이상인 도서를 주문한 고객명, 도서명, 판매정가를 구하시오
SELECT cc.custId 고객명, bb.bookName, oo.salePrice
FROM customer cc, orders oo , books bb
WHERE cc.custId = oo.custId and oo.bookId = bb.bookId and oo.salePrice >=20000;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 정렬하여 출력하시오
SELECT cc.name 고객명, sum(oo.salePrice) 총판매액
FROM customer cc, orders oo , books bb
WHERE cc.custId=oo.custId and oo.bookId=bb.bookId 
GROUP BY cc.name ORDER BY sum(oo.salePrice) DESC;

/* 고객 모두에 대하여 책을 주문한 내역을 출력하라(단, 책을 구매하지 않은 회원도 출력) */
-- >> 고객테이블이 기준임   -Left Join일때 왼쪽
SELECT cc.name 고객명, oo.bookId
FROM customer cc left join orders oo 
ON cc.custId = oo.custId;


/* 구매한 책에 대하여 책을 주문한 고객의 내역을 출력하시오 :주문안한 회원은 안나옴 (right join) */
SELECT cc.name, oo.bookId 
FROM customer cc right join orders oo
ON cc.custId = oo.custId;

/* Outer Join : 구매안한 고객포함하여 이름과 ,가격 출력 (사실 left를 제일 많이씀)  */
SELECT cc.name 이름, oo.salePrice 가격
FROM customer cc left outer join orders oo
ON cc.custId = oo.custId;


/*------------ 부속질의(Sub Query) ------------*/
-- 가장 비싼 도서의 이름과 가격을 출력하라
SELECT bookName, MAX(price) FROM books;  -- 이러면 bookName은 첫번째것이 나와버림

SELECT bookName, price FROM books 
WHERE price = (SELECT MAX(price) FROM books);

-- 도서를 구매한 적이 있는 고객의 이름을 출력하라
SELECT name FROM customer
WHERE custId IN (SELECT custId FROM orders);

/*'대한미디어' 출판사 책을 구매한 고객의 이름을 출력 */
SELECT name FROM customer
WHERE custId IN (SELECT custId FROM orders
WHERE bookId IN 
(SELECT bookId FROM books WHERE publisher = '대한미디어'));

/* 도서를 구매하지 않은 고객의 이름을 출력하시오  */
SELECT name FROM customer
WHERE custId NOT IN (SELECT custId FROM orders);



1.  
SELECT COUNT(*) FROM orders WHERE custId = 1;

2.

SELECT orderId FROM orders WHERE NOT orderDate >='2019-07-04' and orderDate<='2020-06-05';

3.

SELECT name 이름, address 주소 FROM customer WHERE name like '김_아';

4.

SELECT cc.custId, count(oo.custId) 총수량, sum(oo.salePrice) 총판매액 
FROM customer cc, orders oo
WHERE cc.custId = oo.custId GROUP BY oo.custId;

5.

SELECT custID,count(bookId) 
FROM orders 
WHERE salePrice >=8000 GROUP BY custId HAVING count(*) >=4;

6.

SELECT bb.bookName 도서이름, bb.price 가격, bb.price-oo.salePrice 정가판매가격차이
FROM books bb, orders oo, customer cc
WHERE cc.custId=1 and oo.custId=1 and bb.bookId=oo.bookId;

7.

SELECT name FROM customer
WHERE custId NOT IN(SELECT custId FROM orders);

8.
SELECT cc.name 이름, sum(oo.salePrice) 총판매액
FROM customer cc , orders oo
WHERE cc.custId=oo.custId GROUP BY oo.custId;

9.

SELECT MAX(bb.price-oo.salePrice)
FROM books bb, orders oo
WHERE bb.bookId = oo.bookId;

10.

SELECT cc.name 고객명, format(sum(oo.salePrice)/count(oo.custId),0) 평균구매액
FROM customer cc, orders oo
WHERE cc.custId = oo.custId GROUP BY oo.custId;



