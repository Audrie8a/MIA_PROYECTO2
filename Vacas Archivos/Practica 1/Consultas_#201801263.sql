use Practica1_201801263;


-----------------------------------------CONSULTA 1------. Mostrar cada país con su total de casos


--Resultado Consulta 1 Tabla Temp
select Sum(Cast(tt.new_cases as bigint)) as TotalCasos,tt.locations
from TablaTemp as tt
where tt.new_cases is not null
group by tt.locations
order by tt.locations asc;

--Resultado Consulta ER
select isnull(Sum(C.new_cases),0) as TotalCasos, P.locations
from Pais as P, Casos as C
Where P.id_Pais= C.id_Pais
--and C.Fecha<'2021-06-14'
group by P.locations
order by P.locations asc;

-----------------------------------------CONSULTA 2------. Mostrar cada mes con su cantidad de: contagios, muertes, vacunados para el país de Guatemala



--Consulta con TablaTemp
select MONTH(tt.dates), sum(Cast(tt.new_cases as int)) as TotalContagios, sum(Cast(tt.new_deaths as int )) as TotalMuertes, sum(Cast(tt.new_vaccinations as int)) as TotalVacuanados
from TablaTemp as tt
where tt.locations='Guatemala'
group by MONTH(tt.dates);


--Consulta con ER
select MONTH(C.Fecha) as Mes, Sum(C.new_cases) as TotalCasos,Sum(M.new_deaths) as TotalMuertes,isnull( Sum(DV.new_vaccinations),0) as TotalVacunados
from Pais as P, Muertes as M, DatosVacuna as DV, Casos as C
where P.id_Pais=M.id_Pais
and P.id_Pais=DV.id_Pais
and P.id_Pais=C.id_Pais
and M.Fecha=DV.Fecha
and M.Fecha=C.Fecha
and DV.Fecha=C.Fecha
and P.locations='Guatemala'
and YEAR(M.Fecha)='2021'
group by MONTH(M.Fecha), MONTH(DV.Fecha), MONTH(C.Fecha)
order by MONTH(M.Fecha), MONTH(DV.Fecha), MONTH(C.Fecha);



--------------------------------------CONSULTA 3-------. Mostrar por Continente la cantidad total de casos.

--Consulta tabla temp
select tt.continent, sum(cast(tt.new_cases as int))
from TablaTemp as tt
group by tt.continent
order by tt.continent asc;

--Consulta con ER ----------
select C.continent, sum(CA.new_cases)
from Continente as C, Pais as P, Casos as CA
where C.id_Continente=P.id_Continente
and P.id_Pais=CA.id_Pais
--and CA.Fecha<'2021-06-14'
group by C.continent
order by C.continent asc;

--------------------------------CONSULTA 4-----------.Mostrar el promedio de contagios por pais.

--Consulta usando Tabla Temp
select MONTH(convert(date,tt.dates)),tt.locations, AVG(cast(tt.new_cases as decimal(10,3))) as PromedioContagios
from TablaTemp as tt
group by tt.locations, MONTH(convert(date,tt.dates))
order by MONTH(convert(date,tt.dates)), tt.locations asc;


--Consulta ER----------
select MONTH(C.Fecha) as Mes,P.locations, isnull(AVG(cast(C.new_cases as decimal(10,3))),0) as PromedioContagios
from Pais as P, Casos as C
where P.id_Pais=C.id_Pais
and YEAR(C.Fecha)='2021'
--and C.Fecha<'2021-06-14'
group by P.locations, MONTH(C.Fecha)
order by MONTH(C.Fecha), P.locations asc;

------------------------------CONSULTA 5------------. Top 10 de países que han realizados mas pruebas

--Consulta usando Tabla Temp
select top 10  tt.locations, sum(cast(tt.total_tests as bigint)) as TotalPruebas
from TablaTemp as tt
group by tt.locations
order by TotalPruebas desc;


--Consulta ER
select top 10 P.locations,MAX(DT.total_test) as TotalPruebas
from Pais as P, DatosTest as DT
where P.id_Pais=DT.id_Pais
--and DT.Fecha<'2021-06-14'
group by P.locations
order by TotalPruebas desc;

------------------------CONSULTA 6----------Top 10 de países que han tenido la mayor cantidad de personas vacunada

--Consulta TablaTemp 
select  top 10 tt.locations, MAX(tt.total_vaccinations) as PersonasVacunadas
from TablaTemp as tt
group by tt.locations
order by PersonasVacunadas desc;


--consulta ER
select top 10 P.locations, MAX(DV.people_vaccinated) as PersonasVacunadas
from Pais as P, DatosVacuna as DV
where P.id_Pais=DV.id_Pais
--and DV.Fecha<'2021-06-14'
group by P.locations
order by PersonasVacunadas desc;

----------------------CONSULTA 7-----------. Top 10 de países con mas contagios

--Consulta ER
select top 10 P.locations, MAX(C.total_cases) as TotalCasos
from Pais as P, Casos as C
where P.id_Pais=C.id_Pais
--and C.Fecha<'2021-06-14'
group by P.locations
order by TotalCasos desc;


---------------------CONSULTA 8 -----------
--Crear un procedure que permita obtener los países tuvieron mas de m cantidad
--de contagios y menos de n cantidad de contagios (n y m son números enteros
--y se indicaran el día de la calificación)

drop procedure ConsultaOcho;

Create Procedure ConsultaOcho (@m int, @n int)
as
begin
set nocount on
	select P.locations, Sum(C.new_cases) as TotalContagios
	from Pais as P,Casos as C
	where P.id_Pais=C.id_Pais
	--and C.Fecha<'2021-06-14'
	group by P.locations
	having Sum(C.new_cases)>@m
	and Sum(C.new_cases)<@n
	order by P.locations;
end
 
 exec ConsultaOcho 100000,150000


--------------CONSULTA 9 -------------
-- Mostrar nuevos casos, nuevas vacunas,nuevas muertes, 
--(no tienen que mostrar individualmente por cada fecha, tienen que mostrar la sumatoria)
--en el país de Guatemala de la fecha de 01/01/2021 hasta el 12/06/2021.

select P.locations, Sum(C.new_cases) as NuevosCasos, Sum(DV.new_vaccinations) as NuevasVacunas, Sum(M.new_deaths) as NuevasMuertes
from Pais as P, Casos as C, DatosVacuna as DV, Muertes as M
where P.id_Pais=C.id_Pais
and P.id_Pais=DV.id_Pais
and P.id_Pais=M.id_Pais
and C.Fecha=DV.Fecha
and C.Fecha= M.Fecha
and M.Fecha=DV.Fecha
and P.locations='Guatemala'
and C.Fecha>'2020-12-31'
and C.Fecha<'2021-06-13'
Group by P.locations;
;


----------------CONSULTA 10 ----------
--Consulta que muestre los países latinoamericanos ordenados de los que tienen
--mas casos de contagio a los que tienen menos casos de contagio de la fecha de
--01/01/2021 hasta el 12/06/2021.

select P.locations, sum(C.new_cases) as TotalCasos
from Pais as P, Casos as C
where P.id_Pais=C.id_Pais
and P.locations in ('Argentina', 'Bolivia', 'Brazil','Chile', 'Colombia', 'Costa Rica', 'Cuba', 'Ecuador', 'El Salvador', 'Guayana', 'Grenada', 'Guatemala', 'Haiti', 'Honduras','Jamaica',
'Mexico','Nicaragua', 'Paraguay', 'Panama', 'Peru', 'Puerto Rico', 'Dominican Republic', 'Suriname', 'Uruguay', 'Venezuela')
and C.Fecha>'2020-12-31'
and C.Fecha<'2021-06-13'
group by P.locations
order by TotalCasos desc;

