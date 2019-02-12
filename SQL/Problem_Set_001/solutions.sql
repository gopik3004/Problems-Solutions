--DB CREATION--
create Database Empoloyee_dept_Db;
use Empoloyee_dept_Db;

--Dept Table Creation--
create table dept(dep_id varchar(3) primary key,depname varchar(20),depmanager varchar(20));
--Inserting into Dept Table--
insert into dept values("D01","HEALTH","TIM ARCHER");
insert into dept values("D02","COMMUNICATIONS","ADAM JUSTIN");
insert into dept values("D03","PRODUCT","BRUCE WILLS");
insert into dept values("D04","INSURANCE","ROBERT SWIFT");
insert into dept values("D05","FINANCE","NATASHA STEVENS");

--Employee Table Creation--
create table employee(e_id varchar(5) ,name varchar(20),dep_id varchar(5) references dept(dep_id),salary number,managerid varchar(5));

--Inserting into Employee Table--
insert into employee values("A114","MARTIN TREDEAU","D01",54497,"A120");
insert into employee values("A116","ROBIN WAYNE","D02",20196,"A187");
insert into employee values("A178","BRUCE WILLS","D03",66861,"A298");
insert into employee values("A132","PAUL VINCENT","D01",94791,"A120");
insert into employee values("A198","TOM HANKS","D02",16879,"A187");
insert into employee values("A120","TIM ARCHER","D01",48834,"A298");
insert into employee values("A143","BRAD MICHAEL","D01",24488,"A120");
insert into employee values("A187","ADAM JUSTIN","D02",80543,"A298");
insert into employee values("A121","STUART WILLIAM","D02",78629,"A187");
insert into employee values("A187","ROBERT SWIFT","D04",27700,"A298");
insert into employee values("A176","EDWARD CANE","D01",89176,"A120");
insert into employee values("A142","TARA CUMMINGS","D04",99475,"A187");
insert into employee values("A130","VANESSA PARY","D04",28565,"A187");
insert into employee values("A128","ADAM WAYNE","D05",94324,"A165");
insert into employee values("A129","JOSEPH ANGELIN","D05",44280,"A165");
insert into employee values("A165","NATASHA STEVENS","D05",31377,"A298");
insert into employee values("A111","JOHN HELLEN","D01",15380,"A120");
insert into employee values("A194","HAROLLD STEVENS","D02",32166,"A187");
insert into employee values("A133","STEVE MICHELOS","D02",61215,"A187");
insert into employee values("A156","NICK MARTIN","D03",50174,"A178");

/*Queries:

1)Select the Employee with the top three salaries */

select name,salary from employee order by salary desc limit 3;

--2)Select the Employee with the least salary--

select name from employee where salary=(select min(salary) from employee);

select name from employee order by salary limit 1;

--3)Select the Employee who does not have a manager in the department table--

select name from employee where managerid not in (select e_id from employee);

--4)Select the Employee who is also a Manager--

select name,e_id from employee e join dept d on e.name=d.depmanager;

select name,e_id from employee where e_id in (select managerid from employee);

select e.name,e.e_id from employee e where e.e_id in (select distinct(managerid) from employee);

--5)Select the Empolyee who is a Manager and has least salary--

select name,salary from employee e join dept d on e.name=d.depmanager order by salary limit 1;

--6)Select the total number of Employees in Communications departments--

select count(*) as 'No.of Employees in Communications departments' from employee where dep_id=(select dep_id from dept where depname='COMMUNICATIONS');

select count(*) from employee  where dep_id=(select dep_id from dept where depname='COMMUNICATIONS') group by dep_id;

select count(*) from employee e join dept d on d.dep_id=e.dep_id where d.depname='COMMUNICATIONS';

--7)Select the Employee in Finance Department who has the top salary--

select name,salary from employee where dep_id=(select dep_id from dept where depname='FINANCE') order by salary desc limit 1 ;

select e.name,e.salary from employee e join dept d on d.dep_id=e.dep_id where d.depname='FINANCE' order by e.salary desc limit 1;


--8)Select the Employee in product depatment who has the least salary--

select e.name,e.salary from employee e join dept d on d.dep_id=e.dep_id where d.depname='PRODUCT' order by salary limit 1;

--9)Select the count of Empolyees in Health with maximum salary--

select count(*) from employee e join dept d on d.dep_id=e.dep_id where d.depname='HEALTH';

select count(name) from employee where salary=(select max(salary) from employee e join dept d on d.dep_id=e.dep_id where d.depname='HEALTH');

--10)Select the Employees who report to Natasha Stevens--

select e.name,e.managerid from employee e join dept d on d.dep_id=e.dep_id where d.depmanager='NATASHA STEVENS';

--11)Display the Employee name,Employee count,Dep name,Dept manager in the Health department--

select e.name,d.depname,d.depmanager from employee e join dept d on e.dep_id=d.dep_id  where d.depname='HEALTH';

--12)Display the Department id,Employee ids and Manager ids for the Communications department--

select d.dep_id,e.e_id,e.managerid from employee e join dept d on d.dep_id=e.dep_id where d.depname='COMMUNICATIONS';

--13)Select the Average Expenses for Each dept with Dept id and Dept name--

select avg(salary),d.dep_id,d.depname from employee e join dept d on d.dep_id=e.dep_id group by dep_id;

--14)Select the total expense for the department finance--

select sum(e.salary) as 'Total Finance Expense' from employee e join dept d on d.dep_id=e.dep_id where d.depname='FINANCE';

