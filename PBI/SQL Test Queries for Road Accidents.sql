-- Q1: CY Casualties

SELECT sum(number_of_casualties) as CY_Casualties 
FROM road_accident
Where year(accident_date)='2022'

-- Q2: CY Accidents

SELECT count(distinct accident_index) as CY_Accidents
FROM road_accident
Where year(accident_date)='2022'

-- Q3: CY Fatal Casualties

SELECT sum(number_of_casualties) as CY_Fatal_Casualties
FROM road_accident
Where year(accident_date)='2022' and accident_severity = 'Fatal'

-- Q4: CY Serious Casualities

SELECT sum(number_of_casualties) as CY_Serious_Casualities
FROM road_accident
Where year(accident_date)='2022' and accident_severity = 'Serious'

-- Q5: CY Slight Casualities

SELECT sum(number_of_casualties) as CY_Slight_Casualities
FROM road_accident
Where year(accident_date)='2022' and accident_severity = 'Slight'

-- Q6: Casualties by Vehicle Type

SELECT 
case when vehicle_type in ('Agricultural vehicle') then 'Agri Vehicles' 
when vehicle_type in ('Car','Taxi/private hire car') then 'Car' 
when vehicle_type in ('Motorcycle 125cc and under','Motorcycle over 50cc and under','Motorcycle over 125cc and up to 50cc' ,
						   'Motorcycle over 500cc','Pedal cycle' ) then 'Bike'
when vehicle_type in ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') then 'Bus'
when vehicle_type in ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') then 'Van'
Else 'Other' end as vehicle_group,
sum(number_of_Casualties) as CY_Casualties 
FROM road_accident
Where year(accident_date)='2022'
group by 
case when vehicle_type in ('Agricultural vehicle') then 'Agri Vehicles' 
when vehicle_type in ('Car','Taxi/private hire car') then 'Car' 
when vehicle_type in ('Motorcycle 125cc and under','Motorcycle over 50cc and under','Motorcycle over 125cc and up to 50cc' ,
						   'Motorcycle over 500cc','Pedal cycle' ) then 'Bike'
when vehicle_type in ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') then 'Bus'
when vehicle_type in ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') then 'Van'
Else 'Other' 
end
-- Q7: CY Casualities monthly trend 

select datename(month,accident_date) as Month_Name,
sum(number_of_casualties) as CY Casualties
from road_accident
where year(accident_date) = '2022'
group by datename(month,accident_date)

select datename(month,accident_date) as Month_Name,
sum(number_of_casualties) as PY Casualties
from road_accident
where year(accident_date) = '2021'
group by datename(month,accident_date)

-- Q8: Casualties by road type

Select road_type ,sum(number_of_casualties) as CY_Casual 
from road_accident
where Year(accident_date) = '2022'
group by road_type

-- Q9: Casualties by urban/rural type

select urban_or_rural_area, 
cast(sum(number_of_casualties) as decimal (10,2))*100/
(select cast(sum(number_of_casualties) as decimal (10,2)) from road_accident where Year(accident_date) = '2022') as percen
from road_accident
where Year(accident_date) = '2022'
group by urban_or_rural_area

-- Q10: Casualties by Light condition

select 
case when light_conditions in ('Daylight') then 'DAY' 
when light_conditions in ('Darkness - lighting unknown','Darkness - lights lit','Darkness - lights unlit','Darkness - no lighting') then 'NIGHT' 
end as Light_condition, cast(cast(sum(number_of_casualties) as decimal (10,2))*100 /(select cast(sum(number_of_casualties) as decimal (10,2))
FROM road_accident
where Year(accident_date) = '2022') as decimal (10,2)) as CY_Casualties_percen
from road_accident
where Year(accident_date) = '2022'
group by 
case when light_conditions in ('Daylight') then 'DAY' 
when light_conditions in ('Darkness - lighting unknown','Darkness - lights lit','Darkness - lights unlit','Darkness - no lighting') then 'NIGHT' 
end

