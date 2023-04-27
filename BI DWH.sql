drop table DWH_F_summary1
drop table DWH_F_Summary2
drop table DWH_F_Searches
drop table DWH_F_Orders
drop table DWH_D_Taskers
drop table DWH_D_TaskersType2
drop table DWH_D_Areas
drop table DWH_D_Customers
drop table DWH_D_Dates

drop procedure updateOldVersions

create procedure updateOldVersions as begin
update DWH_D_TaskersType2 
set [Valid until] = getdate() 
where DWTasker in (select DWTasker from Old_Versions)
truncate table Old_Versions
end

exec updateOldVersions

create table DWH_D_Customers (
DWCustomer int primary key not null,
customer varchar(50) not null,
[Private name] varchar(20) not null,
[last name] varchar(20) not null,
area varchar(50) not null,
[get ads] bit not null,
[Gender] char not null,
);

create table DWH_F_Searches (
DW_Search int primary key not null,
[Search date] date not null,
[service length] int NOT NULL ,
Customer varchar(50) not null,
Tasker int not null,
[service location] varchar(50) not null,
[leads to order] bit not null,
);

create table DWH_F_Orders (
[order id] int primary key not null,
[order date] date not null,
[service date] date not null,
method varchar(25) not null,
[skill score] int not null,
[tasker score] int not null,
[total price] money not null,
[service length] int not null,
customer varchar(50) not null,
tasker int not null,
area varchar(50) not null,
);


create table DWH_D_Taskers(
DWTasker int primary key not null,
Tasker varchar(50) not null,
[Private name] varchar(20) not null,
[last name] varchar(20) not null,
area varchar(50) not null,
[get ads] bit not null,
skill varchar(50) not null,
[hourly price] money not null,
tool varchar(20) null,
[vehicle type] varchar(30) null,
);

create table DWH_D_TaskersType2(
DWTasker int identity(1,1) primary key not null,
Tasker varchar(50) not null,
[Private name] varchar(20) not null,
[last name] varchar(20) not null,
area varchar(50) not null,
[get ads] bit not null,
skill varchar(50) not null,
[hourly price] money not null,
tool varchar(20) null,
[vehicle type] varchar(30) null,
[Valid from] date not null,
[Valid until] date null,
);

create table DWH_D_Areas(
DW_Area						int identity(1,1) primary key not null,
Area						Varchar(50) not null,
County						Varchar(30) not null,
[Year]						int not null,
[Average Income]			money not null,
[Number of inhabitants]		int not null,
[Age under 14]				real not null,
[Age between 15 and 24]		real not null,
[Age between 25 and 54]		real not null,
[Age between 55 and 65]		real not null,
[Age over 65]				real not null,
[Average Apartment size]	real not null,
[Female percentage]			real not null,
);

create table DWH_F_summary1(
Area Varchar(50) not null,
[Year] int not null,
County Varchar(30) not null,
[Number of customers] int not null,
[Number of taskers] int not null,
[Total income] money not null,
constraint FK_sm1 primary key (Area,[Year]),
);

create table DWH_F_Summary2(
Tasker varchar(50) not null,
[Year] int not null,
[Avg grade] real not null,
[Avg income] money not null,
[Number of orders] int not null,
constraint FK_sm2 primary key (Tasker, [Year]),
);

create table DWH_D_Dates
(
	TheDate date,
	TheDay int,
	TheDayName varchar(20),
	TheDayOfWeek int,
	IsWeekend int,
	TheWeek int,
	TheWeekOfMonth int,
	TheMonth int,
	TheMonthName varchar(20),
	TheQuarter int,
	TheFirstOfQuarter date,
	TheLastOfQuarter date,
	TheYear int,
	IsLeapYear int
	)


DECLARE @StartDate  date = '20180101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));
;WITH seq(n) AS
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
),

dim AS
(
  SELECT
    TheDate,
    TheDay,
    TheDayName,
    TheDayOfWeek,
    IsWeekend           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7)
                            THEN 1 ELSE 0 END,
    TheWeek,
    TheWeekOfMonth      = CONVERT(tinyint, DENSE_RANK() OVER
                            (PARTITION BY TheYear, TheMonth ORDER BY TheWeek)),
    TheMonth,
    TheMonthName,
    TheQuarter,
    TheFirstOfQuarter   = MIN(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheLastOfQuarter    = MAX(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheYear,
    IsLeapYear          = CONVERT(bit, CASE WHEN (TheYear % 400 = 0)
                            OR (TheYear % 4 = 0 AND TheYear % 100 <> 0)
                            THEN 1 ELSE 0 END)
  FROM src
)
insert into DWH_D_Dates
SELECT * FROM dim
  ORDER BY TheDate

OPTION (MAXRECURSION 0);


