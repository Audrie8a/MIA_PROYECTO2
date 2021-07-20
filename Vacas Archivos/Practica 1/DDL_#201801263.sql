use Practica1_201801263;
alter table Pais drop constraint  fk_Continente_Pais;
alter table DatosHospital drop constraint fk_Pais_DatosHospital
alter table DatosCasosEspeciales drop constraint fk_Pais_DatosCasosEspeciales
alter table Rates drop constraint  fk_Pais_Rates
alter table DatosTest drop constraint fk_Pais_DatosTest
alter table DatosPais drop constraint  fk_Pais_DatosPais;
--alter table Registro drop constraint  fk_Pais_Registro;
alter table Muertes drop constraint  fk_Pais_Muertes;
alter table DatosVacuna drop constraint fk_Pais_DatosVacuna;
alter table Casos drop constraint fk_Pais_Casos;
drop table Casos;
drop table Continente;
drop table Pais;
drop table DatosPais;
--drop table Registro;
drop table Muertes;
drop table DatosVacuna;
drop table DatosTest;
drop table Rates;
drop table DatosCasosEspeciales;
drop table DatosHospital;


Create table Continente(
	id_Continente int identity(1,1),
	continent varchar(45) NULL,
	primary key (id_Continente)
);

Create table Pais(
	id_Pais int identity(1,1),
	iso_code varchar(45) NULL,
	locations varchar(45) NULL,
	id_Continente int not null,
	primary key (id_Pais)	
);
alter table Pais add constraint fk_Continente_Pais foreign key (id_Continente) references Continente (id_Continente);



Create table Muertes(
	id_Muertes int identity (1,1) ,
	total_deaths int null,
	new_deaths int  null,
	new_deaths_smoothed	float null,
	total_deaths_per_million float null,
	new_deaths_per_million float null,
	new_deaths_smoothed_per_million float null,
	id_Pais int not null,
	Fecha date null,
	primary key (id_Muertes)
);
alter table Muertes add constraint fk_Pais_Muertes foreign key (id_Pais) references Pais(id_Pais);

Create table Casos(
	id_Casos int identity (1,1),
	total_cases int null,
	new_cases int null, 
	new_cases_smoothed float,
	total_cases_per_million	float,
	new_cases_per_million float,
	new_cases_smoothed_per_million float,
	Fecha date null,
	id_Pais int not null,
	primary key (id_Casos)
);
alter table Casos add constraint fk_Pais_Casos foreign key (id_Pais) references Pais(id_Pais);


Create table DatosVacuna(
	id_DatosVacuna int identity (1,1),
	total_vaccinations int null,
	people_vaccinated int null,
	people_fully_vaccinated int null,
	new_vaccinations int null,
	new_vaccinations_smoothed float,
	total_vaccinations_per_hundred float,
	people_vaccinated_per_hundred float,
	people_fully_vaccinated_per_hundred	float,
	new_vaccinations_smoothed_per_million float,
	Fecha date null,
	id_Pais int not null,
	primary key (id_DatosVacuna)
);
alter table DatosVacuna add constraint fk_Pais_DatosVacuna foreign key (id_Pais) references Pais(id_Pais);

Create table DatosPais(
	id_DatosPais int identity(1,1),
	populations int null,
	population_density float null,
	extreme_poverty float null,
	life_expectancy float null,
	gdp_per_capita float null,
	human_development_index float null,
	median_age float null,
	aged_65_older float null,
	aged_70_older float null,
	--stringency_index float null,
	handwashing_facilities float null,
	id_Pais int not null,	
	anio varchar(45) null,
	primary key (id_DatosPais)
);
alter table DatosPais add constraint fk_Pais_DatosPais foreign key (id_Pais) references Pais(id_Pais);


Create table DatosTest(
	id_DatosTest int identity (1,1),
	new_test int null,
	total_test int null,
	total_tests_per_thousand float null,
	new_tests_per_thousand float null,
	new_tests_smoothed float null,
	new_tests_smoothed_per_thousand	float null,
	tests_units varchar(45) null,
	Fecha date null,
	id_Pais int not null,
	primary key (id_DatosTest)
);
alter table DatosTest add constraint fk_Pais_DatosTest foreign key (id_Pais) references Pais(id_Pais);


Create table Rates(
	id_Rates int identity (1,1),
	reproduction_rate float null,
	positive_rate float null,
	test_per_case float null,
	excess_mortality float null,
	stringency_index float null,
	Fecha date null,
	id_Pais int not null,
	primary key (id_Rates)
);
alter table Rates add constraint fk_Pais_Rates foreign key (id_Pais) references Pais(id_Pais);


Create table DatosCasosEspeciales(
	id_DCE int identity (1,1),
	cardiovas_death_rate float null,
	diabetes_prevalence float null,
	female_smokers float null,
	male_smokers float null,
	Fecha date null,
	id_Pais int not null,
	primary key (id_DCE)
);
alter table DatosCasosEspeciales add constraint fk_Pais_DatosCasosEspeciales foreign key (id_Pais) references Pais(id_Pais);


Create table DatosHospital(
	id_DatosHospital int identity (1,1),
	hosp_patientes int null,
	hosp_patientes_per_million float null,
	weekly_hosp_admissions float null,
	weekly_hosp_admissions_per_million float null,
	icu_patients int,
	icu_patientes_per_million float null,
	weeckly_icu_admissions_per_million float null,
	weeckly_icu_admissions float null,
	hospital_beds_per_thousand float null,
	Fecha date null,
	id_Pais int not null,
	primary key(id_DatosHospital)
);

alter table DatosHospital add constraint fk_Pais_DatosHospital foreign key (id_Pais) references Pais(id_Pais);

