use Practica1;
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
	new_deaths_smoothed	varchar(45) null,
	total_deaths_per_million varchar(45) null,
	new_deaths_per_million varchar(45) null,
	new_deaths_smoothed_per_million varchar(45) null,
	id_Pais int not null,
	Fecha date null,
	primary key (id_Muertes)
);
alter table Muertes add constraint fk_Pais_Muertes foreign key (id_Pais) references Pais(id_Pais);

Create table Casos(
	id_Casos int identity (1,1),
	total_cases int null,
	new_cases int null, 
	new_cases_smoothed varchar(45),
	total_cases_per_million	varchar(45),
	new_cases_per_million varchar(45),
	new_cases_smoothed_per_million varchar(45),
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
	new_vaccinations_smoothed varchar(45),
	total_vaccinations_per_hundred varchar(45),
	people_vaccinated_per_hundred varchar(45),
	people_fully_vaccinated_per_hundred	varchar(45),
	new_vaccinations_smoothed_per_million varchar(45),
	Fecha date null,
	id_Pais int not null,
	primary key (id_DatosVacuna)
);
alter table DatosVacuna add constraint fk_Pais_DatosVacuna foreign key (id_Pais) references Pais(id_Pais);

Create table DatosPais(
	id_DatosPais int identity(1,1),
	populations int null,
	population_density varchar(45) null,
	extreme_poverty varchar(45) null,
	life_expectancy varchar(45) null,
	gdp_per_capita varchar(45) null,
	human_development_index varchar(45) null,
	median_age varchar(45) null,
	aged_65_older varchar(45) null,
	aged_70_older varchar(45) null,
	--stringency_index varchar(45) null,
	handwashing_facilities varchar(45) null,
	id_Pais int not null,	
	anio varchar(45) null,
	primary key (id_DatosPais)
);
alter table DatosPais add constraint fk_Pais_DatosPais foreign key (id_Pais) references Pais(id_Pais);


Create table DatosTest(
	id_DatosTest int identity (1,1),
	new_test int null,
	total_test int null,
	total_tests_per_thousand varchar(45) null,
	new_tests_per_thousand varchar(45) null,
	new_tests_smoothed varchar(45) null,
	new_tests_smoothed_per_thousand	varchar(45) null,
	tests_units varchar(45) null,
	Fecha date null,
	id_Pais int not null,
	primary key (id_DatosTest)
);
alter table DatosTest add constraint fk_Pais_DatosTest foreign key (id_Pais) references Pais(id_Pais);


Create table Rates(
	id_Rates int identity (1,1),
	reproduction_rate varchar(45) null,
	positive_rate varchar(45) null,
	test_per_case varchar(45) null,
	excess_mortality varchar(45) null,
	stringency_index varchar(45) null,
	Fecha date null,
	id_Pais int not null,
	primary key (id_Rates)
);
alter table Rates add constraint fk_Pais_Rates foreign key (id_Pais) references Pais(id_Pais);


Create table DatosCasosEspeciales(
	id_DCE int identity (1,1),
	cardiovas_death_rate varchar(45) null,
	diabetes_prevalence varchar(45) null,
	female_smokers varchar(45) null,
	male_smokers varchar(45) null,
	Fecha date null,
	id_Pais int not null,
	primary key (id_DCE)
);
alter table DatosCasosEspeciales add constraint fk_Pais_DatosCasosEspeciales foreign key (id_Pais) references Pais(id_Pais);


Create table DatosHospital(
	id_DatosHospital int identity (1,1),
	hosp_patientes int null,
	hosp_patientes_per_million varchar(45) null,
	weekly_hosp_admissions varchar(45) null,
	weekly_hosp_admissions_per_million varchar(45) null,
	icu_patients int,
	icu_patientes_per_million varchar(45) null,
	weeckly_icu_admissions_per_million varchar(45) null,
	weeckly_icu_admissions varchar(45) null,
	hospital_beds_per_thousand varchar(45) null,
	Fecha date null,
	id_Pais int not null,
	primary key(id_DatosHospital)
);

alter table DatosHospital add constraint fk_Pais_DatosHospital foreign key (id_Pais) references Pais(id_Pais);


Create table Registro(
	id_Registro int identity(1,1),
	id_Pais int not null,
	Fecha date,
	primary key(id_Registro)
);
alter table Registro add constraint fk_Pais_Registro foreign key (id_Pais) references Pais(id_Pais);
