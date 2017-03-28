// 객실
CREATE TABLE room(
rno NUMBER(3) primary key,
rname VARCHAR2(20 byte) NOT NULL,
rsize NUMBER(2) NOT NULL,
men NUMBER(2) NOT NULL,
addman NUMBER(6) DEFAULT 0,
weekday NUMBER(6) NOT NULL,
weekend NUMBER(6) NOT NULL,
sweekday NUMBER(6) NOT NULL,
sweekend NUMBER(6) NOT NULL,
constraint room_rname_uk unique(rname)
);

// 예약
CREATE TABLE reservation(
rsno NUMBER(11) primary key,
rno NUMBER(3) NOT NULL,
uno NUMBER(11) NOT NULL,
res_date DATE NOT NULL,
night NUMBER(2) NOT NULL,
usemen NUMBER(2) NOT NULL,
price NUMBER(7) NOT NULL,
payment CHAR DEFAULT 'C',
pay_name VARCHAR2(20 byte) NOT NULL,
pay_number VARCHAR2(20 byte) NOT NULL,
pay_yn CHAR DEFAULT 'N',
reg_date DATE DEFAULT SYSDATE,
constraint reservation_rno_fk foreign key(rno) references room(rno),
constraint reservation_uno_fk foreign key(uno) references member(mno),
constraint reservation_pay_ck CHECK(pay_yn IN ('Y','N')),
constraint reservation_payment_ck CHECK(payment IN ('C','V'))
);

// 객실 시퀀스
CREATE sequence room_seq
minvalue 1
maxvalue 999
increment BY 1
START with 1;

// 예약 시퀀스
CREATE sequence reservation_seq
minvalue 1
maxvalue 99999999999
increment BY 1
START with 1;


// 펜션관리(성수기,계좌)
CREATE TABLE PUBLICPENSION(
sseason	VARCHAR2(5) NOT NULL,
eseason VARCHAR2(5) NOT NULL,
bankname VARCHAR2(20 byte) NOT NULL,
banknumber VARCHAR2(30 byte) NOT NULL,
bankuser VARCHAR2(20 byte) NOT null
);

// 회원
CREATE TABLE MEMBER (
mno NUMBER(5) NOT NULL primary key,
id VARCHAR2(12) NOT NULL,
passwd VARCHAR2(12) NOT NULL,
name VARCHAR2(12) NOT NULL,
jumin1 CHAR(6) NOT NULL,
jumin2 CHAR(7) NOT NULL,
email VARCHAR2(50) NOT NULL,
recv_yn CHAR(1) NOT NULL,
phone1 VARCHAR2(5) NULL,
phone2 VARCHAR2(5) NULL,
phone3 VARCHAR2(5) NULL,
cell1 VARCHAR2(5) NOT NULL,
cell2 VARCHAR2(5) NOT NULL,
cell3 VARCHAR2(5) NOT NULL,
zip CHAR(7) NOT NULL,
addr1 VARCHAR2(50) NOT NULL,
addr2 VARCHAR2(50) NULL,
reg_date TIMESTAMP NOT NULL
);
// 관리자 입력
insert into member values(0,'admin','admin','이름',0,0,'이메일','n','0','0','0','0','0','0','0','펜션','펜션',sysdate);

// 회원시퀀스
create sequence member_seq
start with 1
increment by 1
nocycle

// 게시판
create table board (
num number primary key,
writer varchar2(10),
email varchar2(30),
subject varchar2(50),
passwd varchar2(12),
reg_date date,
readcount number,
ref number,
re_step number,
re_level number,
content varchar2(4000)
);

// 게시판 시퀀스
create sequence seq_board_id
increment by 1
start with 1
maxvalue 999999;

// 게시판2
create table board1 (
num number primary key,
writer varchar2(10),
email varchar2(30),
subject varchar2(50),
passwd varchar2(12),
reg_date date,
readcount number,
ref number,
re_step number,
re_level number,
content varchar2(4000)
);

// 게시판2 시퀀스
create sequence seq_board1_id
increment by 1
start with 1
maxvalue 999999;

// 이미지게시판
create table gboard(
name varchar2(15) primary key,
passwd varchar2(15),
email varchar2(20),
homepage varchar2(20),
title varchar2(20) ,
content varchar2(999),
uploadfile varchar2(50),
reg_date date
);
