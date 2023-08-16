--Count number of facilities--
select count(*) from facilities

--Count number of expensive facilities--
select count(*) from facilities
where guestcost >= 10

--Count number of recommendations each member makes--
select recommendedby, count(*) from members
where recommendedby is not null
group by recommendedby
order by recommendedby

--List total slots booked per facility in a given month--
select facid, sum(slots) from bookings
where extract(month from starttime) = 09
group by facid
order by sum(slots)

--List total slots booked per facility per month--
select facid, sum(slots), extract(month from starttime) as month from bookings
where extract(year from starttime) = 2012
group by facid, extract(month from starttime)
order by facid, extract(month from starttime)

--List facilites with more than 1000 slots booked--
select f.facid, sum(b.slots) from bookings b, facilities f
where f.facid = b.facid
group by f.facid
having sum(b.slots) > 1000
order by f.facid

--List facilities with total revenue less than 1000--
select f.name, 
sum(case when b.memid = 0 then slots*guestcost
	else slots*membercost
	end) as revenue
from facilities f, bookings b
where b.facid = f.facid 
group by f.name
having sum(case when b.memid = 0 then slots*guestcost
	else slots*membercost
	end) < 1000
order by revenue

--List total hours booked per named facility--
select b.facid, f.name, (sum(b.slots)*0.5) as hours from bookings b, facilities f
where f.facid = b.facid
group by b.facid, f.name
order by b.facid

--List each member's first booking after September 1st 2012--
select m.surname, m.firstname, b.memid, max(b.starttime) from bookings b, members m
where b.memid = m.memid and b.starttime > '2012-09-01'
group by m.surname, m.firstname, b.memid
order by b.memid

--Find top three revenue generating facilities--
select f.name, 
sum(case when b.memid = 0 then slots*guestcost
	else slots*membercost
	end) as revenue
from facilities f, bookings b
where b.facid = f.facid 
group by f.name
order by revenue desc
limit 3

