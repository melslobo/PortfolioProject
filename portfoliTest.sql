SELECT location, date, total_cases, new_cases, total_deaths, population 
from CovidDeaths
order by 3,4

SELECT location, date, total_cases, population, (total_cases/population)*100 as casePopulation  
from CovidDeaths
where location like '%canada%'
order by 1,2, 5 desc

SELECT location,  population, max(total_cases) as highestInfection, max(total_cases/population)*100 as percentOfPopulation  
from CovidDeaths
--where location like '%canada%'
where continent is not null
group by location, population
order by percentOfPopulation desc

SELECT location,    
max(total_deaths) as TotalDeathCount
from CovidDeaths
--where location like '%canada%'
where continent is  null
group by location
order by TotalDeathCount desc


SELECT location,   max(total_cases) as highestInfection, 
max(cast(total_deaths as int)), 
max(total_cases/total_deaths)*100 as percentOfPopulation
from CovidDeaths
--where location like '%canada%'
where continent is not null
group by location, population
order by percentOfPopulation desc


SELECT  continent,
max(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is  not null
group by continent
order by TotalDeathCount desc

--Global numbers
SELECT sum(new_cases) as totalCase, sum(new_deaths) as totalDeath,
sum(new_cases)/sum(new_deaths) * 100as DeathPercentage  
--sum((new_deaths/new_cases)*100) as DeathPercentage  
from CovidDeaths
where continent is not null
--group by date
order by 1,2

select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, SUM(vc.new_vaccinations) 
	OVER (partition by dt.location order by dt.location, dt.date ) as RollingPeopleVaccinated
FROM
 CovidDeaths dt
Join CovidVaccinations vc
	On dt.location = vc.location and
	dt.date = vc.date
where dt.continent is not null
and dt.location = 'Albania'
and vc.new_vaccinations is not null
order by 2,3


--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
	select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
	, SUM(vc.new_vaccinations) 
		OVER (partition by dt.location order by dt.location, dt.date ) as RollingPeopleVaccinated
	FROM
	 CovidDeaths dt
	Join CovidVaccinations vc
		On dt.location = vc.location and
		dt.date = vc.date
	where dt.continent is not null
	and vc.new_vaccinations is not null
	--order by 2,3
)






With PopvsVac 
	(Continent, Location, Date, Population)
as 
(
	select dt.continent, dt.location, dt.date
	FROM
	 #TestTempTable dt
	where dt.continent is not null
	and dt.location = 'India'
	--order by 2,3
)

CREATE view ViewTable(
	Continent [varchar](50) NOT NULL,
	Location [varchar](50) NOT NULL,
	date [date] NULL
)

CREATE view ViewTable(
select dt.continent, dt.location, dt.date, dt.population
	FROM
	 CovidDeaths
select * from  #TestTempTable


Drop  view PercentPolulatedVacinated;
CREATE view PercentPolulatedVacinated as 
	select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
	, SUM(vc.new_vaccinations) 
		OVER (partition by dt.location order by dt.location, dt.date ) as RollingPeopleVaccinated
	FROM
	 CovidDeaths dt
		Join CovidVaccinations vc
		On dt.location = vc.location and
		dt.date = vc.date
	 Where vc.new_vaccinations is not null
--	order by 2,3