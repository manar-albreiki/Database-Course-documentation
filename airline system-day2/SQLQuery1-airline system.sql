create database airline
use airline

create table airport (
airport_code CHAR(10) primary key,
airport_name varchar(30),
airport_state varchar(30),
airport_city varchar(30),
)

create table fligth_leg (
leg_no int primary key identity(1,1 ),
airport_code CHAR(10),
foreign key (airport_code) references airport (airport_code)
)

create table fligth (
flight_no VARCHAR(10) PRIMARY KEY,
Airline_type VARCHAR(30),
weekdays VARCHAR(20),
restriction VARCHAR(100),
)
alter table fligth_leg
add flight_no VARCHAR(10)  foreign key references fligth (flight_no)

create table airplane_types (
airplaneTypes_name VARCHAR(30) PRIMARY KEY,
airplane_company VARCHAR(30),
max_seat int not null,
airport_code CHAR(10) ,
foreign key (airport_code) references airport (airport_code)
)

create table Airplane (
Airplane_id VARCHAR(10) primary key not null,
total_seats int not null,
typesAirplain VARCHAR(70)
)
create table Leg_instance (
Leg_instance_date date primary key not null,
arrival_time time, 
departure_time time,
available_seats int,
leg_no int,
foreign key (leg_no) references fligth_leg (leg_no),
Airplane_id VARCHAR(10),
foreign key (Airplane_id) references Airplane (Airplane_id)
)

create table customer (
customer_id int primary key not null,
customer_name varchar (20),
customer_phone varchar (20)
)
create table reservation (
reservation_id int primary key not null,
customer_id int,
foreign key (customer_id) references customer (customer_id),
reservation_date date,
seat_no varchar (20)
)
create table fare (
code int primary key not null,
amount decimal (8,3),
flight_no VARCHAR(10),
foreign key (flight_no) references fligth (flight_no)
)