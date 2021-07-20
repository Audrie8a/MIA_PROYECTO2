create database Practica1_201801263;
use Practica1_201801263;

create table #TablaTemp(
	id int identity(1,1),
	iso_code varchar(45) NULL,
	continent varchar(45)NULL,
	location varchar(45) NULL,
	date varchar(45) NULL,
	total_cases varchar(45) NULL,
	new_cases varchar(45) NULL,
	new_cases_smoothed varchar(45) NULL,
	total_deaths varchar(45) NULL,
	new_deaths varchar(45) NULL,
	new_deaths_smoothed varchar(45) NULL,
	total_cases_per_million varchar(45) NULL,
	new_cases_per_million varchar(45) NULL,
	new_cases_smoothed_per_million varchar(45) NULL,
	total_deaths_per_million varchar(45) NULL,
	new_deaths_per_million varchar(45) NULL,
	new_deaths_smoothed_per_million varchar(45) NULL,
	reproduction_rate varchar(45) NULL,
	icu_patients varchar(45) NULL,
	icu_patients_per_million varchar(45) NULL,
	hosp_patients varchar(45) NULL,
	hosp_patients_per_million varchar(45) NULL,
	weekly_icu_admissions varchar(45) NULL,
	weekly_icu_admissions_per_million varchar(45) NULL,
	weekly_hosp_admissions varchar(45) NULL,
	weekly_hosp_admissions_per_million varchar(45) NULL,
	new_tests varchar(45) NULL,
	total_tests varchar(45) NULL,
	total_tests_per_thousand varchar(45) NULL,
	new_tests_per_thousand varchar(45) NULL,
	new_tests_smoothed varchar(45) NULL,
	new_tests_smoothed_per_thousand varchar(45) NULL,
	positive_rate varchar(45) NULL,
	tests_per_case varchar(45) NULL,
	tests_units varchar(45) NULL,
	total_vaccinations varchar(45) NULL,
	people_vaccinated varchar(45) NULL,
	people_fully_vaccinated varchar(45) NULL,
	new_vaccinations varchar(45) NULL,
	new_vaccinations_smoothed varchar(45) NULL,
	total_vaccinations_per_hundred varchar(45) NULL,
	people_vaccinated_per_hundred varchar(45) NULL,
	people_fully_vaccinated_per_hundred varchar(45) NULL,
	new_vaccinations_smoothed_per_million varchar(45) NULL,
	stringency_index varchar(45) NULL,
	population varchar(45) NULL,
	population_density varchar(45) NULL,
	median_age varchar(45) NULL,
	aged_65_older varchar(45) NULL,
	aged_70_older varchar(45) NULL,
	gdp_per_capita varchar(45) NULL,
	extreme_poverty varchar(45) NULL,
	cardiovasc_death_rate varchar(45) NULL,
	diabetes_prevalence varchar(45) NULL,
	female_smokers varchar(45) NULL,
	male_smokers varchar(45) NULL,
	handwashing_facilities varchar(45) NULL,
	hospital_beds_per_thousand varchar(45) NULL,
	life_expectancy varchar(45) NULL,
	human_development_index varchar(45) NULL,
	excess_mortality varchar(45) NULL
);

BULK INSERT #TablaTemp
FROM '?D:\Practica1.csv'
   WITH 
      (
         FIELDTERMINATOR =',',
         ROWTERMINATOR ='\n',
		 FIRSTROW = 2
 );

 SELECT * FROM #TablaTemp
 
 DROP TABLE #TablaTemp

 INSERT INTO Cliente (RUT,Nombre,Apellido,Direccion)
 SELECT DISTINCT rut_cliente,nombre_cliente,apellido_cliente,direccion_cliente