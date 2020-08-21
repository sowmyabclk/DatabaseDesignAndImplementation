
--/*****************************************/
-- Group 11 - Online Shopping Website 
--/************Group Members****************/
--           - Aleesha Reez
--			 - Sahana Kannahallimole Somanna 
--		     - Sowmya Benakappa
--		     - Snehal Pathak
--/*****************************************/

--Create database " Online_Shopping_Website_Group11"
Create database Online_Shopping_Website_Group11;

--use database " Online_Shopping_Website_Group11"
use Online_Shopping_Website_Group11;

--create Address entity
create table Address (
	addressId INT Primary Key NOT NULL,
	houseNo varchar(10) NOT NULL,
	streetName varchar(35) NOT NULL,
	state varchar(20) NOT NULL,
	zipcode varchar(10) NOT NULL,
	country varchar(10) NOT NULL
);

--Insert values into Address table
INSERT INTO Address Values (1, '314', 'garfield street E', 'WA', '98102','US'),
(2, '402', 'broadway Ave E', 'WA', '98105','US'),
(3, '700', 'roy street E', 'WA', '98106','US'),
(4, '1223', 'mercer street E', 'WA', '98132','US'),
(5, '3554', 'bellevue ave NE', 'WA', '98106','US'),
(6, '9088', 'bellred street E', 'WA', '99102','US'),
(7, '112', 'sunset street E', 'WA', '91302','US'),
(8, '656', '148th street E', 'WA', '98143','US'),
(9, '123', 'pine street E', 'WA', '96544','US'),
(10, '564', 'pike street E', 'WA', '94332','US')

---Password encryption steps
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'AdmIn_P@$$ord';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE PersonPasswordCertificate
WITH SUBJECT = 'Online Shopping Website Certificate',
EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY PersonSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE PersonPasswordCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY PersonSymmetricKey
DECRYPTION BY CERTIFICATE PersonPasswordCertificate;

--Create Person entity
create table Person (
	personId INT Primary Key NOT NULL,
	firstName varchar(30) NOT NULL,
	lastName varchar(30) NOT NULL,
	emailId varchar(50) NOT NULL,
	phoneNo varchar(15) NOT NULL,
	password VARBINARY(250) NOT NULL,
	addressId INT REFERENCES Address(addressId) NOT NULL
);

--drop Person table
drop table Person;

--Insert values into Person table
INSERT INTO Person Values (101,'Tom','Cruise','tom@gmail.com','6767764278',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'Tommy@323')), 1),
(102,'Sherlock','Holmes','sherlock@gmail.com','4259870092',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'Sher@lock23')), 2),
(103,'Adam','James','adam@gmail.com','4257891234',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'james@345')), 3),
(104,'John','Peter','john@gmail.com','4133907845',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'jopet@123')), 4),
(105,'Christine','Bekerly','christine@gmail.com','6245678923',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'bekerchris@87')), 5),
(106,'Sheila','Dielson','sheila@gmail.com','4278904567',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, '456sheila@d')), 6),
(107,'Amber','Olander','amberolander@gmail.com','2034675890',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'amber2345@WA')), 7),
(108,'Ralph','Ojar','rojer@gmail.com','4135672345',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'amber2345@settle')), 8),
(109,'Peter','Anderson','andersonp@gmail.com','4567238945',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'andy1992#')), 9),
(110,'Justin','Parus','justinp@gmail.com','4256712356',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'seahawks@123')), 10), (119,'James','Brown','james@gmail.com','4259870092',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'Jammy@121')), 2),
(112,'Rachel','Green','rachel@gmail.com','4257891234',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'rachel@345')), 3),
(113,'Joey','Tribiany','joey@gmail.com','4133907845',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'jopet@123')), 4),
(114,'Ross','Geller','geller@gmail.com','6245678923',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'gellerR@87')), 5),
(115,'Monika','Geller','monG@gmail.com','4278904567',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'monny@d99')), 6),
(116,'Chandlier','Bing','Cbing@gmail.com','2034675890',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'Cbing@WA')), 7),
(117,'Pheobe','Ojar','phebbes@gmail.com','4135672345',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'pheobe@settle')), 8),
(118,'Richard','Anderson','richard@gmail.com','4567238945',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'richie#33')), 9),
(111,'Maggie','Noodles','maggie@gmail.com','4256712356',EncryptByKey(Key_GUID(N'PersonSymmetricKey'), convert(varbinary, 'noodles@123')), 10);


--create Admin entity
create table Admin(
	adminId INT PRIMARY KEY NOT NULL,
	personId INT REFERENCES Person(personId) NOT NULL,
	registrationDate datetime DEFAULT Current_Timestamp 
)
--drop Admin table
drop table Admin;

--Insert Values into Admin table
INSERT INTO Admin (adminId, personId) Values(201, 101), 
(202, 102),
(203, 103),
(204, 104),
(205, 105),
(206, 106),
(207, 107),
(208, 108),
(209, 109),
(210, 110);

--Create Customer table
create table Customer(
	customerId INT PRIMARY KEY NOT NULL,
	personId INT REFERENCES Person(personId) NOT NULL,
	registrationDate datetime DEFAULT Current_Timestamp,
	accountNo varchar(30) 
)

--drop Customer table
drop table Customer;

--Insert values into Customer table
INSERT INTO Customer (customerId, personId, accountNo) values (301, 101, '10040089898'),
(321, 102, '34561234895'),
(303, 103, '45083890123'),
(304, 104, '42560005001'),
(305, 105, '90086745003'),
(306, 106, '70041267980'),
(307, 107, '34082387459'),
(308, 108, '40807465342'),
(309, 109, '78248945746'),
(310, 110, '45037824673'),
(311, 111, '34590234895'),
(312, 112, '45083890124'),
(313, 113, '42560005003'),
(314, 114, '90086745004'),
(315, 115, '70041267981'),
(316, 116, '34082387460'),
(317, 117, '40807465343'),
(318, 118, '78248945747'),
(319, 119, '45037824674');

--create Distributor entity
create table Distributor(
	distributorId INT PRIMARY KEY NOT NULL,
	distributorName varchar(40) NOT NULL,
	registrationDate datetime DEFAULT Current_Timestamp,
	adminId INT REFERENCES Admin(adminId) NOT NULL,
	addressId INT REFERENCES Address(addressId) NOT NULL
)

--drop Distributor table
drop table Distributor;

--Insert values into Distributor table
INSERT INTO Distributor(distributorId, distributorName, adminId, addressId) Values(401,'J&J Company Co', 201, 1),
(402,'AKP Sales', 202, 2),
(403,'Agama Solutions', 203, 3),
(404,'American Distributors', 204, 4),
(405,'United Distributing Company', 205, 5),
(406,'Cloud Valley Trade', 206, 6),
(407,'Atlas Distributors', 207, 7),
(408,'A&T Co', 208, 8),
(409,'Cloud9 Sales', 209, 9),
(410,'ASO Distributors', 210, 10);

--create Supplier entity
create table Supplier(
	supplierId INT PRIMARY KEY NOT NULL,
	companyName varchar(40) NOT NULL,
	accountNo varchar(30), 
	registrationDate datetime DEFAULT Current_Timestamp,
	adminId INT REFERENCES Admin(adminId) NOT NULL,
	addressId INT REFERENCES Address(addressId) NOT NULL
)

--drop Supplier table
drop table Supplier;

--Insert values into Supplier table
INSERT INTO Supplier Values (501, 'PK Sales', '209ADR23232', GETDATE(), 201, 3),
(502, 'Ali Linens', '208ADB23412', GETDATE(), 202, 2),
(503, 'Weavers & Sewers', '207ADC23413', GETDATE(), 203, 3),
(504, 'Choice Traders', '206ADF33672', GETDATE(), 204, 4),
(505, 'BestFit LLC', '205ADE23232', GETDATE(), 205, 5),
(506, 'ARCO Sales', '204TYDR4852', GETDATE(), 206, 6),
(507, 'Baba Traders', '203AGN6K233', GETDATE(), 207, 7),
(508, 'SummerFit Sales', '202SDR98432', GETDATE(), 208, 8),
(509, 'AP&T Traders', '201TYU25672', GETDATE(), 209, 9),
(510, 'Clothing Shoppe', '200AIOP2034', GETDATE(), 210, 10);

--create Support entity
create table Support(
	supportId INT PRIMARY KEY NOT NULL,
	customerId INT REFERENCES Customer(customerId) NOT NULL,
	adminId INT REFERENCES Admin(adminId) NOT NULL,
	supportPersonName varchar(30) NOT NULL,
	customerQuery varchar(MAX) NOT NULL,
	isResolved  BIT
)

--drop Support table
drop table Support;

--Insert values into Support table
INSERT INTO Support Values(601, 301, 201, 'John', 'Cart is empty', 0),
(602, 321, 202, 'Matt', 'Order not received', 1),
(603, 303, 203, 'Smith', 'Damaged product', 0),
(604, 304, 204, 'Alice', 'Not great quality', 1),
(605, 305, 205, 'James', 'Dress does not fit', 1),
(606, 306, 206, 'Mary', 'Item received very late', 1),
(607, 307, 207, 'Job', 'Found better price', 0),
(608, 308, 208, 'Jill', 'Address changed', 1),
(609, 309, 209, 'Jack', 'Not able to update cart', 0),
(610, 310, 210, 'Terry', 'Item is missing', 0);

--create ShippingDetails entity
create table ShippingDetails(
	shippingId INT PRIMARY KEY NOT NULL,
	distributorId INT REFERENCES Distributor(distributorId) NOT NULL,
	shippingDate datetime DEFAULT Current_Timestamp
)

--drop ShiipingDetails table
drop table ShippingDetails;

--Insert values into ShippingDetails table
INSERT INTO ShippingDetails Values(701, 401, GETDATE()),
(702, 402, GETDATE()),
(703, 403, GETDATE()),
(704, 404, GETDATE()),
(705, 405, GETDATE()),
(706, 406, GETDATE()),
(707, 407, GETDATE()),
(708, 408, GETDATE()),
(709, 409, GETDATE()),
(710, 410, GETDATE());

--create Orders entity
create table Orders(
	orderId INT PRIMARY KEY NOT NULL,
	customerId INT REFERENCES Customer(customerId) NOT NULL,
	shippingId INT REFERENCES ShippingDetails(shippingId) NOT NULL,
	tax MONEY NOT NULL,
	orderNo varchar(30) NOT NULL,
	orderDate datetime DEFAULT Current_Timestamp NOT NULL,
	estimatedDeliveryDate datetime NOT NULL,
	amount MONEY NOT NULL
);

--drop Orders table
drop table Orders;

--Insert values into Orders table
INSERT INTO Orders Values(801, 301, 701, 12.3, 'OR12321', GETDATE(), '08-01-2020', 40),
(802, 321, 710, 12.3, 'OR56567', GETDATE(), '08-05-2020', 60),
(803, 303, 702, 12.3, 'OR45467', GETDATE(), '08-24-2020', 100),
(804, 304, 703, 12.3, 'OR53421', GETDATE(), '08-10-2020', 120),
(805, 305, 704, 12.3, 'OR76547', GETDATE(), '08-08-2020', 90),
(806, 306, 705, 12.3, 'OR6543', GETDATE(), '08-22-2020', 35),
(807, 307, 706, 12.3, 'OR32456', GETDATE(), '08-11-2020', 30),
(808, 308, 707, 12.3, 'OR7767', GETDATE(), '08-10-2020', 120),
(809, 309, 708, 12.3, 'OR65567', GETDATE(), '08-15-2020', 80),
(810, 310, 709, 12.3, 'OR66567', GETDATE(), '08-25-2020', 70),
(857, 306, 701, 12.3, 'OR78651', GETDATE(), '09-01-2020', 40),
(858, 306, 701, 12.3, 'OR99699', GETDATE(), '09-13-2020', 30),
(859, 306, 701, 12.3, 'OR78522', GETDATE(), '09-14-2020', 80),
(860, 306, 706, 12.3, 'OR32456', GETDATE(), '08-11-2020', 30);

--create Product entity
create table Product(
	productId INT PRIMARY KEY NOT NULL,
	productName varchar(40) NOT NULL,
	description varchar(MAX) NOT NULL,
	price MONEY NOT NULL,
	quantity INT NOT NULL,
	adminId INT NOT NULL REFERENCES Admin(adminId) 
)

--drop Product table
drop table Product;

--Insert values into Product table
INSERT INTO Product Values (901, 'Yoga tshirts', 'Comfortable and light weight sports wear', 13.99, 30,201),
(902, 'shirt', 'formal cotton shirt ', 13.99, 30,202),
(903, 'frock', 'party wear for girls', 13.99, 20,203),
(904, 'trousers', 'slim fit pant', 13.99, 10,204),
(905, 'paper bag pants', 'comfortable pants for summer', 13.99, 5,205),
(906, 'men shorts', 'nylon shorts for outing', 13.99, 15,206),
(907, 'swim wear', 'Comfortable swim wear', 13.99, 10,207),
(908, 'crop top', 'Comfortable wear for cool looks', 13.99, 40,208),
(909, 'jacket', 'winter wear,keeps you warm', 13.99, 25,209),
(910, 'shrug', 'comfortable woolen shrug', 13.99, 15,210);

 --create Sizes entity
create table Sizes(
	sizeId INT PRIMARY KEY NOT NULL,
	type varchar(15) NOT NULL
)

--drop Sizes table
drop table Sizes;

--Insert values into Sizes table
INSERT INTO Sizes Values(1001, 'XS'),
(1002, 'S'),
(1003, 'M'),
(1004, 'L'),
(1005, 'XL'),
(1006, 'XXL'),
(1007, 'XXXL'),
(1008, 'PS'),
(1009, 'PM'),
(1010, 'PL'), 
(1011, 'PXL');

--create Colors entity
create table Colors(
	colorId INT PRIMARY KEY NOT NULL,
	colorName varchar(15) NOT NULL
)

--drop Colors table
drop table Colors;

--Insert values into Colors table
INSERT INTO Colors Values (1101, 'Red'),
(1102, 'Blue'),
(1103, 'Green'),
(1104, 'Yellow'),
(1105, 'Cyan'),
(1106, 'Black'),
(1107, 'White'),
(1108, 'Pink'),
(1109, 'Gray'),
(1110, 'Orange'),
(1111, 'Brown')

--create Categories entity
create table Categories(
	categoryId INT PRIMARY KEY NOT NULL,
	type varchar(15) NOT NULL
)

--drop Categories table
drop table Categories;

--Insert values into Categories table
INSERT INTO Categories Values (1201, 'boys'),
(1202, 'girls'), 
(1203, 'Mens'),
(1204, 'Womens'),
(1205, 'Sports'),
(1206, 'swimming wear'),
(1207, 'Casual wear'),
(1208, 'Formal wear'),
(1209, 'winter wear'), 
(1210, 'Summer style');

--create ProductDetails entity
create table ProductDetails(
	productDetailsId INT PRIMARY KEY NOT NULL,
	productId INT REFERENCES Product(productId) NOT NULL,
	sizeId INT REFERENCES Sizes(sizeId) NOT NULL,
	colorId INT REFERENCES Colors(colorId) NOT NULL,
	categoryId INT REFERENCES Categories(categoryId) NOT NULL,
	supplierId INT REFERENCES Supplier(supplierId) NOT NULL,
	quantity INT NOT NULL
)

--drop ProductDetails table
drop table ProductDetails;

--Insert values into ProductDetails table
INSERT INTO ProductDetails Values (1301, 901, 1001, 1101, 1201, 501, 50),
(1302, 902, 1002, 1102, 1202, 502, 40),
(1303, 903, 1003, 1103, 1203, 503, 35),
(1304, 904, 1004, 1104, 1204, 504, 100),
(1305, 905, 1005, 1106, 1205, 505, 87),
(1306, 906, 1006, 1106, 1206, 506, 32),
(1307, 907, 1007, 1107, 1207, 507, 787),
(1308, 908, 1004, 1108, 1208, 508, 123),
(1309, 909, 1005, 1109, 1209, 509, 900),
(1310, 910, 1002, 1110, 1210, 510, 550),
(1311, 901, 1007, 1111, 1203, 508, 355)

--create Cart entity
create table Cart(
	cartId INT PRIMARY KEY NOT NULL,
	productDetailsId INT REFERENCES ProductDetails(productDetailsId) NOT NULL,
	customerId INT REFERENCES Customer(customerId) NOT NULL,
	quantity INT NOT NULL
)

--drop Cart table
drop table Cart;

--Insert values into Cart table
INSERT INTO Cart Values (1401, 1301, 301, 2),
(1402, 1302, 301, 3),
(1403, 1302, 303, 6),
(1404, 1303, 304, 7),
(1405, 1304, 305, 9),
(1406, 1305, 306, 2),
(1407, 1303, 303, 1),
(1408, 1304, 305, 3),
(1409, 1306, 308, 4),
(1410, 1310, 309, 1);

--create OrderDetails entity
create table OrderDetails(
	orderId INT REFERENCES Orders(orderId) PRIMARY KEY NOT NULL,
	productDetailsId INT REFERENCES ProductDetails(productDetailsId) NOT NULL,
	quantity INT NOT NULL
)

--Insert values into OrderDetails table
INSERT INTO OrderDetails Values (801, 1301, 3),
(802, 1302, 2),
(803, 1303, 2),
(804, 1304, 3),
(805, 1304, 5),
(806, 1306, 7),
(807, 1307, 1),
(808, 1302, 1),
(809, 1305, 8),
(810, 1302, 10);

--drop OrderDetails table
drop table OrderDetails;

--Decrypt password
select firstName AS FirstName, lastName AS LastName, convert(varchar, DecryptByKey(password)) AS Password
from Person;


------------------------
--1. VIEW to generate horizontal reports for Customer and their Orders
--Create VIEW CustomerOrderView
Create VIEW CustomerOrderView
As
Select distinct p.firstName, p.lastName, 
 stuff((select ', '+RTRIM(cast(orderId as char))
    from Orders
	where customerId = c.customerId
	for xml path('')),1,2,'') as Orders
From Customer c
JOIN Person p
ON p.personId = c.personId
JOIN Orders o
ON o.customerId = c.customerId;

--Select From CustomerOrderView
Select * from CustomerOrderView;

--drop view CustomerOrderView
drop View CustomerOrderView;

--2. Horizontal reporting to get Count of Product for all available sizes

--create view
Create VIEW ProductChartView
AS
Select 'Product chart' as No_Of_Products_Sorted_By_Size,
[XS],[S],[M],[L],[XL],[XXL],[XXXL],[PS],[PM],[PL],[PXL]
From 
(
	Select s.type, pd.productId
	From ProductDetails pd
	JOIN Sizes s
	ON s.sizeId = pd.sizeId
) AS SourceTable
PIVOT 
(
	COUNT(productId) 
	FOR type IN ([XS],[S],[M],[L],[XL],[XXL],[XXXL],[PS],[PM],[PL],[PXL])
)As PivotTable

--select from View
Select * FROM ProductChartView;

--3. VIEW to get Customer details with highest no. of orders
--create view
Create View TopCustomer
As 
with temp as
(
	Select p.firstName, p.lastName, p.emailId, p.phoneNo, Count(o.orderId) As 'No of Orders',
	RANK() over(order by COUNT(o.orderId) desc) as Rank
	From Customer c
	Join Person p
	ON p.personId = c.personId
	JOIN Orders o
	ON o.customerId = c.customerId
	Group by p.firstName, p.lastName, p.emailId, p.phoneNo
)

Select * from temp
where Rank = '1';

--select from view
Select * from TopCustomer;

--drop view
drop View TopCustomer;

--CHECK Constraint
--Create table CustomerStatus
Create table CustomerStatus 
(
	customerId INT PRIMARY KEY REFERENCES dbo.Customer(customerId) NOT NULL,
	status varchar(15)
)

--drop table
drop table CustomerStatus;

--Function to check/validate CustomerStatus and return no. of Orders customer placed
CREATE FUNCTION CheckCustomerStatus (@customerId INT)
RETURNS varchar(15)
AS
BEGIN
   DECLARE @Count INT = 0;
   BEGIN
		SELECT @Count = COUNT(o.orderId) 
          FROM Customer c
		  JOIN Orders o
		  ON c.customerId = o.customerId
          WHERE c.customerId = @customerId; 
   END
   BEGIN
	IF @Count > 3
		Return 'Premium';
   END
   Return 'Regular';
END;

--drop function
drop function CheckCustomerStatus;

--Adding Table level check constraint
ALTER TABLE dbo.CustomerStatus ADD CONSTRAINT Check_CustomerStatus CHECK (dbo.CheckCustomerStatus(customerId) = 'Premium');

INSERT INTO CustomerStatus Values(301, 'Premium Member');

INSERT INTO CustomerStatus Values(302, 'Premium Member');

INSERT INTO CustomerStatus Values(303, 'Premium Member');

INSERT INTO CustomerStatus Values (309, 'Premium Member');

--select from table
Select * from CustomerStatus;

--Computed Columns
--Function to calculate total amount payable by customer for an Order
CREATE FUNCTION CalculateTotalAmountPayable(@orderID INT)
RETURNS MONEY
AS
   BEGIN
      DECLARE @total MONEY =
         (SELECT (tax + amount)
          FROM Orders
          WHERE orderId =@orderID);
      SET @total = ISNULL(@total, 0);
      RETURN @total;
END

-- Add a computed column to the Orders table
ALTER TABLE Orders
ADD totalAmount AS (dbo.CalculateTotalAmountPayable(orderId));

select * from Orders;

