create database zuoye default charset=utf8;      -- 创建数据库
use zuoye;      -- 使用数据库


#创建几个库表
create table Student    -- 学生表
(
Sno char(3) NOT NULL Primary key ,    -- 学号 ，设为主键，不允许空值   
Sname char(8) NOT NULL,        -- 学生姓名
Ssex char(2)NOT NULL,        -- 学生性别
Sbirthday datetime,     -- 学生出生年月
Class char(5)         -- 学生所在班级
);

create table Teacher        -- 教师表
(
Tno char(3)NOT NULL primary key,        -- 教工编号设为主键
Tname char(4)NOT NULL,        -- 教工姓名
Tsex char(2)NOT NULL,        -- 教工性别
Tbirthday datetime,        -- 教工出生年月
Prof char(6),        -- 职称
Depart varchar(10)NOT NULL        -- 教工所在部门
)

create table Course        -- 课程表
(
    Cno char(5) NOT NULL Primary key ,        -- 课程号设为主键
    Cname varchar(10) NOT NULL,        -- 课程名称
    Tno char(3) NOT NULL references Teacher(Tno)        -- 教工编号设为外键
)

create table Score    -- 成绩表
(
Sno char(3) NOT NULL references Student(Sno),    -- 学号设为外码
Cno char(5) NOT NULL references Course(Cno),    -- 课程号设为外码
Degree Decimal(4,1),    -- 成绩
primary key(Sno,Cno)    -- 学号和课程号设为联合主键
)

二、插入数据


insert into Student values(108,'曾华','男','1977-09-01','95033');
insert into Student values(105,'匡明','男','1975-10-02','95031');
insert into Student values(107,'王丽','女','1976-01-23','95033');
insert into Student values(101,'李军','男','1976-02-20','95033');
insert into Student values(109,'王芳','女','1975-02-10','95031');
insert into Student values(103,'陆君','男','1974-06-03','95031');

insert into Teacher values(804,'李诚','男','1958-12-02','副教授','计算机系');
insert into Teacher values(856,'张旭','男','1969-03-12','讲师','电子工程系');
insert into Teacher values(825,'王萍','女','1972-05-05','助教','计算机系') ;
insert into Teacher values(831,'刘冰','女','1977-08-14','助教','电子工程系');

insert into Course values('3-105','计算机导论',825);
insert into Course values('3-245','操作系统',804);
insert into Course values('6-166','数字电路',856);
insert into Course values('9-888','高等数学',831);

insert into Score values(103,'3-245',86);
insert into Score values(105,'3-245',75);
insert into Score values(109,'3-245',68);
insert into Score values(103,'3-105',92);
insert into Score values(105,'3-105',88);
insert into Score values(109,'3-105',76);
insert into Score values(101,'3-105',64);
insert into Score values(107,'3-105',91);
insert into Score values(108,'3-105',78);
insert into Score values(101,'6-166',85);
insert into Score values(107,'6-166',79);
insert into Score values(108,'6-166',81); 

select * from Student;
select * from Teacher;
select * from Course;
select * from Score;


create table Grade(Low int  ,Upp int,Rank char(1))
select *from Grade;
insert into Grade values(90,100,'A');
insert into Grade values(80,89,'B');
insert into Grade values(70,79,'C');
insert into Grade values(60,69,'D');
insert into Grade values(0,59,'E');

-- 1、 查询Student表中的所有记录的Sname、Ssex和Class列。
select sname,ssex,class from student;

-- 2、 查询教师所有的单位即不重复的Depart列。  distinct
select distinct depart from teacher;

-- 3、 查询Student表的所有记录。
select * from student;

-- 4、 查询Score表中成绩在60到80之间的所有记录。    and  
select * from score where degree >60 and degree <80;
select * from score where degree between 60 and 80;

-- 5、 查询Score表中成绩为85，86或88的记录。  or
select cno,degree,sno from score where degree=85 or degree=86 or degree=88;

-- 6、 查询Student表中"95031"班或性别为"女"的同学记录。  or   ||
select class,ssex from student where class=95031 || ssex='女';

-- 7、 以Class降序查询Student表的所有记录。
select * from student order by class desc;

-- 8、 以Cno升序、Degree降序查询Score表的所有记录。
select* from score order by cno ,degree desc;

-- 9、 查询"95031"班的学生人数。
select count(*) from student where class='95031';
select * from student;

-- 10、 查询Score表中的最高分的学生学号和课程号。（子查询或者排序）
select sno,cno from score  order by degree desc limit 1 ;
select * from score;

-- 10.1 查询Score表中除了每门课程最高分的学生学号和课程号。（子查询或者排序） 
select sno,cno from score where degree  !=(select degree from score  order by degree desc limit 1 
)

-- 11、查询每门课的平均成绩。
select  avg(degree) from score group by cno;
select * from score;

-- 12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
select cno, avg(degree)
from score  where cno like '%3%' 
group by cno
having count(sno)>=5;

-- 13、查询分数大于70，小于90的Sno列。
select sno
from score
group by sno
having min(degree)>70 and max(degree)<90;

-- 14、查询所有学生的Sname、Cno和Degree列。 
select sname,cno,degree from student join score on student.sno=score.sno
order by student.sno;

-- 15、查询所有学生的Sno、Cname和Degree列
select sno,cname,degree from course join score on course.cno=score.cno
order by sno;

-- 16、查询所有学生的Sname、Cname和Degree列。
select sname,cname,degree from student join score on student.sno=score.sno join course on score.cno=course.cno
order by student.sno;

-- 17、查询"95033"班学生的平均分。
select class, avg(degree) from student
join score on student.sno=score.sno
group by class
having class='95033'
order by class

-- 18、 现查询所有同学的Sno、Cno和rank列。
select sno,cno,rank from score join grade on score.degree between grade.low and grade.upp
order by sno;

-- 19、查询选修"3-105"课程的,并且成绩高于"109"号同学成绩的所有同学的记录。
select *
from student join score on student.sno=score.sno
where cno = '3-105'
group by score.sno
having degree > (select max(degree) from score where score.sno='109');

-- 20、查询成绩高于学号为"109"、课程号为"3-105"的成绩的所有记录。
select *
from score join course on score.cno=course.cno
where course.cno = '3-105'
group by sno
having degree > (select max(degree) from score where sno='109');