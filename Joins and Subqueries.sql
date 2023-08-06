--Retrieve start times of a member--
select m.firstname, m.surname, b.starttime from members m, bookings b
where m.memid = b.memid and m.firstname like 'David' and m.surname like 'Farrell'

--Retrieve start times for tennis courts--
select f.name, b.starttime from facilities f, bookings b
where b.facid = f.facid and f.name in ('Tennis Court 1', 'Tennis Court 2') and b.starttime in 
(select b.starttime from bookings b, members m
where m.memid = b.memid and b.starttime >= '2012-09-21' and b.starttime < '2012-09-22')

--Retrieve start times for tennis courts using join--
select f.name, b.starttime from facilities f
join bookings b
on b.facid = f.facid and b.starttime >= '2012-09-21' and b.starttime < '2012-09-22'
where f.name in ('Tennis Court 1', 'Tennis Court 2')
order by b.starttime asc

--Retrieve all members who have recommended other members--
select firstname, surname from members
where memid in (select recommendedby from members
where recommendedby is not null)
order by surname, firstname

--Retrieve members with list of recommenders
select m1.firstname, m1.surname, m2.firstname, m2.surname from members m1 
join members m2 on m1.recommendedby = m2.memid
where m1.recommendedby is not null 
order by m1.surname, m1.firstname, m2.surname, m2.firstname

--Retrieve a list of all members who have used a tennis court
select distinct f.name as facility, concat(m.firstname,' ',m.surname) as name
from facilities f, members m, bookings b
where f.facid = b.facid and b.memid = m.memid and f.name like '%Tennis Court%'
order by name

--Retrieve a list of costly bookings--
select concat(m.firstname, ' ',m.surname), f.name,
case when b.memid = 0 then f.guestcost*b.slots
when b.memid != 0 then f.membercost*b.slots 
end as cost
from bookings b, facilities f, members m
where m.memid = b.facid and b.facid = f.facid
and b.starttime >= '2012-09-14' and b.starttime < '2012-09-15'
and ((b.memid = 0 and f.guestcost*b.slots > 30) or (b.memid != 0 and f.membercost*b.slots > 30))  
order by cost desc




