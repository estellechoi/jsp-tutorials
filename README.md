# My SQL Tutorials

mysql -u 아이디 -p 비번

* bin (실행파일 디렉토리)

♣ Structure

MySQL > ⓐ DB > my DB > ⓑ Table > ⓒ Field(category) > ⓓ Record (values)

작업  > insert (입력), update (수정), delete (삭제), select (조회)

♣ 자료형

① int
② char(문자수)
③ text

...varchar -> 입력된 문자수 만큼만 메모리 차지

♣ MySQL Console(root) 명령어

enter password: apmsetup

mysql>

; or \g : send cmd to mysql.
help or \h : help
\c : clear the input statement.
\q : quit (sql 종료)

show databases; DB 존재현황 보기

create database "db name"; DB 만들기

drop database "db name"; DB 삭제

drop table "table name"; 테이블 삭제


use "db name"; 해당 DB 내에서 작업하겠다 declare

create table "table name"("field name" "datatype"(text limit),"field name" "datatype"(n)); table 만들기

       [ex] create table member(name char(10), address char(20), phone char(20), age int);

※ first to do before making other fields

   → create table "table name"(id int auto_increment primary key, name char(10) ... );

show tables; table 현황 보기

desc "table name"; 해당 테이블 구성 보기 (description)

select*from "table name"; 해당 테이블에서 all(*) data 선택 조회

select "field", "field" from "table name"; 원하는 필드의 레코드만 선택 조회

select*from "table name" where "field"='값'; 조건에 맞는 레코드만 선택 조회

select*from "table name" order by age desc; > 나이순 조회

insert into "table name"("field", "field", "field", "field") values("문자값", 숫자값, value, value);

update; 전체 레코드 수정

delete; 전체 레코드 삭제

alter table "table name" add column "field" "datatype"; 테이블 형식 수정 (항목 수정/추가 등)

update "table name" set "field"='업데이트값', "field"='없데이트값 where "field"='기존값'(조건); table 레코드 수정

delete from "table name"; 테이블 값 전체 삭제

delete from "table name" where "field"='값'; 선택한 레코드만 삭제
