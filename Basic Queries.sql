--Retrieve everything from a table--
select * from facilities

--Retrieve specific columns--
select name, membercost, guestcost from facilities

--Retrieve specific rows part I
select name from facilities
where membercost != 0

--Retrieve specific rows part II
select name from facilities
where membercost != 0 and membercost < (monthlymaintenance/50)

--String search --
select * from facilities
where name like '%Tennis%'

--Classify results into buckets--
select name, monthlymaintenance,
	case when monthlymaintenance > 100 then 'Expensive'
	else 'Cheap'
	end as "Label" from facilities

--Working with Dates--
select memid, surname, firstname, joindate from members
where joindate > '2012-09-01'

--Removing duplicates and ordering--
select distinct surname from members
order by surname
limit 10

--Combining results from multiple queries--
select memid, zipcode from members
union 
select slots, memid from bookings

--Simple Aggregation--
select joindate as "latest" from members 
order by joindate desc
limit 1

--Aggregation Part II--
select firstname, surname, joindate from members
order by joindate desc
limit 1









