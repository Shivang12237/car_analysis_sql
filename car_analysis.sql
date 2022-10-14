
use CarsDB

select * from cclass
select * from audi
select * from hyndai
select * from merc
select * from models
select * from transmission
select * from fueltype
select * from bmw

---AUDI Table---
select * from audi
inner join models on audi.model_ID = models.model_ID
---BMW Table---
select * from bmw
inner join models on bmw.model_ID = models.model_ID
---Cclass Table---
select * from cclass
inner join models on cclass.model_ID = models.model_ID
---Hyundai Table---
select * from hyndai
inner join models on hyndai.model_ID = models.model_ID
---Mercedes Table---
select * from merc
inner join models on merc.model_ID = models.model_ID

---Adding BrandId---
ALTER TABLE audi
ADD Brand_ID int NOT NULL
DEFAULT 1
WITH VALUES;

ALTER TABLE bmw
ADD Brand_ID int NOT NULL
DEFAULT 2 
WITH VALUES;

ALTER TABLE cclass
ADD Brand_ID int NOT NULL
DEFAULT 3 
WITH VALUES;

ALTER TABLE hyndai
ADD Brand_ID int NOT NULL
DEFAULT 4 
WITH VALUES;

ALTER TABLE merc
ADD Brand_ID int NOT NULL
DEFAULT 5 
WITH VALUES;



---Creating a View---
create view all_brands_information as
(select 'Audi' as brand_name, * from audi
union
select 'BMW' as brand_name, * from bmw
union
select 'CClass' as brand_name, * from cclass
union
select 'Hyundai'as brand_name, * from hyndai
union
select 'Mercedes'as brand_name, * from merc)

---Brands Table---
create table Brands
(ID int , Name varchar(20))

insert into Brands values(1, 'Audi')
insert into Brands values(2, 'BMW')
insert into Brands values(3, 'Mercedes')
insert into Brands values(4, 'Hyundai')
insert into Brands values(5, 'Cclass')

select * from Brands

ALTER TABLE Brands
drop column tax

ALTER TABLE Brands
drop column mpg

---Counting No of cars of each brand---

select count(*) as no_of_audi_cars_sold from audi
select count(*) as no_of_bmw_cars_sold from bmw
select count(*) as no_of_cclass_cars_sold from cclass
select count(*) as no_of_hyundai_cars_sold from hyndai
select count(*) as no_of_mercedes_cars_sold from merc

select * from all_brands_information

---Sales data Model wise---
select model_ID, count(*) as No_of_car_sold from all_brands_information
group by model_ID

---Sales data of Transmission used in cars---
select transmission_ID, count(*) as No_of_car_sold from all_brands_information
group by transmission_ID

---Sales data of Fuel used in cars---
select fuel_ID, count(*) as No_of_car_sold from all_brands_information
group by fuel_ID

---Volume of cars sold over the years---
select YEAR, count(*) as No_of_cars_sold from all_brands_information
group by year order by year

select brand_name, count(*) as No_of_car_sold from all_brands_information
group by brand_name

select count(*) as total_cars_sold from all_brands_information

select max(price) as maximum_price from all_brands_information
select min(price) as minimum_price from all_brands_information
select avg(price) as average_price from all_brands_information


select max(price) as maximum_price, 
min(price) as minimum_price,
avg(price) as average_price from all_brands_information


select brand_name, min(year) as from_, max(year) as to_, sum(price) as total_amt
from all_brands_information
group by brand_name, floor( year / 6 )
order by brand_name

select * from all_brands_information


select case when price <= 10000 then 'LIG'
			when price > 10000 and price <=20000 then 'MIG'
			when price > 20000 and price <=30000 then 'HIG'
			when price > 30000 then 'Rich'
		end income_group, count(*) as Total_Count
from all_brands_information
group by case when price <= 10000 then 'LIG'
			when price > 10000 and price <=20000 then 'MIG'
			when price > 20000 and price <=30000 then 'HIG'
			when price > 30000 then 'Rich'
		end


select case when price <= 10000 then 'Mini Compact'
			when price > 10000 and price <=20000 then 'Sub-Compact'
			when price > 20000 and price <=40000 then 'Compact'
			when price > 40000 and price <=650000 then 'Mid-Size'
			when price > 65000 and price <=100000 then 'Full-Size'
			when price > 100000 then 'Full-Luxury'
		end categories, year, count(*) as Total_Count
from all_brands_information
group by case when price <= 10000 then 'Mini Compact'
			when price > 10000 and price <=20000 then 'Sub-Compact'
			when price > 20000 and price <=40000 then 'Compact'
			when price > 40000 and price <=650000 then 'Mid-Size'
			when price > 65000 and price <=100000 then 'Full-Size'
			when price > 100000 then 'Full-Luxury'
		end, year;

select case when price <= 10000 then 'Mini Compact'
			when price > 10000 and price <=20000 then 'Sub-Compact'
			when price > 20000 and price <=40000 then 'Compact'
			when price > 40000 and price <=650000 then 'Mid-Size'
			when price > 65000 and price <=100000 then 'Full-Size'
			when price > 100000 then 'Full-Luxury'
		end categories, AVG(mpg) as Fuel_efficiency
from all_brands_information
group by case when price <= 10000 then 'Mini Compact'
			when price > 10000 and price <=20000 then 'Sub-Compact'
			when price > 20000 and price <=40000 then 'Compact'
			when price > 40000 and price <=650000 then 'Mid-Size'
			when price > 65000 and price <=100000 then 'Full-Size'
			when price > 100000 then 'Full-Luxury'
		end;

select case when price <= 10000 then 'Mini Compact'
			when price > 10000 and price <=20000 then 'Sub-Compact'
			when price > 20000 and price <=40000 then 'Compact'
			when price > 40000 and price <=650000 then 'Mid-Size'
			when price > 65000 and price <=100000 then 'Full-Size'
			when price > 100000 then 'Full-Luxury'
		end categories,  (LAST_VALUE(price) OVER (PARTITION BY year ORDER BY year) - 
		 FIRST_VALUE(price) OVER (PARTITION BY year ORDER BY year))
from all_brands_information
group by case when price <= 10000 then 'Mini Compact'
			when price > 10000 and price <=20000 then 'Sub-Compact'
			when price > 20000 and price <=40000 then 'Compact'
			when price > 40000 and price <=650000 then 'Mid-Size'
			when price > 65000 and price <=100000 then 'Full-Size'
			when price > 100000 then 'Full-Luxury'
		end, year, price;

SELECT ABI.brand_name, Mo.model_name, ABI.year, ABI.price, ABI.mileage, ABI.tax, ABI.mpg, ABI.engineSize, T.transmission, F.fueltype, Fp.column2 as fuelprice,
case when ABI.price <= 10000 then 'Mini Compact'
			when ABI.price > 10000 and ABI.price <=20000 then 'Sub-Compact'
			when ABI.price > 20000 and ABI.price <=40000 then 'Compact'
			when ABI.price > 40000 and ABI.price <=650000 then 'Mid-Size'
			when ABI.price > 65000 and ABI.price <=100000 then 'Full-Size'
			when ABI.price > 100000 then 'Full-Luxury'
		end AS category,
case when price <= 10000 then 'LIG'
			when price > 10000 and price <=20000 then 'MIG'
			when price > 20000 and price <=30000 then 'HIG'
			when price > 30000 then 'Rich'
		end income_group
INTO Brandstable 
FROM all_brands_information ABI 
LEFT JOIN models Mo ON ABI.model_ID = Mo.model_ID
LEFT JOIN transmission T ON ABI.transmission_ID = T.ID
LEFT JOIN fueltype F ON ABI.fuel_ID = F.fuel_ID
LEFT JOIN fuelprice Fp ON ABI.year = Fp.column1;

SELECT * FROM Brandstable;
---Category wise price change---
SELECT category, MAX(price) - MIN(price) AS price_change FROM Brandstable
GROUP BY category;

SELECT category, AVG(mpg) AS avgfuelefficiency, MAX(transmission) AS transmission, MAX(fueltype) AS fueltype  
FROM Brandstable
GROUP BY category;
select
    CONCAT(bucket_floor, '-', bucket_ceiling) as fuelspending,
    count(*) as sale
from (
	select 
		floor(FUELSPEND/10000.00)*10000 as bucket_floor,
		floor(FUELSPEND/10000.00)*10000 + 10000 as bucket_ceiling
	from fueltbl
) a
group by bucket_floor, bucket_ceiling
order by bucket_floor;

SELECT * INTO fueltbl FROM
(SELECT ((mileage/mpg)*fuelprice) AS FUELSPEND FROM Brandstable
WHERE mpg != 0) AS FLTBL;

SELECT * FROM fueltbl;

SELECT category, (MAX(sale) - MIN(sale)) AS sale_incr
FROM (SELECT  category, year, COUNT(*) AS sale FROM Brandstable GROUP BY  category, year ) B
GROUP BY category ;

SELECT transmission , COUNT(*) AS Sale 
FROM Brandstable
GROUP BY transmission;

  






