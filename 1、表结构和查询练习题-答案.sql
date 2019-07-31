1����������   emp                                                         
��1�� ��Ա����Ϣ����Ա������ţ�1000��������������нˮ��3200��
insert into emp(empno,ename,sal) values('1000','����','3200');  
��2�� ��Ա����Ϣ����Ա������ţ�1001�����������ģ�нˮ��3500����
�����ڣ�1992-02-23��                                         
insert into emp(empno,ename,sal,hiredate) values('1001','����','3500',to_date('19920223','YYYY-MM-DD'));   
��3�� ��Ա����Ϣ����Ա������ţ�1002�����������壬нˮ��3600����
�����ڣ�ϵͳ��ǰ���ڡ�      
insert into emp(empno,ename,sal,hiredate) values('1002','����','3600',to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD'));                                      
��4�� �´���һ����EMP1��ͬʱ��EMP ���еĲ���Ϊ20 ������Ա������   
���뵽EMP1 ���С�    
CREATE TABLE EMP_1 AS SELECT * FROM EMP WHERE DEPTNO=20;     
��5�� �Ѳ������ݵ��뵽EMP1 ���У����ű�Ų��뵽EMPNO ���ϣ�����   
���Ʋ��뵽ENAME ���ϣ�LOC�ֶβ���Ҫ���뵽EMP1 ���С� 
insert into emp_1(empno,ename) select deptno,dname from dept;


2��   �޸ı�ṹ
��1�� ��EMP�����DEPTNAME�ֶΣ��ֶ�����INT��
  alter table emp add(deptname int);
��2�� �޸�DEPTNAME�ֶε�����ΪVARCHAR2(10)��
  alter table emp modify(deptname varchar2(10));
��3�� �޸�DEPTNAME�ֶε���ΪDNAME��
  alter table emp rename column deptname to dname;
��4�� �޸�DNAME���ֶ�ֵ�����ݲ��ű�����϶�Ӧ�Ĳ������ơ�
  update emp e set e.dname = (select d.dname from dept d where e.deptno=d.deptno);
��5�� ɾ��DNAME�ֶΡ�	
 alter table emp drop(dname);



3����ѯ
��1����ѯԱ��нˮ�Լ�Ա��������Ȼ���жϣ����нˮС��1000����ʾ��нˮ�͡���
���1000��2000����ʾ���еȡ�������2000����ʾ��нˮ������
select ename,sal,
case 
when sal < 1000 then 'нˮ��'
when sal >= 1000 and sal <= 2000 then '�е�'
else 'нˮ����' end sal_s
from emp;
��2����ѯнˮ��1500��3000֮���Ա���Ļ�����Ϣ��Ҫ��ʹ��between...andʵ�֣�
select * from emp where sal between 1500 and 3000;
��3����ѯ�����а���A�����ڲ���MANAGER�Ͳ���CLERK��ְ��Ա����Ϣ
select * from emp where ename like'%A%' and job in('MANAGER','CLERK');
��4����ѯ����MANAGER�Ͳ���CLERK���н����Ա��������
select count(*) from emp where job in('MANAGER','CLERK') and comm is not null;
 (5) ��ѯemp��Ա�����깤�ʣ����ɴ�Сһ������
 select ename,sal*12 sal_12 from emp order by sal*12 desc;
��6���б�emp��дһ����ѯ��䣬��������������Ա���ӹ��ʣ�
ԭ�����ʴ���3000�����ʼ�100��ԭ�����ʴ���1500�����ʼ�200���������ʼ�250 ;
select sal,
case
when sal > 3000 then sal + 100
when sal between 1500 and 3000 then sal + 200
else sal + 250 end sal_jgz from emp;
��7��.  ��emp���в�ѯ�����ű��Ϊ10��20�ļ�¼
����ֱ�ʹ��OR��IN�ؼ��֣�
select * from emp  where deptno =10 or deptno=20;

select * from emp  where deptno in(10,20);
��8����emp���в�ѯ�������ĵڶ�����ĸΪA�ļ�¼��
select * from emp  where ename like '_A%';

��9����ѯemp����1981����õ�����Ա����������1987��5�¹��õ�Ա����
to_date--ת������������
  to_char--ת�����ַ�����
  select * from emp where
       to_char(hiredate,'yyyy')=1981
    or to_char(hiredate,'yyyymm')=198705;
  select * from emp 
  where  to_char(hiredate,'yyyy') like '1981%'  
      or to_char(hiredate,'yyyymm') like'198705%'
��10���ҳ�����10�����о���MANAGER���Ͳ���20�����а���Ա��CLERK������ϸ���ϡ�
select * from emp where 
      deptno=10 and job='MANAGER'
   or deptno=20 and JOB='CLERK'; 
��11���ҳ�����10�����о���MANAGER���� ����20 �����а���Ա��CLERK��,
 �Ȳ��Ǿ����ֲ��ǰ���Ա��CLERK������н����ڻ����2000������Ա������Ϣ��
  select * from emp where 
      deptno=10 and job='MANAGER'
   or deptno=20 and JOB='CLERK'
   or job not in('MANAGER','CLERK') and sal>=2000;
��12����ʾ����������R��Ա����������
 select * from emp where ename not like '%R%';   

4��(1)����һ��emp�ı��ݱ���Ϊemp_tmp, ��emp�е����ݲ���emp_tmp��
   (2)ɾ��emp_tmp�е�jobΪMANGFER����Ա��Ϣ
   (3)�ֱ��ѯemp_tmp��emp��Ľ����������������Ϣ 
create table emp_tmp as select * from emp;
delete from emp_tmp where job='MANAGER';
SELECT * FROM EMP_TMP INTERSECT SELECT * FROM EMP;--����
SELECT * FROM EMP_TMP UNION SELECT * FROM EMP;--����
SELECT * FROM EMP minus SELECT * FROM EMP_TMP;--�
