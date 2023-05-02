create database Jobu
use jobu
create table Madara(
Activities varchar(100),
Time int,
Location varchar (100),
Weight int
) 
alter table Madara
add Math varchar(255);
alter table madara
add id int primary key identity(1,1)

insert into Madara (Activities, Time, Weight, math) values('Gym', 0800, 70, 'True')
insert into Madara (Activities, Time, Weight, math) values('Breakfast', 1000, 45, 'True')
insert into Madara (Activities, Time, Weight, math) values('Read', 1030, 75, 'True')
insert into Madara (Activities, Time, Weight, math) values('Teach', 1230, 70, 'False')
insert into Madara (Activities, Time, Weight, math) values('Trade', 1500, 70, 'False')
insert into Madara (Activities, Time, Weight, math) values('Trade', 1500, 70, 'False')

select*
from Madara

create table Madara_Extra(
id int primary key identity(1,1),
Active varchar (100),
Time_takenhrs int,
Location2 varchar(100),
Math_ref varchar(255)
)

Insert into madara_extra (Active, Time_takenhrs, Location2, Math_ref) values ('Benchpress', 2, 'Utawala', 'Two Days') 
Insert into madara_extra (Active, Time_takenhrs, Location2, Math_ref) values ('Fish', 1, 'Nyanam', 'Three Days')
Insert into madara_extra (Active, Time_takenhrs, Location2, Math_ref) values ('Linear Algebra', 3, 'Lavington', 'Four Days')
Insert into madara_extra (Active, Time_takenhrs, Location2, Math_ref) values ('Calculus', 4, 'Lavington', 'Three Days')
Insert into madara_extra (Active, Time_takenhrs, Location2, Math_ref) values ('Dow Jones', 3, 'Kilimani', 'Three Days')
Insert into madara_extra (Active, Time_takenhrs, Location2, Math_ref) values ('Dow Jones', 3, 'Kilimani', 'Three Days')

select*
from Madara_Extra

SELECT LOCATION
, CASE WHEN LOCATION = 'Null' then 'Nairobi'
else Location
end
from Madara

update madara 
set location = CASE WHEN LOCATION = 'Null' then 'Nairobi'
end

select *
from madara

alter table madara
add foreign key (id) references madara_extra(id)

update madara
set location  = 'Nairobi'
where id = 6;

select * from madara
full join madara_extra on madara.id=Madara_Extra.id

update madara
set location  = 'Nakuru'
where id between 2 and 5;

select location, avg(weight) from Madara
group by location

select location2, sum(time_takenhrs) as total_time, count(location2) as Frequency from Madara_Extra
group by location2

select  m2.location2, sum(m2.time_takenhrs) as total_time, count (m2.location2) as Frequeny
from Madara_Extra as m2
join madara as m on m2.id=m.id
group by m2.Location2
--having location2 = 'Lavington'