create schema TravelOnTheGo;

use TravelOnTheGo;
 
/*
1. Creating Tables
*/
CREATE TABLE IF NOT EXISTS PASSENGER (
    Passenger_name VARCHAR(20),
    Category VARCHAR(20),
    Gender VARCHAR(5),
    Boarding_City VARCHAR(15),
    Destination_City VARCHAR(15),
    Distance INT,
    Bus_Type VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS PRICE (
    Bus_Type VARCHAR(10),
    Distance INT,
    Price INT
);

/*
2. Inserting values inside Tables
*/
 
INSERT INTO PASSENGER VALUES ("Sejal", 'AC', 'F', 'Bengaluru', 'Chennai',350, 'Sleeper');
INSERT INTO PASSENGER VALUES ("Anmol", 'Non-AC', 'M', 'Mumbai', 'Hyderabad',700, 'Sitting');
INSERT INTO PASSENGER VALUES ("Pallavi", 'AC', 'F', 'Panaji', 'Bengaluru',600, 'Sleeper');
INSERT INTO PASSENGER VALUES ("Khusboo", 'AC', 'F', 'Chennai', 'Mumbai',1500, 'Sleeper');
INSERT INTO PASSENGER VALUES ("Udit", 'Non-AC', 'M', 'Trivandrum', 'panaji',1000, 'Sleeper');
INSERT INTO PASSENGER VALUES ("Ankur", 'AC', 'M', 'Nagpur', 'Hyderabad',500, 'Sitting');
INSERT INTO PASSENGER VALUES ("Hemant", 'Non-AC', 'M', 'Panaji', 'Mumbai',700, 'Sleeper');
INSERT INTO PASSENGER VALUES ("Manish", 'Non-AC', 'M', 'Hyderabad', 'Bengaluru',500, 'Sitting');
INSERT INTO PASSENGER VALUES ("Piyush", 'AC', 'M', 'Pune', 'Nagpur',700, 'Sitting');
 
INSERT INTO PRICE VALUES ("Sleeper", 350, 770);
INSERT INTO PRICE VALUES ("Sleeper", 500, 1100);
INSERT INTO PRICE VALUES ("Sleeper", 600, 1320);
INSERT INTO PRICE VALUES ("Sleeper", 700, 1540);
INSERT INTO PRICE VALUES ("Sleeper", 1000, 2200);
INSERT INTO PRICE VALUES ("Sleeper", 1200, 2640);
INSERT INTO PRICE VALUES ("Sleeper", 1500, 2700);
INSERT INTO PRICE VALUES ("Sitting", 500, 620);
INSERT INTO PRICE VALUES ("Sitting", 600, 744);
INSERT INTO PRICE VALUES ("Sitting", 700, 868);
INSERT INTO PRICE VALUES ("Sitting", 1000, 1240);
INSERT INTO PRICE VALUES ("Sitting", 1200, 1488);
INSERT INTO PRICE VALUES ("Sitting", 1500, 1860);


/*
3. How many females and how many male passengers travelled for a minimum distance of 600 KM s?
*/
SELECT 
    COUNT(Gender) AS Count
FROM
    PASSENGER
WHERE
    Distance >= 600 AND Gender = 'F';       

/*
4. Find the minimum ticket price for Sleeper Bus
*/
SELECT 
    MIN(p.Price) AS 'Minimum Ticket Price', p.Bus_Type
FROM
    Price p
WHERE
    p.Bus_Type = 'Sleeper';

/*
5. Select passenger names whose names start with character 'S'
*/
SELECT 
    Passenger_name
FROM
    travelonthego.passenger
WHERE
    Passenger_name LIKE 'S%';
    
/*
6. Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output
*/
SELECT 
    A.Passenger_name,
    A.Boarding_City,
    A.Destination_City,
    A.Bus_Type,
    B.Price
FROM
    passenger A
        JOIN
    price B ON A.Distance = B.Distance
        AND A.Bus_Type = B.Bus_Type;

/*
7. What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s
*/
SELECT 
    A.Passenger_name, B.Price AS Charge
FROM
    passenger A
        JOIN
    price B ON A.Bus_Type = 'Sitting'
WHERE
    A.Distance = 1000;

/*
8. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
*/
SELECT 
    B.Bus_Type, B.Price
FROM
    passenger A
        JOIN
    price B ON A.Distance = B.Distance
WHERE
    Passenger_name = 'Pallavi';

/*
9. List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
*/

SELECT DISTINCT
    (Distance)
FROM
    passenger
ORDER BY Distance DESC;

/*
10. Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
*/
SELECT 
    p.Passenger_name,
    p.Distance AS 'Distance Travelled',
    p.Distance * 100 / (SELECT 
            SUM(p.distance)
        FROM
            passenger p) AS '% of distance travelled from total distance travelled by all passengers'
FROM
    PASSENGER p;

   

/*
11. Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
SELECT DISTINCT
    pr.Distance,
    pr.Price,
    CASE
        WHEN pr.price > 1000 THEN 'Expensive'
        WHEN pr.price > 500 AND pr.price < 1000 THEN 'Average Coast'
        ELSE 'Cheap'
    END AS Price_Category
FROM
    Price pr;