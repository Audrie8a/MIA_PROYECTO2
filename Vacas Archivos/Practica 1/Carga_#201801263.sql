create database Practica1_201801263;
use Practica1_201801263;

drop table TablaTemp;

create table TablaTemp(
id int identity(1,1),
iso_code varchar(45),
continent varchar(45),
locations varchar(45),
dates varchar(45),
total_cases varchar(45),
new_cases varchar(45),
new_cases_smoothed float,
total_deaths varchar(45),	
new_deaths varchar(45),
new_deaths_smoothed	float,
total_cases_per_million	float,
new_cases_per_million float,
new_cases_smoothed_per_million float,
total_deaths_per_million float,
new_deaths_per_million float,
new_deaths_smoothed_per_million float,
reproduction_rate float,
icu_patients float,
icu_patients_per_million float,	
hosp_patients float,
hosp_patients_per_million float,
weekly_icu_admissions float,
weekly_icu_admissions_per_million float,
weekly_hosp_admissions float,
weekly_hosp_admissions_per_million float,
new_tests varchar(45),
total_tests varchar(45),
total_tests_per_thousand float,	
new_tests_per_thousand float,
new_tests_smoothed float,
new_tests_smoothed_per_thousand	float,
positive_rate float,
tests_per_case float,
tests_units varchar(45),
total_vaccinations varchar(45),
people_vaccinated varchar(45),
people_fully_vaccinated	float,
new_vaccinations varchar(45),
new_vaccinations_smoothed float,
total_vaccinations_per_hundred float,
people_vaccinated_per_hundred float,
people_fully_vaccinated_per_hundred	float,
new_vaccinations_smoothed_per_million float,
stringency_index float,
populations varchar(45),	
population_density float,
median_age float,
aged_65_older float,
aged_70_older float,
gdp_per_capita float,
extreme_poverty	float,
cardiovasc_death_rate float,
diabetes_prevalence float,
female_smokers float,
male_smokers float,
handwashing_facilities float,
hospital_beds_per_thousand float,
life_expectancy	float,
human_development_index	float,
excess_mortality float
);



select * from TablaTemp;


--CONTINENTE ---------
insert into Continente
select distinct continent from TablaTemp where  (continent is not null);

--select *from Continente;

--PAIS----------------
insert into Pais
select distinct tt.iso_code,tt.locations,C.id_Continente from TablaTemp as tt,Continente as C 
where tt.continent= C.continent;

--select * from Pais;

--select P.iso_code,C.continent,P.locations 
--from Pais as P, Continente as C
--where C.id_Continente=P.id_Continente order by P.locations asc;


--Muertes
insert into Muertes
select distinct tt.total_deaths, tt.new_deaths, tt.new_deaths_smoothed, tt.total_deaths_per_million, tt.new_deaths_per_million, tt.new_deaths_smoothed_per_million, P.id_Pais, convert(date,tt.dates)
from TablaTemp as tt, Pais as P, Continente as C
where tt.locations=P.locations;

--select * from Muertes;

--Casos

insert into Casos
select distinct tt.total_cases, tt.new_cases, tt.new_cases_smoothed, tt.total_cases_per_million, tt.new_cases_per_million, tt.new_cases_smoothed_per_million,convert(date,tt.dates),P.id_Pais
from TablaTemp as tt, Pais as P
where tt.locations=P.locations;

--select * from Casos;

--DatosVacuna

insert into DatosVacuna
select distinct tt.total_vaccinations, tt.people_vaccinated, tt.people_fully_vaccinated, tt.new_vaccinations, tt.new_vaccinations_smoothed, tt.total_vaccinations_per_hundred, 
tt.people_vaccinated_per_hundred, tt.people_fully_vaccinated_per_hundred, tt.new_vaccinations_smoothed_per_million, convert(date,tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where tt.locations=P.locations;

--select * from DatosVacuna;

--DATOSPAIS------------

insert into DatosPais
select  distinct tt.populations,tt.population_density, tt.extreme_poverty, tt.life_expectancy, tt.gdp_per_capita, tt.human_development_index,
tt.median_age, tt.aged_65_older, tt.aged_70_older, tt.handwashing_facilities, P.id_Pais,YEAR(tt.dates)
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;

--select * from DatosPais;


--DATOSTEST----------------
insert into DatosTest
select distinct tt.new_tests, tt.total_tests, tt.total_tests_per_thousand, tt.new_tests_per_thousand, tt.new_tests_smoothed,
tt.new_tests_smoothed_per_thousand, tt.tests_units, convert(date, tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;


--RATES--------------------
insert into Rates
select distinct tt.reproduction_rate, tt.positive_rate, tt.tests_per_case, tt.excess_mortality, tt.stringency_index, convert(date, tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where P.locations =tt.locations;

--select * from Rates;

--DATOSCASOSESPECIALES
insert into DatosCasosEspeciales
select distinct tt.cardiovasc_death_rate, tt.diabetes_prevalence, tt.female_smokers, tt.male_smokers, convert(date, tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;

--select * from DatosCasosEspeciales;

--DATOSHOSPITAL
insert into DatosHospital
select distinct tt.hosp_patients, tt.hosp_patients_per_million, tt.weekly_hosp_admissions, tt.weekly_hosp_admissions_per_million,
tt.icu_patients, tt.icu_patients_per_million, tt.weekly_hosp_admissions_per_million, tt.weekly_icu_admissions, tt.hospital_beds_per_thousand, convert(date, tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;

--REGISTRO-----------------
--insert into Registro
--select  distinct P.id_Pais, tt.dates
--from TablaTemp as tt, Pais as p, Continente as C
--where  P.locations=tt.locations
--and C.continent=tt.continent
--and C.iso_code=tt.iso_code
--order by P.id_Pais asc;