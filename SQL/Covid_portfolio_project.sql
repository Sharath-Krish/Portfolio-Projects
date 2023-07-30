-- Q1: List the total positive cases in decending order in Nepal country against the population in 2020?

select location,dates,total_cases,population
from covid_deaths
where location='Nepal' and
dates <= '31-12-2020' and dates >= '01-01-2020' and total_cases is not null
order by total_cases desc

-- Q2: which african country had highest deaths against positive cases in 2021?

select location,total_deaths,total_cases
from covid_deaths
where continent='Africa' and
dates <= '31-12-2021' and dates >= '01-01-2021' and 
total_deaths is not null and location <> 'South Africa'
order by total_deaths desc
limit 1

-- Q3: list the asian country that had least positive cases in feb-2020 apart from zero?

select x.location,min(x.total_cases) 
from(
	 select location,dates,total_cases
	 from covid_deaths
	 where dates >='01-02-2020' and dates <= '28-02-2020' and continent='Asia'
	 order by total_cases
	 ) as x
group by x.location
order by min(x.total_cases)

-- Q4: What is the percentage of deaths against population in india?

select (max(total_deaths)/avg(population)*100)
from covid_deaths
where location='India'

-- Q5: List the countries having Least vaccination rate against its total positive cases?

select x.location, x.vaccination_rate as rate
from
(select cd.location,cv.date_, 
(sum(cv.total_vaccinations)/sum(cd.total_cases+cd.new_cases)) as vaccination_rate 
from covid_deaths cd
join covid_vaccinations cv on
cd.iso_code=cv.iso_code and cd.dates=cv.date_
group by cd.location,cv.date_
) as x
where x.vaccination_rate is not null
order by rate desc


