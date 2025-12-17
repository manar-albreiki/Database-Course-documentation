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
--------------------------------------------------------------
INSERT INTO airport (airport_code, airport_name, airport_state, airport_city)
VALUES 
('MCT', 'Muscat International', 'Muscat', 'Muscat'),
('SLL', 'Salalah Airport', 'Dhofar', 'Salalah'),
('MNH', 'Seeb Airport', 'Muscat', 'Seeb'),
('SUH', 'Sohar Airport', 'Al Batinah', 'Sohar');

select * from airport

INSERT INTO fligth (flight_no, Airline_type, weekdays, restriction)
VALUES
    ('FL100', 'Emirates', 'Mon,Wed,Fri', 'No pets allowed'),
    ('FL101', 'Delta', 'Tue,Thu,Sat', 'Only carry-on luggage'),
    ('FL102', 'Qatar Airways', 'Mon-Fri', 'No liquids over 100ml'),
    ('FL103', 'British Airways', 'Daily', 'Passport required'),
    ('FL104', 'Singapore Airlines', 'Mon,Wed,Sun', 'Check-in 2 hours prior');
select * from fligth

INSERT INTO fligth_leg (airport_code, flight_no)
VALUES 
    ('MCT', 'FL100'),
    ('MNH', 'FL101'),
    ('SLL', 'FL102'),
    ('SUH', 'FL103');

	select * from fligth_leg

	INSERT INTO airplane_types (airplaneTypes_name, airplane_company, max_seat, airport_code)
VALUES
    ('Boeing 737', 'Boeing', 215, 'MCT'),
    ('Airbus A320', 'Airbus', 180, 'MNH'),
    ('Boeing 777', 'Boeing', 396, 'SLL'),
    ('Airbus A380', 'Airbus', 525, 'SUH');

	select * from airplane_types

	INSERT INTO Airplane (Airplane_id, total_seats, typesAirplain)
VALUES
    ('AP001', 215, 'Boeing 737'),
    ('AP002', 180, 'Airbus A320'),
    ('AP003', 396, 'Boeing 777'),
    ('AP004', 525, 'Airbus A380'),
    ('AP005', 242, 'Boeing 787');
		select * from Airplane

INSERT INTO Leg_instance (Leg_instance_date, arrival_time, departure_time, available_seats, leg_no, Airplane_id)
VALUES
    ('2025-12-20', '08:00', '10:00', 180, 7, 'AP001'),
    ('2025-12-21', '09:00', '11:30', 150, 6, 'AP002'),
    ('2025-12-22', '14:00', '18:00', 396, 5, 'AP003'),
    ('2025-12-23', '20:00', '02:00', 525, 4, 'AP004'),
    ('2025-12-24', '06:30', '12:00', 242, 5, 'AP005');
	select * from Leg_instance

	INSERT INTO customer (customer_id, customer_name, customer_phone)
VALUES
    (1, 'John Doe', '123-456-7890'),
    (2, 'Jane Smith', '234-567-8901'),
    (3, 'Ahmed Ali', '345-678-9012'),
    (4, 'Sara Khan', '456-789-0123'),
    (5, 'Lina Chen', '567-890-1234');
	select * from customer

INSERT INTO reservation (reservation_id, customer_id, reservation_date, seat_no)
VALUES
    (1, 1, '2025-12-20', '12A'),
    (2, 2, '2025-12-21', '14B'),
    (3, 3, '2025-12-22', '10C'),
    (4, 4, '2025-12-23', '16D'),
    (5, 5, '2025-12-24', '18E');
	select * from reservation

	INSERT INTO fare (code, amount, flight_no)
VALUES
    (15, 250.500, 'FL100'),
    (29, 180.750, 'FL101'),
    (32, 320.000, 'FL102'),
    (40, 450.250, 'FL103'),
    (51, 500.000, 'FL104');
select * from fare

