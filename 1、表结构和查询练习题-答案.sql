1、插入数据   emp                                                         
（1） 把员工信息插入员工表，编号：1000，姓名：张三，薪水：3200。
insert into emp(empno,ename,sal) values('1000','张三','3200');  
（2） 把员工信息插入员工表，编号：1001，姓名：李四，薪水：3500，雇
用日期：1992-02-23。                                         
insert into emp(empno,ename,sal,hiredate) values('1001','李四','3500',to_date('19920223','YYYY-MM-DD'));   
（3） 把员工信息插入员工表，编号：1002，姓名：王五，薪水：3600，雇
用日期：系统当前日期。      
insert into emp(empno,ename,sal,hiredate) values('1002','王五','3600',to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD'));                                      
（4） 新创建一个表EMP1，同时把EMP 表中的部门为20 的所有员工数据   
插入到EMP1 表中。    
CREATE TABLE EMP_1 AS SELECT * FROM EMP WHERE DEPTNO=20;     
（5） 把部门数据导入到EMP1 表中，部门编号插入到EMPNO 列上，部门   
名称插入到ENAME 列上，LOC字段不需要导入到EMP1 表中。 
insert into emp_1(empno,ename) select deptno,dname from dept;


2、   修改表结构
（1） 给EMP表添加DEPTNAME字段，字段类型INT。
  alter table emp add(deptname int);
（2） 修改DEPTNAME字段的类型为VARCHAR2(10)。
  alter table emp modify(deptname varchar2(10));
（3） 修改DEPTNAME字段的名为DNAME。
  alter table emp rename column deptname to dname;
（4） 修改DNAME的字段值，根据部门编号填上对应的部门名称。
  update emp e set e.dname = (select d.dname from dept d where e.deptno=d.deptno);
（5） 删除DNAME字段。	
 alter table emp drop(dname);



3、查询
（1）查询员工薪水以及员工姓名，然后判断，如果薪水小于1000，显示“薪水低”，
如果1000到2000，显示“中等”，大于2000，显示“薪水不错”。
select ename,sal,
case 
when sal < 1000 then '薪水低'
when sal >= 1000 and sal <= 2000 then '中等'
else '薪水不错' end sal_s
from emp;
（2）查询薪水在1500至3000之间的员工的基本信息（要求使用between...and实现）
select * from emp where sal between 1500 and 3000;
（3）查询名字中包含A并且在部门MANAGER和部门CLERK就职的员工信息
select * from emp where ename like'%A%' and job in('MANAGER','CLERK');
（4）查询部门MANAGER和部门CLERK中有奖金的员工的数量
select count(*) from emp where job in('MANAGER','CLERK') and comm is not null;
 (5) 查询emp中员工的年工资，并由大到小一次排列
 select ename,sal*12 sal_12 from emp order by sal*12 desc;
（6）有表emp，写一个查询语句，根据以下条件给员工加工资：
原来工资大于3000，工资加100，原来工资大于1500，工资加200，其他工资加250 ;
select sal,
case
when sal > 3000 then sal + 100
when sal between 1500 and 3000 then sal + 200
else sal + 250 end sal_jgz from emp;
（7）.  在emp表中查询出部门编号为10或20的记录
（请分别使用OR和IN关键字）
select * from emp  where deptno =10 or deptno=20;

select * from emp  where deptno in(10,20);
（8）在emp表中查询出姓名的第二个字母为A的记录。
select * from emp  where ename like '_A%';

（9）查询emp表中1981年雇用的所有员工，或者是1987年5月雇用的员工。
to_date--转换成日期类型
  to_char--转换成字符类型
  select * from emp where
       to_char(hiredate,'yyyy')=1981
    or to_char(hiredate,'yyyymm')=198705;
  select * from emp 
  where  to_char(hiredate,'yyyy') like '1981%'  
      or to_char(hiredate,'yyyymm') like'198705%'
（10）找出部门10中所有经理（MANAGER）和部门20中所有办事员（CLERK）的详细资料。
select * from emp where 
      deptno=10 and job='MANAGER'
   or deptno=20 and JOB='CLERK'; 
（11）找出部门10中所有经理（MANAGER）， 部门20 中所有办事员（CLERK）,
 既不是经理又不是办事员（CLERK）但其薪金大于或等于2000的所有员工的信息。
  select * from emp where 
      deptno=10 and job='MANAGER'
   or deptno=20 and JOB='CLERK'
   or job not in('MANAGER','CLERK') and sal>=2000;
（12）显示姓名不带有R的员工的姓名。
 select * from emp where ename not like '%R%';   

4、(1)创建一个emp的备份表名为emp_tmp, 将emp中的数据插入emp_tmp中
   (2)删除emp_tmp中的job为MANGFER的人员信息
   (3)分别查询emp_tmp和emp表的交集，并集，差集的信息 
create table emp_tmp as select * from emp;
delete from emp_tmp where job='MANAGER';
SELECT * FROM EMP_TMP INTERSECT SELECT * FROM EMP;--交集
SELECT * FROM EMP_TMP UNION SELECT * FROM EMP;--并集
SELECT * FROM EMP minus SELECT * FROM EMP_TMP;--差集
