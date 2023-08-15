--Insert Data into a table--
insert into facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
values(9, 'Spa', 20, 30, 100000, 800)

--Drop Row from a table--
delete from facilities
where facid = 9

-- Add multiple rows into a table--
insert into facilities
values (9, 'Spa', 20, 30, 100000, 80),
	   (10, 'Squash Court', 3.5, 17.5, 5000, 80)
	   
--Update existing data--
update facilities
set initialoutlay = 10000
where name = 'Tennis Court 2'

--Update multiple rows and column at once--
update facilities
set guestcost = 30, membercost = 6
where name like 'Tennis Court%'

--Update a row based on contents of the row--
update facilities
set guestcost = (select guestcost from facilities where name like 'Tennis Court 1')*1.1,
	membercost = (select membercost from facilities where name like 'Tennis Court 1')*1.1
where name like 'Tennis Court 2'

--Delete a row from table--
delete from bookings
where bookid = 37

--Delete row(s) using a subquery--
delete from members
where memid not in (select memid from bookings)

