drop table Orders_MRR
drop table Searches_MRR
drop table Customers_MRR
drop table Taskers_MRR


CREATE	TABLE Customers_MRR (
Email                  Varchar (50) NOT NULL ,
[Private name]         Varchar (20) NOT NULL ,
[last name]            Varchar (20) NOT NULL ,
area                   Varchar(50) NOT NULL ,
[user password]        Varchar(20) NOT NULL ,
[get ads]              bit NOT NULL ,
[Gender]				char not null,
CONSTRAINT PKCustomers_MRR primary key (Email),
);

CREATE	TABLE Taskers_MRR (
Email                  Varchar (50) NOT NULL ,
[Private name]         Varchar (20) NOT NULL ,
[last name]            Varchar (20) NOT NULL ,
area                   Varchar(50) NOT NULL ,
[user password]        Varchar(20) NOT NULL ,
[get ads]              bit NOT NULL ,
[bank account]         Integer NOT NULL ,
skill                  Varchar(50) NOT NULL ,
[hourly price]         money NOT NULL ,
tool                   Varchar(20) NULL ,
[vehicle type]         Varchar(30) NULL ,
CONSTRAINT PK_Taskers_MRR primary key (Email),
);

CREATE	TABLE Searches_MRR (
DW_search                    int primary key not null,
[ip address]                 Varchar (30) NOT NULL ,
[search dt]                  DateTime NOT NULL ,
[service length]             int NOT NULL ,
customer                     Varchar(50) NOT NULL ,
[service location]           Varchar(50) NOT NULL ,
[Tasker Found]               Varchar(50) NOT NULL ,
[leads to order]             bit NOT NULL ,
);

CREATE	TABLE Orders_MRR (
[order id]             integer NOT NULL ,
[order dt]             DateTime NOT NULL ,
[service DT]           Datetime NOT NULL ,
method                 Varchar(20) NOT NULL ,
[skill score]          integer NOT NULL ,
[tasker score]         integer NOT NULL ,
[total price]          money NOT NULL ,
[service length]       integer NOT NULL ,
customer               Varchar(50) NOT NULL ,
tasker                 Varchar(50) NOT NULL ,
area					varchar(50) not null,
CONSTRAINT PK_Orders_MRR primary key ([order id],[order dt]),
); 	

