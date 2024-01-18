

-- Likelihood of Dying from Covid
select location, date, total_cases, total_deaths, 
Concat(round((total_deaths/total_cases)*100,2), "%") as TotalDeathPerCases
from coviddeaths
where location ="Indonesia";

-- Total cases vs population
select location, date, population, total_cases,
concat((total_cases/population)*100, "%") as PercentPopulationInfected
from coviddeaths
-- where location="Indonesia"
group by location, population, total_cases, date
order by PercentPopulationInfected desc;

-- Highest infection rate compared to their population
select location, population, max(total_cases) as max_cases,
concat(round((max(total_cases)/population)*100,2), "%") as InfectionRatePerCountry
from coviddeaths
group by location, population
order by InfectionRatePerCountry desc;


-- Country with highest deceased rate
									-- Unsigned equal to Integer here!!
									-- This is just MySQL default
select location, max(cast(total_deaths as unsigned)) as max_deceased, 
concat(round((max(cast(total_deaths as unsigned))/population)*100,3), "%") as DeceasedRatePerCountry
from coviddeaths
where continent is not null
group by location, population
order by max(cast(total_deaths as unsigned)) desc;


-- Continent with highest death count
select continent, max(cast(total_deaths as unsigned)) as Total_death_count
from coviddeaths
where continent is not null
group by continent
order by Total_death_count desc;


-- Global number
-- Might be wrong with the "sum(cast(new_deaths as unsigned)) as Total_New_deaths"
-- THe number seems inconsistent 
select date, sum(new_cases) as total_new_cases, sum(cast(new_deaths as unsigned)) as Total_New_deaths,
sum(cast(new_deaths as unsigned)) / sum(new_cases)*100 as Death_Percentage
from coviddeaths
where continent is not null
group by date
order by 1,2;


-- Why row where continent is null still being taken?? ...
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from coviddeaths as dea
left join covidvaccination as vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
	and vac.continent is not null
order by 2,3;
    

describe coviddeaths;