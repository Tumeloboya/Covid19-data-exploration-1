
/* Covid 19 data exploration*/


SELECT * 
FROM covid_deaths
WHERE continent is not null
ORDER BY 3,4

SELECT  location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
WHERE continent is not null
ORDER BY 3,4

--Total cases vs total deaths

SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 
AS Death_percentage
FROM covid_deaths
WHERE location = 'South Africa'
AND continent is not null
ORDER BY 1,2

--Total cases per population

SELECT location, date, population, total_cases, total_deaths, (total_deaths/population )*100 
AS Percentage_population_infected 
FROM covid_deaths
WHERE continent is not null
ORDER BY 1,2

--Countries with the highest infection rate by population

Select location, population, MAX(total_cases) as Highest_infection_count,  Max((total_cases/population))*100 as Percent_population_infected
FROM covid_deaths
GROUP BY location, population
ORDER BY Percent_population_infected desc

-- Countries with Highest Death Count per Population

SELECT location, MAX(cast(total_deaths as int)) AS Total_death_count
FROM covid_deaths
WHERE continent is not null 
GROUP BY location
ORDER BY Total_death_count desc

--Contintents with the highest death count per population

SELECT continent, MAX(cast(Total_deaths as int)) AS Total_death_count
FROM covid_deaths
WHERE continent is not null 
GROUP BY continent
ORDER BY Total_death_count desc

--Joining covid_death to covid_vaccines table

SELECT * 
FROM Portfolio_project..covid_deaths cd
JOIN Portfolio_project..covid_vaccines cv
ON cd.location = cv.location
and cd.date =  cv.date

--showing people who are fully vaccinated per population 

SELECT cd.continent, cd.location, cd.date, cd.population, cv.people_fully_vaccinated
FROM Portfolio_project..covid_deaths cd
JOIN Portfolio_project..covid_vaccines cv 
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent is not null
ORDER BY 2,3

SELECT cd.continent, cd.location, cd.date, cd.population, cv.people_fully_vaccinated
FROM Portfolio_project..covid_deaths cd
JOIN Portfolio_project..covid_vaccines cv 
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent = 'Africa'
ORDER BY 2,3

--Percentage of people who are fully vaccinated in South Africa


SELECT cd.continent, cd.location, cd.date, cd.population, cv.people_fully_vaccinated, (cv.people_fully_vaccinated/cd.population)*100 AS Percentage_people_fully_vaccinated
FROM Portfolio_project..covid_deaths cd
JOIN Portfolio_project..covid_vaccines cv 
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.location = 'South Africa'
ORDER BY 2,3
