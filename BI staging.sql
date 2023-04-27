drop table STG_F_Searches
drop table STG_F_Orders
drop table STG_D_Taskers
drop table STG_D_Customers

create table STG_D_Customers (
DWCustomer int identity(1,1) primary key not null,
customer varchar(50) not null,
[Private name] varchar(20) not null,
[last name] varchar(20) not null,
area varchar(50) not null,
[get ads] bit not null,
[Gender] char not null,
);

create table STG_F_Searches (
DW_Search int identity(1,1) primary key not null,
[Search date] date not null,
[service length] int NOT NULL ,
Customer varchar(50) not null,
Tasker varchar(50) not null,
[service location] varchar(50) not null,
[leads to order] bit not null,
);

create table STG_F_Orders (
[order id] int primary key not null,
[order date] date not null,
[service date] date not null,
method varchar(25) not null,
[skill score] int not null,
[tasker score] int not null,
[total price] money not null,
[service length] int not null,
customer varchar(50) not null,
tasker varchar(50) not null,
area varchar(50) not null,
);

create table STG_D_Taskers(
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
);



