drop table orders
drop table searches
drop table customers
drop table taskers
drop table Areas

CREATE	TABLE customers (
Email                  Varchar (50) NOT NULL ,
[Private name]         Varchar (20) NOT NULL ,
[last name]            Varchar (20) NOT NULL ,
area                   Varchar(50) NOT NULL ,
[user password]        Varchar(20) NOT NULL ,
[get ads]              bit NOT NULL ,
[Gender]				char not null,
CONSTRAINT PKcustomers primary key (Email),
);

CREATE	TABLE taskers (
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
CONSTRAINT PK_taskers primary key (Email),
CONSTRAINT ck_TaskerEmail check (Email like '%@%.%'),
CONSTRAINT ck_BankAccount check ([bank account] > 0),
CONSTRAINT ck_HourlyPrice check ( [hourly price] > 0),
);

CREATE	TABLE searches (
DW_Search					int identity(1,1) primary key not null,
[ip address]                 Varchar (30) NOT NULL ,
[search dt]                  DateTime NOT NULL ,
[service length]             int NOT NULL ,
customer                     Varchar(50) NOT NULL ,
[service location]           Varchar(50) NOT NULL ,
[Tasker Found]               Varchar(50) NOT NULL ,
[leads to order]             bit NOT NULL ,
CONSTRAINT fk_customer FOREIGN KEY(customer) REFERENCES customers(Email),
CONSTRAINT fk_Tasker_Found FOREIGN KEY([Tasker Found]) REFERENCES taskers(Email),
CONSTRAINT ck_IP check ([ip address] like '%%%.%%%.%%%'),
CONSTRAINT ck_ServiceLength check ([service length] in (1,2,3)),
);

CREATE	TABLE orders (
[order id]             integer NOT NULL ,
[order dt]             DateTime NOT NULL ,
[service DT]           Datetime NOT NULL ,
method                 Varchar(25) NOT NULL ,
[skill score]          integer NOT NULL ,
[tasker score]         integer NOT NULL ,
[total price]          money NOT NULL ,
[service length]       integer NOT NULL ,
customer               Varchar(50) NOT NULL ,
tasker                 Varchar(50) NOT NULL ,
area					varchar(50) not null,
CONSTRAINT PK_orders primary key ([order id],[order dt]),
CONSTRAINT fk_customer1 FOREIGN KEY(customer) REFERENCES customers(Email),
CONSTRAINT fk_Tasker_Found1 FOREIGN KEY(tasker) REFERENCES taskers(Email),
CONSTRAINT ck_skillScore check ([skill score] > 0),
CONSTRAINT ck_skillScore2 check ([skill score] < 6),
CONSTRAINT ck_serviceLength2 check ([service length] in (1,2,3)),
CONSTRAINT ck_taskerScore check ([tasker score] > 0),
CONSTRAINT ck_taskerScore2 check ([tasker score] < 6),
CONSTRAINT ck_totalPrice check ([total price] > 0),
CONSTRAINT ck_CustomerEmail check (customer like '%@%.%')
); 		

create table Areas (
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
constraint ck_positive1	check ([Average Income]>0),
constraint ck_positive2	check ([Number of inhabitants]>0),
constraint ck_positive3	check ([Age under 14]>0),
constraint ck_positive4	check ([Age between 15 and 24]>0),
constraint ck_positive5	check ([Age between 25 and 54]>0),
constraint ck_positive6	check ([Age between 55 and 65]>0),
constraint ck_positive7	check ([Age over 65]>0),
constraint ck_positive8	check ([Average Apartment size]>0),
constraint ck_positive9	check ([Female percentage]>0),
constraint ck_positive10 check ([Year]>2000),
constraint FK_Areas primary key (Area, [Year]),
);

