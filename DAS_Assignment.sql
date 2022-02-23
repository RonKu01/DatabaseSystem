

create table Publisher
(PublisherID nvarchar(50) primary key not null,
PublisherName nvarchar(50) not null);

Insert into Publisher values
('P01','John'),
('P02','Andrew'),
('P03','Jordan'),
('P04','George'),
('P05','James');

select * from Publisher

create table Book
(BookID nvarchar(50) primary key not null,
BookName nvarchar(50) not null,
Author nvarchar(50) not null,
Price money not null,
PublisherID nvarchar(50) not null foreign key 
references Publisher(PublisherID));

insert into book values
('B01','The Testaments','Margaret Atwood','20','P01'),
('B02','Normal People','Sally Rooney','15','P02'),
('B03','Such a Fun Age','Kiley Raid','22','P03'),
('B04','Africaville','Jeffrey Colvin','26','P01'),
('B05','The Library of the Unwritten','Hackwith','32','P04'),
('B06','The Starless Sea','Erin Morgenstern','28','P05');

Select * from book

create table Store
(StoreID nvarchar(50) primary key not null,
Store_ManagerName nvarchar(50) not null,
Location nvarchar(50) not null);

insert into Store values
('S01','Oliver','Kuala Lumpur'),
('S02','Jack','Kepong'),
('S03','Oscar','Johor Bahru'),
('S04','Jacob','Seremban'),
('S05','Emily','Malacca');

Select * from store

Create table Manager_Ordered
(Manager_Ordered_ID nvarchar(50) primary key not null,
StoreID nvarchar(50) not null foreign key references Store(StoreID),
Total_Price money not null,
Order_Date Date not null);

insert into Manager_Ordered values
('MNG_ODR_01','S01','3440','30November2019'),
('MNG_ODR_02','S02','3140','6December2019'),
('MNG_ODR_03','S03','1680','16December2019'),
('MNG_ODR_04','S04','800','18December2019'),
('MNG_ODR_05','S05','3620','20December2019'),
('MNG_ODR_06','S02','640','26December2019');
Select * from Manager_Ordered


Create table Manager_Ordered_Detail
(Ordered_Detail_ID nvarchar(50) primary key not null,
Manager_Ordered_ID nvarchar(50) foreign key references Manager_Ordered(Manager_Ordered_ID),
BookID nvarchar(50) not null foreign key references Book(BookID),
Quantity int not null);

Insert into Manager_Ordered_Detail values
('1','MNG_ODR_01','B06','80'),
('2','MNG_ODR_01','B01','60'),
('3','MNG_ODR_02','B02','100'),
('4','MNG_ODR_02','B04','20'),
('5','MNG_ODR_02','B05','35'),
('6','MNG_ODR_03','B06','60'),
('7','MNG_ODR_04','B01','40'),
('8','MNG_ODR_05','B03','70'),
('9','MNG_ODR_05','B04','80'),
('10','MNG_ODR_06','B05','20');

Select * from Manager_Ordered_Detail

Create table Member
(MemberID nvarchar(50) primary key not null,
MemberName nvarchar(50) not null,
Gender nvarchar(6) not null
Constraint chk_Gender Check( Gender ='Male' or Gender='Female'),
Identification_Number nvarchar(14),
Address nvarchar(255) not null,
ContactNumber nvarchar(15) not null);

insert into Member values
('M01','Noah','Male','000130-14-1233','03,Jalan Ampang,68000 Ampang','010-202-3030'),
('M02','Thomas','Male','990210-08-3211','21,Jalan Seremban,33222 Seremban','011-222-3333'),
('M03','Jessica','Female','000720-06-5220','C01,Jalan SS15,66888 SS15','012-234-4567'),
('M04','Linda','Female','010830-09-1234','35,Jalan Kenaga,68700 Kenaga','012-333-4444'),
('M05','Sarah','Female','000328-10-5678','86,Jalan Loke You,55666 Kuala Lampur','013-345-5678'),
('M06','Robert','Male','050730-12-5433','D2-06,Jalan Mili,11200 Miri','013-555-9999'),
('M07','Sandra','Female','000321-14-4466','45,Jalan Mutiara,88000 Imbi','019-000-1234'),
('M08','Tracy','Female','090422-03-8862','03,Jalan Vista,53500 Perdana','018-456-6677');

Select * from Member

create table Cart
(CartID nvarchar(50) Primary key not null,
MemberID nvarchar(50) not null foreign key references Member(MemberID),
TotalPrice money not null);

insert into Cart values
('C01','M01','74'),
('C02','M03','54'),
('C03','M04','60'),
('C04','M05','32'),
('C05','M06','15'),
('C06','M07','28');

Select * from Cart

create table Cart_Detail
(Cart_Detail_ID nvarchar(50) Primary key not null,
CartID nvarchar(50) not null foreign key references Cart(CartID),
BookID nvarchar(50) not null foreign key references Book(BookID),
Quantity int not null);

Insert into Cart_Detail values
('C_DET_01','C01','B01','1'),
('C_DET_02','C01','B03','1'),
('C_DET_03','C01','B05','1'),
('C_DET_04','C02','B04','1'),
('C_DET_05','C02','B06','1'),
('C_DET_06','C03','B05','1'),
('C_DET_07','C03','B06','1'),
('C_DET_08','C04','B05','1'),
('C_DET_09','C05','B02','1'),
('C_DET_10','C06','B04','1');

Select * from Cart_Detail

Create table Invoice
(InvoiceID nvarchar(50) primary key not null,
MemberID nvarchar(50) not null foreign key references Member(MemberID),
Total_Book_Ordered int not null,
Total_Price money not null,
InvoiceDate date not null,
Status_Of_Delivery nvarchar(50) not null 
constraint chk_Status_Of_Delivery Check (Status_Of_Delivery='Delivered' or Status_Of_Delivery='Pending'));

insert into Invoice values
('INV01','M02','2','47','5January2020','Delivered'),
('INV02','M03','2','42','8January2020','Delivered'),
('INV03','M04','1','28','8January2020','Delivered'),
('INV04','M05','1','26','11January2020','Delivered'),
('INV05','M06','1','15','14January2020','Pending'),
('INV06','M08','2','48','14January2020','Pending'),
('INV07','M03','1','32','16January2020','Pending');

Select * from Invoice

Create table Ordered_Detail
(OrderID nvarchar(50) primary key not null,
InvoiceID nvarchar(50) not null foreign key references Invoice(InvoiceID),
BookID nvarchar(50) not null foreign key references Book(BookID),
Quantity int not null,
Rating decimal(2,1) not null constraint chk_Customer_Rating Check (Rating >= 1 And Rating <= 10),
Comment nvarchar(255));

insert into Ordered_Detail values
('ODR_01','INV01','B02','1','8.5','Haha,Its funny'),
('ODR_02','INV01','B05','1','5.5','So Boring.'),
('ODR_03','INV02','B01','1','6.0',null),
('ODR_04','INV02','B03','1','7.5','The story is so attractive.'),
('ODR_05','INV03','B06','1','9.5',null),
('ODR_06','INV04','B04','1','6.5',null),
('ODR_07','INV05','B02','1','7.5','Unforgettable Book'),
('ODR_08','INV06','B01','1','8.0','I was HOOKED, the book is interesting'),
('ODR_09','INV06','B06','1','9.0',null),
('ODR_10','INV07','B05','1','6.5','The story is very confusing');

Select * from Ordered_Detail;

--Q1
Select book.bookID,book.BookName, Avg(Ordered_Detail.Rating) as Highest_Ratings 
from Ordered_Detail inner join book on Ordered_Detail.BookID = Book.BookID
group by book.bookID,book.BookName
having avg(Ordered_Detail.Rating) = (Select max(Highest_Ratings) from 
(Select book.bookID,book.BookName, avg(Ordered_Detail.Rating) as Highest_Ratings 
from Ordered_Detail inner join book on Ordered_Detail.BookID = book.BookID
group by book.bookID,book.BookName) Ordered_Detail inner join book on Ordered_Detail.BookID = Book.BookID)


--Q2
Select member.MemberID,Member.MemberName, Count(Ordered_Detail.Comment) As Total_Number_Of_Feedbacks 
from member
left join invoice on Invoice.MemberID=Member.MemberID
left join Ordered_Detail on Invoice.InvoiceID=Ordered_Detail.InvoiceID
Group by member.MemberID,Member.MemberName;

Select * from member

--Q3
Select Book.PublisherID,Publisher.PublisherName,Count(Book.BookID) As Total_Number_Of_Book_Published 
from book
inner join Publisher on Book.PublisherID = Publisher.PublisherID
Group by Book.PublisherID,Publisher.PublisherName;

--Q4 
Select Manager_Ordered.StoreID,Publisher.PublisherID ,Sum(Manager_Ordered_Detail.Quantity) As Number_Of_Books_Ordered  
from Manager_Ordered
inner join Manager_Ordered_Detail on Manager_Ordered.Manager_Ordered_ID = Manager_Ordered_Detail.Manager_Ordered_ID
inner join book on Manager_Ordered_Detail.BookID =Book.BookID
inner join Publisher on book.PublisherID = Publisher.PublisherID
Group by Manager_Ordered.StoreID,Publisher.PublisherID
order by StoreID asc;

--Q5
Select member.MemberID,Count(Ordered_Detail.BookID) As Total_Number_Of_Books_Ordered 
from member
left join Invoice on member.MemberID = Invoice.MemberID
left join Ordered_Detail on Invoice.InvoiceID = Ordered_Detail.InvoiceID
group by member.MemberID;

Select * from Ordered_Detail

--Q6
Select  Ordered_detail.BookID as Best_Selling_Books,sum(Ordered_Detail.Quantity) as Number_Of_Book_Sold 
from Ordered_Detail 
Group by Ordered_detail.BookID
having sum(Ordered_Detail.Quantity) = (Select max(Number_Of_Book_Sold) from 
(Select Ordered_detail.BookID as Best_Selling_Books,sum(Ordered_Detail.Quantity) as Number_Of_Book_Sold 
from Ordered_Detail Group by Ordered_detail.BookID) OrderDetail)
Order by Number_Of_Book_Sold desc;

--Q7
Select Gender,Count(MemberID) as Total_Number_Of_Registered_Members from member
where Gender='Male' or Gender='Female'
group by Gender

--Q8
Select Member.MemberID,member.Identification_Number,member.Address,Member.ContactNumber,
Ordered_Detail.BookID,Book.BookName,Ordered_Detail.Quantity,Invoice.InvoiceDate,Invoice.Status_Of_Delivery from Invoice
inner join Member on Invoice.MemberID = Member.MemberID 
inner join Ordered_Detail on Invoice.InvoiceID=Ordered_Detail.InvoiceID
inner join Book on Book.BookID = Ordered_Detail.BookID
where Invoice.Status_Of_Delivery ='Pending'

--Q9
Select Member.MemberID,Member.MemberName, Sum(book.Price) As Total_Expenditure 
from member
inner join Invoice on Member.MemberID = Invoice.MemberID
inner join Ordered_Detail on Invoice.InvoiceID = Ordered_Detail.InvoiceID
inner join book on Ordered_Detail.BookID = Book.BookID
group by Member.MemberID,Member.MemberName
having sum(book.Price) = (Select max(Total_Expenditure) from 
(Select Member.MemberID,Member.MemberName, Sum(book.Price) As Total_Expenditure 
from member
inner join Invoice on Member.MemberID = Invoice.MemberID
inner join Ordered_Detail on Invoice.InvoiceID = Ordered_Detail.InvoiceID
inner join book on Ordered_Detail.BookID = Book.BookID
group by Member.MemberID,Member.MemberName) as member 
inner join Invoice on Member.MemberID = Invoice.MemberID
inner join Ordered_Detail on Invoice.InvoiceID = Ordered_Detail.InvoiceID
inner join book on Ordered_Detail.BookID = Book.BookID)


Select * from member

--Q10 
Select member.MemberID , Count(Cart_Detail.BookID) As Total_Books_In_Cart from member
left join Cart on member.memberID = Cart.MemberID
left join Cart_Detail on Cart.CartID = Cart_Detail.CartID
group by member.MemberID


--List all members who had made at least 2 orders
Select Member.MemberID , count(Invoice.InvoiceID) as AtLeast2Orders from Member
inner join Invoice on Member.MemberID = Invoice.MemberID 
group by Member.MemberID
having count(Invoice.InvoiceID) >= 2

select * from Ordered_Detail
