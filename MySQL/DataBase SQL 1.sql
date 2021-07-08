MySQL 데이터베이스 0708 요약

<MySQL 들어가기>
C:\Users\rentalhub-lg1>cd..

C:\Users>cd..

C:\APM_Setup\Server\MySQL>cd bin

<관리자 접속>
C:\ > mysql - uroot -papmsetup mysql

<MySQL 종료>
mysql> quit
mysql > \q

<새로운 계정 생성>
* 데이터베이스에 관리자 계정으로 접속
C:\> mysql -uroot -papmsetup mysql

* 존재하는 데이터베이스 목록보기
mysql> show databases;

* 테이블 목록보기
mysql> show tables;

<새로운 데이터베이스 생성>
* 이름이 kim_db인 새로운 데이터베이스 생성
mysql > create databse kim_db;

* 데이터베이스 목록보기
mysql> show databases;


<개인 계정 등록>
*user 테이블에 계정과 비밀번호 등록
- 테이블 구조 출력 명령
mysql> desc 테이블명;
* user 테이블의 구조 확인
mysql> desc user;
* 특정 필드에 입력된 데이터 검색 명령
mysql>select 필드1, 필드2, 필드3 from 테이블명;
* user 테이블의 host, user, password 데이터를 출력
mysql> select host, user, password from user;
* 필드에 새로운 데이터 입력
mysql> insert into 테이블명 (필드1, 필드2, 필드3)
values(필드1_값, 필드2_값, 필드3_값);

* user 테이블에 계정 등록
mysql> insert into user (host, user, password)
values ('localhost', 'kim',  password('1234'));

<db 테이블에 데이터베이스에 사용 권한 등록>
* 데이터베이스 테이블 구조 파악
mysql> desc db;
* db 테이블에 사용 권한 설정
mysql> insert into db values ('localhost', 'kim_db', 'kim', 'y','y','y','y','y','y','y','y','y','y','y','y');

* user, db 테이블의 변경된 내용 적용
mysql> flush privileges;

* 새로운 계정으로 MySQL에 접속
C:\> mysql -ukim -p1234 kim_db

< 관리자 비밀번호 변경 >
C:\> mysql -ukim -papmsetup mysql
* update를 이용한 비밀번호 변경
mysql> update 테이블명 set 필드명 = password('새로운_비밀번호')
where 필드 = '필드값';
mysql> update user set password=password('1234')
where user='root';

* 변경된 관리자 비밀번호를 MySQL 시스템에 적용
mysql> flush privileges;

* 변경된 관리자 비밀번호로 MySQL에 접속
C:\> mysql -uroot -p1234 mysql

<데이터베이스 접속 명령>
mysql -u계정 -p비밀번호 데이터베이스명

C:\> mysql -ukim -p1234 kim_db

<데이터베이스 생성 명령>
create database 데이터베이스명;
mysql> create database sample1;

<데이터베이스 목록 보기>
show databases;

<데이터베이스 삭제>
* 데이터베이스 삭제 명령
drop database 데이터베이스명;
mysql> drop database sample1;

<테이블 생성 명령>
* 데이터베이스 테이블 생성 명령
mysql> create table 테이블명(
필드명1 타입,
필드명2 타입,
필드명3 타입,
PRIMARY KEY(필드명));

<주소록 테이블(friend) 만들기>
C:\> mysql -ukim -p1234 kim_db
mysql> create table friend (
num int not null,
name char(10),
address char(80),
tel char(20),
email char(20),
primary key(num)
);

<데이터베이스 테이블의 구조 확인>
* 데이터베이스 테이블의 필드 구조 출력 명령
desc 테이블명;

mysql> desc friend;

<새로운 필드 추가 명령>
* 데이터베이스 테이블의 필드 추가 명령
alter table 테이블명 add 새로운 필드명 필드타입 [first 또는 after 필드명];

앞서 만든 friend 테이블 나이 필드를 정수형으로 추가
mysql> alter table friend add age int;
mysql> desc friend;

<필드 삭제>
* 데이터베이스 테이블의 특정 필드 삭제 명령
alter table 테이블명 drop 삭제할 필드명1, 삭제할 필드명2;

* friend 테이블에서 email과 age 필드 삭제
mysql> alter table friend drop email;
mysql> alter table friend drop age;
mysql> desc friend;

<필드 수정 명령>
* 데이터베이스 테이블의 필드 수정 명령
alter table 테이블명 change 이전 필드명 새로운 필드명 필드 타입;

* friend 테이블 필드 중 tel char(20)을 phone int로 변경
mysql> alter table friend change tel phone int;

* name 필드의 타입을 int로 변경
mysql> alter table friend modify name int;

* 데이터베이스 테이블명 수정 명령
alter table 이전 테이블명 rename 새로운 테이블명;

* 테이블명 friend에서 student로 변경
mysql> alter table friend rename student;

* 테이블 삭제
drop table 테이블명;

ex) friend 테이블 삭제
mysql> drop table friend;
mysql> show tables;

* bin 폴더로 이동
friend 테이블의 구조 점검
mysql> desc friend;




