--Looking at Total Vaccination vs Vaccinations

Select dea.continent, dea.location , dea.date, dea.population,vac.new_vaccinations
,SUM(Convert(int,vac.new_vaccinations))  OVER (partition by dea.location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated / dea.population) * 100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac On dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
Order by 2,3


--USE CTE


With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
as (
Select dea.continent, dea.location , dea.date, dea.population,vac.new_vaccinations
,SUM(Convert(int,vac.new_vaccinations))  OVER (partition by dea.location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated / dea.population) * 100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac On dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
) Select * , (RollingPeopleVaccinated / population) * 100 as RollingVaccinationPercent
 From PopvsVac



--TEMP TABLE


DROP TABLE if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated 
(
  Continent nvarchar(255),
  Location nvarchar(255),
  Date datetime,
  Population numeric,
  New_Vaccinations numeric,
  RollingPeopleVaccinated numeric
)
Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location , dea.date, dea.population,vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as bigint))  OVER (partition by dea.location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated / dea.population) * 100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac On dea.location = vac.location and dea.date = vac.date
--Where dea.continent is not null
--Order by 2,3
Select * , (RollingPeopleVaccinated / population) * 100 as RollingVaccinationPercent
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location , dea.date, dea.population,vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations as bigint))  OVER (partition by dea.location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated / dea.population) * 100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac On dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3

Select * From PercentPopulationVaccinated


