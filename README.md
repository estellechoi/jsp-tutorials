# My SQL Tutorials

## Notes
* mysql -u 아이디 -p 비번
* bin (실행파일 디렉토리)

---

## SQL Structure
* MySQL > DB > my DB > Table > Field > Record (values)
* 작업의 종류  : insert(입력), update(수정), delete(삭제), select(조회)


## Datatype(자료형)
* int
* char(문자수)
* text
* ...varchar -> 입력된 문자수 만큼만 메모리 차지

---

## MySQL Console(root) command
> Enter password: apmsetup


### Basic commands
* ; or \g → send cmd to mysql.
* help or \h → help
* \c → clear the input statement.
* \q → quit (sql 종료)


### Commands

> "db"/"table"/"field" 는 관리자가 입력하는 DB/Table/Field의 이름 

* show databases; DB 현황 조회
* create database "db"; DB 생성
* drop database "db"; DB 삭제
* use "db"; 해당 DB에서 작업하겠다 선언

* create table "table"("field" "datatype"(text limit),"field" "datatype"(text limit)); table 생성

       [ex] create table member(name char(10), address char(20), age int);

* 
       ※ Mostly essential to do when making fields
       sql-> create table "table"(id int auto_increment primary key);
       
       [ex] create table member(id int auto_increment primary key, name char(10), age int);

* show tables; table 현황 조회
* drop table "table"; 테이블 삭제
* desc "table"; 해당 테이블 구성 보기 (description)
* alter table "table" add column "field" "datatype"; 테이블 필드 수정/추가 외

       [ex] alter table member add column phone char;

* select*from "table"; 해당 테이블의 모든 레코드 조회 (* means all)
* select "field", "field" from "table"; 선택된 필드의 레코드만 조회
* select*from "table" where "field"='record'; 조건에 해당하는 레코드만 조회

       [ex] select*from member where name='Estelle'; name 필드의 값이 Estelle인 레코드만 조회
       [ex] select*from member order by age desc; 나이순 조회

* insert into "table"("field", "field") values("문자", 숫자); 레코드 추가
* update "table" set "field"='new record', "field"='new record' where "field"='record'; 해당 조건 하에서 필드의 레코드 수정

       [ex] update member set name='Estelle Choi', address='Seoul' where name='Estelle';

* delete from "table"; 테이블 레코드 전체 삭제
* delete from "table" where "field"='record'; 조건에 해당하는 레코드만 삭제

