CREATE TABLE INFOS (
STUID VARCHAR2(7) NOT NULL , --ѧ�� ѧ��=��S��+���+2λ���
STUNAME VARCHAR2(10) NOT NULL, --����
GENDER VARCHAR2(2) NOT NULL,--�Ա�
AGE NUMBER(2) NOT NULL, --����
SEAT NUMBER(2) NOT NULL, --����
ENROLL DATE,--��ѧʱ��
STUADDRESS VARCHAR2(50) DEFAULT '��ַ����', --סַ
CLASSNO VARCHAR2(4) NOT NULL --��� ���=ѧ�����+�༶���
);
select * from infos;
ALTER TABLE INFOS ADD CONSTRAINT PK_INFOS PRIMARY KEY(STUID);
ALTER TABLE INFOS ADD CONSTRAINT CK_INFOS_GENDER CHECK(GENDER='��' OR GENDER='Ů');
ALTER TABLE INFOS ADD CONSTRAINT CK_INFOS_SEAT CHECK(SEAT>=0 AND SEAT<=50); 

ALTER TABLE INFOS ADD CONSTRAINT CK_INFOS_AGE CHECK(AGE>=0 AND AGE<=100) ;
ALTER TABLE INFOS ADD CONSTRAINT CK_INFOS_CLASSNO CHECK((CLASSNO >='1001' AND CLASSNO<='1999') OR (CLASSNO >= '2001' AND CLASSNO<='2999'));
ALTER TABLE INFOS ADD CONSTRAINT UN_STUNAME UNIQUE(STUNAME); 
ALTER TABLE infos ADD CONSTRAINT FK_GENDER_ID FOREIGN KEY(CLASSNO) REFERENCES class(ID);

INSERT INTO INFOS VALUES ( 's100102','�ֳ�','��', 22, 2,TO_DATE('2009-8-9 06:30:10',' YYYY-MM-DD HH24:MI:SS '),'����','1001');
INSERT INTO INFOS VALUES ('s100104','��С��','��',26,3,SYSDATE,default,'1001');

UPDATE INFOS SET CLASSNO='1002',STUADDRESS='ɽ������' WHERE STUNAME='��С��';
commit;
select * from emp MINUS select * from emp where deptno = 20;
select * from emp where ename like '%A%';


CREATE TABLE phone (PHONENUM VARCHAR2 (8),PAY number(8,2), NUMLEVEL VARCHAR(24),PAYDATE date);
INSERT INTO phone VALUES ('123456', 600,'pt04',to_date('2005-12-20','yyyy-MM--DD'));
INSERT INTO phone VALUES ('888888', 900,'pt05',to_date('2005-10-19','yyyy-MM--DD'));
SELECT * from phone; 
CREATE TABLE phone_bak AS SELECT * FROM phone;
select * from phone_bak;
UPDATE phone SET pay = 1000 where phonenum = '123456';

Rollback;
UPDATE phone SET NUMLEVEL = 'pt04' where phonenum = '888888';
commit;
