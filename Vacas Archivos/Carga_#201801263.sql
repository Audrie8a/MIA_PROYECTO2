--create database Practica1;
use Practica1;

drop table TablaTemp;

truncate table Ubicacion;

create table TablaTemp(
id int identity(1,1),
iso_code varchar(45),
continent varchar(45),
locations varchar(45),
dates varchar(45),
total_cases varchar(45),
new_cases varchar(45),
new_cases_smoothed varchar(45),
total_deaths varchar(45),	
new_deaths varchar(45),
new_deaths_smoothed	varchar(45),
total_cases_per_million	varchar(45),
new_cases_per_million varchar(45),
new_cases_smoothed_per_million varchar(45),
total_deaths_per_million varchar(45),
new_deaths_per_million varchar(45),
new_deaths_smoothed_per_million varchar(45),
reproduction_rate varchar(45),
icu_patients varchar(45),
icu_patients_per_million varchar(45),	
hosp_patients varchar(45),
hosp_patients_per_million varchar(45),
weekly_icu_admissions varchar(45),
weekly_icu_admissions_per_million varchar(45),
weekly_hosp_admissions varchar(45),
weekly_hosp_admissions_per_million varchar(45),
new_tests varchar(45),
total_tests varchar(45),
total_tests_per_thousand varchar(45),	
new_tests_per_thousand varchar(45),
new_tests_smoothed varchar(45),
new_tests_smoothed_per_thousand	varchar(45),
positive_rate varchar(45),
tests_per_case varchar(45),
tests_units varchar(45),
total_vaccinations varchar(45),
people_vaccinated varchar(45),
people_fully_vaccinated	varchar(45),
new_vaccinations varchar(45),
new_vaccinations_smoothed varchar(45),
total_vaccinations_per_hundred varchar(45),
people_vaccinated_per_hundred varchar(45),
people_fully_vaccinated_per_hundred	varchar(45),
new_vaccinations_smoothed_per_million varchar(45),
stringency_index varchar(45),
populations varchar(45),	
population_density varchar(45),
median_age varchar(45),
aged_65_older varchar(45),
aged_70_older varchar(45),
gdp_per_capita varchar(45),
extreme_poverty	varchar(45),
cardiovasc_death_rate varchar(45),
diabetes_prevalence varchar(45),
female_smokers varchar(45),
male_smokers varchar(45),
handwashing_facilities varchar(45),
hospital_beds_per_thousand varchar(45),
life_expectancy	varchar(45),
human_development_index	varchar(45),
excess_mortality varchar(45)
);


select * from TablaTemp;

select distinct (valorInt), valorVarchar45,valorVarchar, valorDec3 from Prueba order by valorInt asc;
insert into Prueba
select new_deaths, iso_code,'a',10.5 from TablaTemp;
--CONTINENTE ---------
insert into Continente
select distinct continent from TablaTemp where  (continent is not null);

select *from Continente;

--PAIS----------------
insert into Pais
select distinct tt.iso_code,tt.locations,C.id_Continente from TablaTemp as tt,Continente as C 
where tt.continent= C.continent;

select * from Pais;

select P.iso_code,C.continent,P.locations 
from Pais as P, Continente as C
where C.id_Continente=P.id_Continente order by P.locations asc;


--Muertes
insert into Muertes
select distinct tt.total_deaths, tt.new_deaths, tt.new_deaths_smoothed, tt.total_deaths_per_million, tt.new_deaths_per_million, tt.new_deaths_smoothed_per_million, P.id_Pais, convert(date,tt.dates)
from TablaTemp as tt, Pais as P, Continente as C
where tt.locations=P.locations;

select * from Muertes;

--Casos

insert into Casos
select distinct tt.total_cases, tt.new_cases, tt.new_cases_smoothed, tt.total_cases_per_million, tt.new_cases_per_million, tt.new_cases_smoothed_per_million,convert(date,tt.dates),P.id_Pais
from TablaTemp as tt, Pais as P
where tt.locations=P.locations;

select * from Casos;
--DatosVacuna

insert into DatosVacuna
select distinct tt.total_vaccinations, tt.people_vaccinated, tt.people_fully_vaccinated, tt.new_vaccinations, tt.new_vaccinations_smoothed, tt.total_vaccinations_per_hundred, 
tt.people_vaccinated_per_hundred, tt.people_fully_vaccinated_per_hundred, tt.new_vaccinations_smoothed_per_million, convert(date,tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where tt.locations=P.locations;

select * from DatosVacuna;

--DATOSPAIS------------
select YEAR('12/05/2020');

insert into DatosPais
select  distinct tt.populations,tt.population_density, tt.extreme_poverty, tt.life_expectancy, tt.gdp_per_capita, tt.human_development_index,
tt.median_age, tt.aged_65_older, tt.aged_70_older, tt.handwashing_facilities, P.id_Pais,YEAR(tt.dates)
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;

select * from DatosPais;


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

select * from Rates;

--DATOSCASOSESPECIALES
insert into DatosCasosEspeciales
select distinct tt.cardiovasc_death_rate, tt.diabetes_prevalence, tt.female_smokers, tt.male_smokers, convert(date, tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;

select * from DatosCasosEspeciales;

--DATOSHOSPITAL
insert into DatosHospital
select distinct tt.hosp_patients, tt.hosp_patients_per_million, tt.weekly_hosp_admissions, tt.weekly_hosp_admissions_per_million,
tt.icu_patients, tt.icu_patients_per_million, tt.weekly_hosp_admissions_per_million, tt.weekly_icu_admissions, tt.hospital_beds_per_thousand, convert(date, tt.dates), P.id_Pais
from TablaTemp as tt, Pais as P
where P.locations=tt.locations;

--REGISTRO-----------------
insert into Registro
select  distinct P.id_Pais, tt.dates
from TablaTemp as tt, Pais as p, Continente as C
where  P.locations=tt.locations
and C.continent=tt.continent
and C.iso_code=tt.iso_code
order by P.id_Pais asc;