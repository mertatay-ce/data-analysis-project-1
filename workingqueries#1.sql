--Select * From PortfolioProject..CovidDeaths Where continent is not null Order by 3,4
--Select * From PortfolioProject..CovidVaccinations Order by 3,4

--Select data that we are going to be using

--Select location, date, total_cases, new_cases, total_deaths, population
--From PortfolioProject..CovidDeaths
--Order by 3,4

-- Looking at Total Cases vs Total Deaths
-- Shows likelyhood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths ,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null
Order by 1,2

-- Looking at Total Cases vs Total Deaths in United States

Select location, date, total_cases, total_deaths ,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location Like '%states'

Order by 1,2

--Looking at Total Cases vs Total Deaths in Turkey
--Select location, date, total_cases, total_deaths ,(total_deaths/total_cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
--Where location Like '%turkey'
--Order by 1,2


--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

--Select location, date, population, total_cases,(total_cases/population)*100 as CasesPercentage
--From PortfolioProject..CovidDeaths
--Where location Like '%turkey'
--Order by 1,2

--Looking at Countries with Highest infection rate compared to Population

--Select location, population, MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population)*100 )as PercentPopulationInfected
--From PortfolioProject..CovidDeaths
----Where location Like '%turkey'
--Group By location, population
--Order by 1,2 

--Looking at Countries with Highest infection rate compared to Population and ordered by descending

--Select location, population, MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population)*100 )as PercentPopulationInfected
--From PortfolioProject..CovidDeaths
----Where location Like '%turkey'
--Group By location, population
--Order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group By location
Order by TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population
Select location, MAX(cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null
Group By location
Order by TotalDeathCount desc


--drill down effect in sql(research)

-- GLOBAL NUMBERS 

Select  SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int)) / SUM(new_cases) * 100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null
--Group by date
Order by 1,2



