create database Practica1;
use Practica1;
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


 SELECT * FROM TablaTemp;
 
 --DROP TABLE TablaTemp;

 select distinct dates, continent, locations, total_cases from TablaTemp where locations='Guatemala' order by dates asc;
select  distinct iso_code from TablaTemp;
 select distinct iso_code,continent,locations  from TablaTemp order by locations asc;
 select distinct locations  from TablaTemp;
 select distinct dates  from TablaTemp order by dates asc;
 select distinct total_cases  from TablaTemp;
 select distinct new_cases  from TablaTemp;
 select distinct new_cases_smoothed  from TablaTemp;
 select distinct total_deaths  from TablaTemp;
 select distinct total_cases  from TablaTemp;
 select distinct new_deaths  from TablaTemp;
 select distinct new_deaths_smoothed  from TablaTemp;
 select distinct total_cases_per_million  from TablaTemp;
 select distinct new_cases_per_million  from TablaTemp;
 select distinct new_cases_smoothed_per_million  from TablaTemp;
 select distinct total_deaths_per_million  from TablaTemp;
 select distinct new_deaths_per_million  from TablaTemp;
 select distinct new_deaths_smoothed_per_million  from TablaTemp;
 select distinct reproduction_rate  from TablaTemp order by reproduction_rate asc;
 select distinct icu_patients  from TablaTemp;
 select distinct icu_patients_per_million  from TablaTemp;
 select distinct hosp_patients  from TablaTemp;
 select distinct hosp_patients_per_million  from TablaTemp;
 select distinct weekly_icu_admissions  from TablaTemp;
 select distinct weekly_icu_admissions_per_million  from TablaTemp;
 select distinct weekly_hosp_admissions  from TablaTemp;
 select distinct weekly_hosp_admissions_per_million  from TablaTemp;
 select distinct new_tests  from TablaTemp;
 select distinct total_tests  from TablaTemp;
 select distinct total_tests_per_thousand  from TablaTemp;
 select distinct new_tests_per_thousand  from TablaTemp;
 select distinct new_tests_smoothed  from TablaTemp;
 select distinct new_tests_smoothed_per_thousand  from TablaTemp;
 select distinct positive_rate  from TablaTemp;
 select distinct tests_per_case  from TablaTemp;
 select distinct total_vaccinations  from TablaTemp;
 select distinct people_vaccinated  from TablaTemp;
 select distinct people_fully_vaccinated  from TablaTemp;
 select distinct new_vaccinations  from TablaTemp;
 select distinct new_vaccinations_smoothed  from TablaTemp;
 select distinct total_vaccinations_per_hundred  from TablaTemp;
 select distinct people_vaccinated_per_hundred  from TablaTemp;
 select distinct people_fully_vaccinated_per_hundred  from TablaTemp;
 select distinct new_vaccinations_smoothed_per_million  from TablaTemp;
 select distinct stringency_index  from TablaTemp;
 select distinct populations  from TablaTemp;
 select distinct population_density  from TablaTemp;
 select distinct median_age  from TablaTemp;
 select distinct population_density  from TablaTemp;
 select distinct median_age  from TablaTemp;
 select distinct aged_65_older  from TablaTemp;
 select distinct aged_70_older  from TablaTemp;
 select distinct gdp_per_capita  from TablaTemp;
 select distinct extreme_poverty  from TablaTemp;
 select distinct cardiovasc_death_rate  from TablaTemp;
 select distinct diabetes_prevalence  from TablaTemp;
 select distinct female_smokers  from TablaTemp;
 select distinct male_smokers  from TablaTemp;
 select distinct handwashing_facilities  from TablaTemp;
 select distinct hospital_beds_per_thousand  from TablaTemp;
 select distinct life_expectancy  from TablaTemp;
 select distinct human_development_index  from TablaTemp;
 select distinct excess_mortality  from TablaTemp;

 select count( distinct iso_code) from TablaTemp;
 select count( distinct  continent  ) from TablaTemp;
 select count( distinct  locations  ) from TablaTemp;
 select count( distinct  dates  ) from TablaTemp;
 select count( distinct  total_cases  ) from TablaTemp;
 select count( distinct  new_cases  ) from TablaTemp;
 select count( distinct  new_cases_smoothed  ) from TablaTemp;
 select count( distinct  total_deaths  ) from TablaTemp;
 select count( distinct total_cases  ) from TablaTemp;
 select count( distinct  new_deaths  ) from TablaTemp;
 select count( distinct  new_deaths_smoothed  ) from TablaTemp;
 select count( distinct  total_cases_per_million  ) from TablaTemp;
 select count( distinct  new_cases_per_million  ) from TablaTemp;
 select count( distinct  new_cases_smoothed_per_million  ) from TablaTemp;
 select count( distinct  total_deaths_per_million  ) from TablaTemp;
 select count( distinct  new_deaths_per_million  ) from TablaTemp;
 select count( distinct  new_deaths_smoothed_per_million  ) from TablaTemp;
 select count( distinct  reproduction_rate  ) from TablaTemp;
 select count( distinct  icu_patients  ) from TablaTemp;
 select count( distinct  icu_patients_per_million  ) from TablaTemp;
 select count( distinct  hosp_patients  ) from TablaTemp;
 select count( distinct  hosp_patients_per_million  ) from TablaTemp;
 select count( distinct  weekly_icu_admissions  ) from TablaTemp;
 select count( distinct  weekly_icu_admissions_per_million  ) from TablaTemp;
 select count( distinct  weekly_hosp_admissions  ) from TablaTemp;
 select count( distinct  weekly_hosp_admissions_per_million  ) from TablaTemp;
 select count( distinct  new_tests  ) from TablaTemp;
 select count( distinct  total_tests  ) from TablaTemp;
 select count( distinct  total_tests_per_thousand  ) from TablaTemp;
 select count( distinct  new_tests_per_thousand  ) from TablaTemp;
 select count( distinct  new_tests_smoothed  ) from TablaTemp;
 select count( distinct  new_tests_smoothed_per_thousand  ) from TablaTemp;
 select count( distinct  positive_rate  ) from TablaTemp;
 select count( distinct  tests_per_case  ) from TablaTemp;
 select count( distinct  total_vaccinations  ) from TablaTemp;
 select count( distinct  people_vaccinated  ) from TablaTemp;
 select count( distinct  people_fully_vaccinated  ) from TablaTemp;
 select count( distinct  new_vaccinations  ) from TablaTemp;
 select count( distinct  new_vaccinations_smoothed  ) from TablaTemp;
 select count( distinct  total_vaccinations_per_hundred  ) from TablaTemp;
 select count( distinct  people_vaccinated_per_hundred  ) from TablaTemp;
 select count( distinct  people_fully_vaccinated_per_hundred  ) from TablaTemp;
 select count( distinct  new_vaccinations_smoothed_per_million  ) from TablaTemp;
 select count( distinct  stringency_index  ) from TablaTemp;
 select count( distinct  populations  ) from TablaTemp;
 select count( distinct  population_density  ) from TablaTemp;
 select count( distinct  median_age  ) from TablaTemp;
 select count( distinct  aged_65_older  ) from TablaTemp;
 select count( distinct  aged_70_older  ) from TablaTemp;
 select count( distinct  gdp_per_capita  ) from TablaTemp;
 select count( distinct  extreme_poverty  ) from TablaTemp;
 select count( distinct  cardiovasc_death_rate  ) from TablaTemp;
 select count( distinct  diabetes_prevalence  ) from TablaTemp;
 select count( distinct  female_smokers  ) from TablaTemp;
 select count( distinct  male_smokers  ) from TablaTemp;
 select count( distinct  handwashing_facilities  ) from TablaTemp;
 select count( distinct  hospital_beds_per_thousand  ) from TablaTemp;
 select count( distinct  life_expectancy  ) from TablaTemp;
 select count( distinct  human_development_index  ) from TablaTemp;
 select count( distinct  excess_mortality  ) from TablaTemp;

 drop table Prueba;
create table Prueba(
	valorInt int,
	valorVarchar45 varchar(45),
	valorVarchar varchar,
	valorDec3 decimal(10,3)
);

select TablaTemp.population_density from TablaTemp where id=1;
insert into Prueba values (79, '45.000', '3', 110.5);
insert into Prueba values (5, '3,20000000', '2', 1.5);
select * from Prueba;

select tt.aged_65_older from TablaTemp as tt;
select cast (tt.populations as int) from TablaTemp as tt;
select * from  DatosPais;

select distinct tt.populations,tt.population_density, tt.extreme_poverty, tt.life_expectancy, tt.gdp_per_capita, tt.human_development_index,
tt.median_age, tt.aged_65_older, tt.aged_70_older, tt.stringency_index, tt.handwashing_facilities, tt.locations, tt.continent, tt.iso_code
from TablaTemp as tt 
where tt.locations='Romania';


insert into PruebaDecimal (population_density) 
select population_density
from TablaTemp;

Create table PruebaDecimal(
	id_DatosPais int identity(1,1),
	population_density float null
);

drop table PruebaDecimal;